<?php

namespace App\Livewire\Dashboard\Settings\Departments;

use Livewire\Component;
use App\Models\Department;
use App\Http\Requests\Dashboard\DepartmentRequest;

class DepartmentCreate extends Component
{
    public $name, $notes, $phones;


    public function rules()
    {
        return (new DepartmentRequest())->rules();
    }


    public function messages()
    {
        return (new DepartmentRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $departmentCreate = $this->validate();
            $checkExists = get_Columns_where_row(new Department(), array('id'), array("com_code" => $com_code, 'name' => $this->name));
            if (!empty($checkExists)) {
                return redirect()->back()->with('error', 'الفرع مسجل بالفعل ');
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