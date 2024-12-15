<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\Dashboard\BranchRequest;
use App\Livewire\Dashboard\Settings\Branches\BranchTable;

class BranchUpdate extends Component
{

    public $updateBranch;
    public $name, $address, $phones, $email, $active;

    protected $listeners = ['BranchEdit'];

    public function rules()
    {
        return (new BranchRequest())->rules();
    }

    public function messages()
    {
        return (new BranchRequest())->messages();
    }


    public function BranchEdit($id)
    {
        $this->updateBranch = Branch::findOrFail($id);
        $this->name = $this->updateBranch->name;
        $this->address = $this->updateBranch->address;
        $this->phones = $this->updateBranch->phones;
        $this->email = $this->updateBranch->email;
        $this->active = $this->updateBranch->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

        try {
            DB::beginTransaction();
            $com_code = auth()->user()->com_code;

columns_names:            
            $checkExists = Branch::select("id")->where("com_code" , $com_code)->where( 'name' , $this->name)->where('id',"!=",$this->updateBranch->id)->first();
            if (!empty($checkExists)) {
                return redirect()->back()->with('error', 'الفرع مسجل بالفعل ');
            }

            $updatedData = $this->validate();
            $this->updateBranch['updated_by'] = auth()->user()->id;
            $this->updateBranch['com_code'] = $com_code;
            $this->updateBranch->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableBranch')->to(BranchTable::class);
            DB::commit();
            session()->flash('message', 'تم إضافة البيانات بنجاح');
        } catch (\Exception $e) {
            DB::rollback();
            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()]);
        }

    }

    public function render()
    {
        return view('dashboard.settings.branches.branch-update');
    }
}
