<?php

namespace App\Http\Controllers\Dashboard\Vacations;

use App\Models\City;
use App\Models\Branch;
use App\Models\Country;
use App\Models\Employee;
use App\Models\JobGrade;
use App\Models\Language;
use App\Models\BloodType;
use App\Models\Department;
use App\Models\ShiftsType;
use App\Models\Governorate;
use App\Models\Nationality;
use App\Models\JobsCategory;
use Illuminate\Http\Request;
use App\Models\Qualification;
use App\Models\MainSalaryEmployee;
use App\Http\Controllers\Controller;
use App\Models\MainEmployeesVacationBalance;

class MainEmployeesVacationBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Employee(), array("*"), array("com_code" => $com_code), "id", "DESC")->get();
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


        if (!empty($data)) {
            foreach ($data as $info) {
                $info->CounterUsedBefore = get_count_where(new MainSalaryEmployee, array('com_code' => $com_code, 'employee_code' => $info['employee_code']));
            }
        }
        return view('dashboard.vacationsBalance.index', compact('data', 'other'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


    public function ajax_search(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $byCode_search = $request->byCode_search;
            $name = $request->name;
            $branch_id = $request->branch_id;
            $department_id = $request->department_id;
            $job_categories_id = $request->job_categories_id;
            $job_grade_id = $request->job_grade_id;
            $functional_status = $request->functional_status;
            $Type_salary_receipt = $request->Type_salary_receipt;
            $gender = $request->gender;
            $searchByRadioCode = $request->searchByRadioCode;

            $query = Employee::query();

            if ($request->filled('byCode')) {
                if ($request->searchByRadioCode == 'employee_code') {
                    $query->where('employee_code', $request->byCode);
                } elseif ($request->searchByRadioCode == 'fp_code') {
                    $query->where('fp_code', $request->byCode);
                }
            }

            // اضف باقي شروط البحث هنا
            // مثال:
            if ($request->filled('name')) {
                $query->where('name', 'like', '%' . $request->name . '%');
            }

            if ($name != '') {
                $query->where('name', 'like', '%' . $name . '%');
            }

            if ($branch_id != 'all') {
                $query->where('branch_id', $branch_id);
            }

            if ($department_id != 'all') {
                $query->where('department_id', $department_id);
            }

            if ($job_categories_id != 'all') {
                $query->where('job_categories_id', $job_categories_id);
            }

            if ($job_grade_id != 'all') {
                $query->where('job_grade_id', $job_grade_id);
            }

            if ($functional_status != 'all') {
                $query->where('functional_status', $functional_status);
            }

            if ($Type_salary_receipt != 'all') {
                $query->where('Type_salary_receipt', $Type_salary_receipt);
            }

            if ($gender != 'all') {
                $query->where('gender', $gender);
            }


            if (!empty($data)) {
                foreach ($data as $info) {
                    $info->CounterUsedBefore = get_count_where(new MainSalaryEmployee, array('com_code' => $com_code, 'employee_code' => $info['employee_code']));
                }
            }

            $data = $query->orderby('id', 'DESC')->paginate(10);

            return view('dashboard.affairs_employees.employees.ajax_search', ['data' => $data]);
        }
    }

}