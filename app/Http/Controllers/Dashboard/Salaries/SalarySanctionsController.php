<?php

namespace App\Http\Controllers\Dashboard\Salaries;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Employee;
use App\Traits\GeneralTrait;
use App\Models\FinanceCalendar;
use App\Models\FinanceClnPeriod;
use App\Models\AdminPanelSetting;
use App\Models\MainSalaryEmployee;
use Illuminate\Support\Facades\DB;
use App\Models\EmployeeSalarySanctions;

class SalarySanctionsController extends Controller
{
    use GeneralTrait;

    public function __construct()
    {
        $this->middleware('permission:الجزاءات', ['only' => ['index']]);
        $this->middleware('permission:عرض الجزاءات', ['only' => ['show']]);
        $this->middleware('permission:اضافة الجزاءات', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الجزاءات', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الجزاءات', ['only' => ['destroy']]);
        $this->middleware('permission:طباعه الجزاءات', ['only' => ['print_search']]);
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

        return view('dashboard.salaries.sanctions.index', compact('data'));
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
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("id"), array("com_code" => $com_code, 'id' => $request->finance_cln_periods_id, 'is_open' => 1));
            $main_salary_employee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, 'employee_code' => $request->employee_code, 'is_archived' => 0));
            if (!empty($finance_cln_periods_data) and !empty($main_salary_employee_data)) {
                DB::beginTransaction();
                $dataToInsert['main_salary_employees_id'] = $main_salary_employee_data['id'];
                $dataToInsert['finance_cln_periods_id'] = $request->finance_cln_periods_id;
                $dataToInsert['is_auto'] = 1;
                $dataToInsert['employee_code'] = $request->employee_code;
                $dataToInsert['day_price'] = $request->day_price;
                $dataToInsert['sanctions_type'] = $request->sanctions_type;
                $dataToInsert['value'] = $request->value;
                $dataToInsert['total'] = $request->total;
                $dataToInsert['notes'] = $request->notes;
                $dataToInsert['created_by'] = auth()->user()->id;
                $dataToInsert['com_code'] = $com_code;
                $flagInsert = insert(new EmployeeSalarySanctions(), $dataToInsert);
                if ($flagInsert) {
                    $this->recalculateMainSalaryEmployee($main_salary_employee_data['id']);
                }

                DB::commit();
                return json_encode("done");
            }
        }
    }



    /**
     * Display the specified resource.
     */


    public function show($finance_cln_periods_id)
    {
        $com_code = auth()->user()->com_code;
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id));

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
        }

        $data = EmployeeSalarySanctions::orderBy('id', 'DESC')
            ->where('com_code', $com_code)
            ->where('finance_cln_periods_id', $finance_cln_periods_id)
            ->paginate(5);

        if (!empty($data)) {
            foreach ($data as $info) {
                $info->emp_name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $info->employee_code));
            }
        }


        $employees = MainSalaryEmployee::where("com_code", "=", $com_code)->where("finance_cln_periods_id", "=", $finance_cln_periods_id)->distinct()->get("employee_code");
        if (!empty($employees)) {
            foreach ($employees as $info) {
                $info->EmployeeData = get_Columns_where_row(new Employee(), array("name", "salary", "day_price"), array("com_code" => $com_code, "employee_code" => $info->employee_code));
            }
        }
        $employees_for_search = get_cols_where(new Employee(), array("employee_code", "name", "salary", "day_price", "fp_code"), array("com_code" => $com_code), 'employee_code', 'ASC');



        return view('dashboard.salaries.sanctions.show', compact('data', 'finance_cln_periods_data', 'employees', 'employees_for_search'));
    }

    /**
     * edit the form for editing the specified resource.
     */


    public function load_edit_row(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("id"), array("com_code" => $com_code, 'id' => $request->the_finance_cln_periods_id, 'is_open' => 1));
            $main_salary_employees_data = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, 'finance_cln_periods_id' => $request->the_finance_cln_periods_id, 'id' => $request->main_salary_employees_id, 'is_archived' => 0));
            $sanctions = get_Columns_where_row(new EmployeeSalarySanctions(), array("*"), array("com_code" => $com_code, 'id' => $request->id, 'is_archived' => 0, 'finance_cln_periods_id' => $request->the_finance_cln_periods_id, 'main_salary_employees_id' => $request->main_salary_employees_id));
            $employees = MainSalaryEmployee::where("com_code", "=", $com_code)->where("finance_cln_periods_id", "=", $request->the_finance_cln_periods_id)->distinct()->get("employee_code");

            $employee = get_cols_where(new Employee(), array("employee_code", "name", "salary", "day_price"), array("com_code" => $com_code), 'employee_code', 'ASC');

            if (!empty($employees)) {
                foreach ($employees as $info) {
                    $info->EmployeeData = get_Columns_where_row(new Employee(), array("name", "salary", "day_price"), array("com_code" => $com_code, "employee_code" => $info->employee_code));
                }
            }
            return view('dashboard.salaries.sanctions.load_edit_row', ['finance_cln_periods_data' => $finance_cln_periods_data, 'main_salary_employees_data' => $main_salary_employees_data, 'sanctions' => $sanctions, 'employees' => $employees, 'employee' => $employee]);
        }
    }



    /**
     * update the form for editing the specified resource.
     */


    public function do_edit_row(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;

            // Fetch related data
            $finance_cln_periods_data = FinanceClnPeriod::where([
                'com_code' => $com_code,
                'id' => $request->the_finance_cln_periods_id,
                'is_open' => 0
            ]);

            $main_salary_employees = MainSalaryEmployee::where([
                'com_code' => $com_code,
                'finance_cln_periods_id' => $request->the_finance_cln_periods_id,
                'employee_code' => $request->employee_code,
                'is_archived' => 0,
                'id' => $request->main_salary_employees_id
            ]);

            $sanctions = EmployeeSalarySanctions::where([
                'com_code' => $com_code,
                'id' => $request->id,
                'is_archived' => 0,
                'finance_cln_periods_id' => $request->the_finance_cln_periods_id,
                'main_salary_employees_id' => $request->main_salary_employees_id
            ]);

            // Validate fetched data
            if ($finance_cln_periods_data && $main_salary_employees && $sanctions) {
                DB::beginTransaction();

                try {
                    // Update sanctions data
                    $flagInsert = $sanctions->update([
                        'employee_code' => $request->employee_code,
                        'day_price' => $request->day_price,
                        'sanctions_type' => $request->sanctions_type,
                        'value' => $request->value,
                        'total' => $request->total,
                        'notes' => $request->notes,
                        'updated_by' => auth()->user()->id
                    ]);

                    if ($flagInsert) {
                        $this->recalculateMainSalaryEmployee($request->main_salary_employees_id);
                    }
                    DB::commit();
                    return response()->json('done');
                } catch (\Exception $e) {
                    DB::rollBack();
                    return response()->json(['error' => 'حدث خطأ أثناء تحديث السجل.'], 500);
                }
            } else {
                return response()->json(['error' => 'تم إدخال بيانات غير صالحة.'], 400);
            }
        }
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

            // استرجاع البيانات من جدول EmployeeSalarySanctions
            $data = get_Columns_where_row(new EmployeeSalarySanctions(), array("*"), array("com_code" => $com_code, 'id' => $id));

            if (empty($data)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }

            // استرجاع بيانات الموظف من جدول MainSalaryEmployee
            $main_salary_employee_data = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array(
                'com_code' => $com_code,
                'finance_cln_periods_id' => $data->finance_cln_periods_id,
                'employee_code' => $data->employee_code,
                'is_archived' => 0
            ));

            // التأكد من وجود بيانات الموظف
            if (empty($main_salary_employee_data)) {
                return redirect()->back()->with(['error' => 'عفوا لم يتم العثور على بيانات الموظف.']);
            }

            DB::beginTransaction();

            // تنفيذ عملية الحذف
            $flagInsert = destroy(new EmployeeSalarySanctions(), array("com_code" => $com_code, 'id' => $id));

            if ($flagInsert) {
                // إعادة حساب الراتب الأساسي
                $this->recalculateMainSalaryEmployee($main_salary_employee_data['id']);
            }

            DB::commit();
            return redirect()->back()->with(['success' => 'تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ: ' . $ex->getMessage()])->withInput();
        }
    }






    public function checkExsistsBefor(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $checkExsistsBeforCounter = get_count_where(new EmployeeSalarySanctions(), array("com_code" => $com_code, "finance_cln_periods_id" => $request->the_finance_cln_periods_id, "employee_code" => $request->employee_code));
            if ($checkExsistsBeforCounter > 0) {
                return json_encode("exsists_befor");
            } else {
                return json_encode("no_exsists_befor");
            }
        }
    }


    public function ajaxSearch(Request $request)
    {


        if ($request->ajax()) {
            $employee_code = $request->employee_code;
            $sanctions_type = $request->sanctions_type;
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
            if ($sanctions_type == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field2 = "id";
                $operator2 = ">";
                $value2 = 0;
            } else {
                $field2 = "sanctions_type";
                $operator2 = "=";
                $value2 = $sanctions_type;
            }
            if ($is_archived == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field3 = "id";
                $operator3 = ">";
                $value3 = 0;
            } else {
                $field3 = "is_archived";
                $operator3 = "=";
                $value3 = $is_archived;
            }
            $com_code = auth()->user()->com_code;
            $data = EmployeeSalarySanctions::select("*")->where($field1, $operator1, $value1)->where($field2, $operator2, $value2)->where($field3, $operator3, $value3)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)->where('com_code', '=', $com_code)->orderby('id', 'DESC')->paginate(5);
            if (!empty($data)) {
                foreach ($data as $info) {
                    $info->name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $info->employee_code));
                }
            }

            return view('dashboard.salaries.sanctions.ajax_search', ['data' => $data]);
        }
    }


    public function print_search(Request $request)
    {

        $employee_code = $request->employee_code_search;
        $sanctions_type = $request->sanctions_type_search;
        $is_archived = $request->is_archived_search;
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
        if ($sanctions_type == 'all') {
            //هنا نعمل شرط دائم التحقق
            $field2 = "id";
            $operator2 = ">";
            $value2 = 0;
        } else {
            $field2 = "sanctions_type";
            $operator2 = "=";
            $value2 = $sanctions_type;
        }
        if ($is_archived == 'all') {
            //هنا نعمل شرط دائم التحقق
            $field3 = "id";
            $operator3 = ">";
            $value3 = 0;
        } else {
            $field3 = "is_archived";
            $operator3 = "=";
            $value3 = $is_archived;
        }
        $com_code = auth()->user()->com_code;
        $other['value_sum'] = 0;
        $other['total_sum'] = 0;
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, 'id' => $the_finance_cln_periods_id));
        $data = EmployeeSalarySanctions::select("*")->where($field1, $operator1, $value1)->where($field2, $operator2, $value2)->where($field3, $operator3, $value3)
            ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)->where('com_code', '=', $com_code)->orderby('id', 'DESC')->get();
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $info->employee_code));
                $other['value_sum'] += $info->value;
                $other['total_sum'] += $info->total;
            }
        }
        $systemData = get_Columns_where_row(new AdminPanelSetting(), array('phons', 'address', 'image', 'company_name'), array("com_code" => $com_code));
        return view('dashboard.salaries.sanctions.print_search', ['data' => $data, 'finance_cln_periods_data' => $finance_cln_periods_data, 'systemData' => $systemData, 'other' => $other]);
    }
}
