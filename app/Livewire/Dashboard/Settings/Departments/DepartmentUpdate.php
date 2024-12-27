<?php

namespace App\Livewire\Dashboard\Settings\Departments;

use App\Http\Requests\Dashboard\DepartmentRequest;
use App\Models\Department;
use Livewire\Component;

class DepartmentUpdate extends Component
{
    public $updateBranch;

    public $name;

    public $phones;

    public $notes;

    public $active;

    protected $listeners = ['editDepartment'];

    public function rules()
    {
        return (new DepartmentRequest)->rules();
    }

    public function messages()
    {
        return (new DepartmentRequest)->messages();
    }

    public function editDepartment($id)
    {
        $this->updateBranch = Department::findOrFail($id);
        $this->name = $this->updateBranch->name;
        $this->phones = $this->updateBranch->phones;
        $this->notes = $this->updateBranch->notes;
        $this->active = $this->updateBranch->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $CheckExsists = Department::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateBranch->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا اسم الادارة مسجل من قبل !'])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateBranch['updated_by'] = auth()->user()->id;
        $this->updateBranch['com_code'] = $com_code;
        $this->updateBranch->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableDepartment')->to(DepartmentTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.departments.department-update');
    }
}
