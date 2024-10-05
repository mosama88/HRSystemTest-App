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
        $data = getColumnsIndex(new MainEmployeesVacationBalance(), array("*"), array("com_code" => $com_code), "id", "DESC")->paginate(10);
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
}