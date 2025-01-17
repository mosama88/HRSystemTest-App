<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Http\Requests\Dashboard\BranchRequest;
use App\Models\Branch;
use Livewire\Component;

class BranchUpdate extends Component
{
    public $updateBranch;

    public $name;

    public $address;

    public $phones;

    public $email;

    public $active;

    protected $listeners = ['BranchEdit'];

    public function rules()
    {
        return (new BranchRequest)->rules();
    }

    public function messages()
    {
        return (new BranchRequest)->messages();
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

        $com_code = auth()->user()->com_code;

        $checkExists = Branch::select('id')->where('com_code', $com_code)->where('name', $this->name)->where('id', '!=', $this->updateBranch->id)->first();
        if (! empty($checkExists)) {
            return redirect()->back()->with('error', 'الفرع مسجل بالفعل ');
        }

        $updatedData = $this->validate();
        $this->updateBranch['updated_by'] = auth()->user()->id;
        $this->updateBranch['com_code'] = $com_code;
        $this->updateBranch->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableBranch')->to(BranchTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.branches.branch-update');
    }
}
