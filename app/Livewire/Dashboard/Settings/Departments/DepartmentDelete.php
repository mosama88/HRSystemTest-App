<?php

namespace App\Livewire\Dashboard\Settings\Departments;

use App\Models\Department;
use App\Models\Employee;
use Livewire\Component;

class DepartmentDelete extends Component
{
    public $departmentDeleteRecored;

    public $name;

    protected $listeners = ['deleteDepartment'];

    public function deleteDepartment($id)
    {

        $this->departmentDeleteRecored = Department::findOrFail($id);
        $this->name = $this->departmentDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Department, ['*'], ['id' => $this->departmentDeleteRecored->id, 'com_code' => $com_code]);
        if (empty($data)) {
            return redirect()->route('dashboard.branches.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'department_id' => $this->departmentDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.departments.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->departmentDeleteRecored->delete();
        $this->reset('departmentDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableDepartment')->to(DepartmentTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.departments.department-delete');
    }
}
