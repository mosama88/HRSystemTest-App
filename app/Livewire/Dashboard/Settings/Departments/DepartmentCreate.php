<?php

namespace App\Livewire\Dashboard\Settings\Departments;

use App\Http\Requests\Dashboard\DepartmentRequest;
use App\Models\Department;
use Livewire\Component;

class DepartmentCreate extends Component
{
    public $name;

    public $notes;

    public $phones;

    public $active;

    public function rules()
    {
        return (new DepartmentRequest)->rules();
    }

    public function messages()
    {
        return (new DepartmentRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $departmentCreate = $this->validate();
        $checkExists = get_Columns_where_row(new Department, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($checkExists)) {
            return redirect()->back()->with('error', 'الادارة مسجلة بالفعل ');
        }
        $departmentCreate['active'] = 1;
        $departmentCreate['created_by'] = auth()->user()->id;
        $departmentCreate['com_code'] = $com_code;
        Department::create($departmentCreate);
        $this->reset(['name', 'phones', 'notes']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableDepartment')->to(DepartmentTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.departments.department-create');
    }
}
