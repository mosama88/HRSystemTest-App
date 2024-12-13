<?php

namespace App\Http\Controllers\Dashboard\Salaries;

use App\Models\Branch;
use App\Models\Employee;
use App\Models\Department;
use App\Models\JobsCategory;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use App\Models\FinanceCalendar;
use App\Models\FinanceClnPeriod;
use App\Models\AdminPanelSetting;
use App\Models\EmployeeSalaryLoan;
use App\Models\MainSalaryEmployee;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Maatwebsite\Excel\Facades\Excel;
use App\Models\EmployeeSalaryRewards;
use App\Models\EmployeeSalaryDiscount;
use App\Models\EmployeeSalaryAllowance;
use App\Models\EmployeeSalarySanctions;
use App\Models\EmployeeSalaryAbsenceDay;
use App\Models\EmployeeSalaryAdditional;
use App\Exports\MainSalaryEmployeeExport;
use App\Models\PermanentLoansInstallment;

class MainSalaryEmployeeController extends Controller
{

    use GeneralTrait;


    public function __construct()
    {
        $this->middleware('permission:رواتب الموظفين', ['only' => ['index']]);
        $this->middleware('permission:عرض رواتب الموظفين', ['only' => ['show']]);
        $this->middleware('permission:اضافة رواتب الموظفين', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل رواتب الموظفين', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف رواتب الموظفين', ['only' => ['destroy']]);
        $this->middleware('permission:طباعه رواتب الموظفين', ['only' => ['print_search']]);
    }



    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = FinanceClnPeriod::select("*")->where("com_code", $com_code)
            ->orderBy("finance_yr", "DESC")
            ->orderBy("start_date_m", "ASC")->paginate(12);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->currentYear = get_Columns_where_row(new FinanceCalendar(), array("is_open"), array("com_code" => $com_code, "finance_yr" => $info->finance_yr));
                $info->counterOpenMonth = get_count_where(new FinanceClnPeriod(), array("com_code" => $com_code, "is_open" => 1));
                $info->counterPreviousWatingOpen = FinanceClnPeriod::where("com_code", "=", $com_code)
                    ->where("finance_yr", "=", $info->finance_yr)
                    ->where("month_id", "<", $info->month_id)
                    ->where("is_open", "=", 0)->count();
            }
        }

        return view('dashboard.salaries.mainSalaryEmployees.index', compact('data'));
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
    public function show($finance_cln_periods_id)
    {
        $com_code = auth()->user()->com_code;
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id, ['is_open', '!=', 0]));

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!'])->withInput();
        }

        $data = MainSalaryEmployee::select(
            "main_salary_employees.id",
            "main_salary_employees.is_archived",
            "main_salary_employees.employee_code",
            "main_salary_employees.total_benefits",
            "main_salary_employees.total_deductions",
            "main_salary_employees.net_salary",
            "main_salary_employees.is_take_action_disbursed_collect",
            "main_salary_employees.is_stopped",
            "main_salary_employees.employee_department_code",
            "main_salary_employees.branch_id",
            "main_salary_employees.employee_jobs_id",
            "employees.name as employee_name",  // جلب اسم الموظف
            "employees.gender",               // جلب الجنس
            "images.filename as employee_photo" // جلب الصورة من جدول Images
        )
            ->join('employees', 'main_salary_employees.employee_code', '=', 'employees.employee_code')
            ->leftJoin('images', function ($join) {
                $join->on('employees.employee_code', '=', 'images.imageable_id')
                    ->where('images.imageable_type', '=', 'App\\Models\\Employee');
            })
            ->where('main_salary_employees.com_code', $com_code)
            ->where('main_salary_employees.finance_cln_periods_id', $finance_cln_periods_id)
            // ->where('is_archived', "=", 0)
            ->orderBy('main_salary_employees.id', 'DESC')
            ->take(10)->get();

        // لا حاجة للتكرار على البيانات لتحديث الاسم والجنس لأنهم تم جلبهم بالفعل في الاستعلام الرئيسي

        $other['branches'] = get_cols_where(new Branch, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['departements'] = get_cols_where(new Department, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['jobs'] = get_cols_where(new JobsCategory, array('id', 'name'), array('com_code' => $com_code, "active" => 1));

        $employees = get_cols_where(new Employee(), array("id", "employee_code", "name", "salary", "day_price", "fp_code"), array("com_code" => $com_code), 'employee_code', 'ASC');
        $other['not_have'] = 0;

        if ($finance_cln_periods_data['is_open'] == 1 && !empty($employees)) {
            foreach ($employees as $info) {
                $info->counter = get_count_where(new MainSalaryEmployee(), array('com_code' => $com_code, "employee_code" => $info->employee_code, "finance_cln_periods_id" => $finance_cln_periods_id));
                if ($info->counter == 0) {
                    $other['not_have']++;
                }
            }
        }

        $other['counter_salaries'] = get_count_where(new MainSalaryEmployee,  array('com_code' => $com_code, "finance_cln_periods_id" => $finance_cln_periods_id));
        $other['counter_salaries_waiting_archive'] = get_count_where(new MainSalaryEmployee,  array('com_code' => $com_code, "finance_cln_periods_id" => $finance_cln_periods_id, 'is_archived' => 0));
        $other['counter_salaries_done_archive'] = get_count_where(new MainSalaryEmployee,  array('com_code' => $com_code, "finance_cln_periods_id" => $finance_cln_periods_id, 'is_archived' => 1));
        $other['counter_salaries_stopped'] = get_count_where(new MainSalaryEmployee,  array('com_code' => $com_code, "finance_cln_periods_id" => $finance_cln_periods_id, 'is_stopped' => 'stopped'));

        return view('dashboard.salaries.mainSalaryEmployees.show', compact('other', 'data', 'finance_cln_periods_data', 'employees'));
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




    public function destroy(Request $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code,  ['is_open', '!=', 0]));

            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!'])->withInput();
            }

            $data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            DB::beginTransaction();
            destroy(new MainSalaryEmployee(), array("com_code" => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->back()->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }







    public function ajaxSearch(Request $request)
    {


        if ($request->ajax()) {
            $employee_code = $request->employee_code;
            $branch_id = $request->branch_id;
            $employee_department_code = $request->employee_department_code;
            $employee_jobs_id = $request->employee_jobs_id;
            $cash_visa = $request->cash_visa;
            $is_stopped = $request->is_stopped;
            $is_archived = $request->is_archived;
            $the_finance_cln_periods_id = $request->the_finance_cln_periods_id;
            if ($employee_code == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field1 = "id";
                $operator1 = ">";
                $value1 = 0;
            } else {
                $field1 = "employee_code";
                $operator1 = "=";
                $value1 = $employee_code;
            }
            if ($branch_id == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field2 = "id";
                $operator2 = ">";
                $value2 = 0;
            } else {
                $field2 = "branch_id";
                $operator2 = "=";
                $value2 = $branch_id;
            }
            if ($employee_department_code == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field3 = "id";
                $operator3 = ">";
                $value3 = 0;
            } else {
                $field3 = "employee_department_code";
                $operator3 = "=";
                $value3 = $employee_department_code;
            }
            if ($employee_jobs_id == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field4 = "id";
                $operator4 = ">";
                $value4 = 0;
            } else {
                $field4 = "employee_jobs_id";
                $operator4 = "=";
                $value4 = $employee_jobs_id;
            }
            if ($is_archived == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field5 = "id";
                $operator5 = ">";
                $value5 = 0;
            } else {
                $field5 = "is_archived";
                $operator5 = "=";
                $value5 = $is_archived;
            }
            if ($cash_visa == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field6 = "id";
                $operator6 = ">";
                $value6 = 0;
            } else {
                $field6 = "cash_visa";
                $operator6 = "=";
                $value6 = $cash_visa;
            }
            if ($is_stopped == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field7 = "id";
                $operator7 = ">";
                $value7 = 0;
            } else {
                $field7 = "is_stopped";
                $operator7 = "=";
                $value7 = $is_stopped;
            }
            $com_code = auth()->user()->com_code;
            $data = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)->where('com_code', '=', $com_code)->orderby('id', 'DESC')->paginate(10);



            $other['counter_salaries'] = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->count();

            $other['counter_salaries_waiting_archive'] = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                ->where('com_code', '=', $com_code)
                ->where('is_archived', '=', 0)
                ->orderby('id', 'DESC')->count();


            $other['counter_salaries_done_archive'] = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                ->where('is_archived', '=', 1)
                ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->count();


            $other['counter_salaries_stopped'] = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('is_stopped', '=', 'stopped')
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->count();


            if (!empty($data)) {
                foreach ($data as $info) {
                    $info->emp_name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $info->employee_code));
                }
            }

            return view('dashboard.salaries.mainSalaryEmployees.ajax_search', ['data' => $data, 'other' => $other]);
        }
    }

    public function print_search(Request $request)
    {
        try {
            DB::beginTransaction();
            $com_code = auth()->user()->com_code;

            $employee_code = $request->employee_code;
            $branch_id = $request->branch_id;
            $employee_department_code = $request->employee_department_code;
            $employee_jobs_id = $request->employee_jobs_id;
            $cash_visa = $request->cash_visa;
            $is_stopped = $request->is_stopped;
            $is_archived = $request->is_archived;
            $the_finance_cln_periods_id = $request->the_finance_cln_periods_id;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $the_finance_cln_periods_id, ['is_open', '!=', 0]));

            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!'])->withInput();
            }
            if ($employee_code == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field1 = "id";
                $operator1 = ">";
                $value1 = 0;
            } else {
                $field1 = "employee_code";
                $operator1 = "=";
                $value1 = $employee_code;
            }
            if ($branch_id == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field2 = "id";
                $operator2 = ">";
                $value2 = 0;
            } else {
                $field2 = "branch_id";
                $operator2 = "=";
                $value2 = $branch_id;
            }
            if ($employee_department_code == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field3 = "id";
                $operator3 = ">";
                $value3 = 0;
            } else {
                $field3 = "employee_department_code";
                $operator3 = "=";
                $value3 = $employee_department_code;
            }
            if ($employee_jobs_id == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field4 = "id";
                $operator4 = ">";
                $value4 = 0;
            } else {
                $field4 = "employee_jobs_id";
                $operator4 = "=";
                $value4 = $employee_jobs_id;
            }
            if ($is_archived == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field5 = "id";
                $operator5 = ">";
                $value5 = 0;
            } else {
                $field5 = "is_archived";
                $operator5 = "=";
                $value5 = $is_archived;
            }
            if ($cash_visa == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field6 = "id";
                $operator6 = ">";
                $value6 = 0;
            } else {
                $field6 = "cash_visa";
                $operator6 = "=";
                $value6 = $cash_visa;
            }
            if ($is_stopped == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field7 = "id";
                $operator7 = ">";
                $value7 = 0;
            } else {
                $field7 = "is_stopped";
                $operator7 = "=";
                $value7 = $is_stopped;
            }
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code));

            $data = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)->where('com_code', '=', $com_code)->where('is_stopped', "=", "unstopped")->orderby('id', 'DESC')->paginate(100);


            if (!empty($data)) {
                foreach ($data as $info) {
                    $info->department_name = get_field_value(new Department(), "name", ["com_code" => $com_code, "id" => $info->employee_department_code]);
                    $info->branch_name = get_field_value(new Branch(), "name", ["com_code" => $com_code, "id" => $info->branch_id]);
                }
            }
            if ($request->submit_button != "in_details" and $request->submit_button != "in_total") {

                $total['salary_employee'] = 0;
                $total['day_price'] = 0;
                $total['total_rewards_salary'] = 0;
                $total['motivation'] = 0;
                $total['additional_days_counter'] = 0;
                $total['additional_days_total'] = 0;
                $total['fixed_allowances'] = 0;
                $total['changeable_allowance'] = 0;
                $total['total_benefits'] = 0;
                $total['absence_days_counter'] = 0;
                $total['absence_days_total'] = 0;
                $total['sanctions_days_counter'] = 0;
                $total['sanctions_days_total'] = 0;
                $total['monthly_loan'] = 0;
                $total['permanent_loan'] = 0;
                $total['discount'] = 0;
                $total['medical_insurance_monthly'] = 0;
                $total['medical_social_monthly'] = 0;
                $total['total_deductions'] = 0;
                $total['last_salary_remain_balance'] = 0;
                $total['net_salary'] = 0;
            }



            if (!empty($data)) {
                foreach ($data as $mainSalaryEmployee_data) {
                    $mainSalaryEmployee_data->employee_name = Employee::where("com_code", $com_code)
                        ->where("employee_code", $mainSalaryEmployee_data['employee_code'])
                        ->value('name');
                    $mainSalaryEmployee_data->gender = Employee::select("gender")->where("com_code", $com_code)->where("gender", $mainSalaryEmployee_data['gender']);
                    $mainSalaryEmployee_data->employee_department_code = Employee::select("department_id")->where("com_code", $com_code)->where("department_id", $mainSalaryEmployee_data['employee_department_code']);
                    $mainSalaryEmployee_data->job_categories_id = Employee::select("job_categories_id")->where("com_code", $com_code)->where("job_categories_id", $mainSalaryEmployee_data['employee_jobs_id']);
                    $mainSalaryEmployee_data->branch_id = Employee::select("branch_id")->where("com_code", $com_code)->where("branch_id", $mainSalaryEmployee_data['branch_id']);

                    if ($request->submit_button != "in_details" and $request->submit_button != "in_total") {
                        $total['salary_employee'] += $mainSalaryEmployee_data->salary_employee;
                        $total['day_price'] += $mainSalaryEmployee_data->day_price;
                        $total['total_rewards_salary'] += $mainSalaryEmployee_data->total_rewards_salary;
                        $total['motivation'] += $mainSalaryEmployee_data->motivation;
                        $total['additional_days_counter'] += $mainSalaryEmployee_data->additional_days_counter;
                        $total['additional_days_total'] += $mainSalaryEmployee_data->additional_days_total;
                        $total['fixed_allowances'] += $mainSalaryEmployee_data->fixed_allowances;
                        $total['changeable_allowance'] += $mainSalaryEmployee_data->changeable_allowance;
                        $total['total_benefits'] += $mainSalaryEmployee_data->total_benefits;
                        $total['absence_days_counter'] += $mainSalaryEmployee_data->absence_days_counter;
                        $total['absence_days_total'] += $mainSalaryEmployee_data->absence_days_total;
                        $total['sanctions_days_counter'] += $mainSalaryEmployee_data->sanctions_days_counter;
                        $total['sanctions_days_total'] += $mainSalaryEmployee_data->sanctions_days_total;
                        $total['monthly_loan'] += $mainSalaryEmployee_data->monthly_loan;
                        $total['permanent_loan'] += $mainSalaryEmployee_data->permanent_loan;
                        $total['discount'] += $mainSalaryEmployee_data->discount;
                        $total['medical_insurance_monthly'] += $mainSalaryEmployee_data->medical_insurance_monthly;
                        $total['medical_social_monthly'] += $mainSalaryEmployee_data->medical_social_monthly;
                        $total['total_deductions'] += $mainSalaryEmployee_data->total_deductions;
                        $total['last_salary_remain_balance'] += $mainSalaryEmployee_data->last_salary_remain_balance;
                        $total['net_salary'] += $mainSalaryEmployee_data->net_salary;
                    }
                }
            }


            $systemData = get_Columns_where_row(new AdminPanelSetting(), array('phons', 'address', 'image', 'company_name'), array("com_code" => $com_code));


            if ($request->submit_button == "in_details") {
                return view('dashboard.salaries.mainSalaryEmployees.print.print_search_in_details', ['data' => $data, 'systemData' => $systemData, 'mainSalaryEmployee_data' => $mainSalaryEmployee_data, 'finance_cln_periods_data' => $finance_cln_periods_data]);
            } elseif ($request->submit_button == "in_total") {

                $other['total_benefits'] = MainSalaryEmployee::select("*")
                    ->where($field1, $operator1, $value1)
                    ->where($field2, $operator2, $value2)
                    ->where($field3, $operator3, $value3)
                    ->where($field4, $operator4, $value4)
                    ->where($field5, $operator5, $value5)
                    ->where($field6, $operator6, $value6)
                    ->where($field7, $operator7, $value7)
                    ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                    ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->sum('total_benefits');

                $other['total_deductions'] = MainSalaryEmployee::select("*")
                    ->where($field1, $operator1, $value1)
                    ->where($field2, $operator2, $value2)
                    ->where($field3, $operator3, $value3)
                    ->where($field4, $operator4, $value4)
                    ->where($field5, $operator5, $value5)
                    ->where($field6, $operator6, $value6)
                    ->where($field7, $operator7, $value7)
                    ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                    ->where('com_code', '=', $com_code)
                    ->orderby('id', 'DESC')->sum('total_deductions');



                $other['net_salary'] = MainSalaryEmployee::select("*")
                    ->where($field1, $operator1, $value1)
                    ->where($field2, $operator2, $value2)
                    ->where($field3, $operator3, $value3)
                    ->where($field4, $operator4, $value4)
                    ->where($field5, $operator5, $value5)
                    ->where($field6, $operator6, $value6)
                    ->where($field7, $operator7, $value7)
                    ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                    ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->sum('net_salary');


                $other['salary_employee'] = MainSalaryEmployee::select("*")
                    ->where($field1, $operator1, $value1)
                    ->where($field2, $operator2, $value2)
                    ->where($field3, $operator3, $value3)
                    ->where($field4, $operator4, $value4)
                    ->where($field5, $operator5, $value5)
                    ->where($field6, $operator6, $value6)
                    ->where($field7, $operator7, $value7)
                    ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)
                    ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->sum('salary_employee');

                return view('dashboard.salaries.mainSalaryEmployees.print.print_search_in_total', ['data' => $data, 'systemData' => $systemData, 'mainSalaryEmployee_data' => $mainSalaryEmployee_data, 'finance_cln_periods_data' => $finance_cln_periods_data, 'other' => $other]);
            } else {


                DB::commit();

                return view('dashboard.salaries.mainSalaryEmployees.print.total_in_details', ['data' => $data, 'systemData' => $systemData, 'mainSalaryEmployee_data' => $mainSalaryEmployee_data, 'finance_cln_periods_data' => $finance_cln_periods_data, 'total' => $total]);
            }
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with('error', 'عفوآ حدث خطأ ما' . $ex->getMessage());
        }
    }



    public function showSalryDetails($mainSalaryEmployee_id)
    {
        $com_code = auth()->user()->com_code;
        $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

        if (empty($mainSalaryEmployee_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
        }

        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
        }

        if ($mainSalaryEmployee_data['is_archived'] == 0) {
            $this->recalculateMainSalaryEmployee($mainSalaryEmployee_id);
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));
        }

        // $mainSalaryEmployee_data->employee_name = Employee::select("name")->where("com_code", $com_code)->where("employee_code", $mainSalaryEmployee_data['employee_code']);
        $mainSalaryEmployee_data->gender = Employee::select("gender")->where("com_code", $com_code)->where("gender", $mainSalaryEmployee_data['gender']);
        $mainSalaryEmployee_data->employee_department_code = Employee::select("department_id")->where("com_code", $com_code)->where("department_id", $mainSalaryEmployee_data['employee_department_code']);
        $mainSalaryEmployee_data->job_categories_id = Employee::select("job_categories_id")->where("com_code", $com_code)->where("job_categories_id", $mainSalaryEmployee_data['employee_jobs_id']);
        $mainSalaryEmployee_data->branch_id = Employee::select("branch_id")->where("com_code", $com_code)->where("branch_id", $mainSalaryEmployee_data['branch_id']);
        return view('dashboard.salaries.mainSalaryEmployees.showSalrayDetails', compact('mainSalaryEmployee_data', 'finance_cln_periods_data'));
    }

    public function addManualSalary(Request $request, $finance_cln_periods_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !']);
            }
            if ($finance_cln_periods_data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن أضافة رواتب للشهر المالى الحالى فى هذه المرحلة !']);
            }

            DB::beginTransaction();

            $employeeData = get_Columns_where_row(
                new Employee(),
                array("*"),
                array('com_code' => $com_code, 'employee_code' => $request->employee_code_add)
            );
            if (empty($employeeData)) {
                return redirect()->back()->with(['error' => 'غير قادر للوصول لبيانات هذا الموظف !']);
            }
            $dataSalaryToInsert = array();
            $dataSalaryToInsert['finance_cln_periods_id'] = $finance_cln_periods_id;
            $dataSalaryToInsert['employee_code'] = $employeeData->employee_code;
            $dataSalaryToInsert['com_code'] = $com_code;
            $checkExistsCounter = get_count_where(new MainSalaryEmployee(), $dataSalaryToInsert);
            if ($checkExistsCounter > 0) {
                return redirect()->back()->with(['error' => 'عفوآ هذا الموظف له سجل راتب مضاف بهذا الشهر المالى !']);
            }
            $dataSalaryToInsert['employee_name'] = $employeeData->name;
            $dataSalaryToInsert['day_price'] = $employeeData->day_price;
            $dataSalaryToInsert['is_sensitive_manager_data'] = 1;
            $dataSalaryToInsert['branch_id'] = $employeeData->branch_id;
            $dataSalaryToInsert['employee_status'] = $employeeData->functional_status;
            $dataSalaryToInsert['employee_department_code'] = $employeeData->department_id;
            $dataSalaryToInsert['employee_jobs_id'] = $employeeData->job_categories_id;

            $lastSalaryData = get_cols_where_row_orderby(new MainSalaryEmployee(), array("net_salary_after_close_for_deportation"), array("com_code" => $com_code, "employee_code" => $employeeData->employee_code, "is_archived" => 1), "id", "DESC");
            if (!empty($lastSalaryData)) {
                $dataSalaryToInsert['last_salary_remain_balance'] = $lastSalaryData['net_salary_after_close_for_deportation'];
            } else {
                $dataSalaryToInsert['last_salary_remain_balance'] = 0;
            }
            $dataSalaryToInsert['salary_employee'] = $employeeData->salary;
            $dataSalaryToInsert['financial_year'] = $finance_cln_periods_data['finance_yr'];
            $dataSalaryToInsert['year_month'] = $finance_cln_periods_data['year_and_month'];
            $dataSalaryToInsert['cash_visa'] = $employeeData->Type_salary_receipt;
            $dataSalaryToInsert['created_by'] = auth()->user()->id;
            $flagInsert = insert(new MainSalaryEmployee(), $dataSalaryToInsert, true);
            if (!empty($flagInsert)) {
                $this->recalculateMainSalaryEmployee($flagInsert['id']);
            }

            DB::commit();
            return redirect()->back()->with('success', 'تم أضافة راتب الموظف بنجاح');
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما ' . $ex->getMessage()])->withInput();
        }
    }


    public function doStopSalary($mainSalaryEmployee_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

            if (empty($mainSalaryEmployee_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
            }

            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
            }

            if ($mainSalaryEmployee_data['is_archived'] == 1 or  $finance_cln_periods_data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن عمل هذا الاجراء حاليآ لان الشهر مؤرشف!']);
            }


            if ($mainSalaryEmployee_data['is_stopped'] == 'stopped') {
                return redirect()->back()->with(['error' => 'عفوا مرتب الموظف موقوف بالفعل!']);
            }
            DB::beginTransaction();

            $DataUpdate['is_stopped'] = 'stopped';
            $DataUpdate['updated_by'] = auth()->user()->id;
            update(new MainSalaryEmployee(), $DataUpdate, array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id, 'is_archived' => 0));
            DB::commit();
            return redirect()->back()->with(['success' => 'تم وقف المرتب بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }



    public function doUnlockSalary($mainSalaryEmployee_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

            if (empty($mainSalaryEmployee_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
            }

            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
            }

            if ($mainSalaryEmployee_data['is_archived'] == 1 or  $finance_cln_periods_data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن عمل هذا الاجراء حاليآ لان الشهر مؤرشف!']);
            }


            if ($mainSalaryEmployee_data['is_stopped'] == 'unstopped') {
                return redirect()->back()->with(['error' => 'عفوا مرتب الموظف مفتوح بالفعل!']);
            }
            DB::beginTransaction();

            $DataUpdate['is_stopped'] = 'unstopped';
            $DataUpdate['updated_by'] = auth()->user()->id;
            update(new MainSalaryEmployee(), $DataUpdate, array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));
            DB::commit();
            return redirect()->back()->with(['success' => 'تم فتح المرتب بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }


    public function doDeleteSalaryInternal($mainSalaryEmployee_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

            if (empty($mainSalaryEmployee_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
            }

            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
            }

            if ($mainSalaryEmployee_data['is_archived'] == 1 or  $finance_cln_periods_data['is_open'] != 1 or $mainSalaryEmployee_data['is_stopped'] == 'stopped') {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن عمل هذا الاجراء حاليآ لان الشهر مؤرشف!']);
            }
            DB::beginTransaction();
            destroy(new MainSalaryEmployee(), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));
            DB::commit();
            return redirect()->route('dashboard.mainSalaryEmployees.show', $mainSalaryEmployee_data['finance_cln_periods_id'])->with(['success' => 'تم حذف المرتب بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }



    public function loadArchiveSalary(Request $request)
    {

        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_id = $request->id;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id, 'is_archived' => 0, 'is_stopped' => 'unstopped'));
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id'], 'is_open' => 1));


            return view('dashboard.salaries.mainSalaryEmployees.loadArchiveSalary', ['mainSalaryEmployee_data' => $mainSalaryEmployee_data, 'finance_cln_periods_data' => $finance_cln_periods_data]);
        }
    }


    public function doArchiveSalary($mainSalaryEmployee_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

            if (empty($mainSalaryEmployee_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
            }

            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
            }

            if ($mainSalaryEmployee_data['is_archived'] == 1 or $mainSalaryEmployee_data['is_stopped'] == 'stopped' or  $finance_cln_periods_data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن عمل هذا الاجراء حاليآ لان الشهر مؤرشف!']);
            }


            if ($mainSalaryEmployee_data['is_stopped'] == 'stopped') {
                return redirect()->back()->with(['error' => 'عفوا مرتب الموظف موقوف بالفعل!']);
            }
            DB::beginTransaction();

            $DataUpdate['is_archived'] = 1;
            $DataUpdate['archived_date'] = date('Y-m-d H:i');
            $DataUpdate['updated_by'] = auth()->user()->id;



            //إذا كان مرتب الموظف بالموجب يبقى مستحق للموظف وبعد الارشفه  بيتم حفظ راتب الموظف داخل ظرف الراتب للشهر
            //إذا كان المرتب بالسالب يتم ترحيل السالب الى الشهر القادم

            if ($mainSalaryEmployee_data['net_salary'] < 0) {
                //المرتب سالب يرحل للشهر القادم
                $DataUpdate['net_salary_after_close_for_deportation'] = $mainSalaryEmployee_data['net_salary'];
            } else {
                $DataUpdate['net_salary_after_close_for_deportation'] = 0;
            }

            $flag = update(new MainSalaryEmployee(), $DataUpdate, array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id, 'is_archived' => 0, 'is_stopped' => 'unstopped'));
            $DataUpdate_variables['is_archived'] = 1;
            $DataUpdate_variables['archived_at'] = now();
            $DataUpdate_variables['archived_by'] = auth()->user()->id;
            update(new EmployeeSalarySanctions(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            update(new EmployeeSalaryAbsenceDay(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            update(new EmployeeSalaryDiscount(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            update(new EmployeeSalaryLoan(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            PermanentLoansInstallment::where('com_code', '=', $com_code)->where('year_month', "=", $finance_cln_periods_data['year_and_month'])
                ->where('is_archived', "=", 0)->where('status', "!=", 2)->where('employee_code', "=", $mainSalaryEmployee_data['employee_code'])
                ->where('main_salary_employees_id', "=", $mainSalaryEmployee_id)->update($DataUpdate_variables);
            update(new EmployeeSalaryAdditional(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            update(new EmployeeSalaryAllowance(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            update(new EmployeeSalaryRewards(), $DataUpdate_variables, array('com_code' => $com_code, 'main_salary_employees_id' => $mainSalaryEmployee_id, 'finance_cln_periods_id' => $finance_cln_periods_data['id']));
            DB::commit();
            return redirect()->back()->with(['success' => 'تم أرشفة المرتب بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }


    public function printSalary($mainSalaryEmployee_id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

            if (empty($mainSalaryEmployee_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
            }

            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
            if (empty($finance_cln_periods_data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
            }



            DB::beginTransaction();
            $mainSalaryEmployee_data->employee_name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $mainSalaryEmployee_data->employee_code));

            $mainSalaryEmployee_data->gender = Employee::select("gender")->where("com_code", $com_code)->where("gender", $mainSalaryEmployee_data['gender']);
            $mainSalaryEmployee_data->employee_department_code = Employee::select("department_id")->where("com_code", $com_code)->where("department_id", $mainSalaryEmployee_data['employee_department_code']);
            $mainSalaryEmployee_data->job_categories_id = Employee::select("job_categories_id")->where("com_code", $com_code)->where("job_categories_id", $mainSalaryEmployee_data['employee_jobs_id']);
            $mainSalaryEmployee_data->branch_id = Employee::select("branch_id")->where("com_code", $com_code)->where("branch_id", $mainSalaryEmployee_data['branch_id']);

            DB::commit();
            $systemData = get_Columns_where_row(new AdminPanelSetting(), array('phons', 'address', 'image', 'company_name'), array("com_code" => $com_code));
            return view('dashboard.salaries.mainSalaryEmployees.print.printSalary', ['mainSalaryEmployee_data' => $mainSalaryEmployee_data, 'finance_cln_periods_data' => $finance_cln_periods_data, 'systemData' => $systemData]);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }


    public function export(){
        return Excel::download(new MainSalaryEmployeeExport(), 'mainSalaryEmployees.xlsx');
    }

}












// مراتجعة الكود إذا حدث خطأ ما

// public function doArchiveSalary($mainSalaryEmployee_id)
// {
//     try {
//         $com_code = auth()->user()->com_code;
//         $mainSalaryEmployee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id));

//         if (empty($mainSalaryEmployee_data)) {
//             return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبة!']);
//         }

//         $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $mainSalaryEmployee_data['finance_cln_periods_id']));
//         if (empty($finance_cln_periods_data)) {
//             return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول إلى بيانات الشهر المالى!']);
//         }

//         if ($mainSalaryEmployee_data['is_archived'] == 1 or $mainSalaryEmployee_data['is_stopped'] == 'stopped' or  $finance_cln_periods_data['is_open'] != 1) {
//             return redirect()->back()->with(['error' => 'عفوا لا يمكن عمل هذا الاجراء حاليآ لان الشهر مؤرشف!']);
//         }


//         if ($mainSalaryEmployee_data['is_stopped'] == 'stopped') {
//             return redirect()->back()->with(['error' => 'عفوا مرتب الموظف موقوف بالفعل!']);
//         }
//         DB::beginTransaction();

//         $DataUpdate['is_archived'] = 1;
//         $DataUpdate['archived_date'] = date('Y-m-d H:i');
//         $DataUpdate['updated_by'] = auth()->user()->id;



//         //إذا كان مرتب الموظف بالموجب يبقى مستحق للموظف وبعد الارشفه  بيتم حفظ راتب الموظف داخل ظرف الراتب للشهر
//         //إذا كان المرتب بالسالب يتم ترحيل السالب الى الشهر القادم

//         if ($mainSalaryEmployee_data['net_salary'] < 0) {
//             //المرتب سالب يرحل للشهر القادم
//             $DataUpdate['net_salary_after_close_for_deportation'] = $mainSalaryEmployee_data['net_salary'];
//         } else {
//             $DataUpdate['net_salary_after_close_for_deportation'] = 0;
//         }

//         update(new MainSalaryEmployee(), $DataUpdate, array("com_code" => $com_code, 'id' => $mainSalaryEmployee_id, 'is_archived' => 0, 'is_stopped' => 'unstopped'));
//         DB::commit();
//         return redirect()->back()->with(['success' => 'تم أرشفة المرتب بنجاح']);
//     } catch (\Exception $ex) {
//         DB::rollBack();
//         return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
//     }
// }