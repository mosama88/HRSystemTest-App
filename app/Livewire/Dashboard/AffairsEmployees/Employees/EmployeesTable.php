<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Employees;

use App\Models\City;
use App\Models\Branch;
use App\Models\Country;
use Livewire\Component;
use App\Models\Employee;
use App\Models\JobGrade;
use App\Models\Language;
use App\Models\BloodType;
use App\Models\Department;
use App\Models\ShiftsType;
use App\Models\Governorate;
use App\Models\Nationality;
use App\Models\JobsCategory;
use App\Traits\GeneralTrait;
use Livewire\WithPagination;
use App\Models\Qualification;
use App\Models\MainSalaryEmployee;

class EmployeesTable extends Component
{
    use  WithPagination;
    use GeneralTrait;

    public
    $employee_code_search,
    $fp_search,
    $name_search,
    $gender_search,
    $branch_id_search,
    $job_grade_id_search,
    $department_id_search,
    $job_categories_id_search,
    $functional_status_search,
    $Type_salary_receipt_search ;

    protected $listeners = ['refreshTableEmployee' => 'refresh'];

 

    protected $queryString = [
        'employee_code_search' => ['sa' => 'كود '],
        'fp_search' => ['sa' => 'كود بصمة '],
        'name_search' => ['sa' => 'الاسم '],
        'gender_search' => ['sa', 'نوع الجنس '],
        'branch_id_search' => ['sa' => 'الفرع'],
        'job_grade_id_search' => ['sa' => 'الدرجه الوظيفية'],
        'department_id_search' => ['sa' => 'الادارة'],
        'job_categories_id_search' => ['sa' => 'نوع الوظيفه'],
        'functional_status_search' => ['sa' => 'الحالة الوظيفية'],
        'Type_salary_receipt_search' => ['sa' => 'نوع صرف الراتب'],
    ];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Employee())->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%' . $this->name_search . '%')
            ->orWhere('national_id', 'like', '%' . $this->name_search . '%')->orWhere('email', 'like', '%' . $this->name_search . '%');
        }

        if ($this->employee_code_search) {
            $query->where('employee_code', 'like', '%' . $this->employee_code_search . '%');
        }

        if ($this->fp_search) {
            $query->where('fp_code', 'like', '%' . $this->fp_search . '%');
        }
        
        if ($this->gender_search) {
            $query->where('gender', 'like', '%' . $this->gender_search . '%');
        }

        if ($this->branch_id_search) {
            $query->where('branch_id', 'like', '%' . $this->branch_id_search . '%');
        }

        if ($this->job_grade_id_search) {
            $query->where('job_grade_id', 'like', '%' . $this->job_grade_id_search . '%');
        }

        if ($this->department_id_search) {
            $query->where('department_id', 'like', '%' . $this->department_id_search . '%');
        }

        if ($this->job_categories_id_search) {
            $query->where('job_categories_id', 'like', '%' . $this->job_categories_id_search . '%');
        }

        if ($this->functional_status_search) {
            $query->where('functional_status', 'like', '%' . $this->functional_status_search . '%');
        }

        if ($this->Type_salary_receipt_search) {
            $query->where('Type_salary_receipt', 'like', '%' . $this->Type_salary_receipt_search . '%');
        }



        $other['branches'] = get_cols_where(new Branch, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['qualifications'] = get_cols_where(new Qualification, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['blood_types'] = get_cols_where(new BloodType, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['nationalities'] = Nationality::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['languages'] = get_cols_where(new Language, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['countires'] = Country::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['governorates'] = Governorate::orderBy('id', 'ASC')->get();
        $other['cities'] = get_cols_where(new City, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['departements'] = get_cols_where(new Department, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['jobs'] = get_cols_where(new JobsCategory, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['shifts_types'] = get_cols_where(new ShiftsType, array('id', 'type', 'from_time', 'to_time', 'total_hours'), array('com_code' => $com_code, "active" => 1));
        $other['job_grades'] = get_cols_where(new JobGrade(), array('id', 'job_grades_code', 'name', 'min_salary', 'max_salary'), array('com_code' => $com_code, "active" => 1));

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);

        if (!empty($data)) {
            foreach ($data as $info) {
                $info->CounterUsedBefore = get_count_where(new MainSalaryEmployee, array('com_code' => $com_code, 'employee_code' => $info['employee_code']));
            }
        }
        return view('dashboard.affairs_employees.employees.employees-table',compact('data','other'));
    }
}
