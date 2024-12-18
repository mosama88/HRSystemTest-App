<?php

namespace App\Http\Controllers\Dashboard\Vacations;

use App\Models\City;
use App\Models\Branch;
use App\Models\Country;
use App\Models\Employee;
use App\Models\JobGrade;
use App\Models\Language;
use App\Models\Allowance;
use App\Models\BloodType;
use App\Models\Department;
use App\Models\ShiftsType;
use App\Models\Governorate;
use App\Models\Nationality;
use App\Models\EmployeeFile;
use App\Models\JobsCategory;
use Illuminate\Http\Request;
use App\Models\Qualification;
use App\Models\MainSalaryEmployee;
use App\Http\Controllers\Controller;
use App\Models\AdminPanelSetting;
use App\Models\EmployeeFixedAllowance;
use App\Models\FinanceClnPeriod;
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
    public function show($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Employee(), array("*"), array("com_code" => $com_code, "id" => $id));
        if (empty($data)) {
            return redirect()->back()->with(['error' => 'عفوا اسم الموظف مسجل من قبل !'])->withInput();
        }

        $other['employee_files'] = get_cols_where(new EmployeeFile(), array('*'), array('com_code' => $com_code, "employee_id" => $id));
        if ($data['fixed_allowances'] == 1) {
            $data['employee_fixed_allowances'] = get_cols_where(new EmployeeFixedAllowance(), array('*'), array('com_code' => $com_code, "employee_id" => $id));
            $other['allowances'] = get_cols_where(new Allowance(), array('id', 'name'), array('active' => 1, 'com_code' => $com_code), 'id', 'ASC');
        }
        $this->calculate_employees_vacations_balance($data['employee_code']);
        return view('dashboard.vacationsBalance.show', compact('data', 'other'));
    }

    public function calculate_employees_vacations_balance($employee_code)
    {
        $com_code = auth()->user()->com_code;

        /*
    1- التأكد من وجود بيانات الموظف وانه بالخدمه
    2- التأكد بأن الموظف له رصيد سنوى
    3- التحقق من حالة تنفيذ المعادله اول مره او نفذت من قبل فكلا الحالتين لهما طريقه عمل مختلفه
    4- فى حالة انه اول مره سنتحقق من الضبط العام ثم السنه المالية المفتوحة ونطبق الضبط العام
    5- فى حالة انه تم تنفيذ الدالة سابقآ سيكون فقط الرصيد المرحل من الشهر السابق على رصيد الشهر الحالى
  */


        //   بداية دالة أحتساب رصيد أجازات السنوى والشهرى
        $employee_data = get_Columns_where_row(new Employee(), array("*"), array("com_code" => $com_code, "employee_code" => $employee_code, 'functional_status' => 'Employee', 'active_vacation' => 'Yes'));
        $admin_panel_settingsData = get_Columns_where_row(new AdminPanelSetting(), array("*"), array("com_code" => $com_code));
        if (!empty($employee_data) && !empty($admin_panel_settingsData)) {
            // التحقق من وجود شهر مالى مفتوج مع سنه مالية مفتوحة
            $currentOpenMonth = get_Columns_where_row(new FinanceClnPeriod(), array("id", "finance_yr", "year_and_month"), array("com_code" => $com_code, "is_open" => 1));
            if (!empty($currentOpenMonth)) {
                if ($employee_data['is_done_Vacation_formula'] == 0) {
                    //أول مره ينزل له رصيد
                    $now = time();
                    $yourDate = strtotime($employee_data['work_start_date']);
                    $dateDiff =  $now  - $yourDate;
                    $difference_days = round($dateDiff / (60 * 60 * 24));
                    //لو عدد الايام يساوى او اكبر من الضبط العام سوف ينزل له رصيد اول المده
                    if ($difference_days >= $admin_panel_settingsData['after_days_begin_vacation']) {
                        $activeDays = $admin_panel_settingsData['after_days_begin_vacation'];
                        $current_year = $currentOpenMonth['finance_yr'];
                        $workYear = date('Y', strtotime($employee_data['work_start_date']));
                        $dateActiveFormula = date('Y-m-d', strtotime($employee_data['work_start_date'] . ' + ' . $activeDays . ' days'));
                        if ($workYear == $current_year) {
                            $dataToInsert['current_month_balance'] = $admin_panel_settingsData['first_balance_begin_vacation'];
                            $dataToInsert['total_available_balance'] = $admin_panel_settingsData['first_balance_begin_vacation'];
                            $dataToInsert['net_balance'] = $admin_panel_settingsData['first_balance_begin_vacation'];
                        } else {
                            $dataToInsert['current_month_balance'] = $admin_panel_settingsData['monthly_vacation_balance'];
                            $dataToInsert['total_available_balance'] = $admin_panel_settingsData['monthly_vacation_balance'];
                            $dataToInsert['net_balance'] = $admin_panel_settingsData['monthly_vacation_balance'];
                        }
//نقطة خلاف
                        if ($difference_days <= 360) {
                            $dataToInsert['year_month'] = date('Y-m', strtotime($dateActiveFormula));
                        } else {
                            $dataToInsert['year_month'] = $current_year . '-01';
                        }
                        $dataToInsert['financial_year'] = $current_year;
                        $dataToInsert['employee_code'] = $employee_code;
                        $dataToInsert['created_at'] = date('Y-m-d H:i:s');
                        $dataToInsert['created_by'] = auth()->user()->id;
                        $dataToInsert['com_code'] = $com_code;
                        $checkExists = get_Columns_where_row(new MainEmployeesVacationBalance(), array("id"), array("com_code"=>$com_code,"employee_code"=>$employee_code,"financial_year"=>$current_year,"year_month"=>$dataToInsert['year_month']));
                        if(empty($checkExists)){
                            $flag = insert(new MainEmployeesVacationBalance(),$dataToInsert);
                            if( $flag ){
                                $dataToUpdate['is_done_Vacation_formula'] = 1;
                                // $dataToUpdate['last_update'] = date('Y-m-d');
                                $dataToUpdate['updated_by '] = auth()->user()->id;
                                update(new Employee(),$dataToUpdate,array("com_code"=>$com_code,"employee_code"=>$employee_code));


                            }
                        }
                    }
                } else { //is_done_Vacation_formula
                    // نزل له رصيد سابقآ
                }
            }
        }
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
            $active_vacation = $request->active_vacation;
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

            if ($active_vacation != 'all') {
                $query->where('active_vacation', $active_vacation);
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

            return view('dashboard.vacationsBalance.ajax_search', ['data' => $data]);
        }
    }
}