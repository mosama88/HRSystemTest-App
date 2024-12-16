<?php

namespace App\Livewire\Dashboard\Settings\Departments;

use Livewire\Component;
use App\Models\Employee;
use App\Models\Department;
use Livewire\WithPagination;

class DepartmentTable extends Component
{

    use  WithPagination;
    public $name;

    protected $listeners = ['refreshTableDepartment' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Department())->query();

        if ($this->name) {
            $query->where('name', 'like', '%' . $this->name . '%')
                ->orWhere('phones', 'like', '%' . $this->name . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "department_id" => $info->id));
            }
        }

        return view('dashboard.settings.departments.department-table', compact('data'));
    }
}