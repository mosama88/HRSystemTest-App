<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\Dashboard\BranchRequest;
use App\Livewire\Dashboard\Settings\Branches\BranchTable;

class BranchCreate extends Component
{

    public $name, $address, $phones, $email, $active;


    public function rules()
    {
        return (new BranchRequest())->rules();
    }


    public function messages()
    {
        return (new BranchRequest())->messages();
    }



    public function submit()
    {
        try {
            DB::beginTransaction();
            $com_code = auth()->user()->com_code;

            $branchCreate = $this->validate();
            $checkExists = get_Columns_where_row(new Branch(), array('id'), array("com_code" => $com_code, 'name' => $this->name));
            if (!empty($checkExists)) {
                return redirect()->back()->with('error', 'الفرع مسجل بالفعل ');
            }
            $branchCreate['active'] = 1;
            $branchCreate['created_by'] = auth()->user()->id;
            $branchCreate['com_code'] = $com_code;
            Branch::create($branchCreate);
            $this->reset(['name', 'address', 'phones', 'email']);
            $this->dispatch('createModalToggle');
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
        return view('dashboard.settings.branches.branch-create');
    }
}