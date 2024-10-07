<?php

namespace App\Http\Controllers\Dashboard\Attendance;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\Dashboard\attendanceDeparturesUploadExcel;
use App\Models\AttendanceDepartureAction;
use App\Models\Employee;
use App\Models\FinanceClnPeriod;
use App\Models\FinanceCalendar;
use App\Models\MainSalaryEmployee;
use App\Models\AttendanceDeparture;
use App\Models\AttendanceDepartureActionExcel;
use App\Imports\AttendanceDepartureImport;
use App\Models\VacationType;
use App\Models\Branch;
use App\Models\Department;
use App\Models\JobsCategory;

use App\Models\WeekDay;
use DateTime;
use Maatwebsite\Excel\Facades\Excel;

class AttendanceDepartureController extends Controller
{


    public function __construct()
    {
        $this->middleware('permission:سجلات بصمة الموظفين', ['only' => ['index']]);
        $this->middleware('permission:عرض بصمة الموظفين', ['only' => ['show']]);
        $this->middleware('permission:اضافة بصمة الموظفين', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل بصمة الموظفين', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف بصمة الموظفين', ['only' => ['destroy']]);
        $this->middleware('permission:طباعه بصمة الموظفين', ['only' => ['print_search']]);
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

        return view('dashboard.attendanceDepartures.attendanceDepartures.index', compact('data'));
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
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id));
        $last_attendance_departures_date = get_cols_where_row_orderby(new AttendanceDepartureActionExcel(), array("date_time_action", "created_at", "created_by"), array("com_code" => $com_code, "id" => $finance_cln_periods_id), 'date_time_action', 'DESC');

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
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
            "employees.gender",                 // جلب الجنس
            "employees.fp_code",                 // جلب الجنس
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
            ->paginate(5);
        $other['branches'] = get_cols_where(new Branch, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['departements'] = get_cols_where(new Department, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['jobs'] = get_cols_where(new JobsCategory, array('id', 'name'), array('com_code' => $com_code, "active" => 1));

        $employees_for_search = get_cols_where(new Employee(), array("employee_code", "name"), array("com_code" => $com_code), 'employee_code', 'ASC');
        $employees = get_cols_where(new Employee(), array("employee_code", "name", "salary", "fp_code", "day_price"), array("com_code" => $com_code), 'employee_code', 'ASC');


        return view('dashboard.attendanceDepartures.attendanceDepartures.show', compact('other', 'data', 'finance_cln_periods_data', 'employees_for_search', 'last_attendance_departures_date', 'employees'));
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
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        //
    }

    public function uploadFileExcel($finance_cln_periods_id)
    {
        $com_code = auth()->user()->com_code;
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id, 'is_open' => 1));

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
        }
        return view('dashboard.attendanceDepartures.attendanceDepartures.uploadFileExcel', compact('finance_cln_periods_data'));
    }


    public function DoUploadFileExcel($finance_cln_periods_id, attendanceDeparturesUploadExcel $request)
    {

        $com_code = auth()->user()->com_code;
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id, 'is_open' => 1));

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
        }
        Excel::import(new AttendanceDepartureImport($finance_cln_periods_data), $request->file('excel_file'));

        return response()->json(['success' => 'تم ارفاق الملف بنجاح']);
    }

    public function showAttendanceDetails($employee_code, $finance_cln_periods_id)
    {
        $com_code = auth()->user()->com_code;
        $employee_data = get_Columns_where_row(new Employee(), array("*"), array("com_code" => $com_code, "employee_code" => $employee_code));

        if (empty($employee_data)) {
            return redirect()->route('dashboard.attendanceDepartures.show', $finance_cln_periods_id['id'])->with(['error' => 'عفوا غير قادر للوصول الى بيانات الموظف !'])->withInput();
        }
        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id));

        if (empty($finance_cln_periods_data)) {
            return redirect()->route('dashboard.attendanceDepartures.index')->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
        }


        return view('dashboard.attendanceDepartures.attendanceDepartures.showAttendanceDetails', compact('employee_data', 'finance_cln_periods_data'));
    }


    public function load_fp_archive(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $AttendanceDepartureActionExcel = get_cols_where(new AttendanceDepartureActionExcel(), array("*"), array("com_code" => $com_code, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id), 'date_time_action', 'ASC');
            if (!empty($AttendanceDepartureActionExcel)) {
                foreach ($AttendanceDepartureActionExcel as $info) {
                    $dt = new DateTime($info->date_time_action);
                    $date = $dt->format('Y-m-d');
                    $nameOfDay = date('l', strtotime($date));
                    $info->week_day_name_ar = get_field_value(new WeekDay(), "name", array("name_en" => $nameOfDay));
                }
            }
            // تمرير البيانات إلى العرض
            return view("dashboard.attendanceDepartures.attendanceDepartures.load_fp_archive", ['AttendanceDepartureActionExcel' => $AttendanceDepartureActionExcel]);
        }
    }


    public function load_active_attendance_departure(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $other['employee_data'] = get_Columns_where_row(new Employee(), array("*"), array("com_code" => $com_code, "employee_code" => $request->employee_code));
            $other['VacationType'] = VacationType::all();

            if (!empty($other['employee_data'])) {
                $other['finance_cln_periods_data'] = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $request->finance_cln_periods_id));
                if (!empty($other['finance_cln_periods_data'])) {
                    //لو الشهر المالى مازال مفتوح ولم يؤرشف
                    if ($other['finance_cln_periods_data']['is_open'] == 1) {
                        //checkDaiesInterval
                        //هنا بنجيب اكبر تاريخ و اخر تاريخ تم سحب البصمة الية
                        $max_attendance_date = AttendanceDeparture::where("com_code", $com_code)->where("finance_cln_periods_id", $request->finance_cln_periods_id)->max('date_in');
                        $to_date = $other['finance_cln_periods_data']['end_date_fp'];
                        $from_date = $other['finance_cln_periods_data']['start_date_fp'];
                        while ($from_date <= $to_date and $from_date <= $max_attendance_date) {
                            //هنا هنشوف الايام الفارغه اللى الموظف لم يعمل بها بصمه اجراء التعبئة تلقائى وتطبيق الضبط ورصيد الأجازات
                            $is_exists = get_Columns_where_row(new AttendanceDeparture(), array("id"), array("com_code" => $com_code, "finance_cln_periods_id" => $request->finance_cln_periods_id, "employee_code" => $request->employee_code, "the_day_date" => $from_date));
                            //هنا اليوم لو مش موجود يبقى لازم النظام ينزل له سجل ويطبق علية متغيرات ان وجدت
                            if (empty($is_exists)) {
                                // تعتبر كأول بصمة للموظف خلال الشهر المالى المفتوح حاليآ
                                // After Check Empty Last
                                $datainsert['finance_cln_periods_id'] = $request->finance_cln_periods_id;
                                $datainsert['shift_hour_contract'] = $other['employee_data']['daily_work_hour'];
                                $datainsert['employee_code'] = $request->employee_code;
                                $datainsert['year_month'] = $other['finance_cln_periods_data']['year_and_month'];
                                $datainsert['branch_id'] = $other['employee_data']['branch_id'];
                                $datainsert['employee_status'] = $other['employee_data']['functional_status'];

                                $main_salary_employees = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "employee_code" => $request->employee_code, "is_archived" => 0));
                                if (!empty($main_salary_employees)) {
                                    $datainsert['main_salary_employees_id'] = $main_salary_employees['id'];
                                }
                                $datainsert['created_by'] = auth()->user()->id;
                                $datainsert['com_code'] = $com_code;
                                // سيتم تغييرة لاحقآ
                                $datainsert['the_day_date'] = $from_date;
                                //باقى هنا تطبيق متغيرات تلقائية مثل خصم رصيد الاجازات و لاحقآ سيتم تكملته
                                insert(new AttendanceDeparture(), $datainsert, true);
                            }
                            $from_date = date("Y-m-d", strtotime($from_date . ' +1 day'));
                        }
                    }
                    $other['data'] = get_cols_where(new AttendanceDeparture(), array("*"), array("com_code" => $com_code, "finance_cln_periods_id" => $request->finance_cln_periods_id, "employee_code" => $request->employee_code), 'the_day_date', 'ASC');
                    $other['total_cut'] = 0;
                    $other['total_attendance_delay'] = 0;
                    $other['total_early_departure'] = 0;
                    $other['total_hours_total'] = 0;
                    $other['total_absence_hours'] = 0;
                    $other['total_additional_hours'] = 0;
                    $other['total_vacations_types'] = 0;
                    $other['total_permission_hours'] = 0;
                    if (!empty($other['data'])) {
                        foreach ($other['data'] as $info) {
                            $nameOfDay = date('l', strtotime($info->the_day_date));
                            $info->week_day_name_ar = get_field_value(new WeekDay(), "name", array("name_en" => $nameOfDay));
                            $info->attendance_departure_actions_counter = get_count_where(new AttendanceDepartureAction(), array("attendance_departure_id" => $info->id, "finance_cln_periods_id" => $request->finance_cln_periods_id, "employee_code" => $request->employee_code));

                            //حساب الأجمالى
                            if ($info->cut != null) {
                                $other['total_cut'] += $info->cut;
                            }
                            if ($info->total_attendance_delay != null) {
                                $other['total_attendance_delay'] += $info->total_attendance_delay;
                            }
                            if ($info->early_departure != null) {
                                $other['total_early_departure'] += $info->early_departure;
                            }
                            if ($info->total_hours != null) {
                                $other['total_hours_total'] += $info->total_hours;
                            }
                            if ($info->absence_hours != null) {
                                $other['total_absence_hours'] += $info->absence_hours;
                            }
                            if ($info->additional_hours != null) {
                                $other['total_additional_hours'] += $info->additional_hours;
                            }
                            if ($info->vacations_types_id != null) {
                                $other['total_vacations_types'] += 1;
                            }

                            if ($info->permission_hours != null) {
                                $other['total_permission_hours'] += 1;
                            }
                        }
                    }
                    // Make sure $max_attendance_date is set even if it's empty
                    $max_attendance_date = $max_attendance_date ?? null;

                    $other['vacationType_distinct'] = AttendanceDeparture::where("com_code", "=", $com_code)
                        ->where("finance_cln_periods_id", "=", $request->finance_cln_periods_id)
                        ->where("employee_code", "=", $request->employee_code)
                        ->where("vacations_types_id", ">", 0)
                        ->orderBy("vacations_types_id", "ASC")->DISTINCT()->get("vacations_types_id");

                    if (!empty($other['vacationType_distinct'])) {
                        foreach ($other['vacationType_distinct'] as $info) {
                            $info->name = get_field_value(new VacationType(), "name", array("id" => $info->vacations_types_id));
                            $info->counter = get_count_where(new AttendanceDeparture(), array(
                                "com_code" => $com_code,
                                "finance_cln_periods_id" => $request->finance_cln_periods_id,
                                "employee_code" => $request->employee_code,
                                "vacations_types_id" => $info->vacations_types_id
                            ));
                        }
                    }
                    return view('dashboard.attendanceDepartures.attendanceDepartures.load_active_attendance_departure', compact('other', 'max_attendance_date', 'other'));
                }
            }
        }
    }


    public function load_my_actions(Request $request)
    {

        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $parent = get_Columns_where_row(new AttendanceDeparture(), array("id", "date_time_in", "date_time_out", "is_archived", "is_updated_active_action", "is_updated_active_action_date", "is_updated_active_action_by"), array("com_code" => $com_code, "employee_code" => $request->employee_code, "id" => $request->attendance_departure_id, 'finance_cln_periods_id' => $request->finance_cln_periods_id));
            $other['VacationType'] = VacationType::all();
            $AttendanceDepartureAction = get_cols_where(new AttendanceDepartureAction(), array("*"), array("com_code" => $com_code, "employee_code" => $request->employee_code,  'finance_cln_periods_id' => $request->finance_cln_periods_id, "attendance_departure_id" => $request->attendance_departure_id), 'date_time_action', 'ASC');
            if (!empty($AttendanceDepartureAction)) {
                foreach ($AttendanceDepartureAction as $info) {
                    $dt = new DateTime($info->date_time_action);
                    $date = $dt->format('Y-m-d');
                    $nameOfDay = date('l', strtotime($date));
                    $info->week_day_name_ar = get_field_value(new WeekDay(), "name", array("name_en" => $nameOfDay));
                }
            }
            // تمرير البيانات إلى العرض
            return view("dashboard.attendanceDepartures.attendanceDepartures.load_my_actions", ['AttendanceDepartureAction' => $AttendanceDepartureAction, 'parent' => $parent, 'other' => $other]);
        }
    }



    public function save_active_attendance_departure(Request $request)
    {

        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $attendance_departures = get_Columns_where_row(new AttendanceDeparture(), array("the_day_date"), array("com_code" => $com_code, "id" => $request->id, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, "is_archived" => 0));
            if (!empty($attendance_departures)) {
                $dataToUpdate['variables'] = $request->variables;
                $dataToUpdate['cut'] = $request->cut;
                $dataToUpdate['vacations_types_id'] = $request->vacations_types_id;
                $dataToUpdate['attendance_delay'] = $request->attendance_delay;
                $dataToUpdate['early_departure'] = $request->early_departure;
                $dataToUpdate['permission_hours'] = $request->permission_hours;
                $dataToUpdate['total_hours'] = $request->total_hours;
                $dataToUpdate['absence_hours'] = $request->absence_hours;
                $dataToUpdate['additional_hours'] = $request->additional_hours;
                $flag = update(new AttendanceDeparture(), $dataToUpdate,  array("com_code" => $com_code, "id" => $request->id, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, "is_archived" => 0));
                if ($flag) {
                    return json_encode("تم حفظ البيانات بنجاح");
                }
            }
        }
    }



    public function redo_update_actions(Request $request)
    {

        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $attendance_departures = get_Columns_where_row(new AttendanceDeparture(), array("*"), array("com_code" => $com_code, "id" => $request->id, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, "is_archived" => 0));
            if (!empty($attendance_departures)) {
                $date_time_in =  $request->date_time_in;
                $date_time_out =  $request->date_time_out;
                if ($date_time_out != "") {
                    //سوف نرى فرق الدقائق بين البصمة المسجله و البصمة الحالية
                    $seconds = strtotime($date_time_out) - strtotime($date_time_in);
                    $hourdiff = $seconds / 60 / 60;
                    $hourdiff = number_format((float)$hourdiff, 2, '.', '');
                    $minuitdiff = $seconds / 60;
                    $minuitdiff = number_format((float)$minuitdiff, 2, '.', '');

                    if ($hourdiff < 0) $hourdiff = $hourdiff * (-1);
                    if ($minuitdiff < 0) $minuitdiff = $minuitdiff * (-1);
                    //سوف نعمل على متغيرات أقفال البصمة الحالية
                    $dataUpdate['date_time_in'] = date("Y-m-d H:i:s", strtotime($date_time_in));
                    $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($date_time_out));
                    $dataUpdate['date_out'] = date("Y-m-d", strtotime($date_time_out));
                    $dataUpdate['time_out'] = date("H:i:s", strtotime($date_time_out));
                    $dataUpdate['total_hours'] = $hourdiff;
                    if ($hourdiff < $attendance_departures['shift_hour_contract']) {
                        $dataUpdate['additional_hours'] = 0;
                        $dataUpdate['absence_hours'] = $attendance_departures['shift_hour_contract'] - $hourdiff;
                    }
                    if ($hourdiff > $attendance_departures['shift_hour_contract']) {
                        $dataUpdate['additional_hours'] = $hourdiff - $attendance_departures['shift_hour_contract'];
                        $dataUpdate['absence_hours'] = 0;
                    }
                    $dataUpdate['is_updated_active_action'] = 1;
                    $dataUpdate['is_updated_active_action_date'] = date("Y-m-d H:i:s");
                    $dataUpdate['is_updated_active_action_by'] = auth()->user()->id;

                    $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("com_code" => $com_code, "id" => $request->id, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, "is_archived" => 0));
                    if ($flagUpdateParent) {
                        return json_encode("تم تعديل البيانات بنجاح");
                    }
                } else {
                    $dataUpdate['total_hours'] = 0;
                    $dataUpdate['additional_hours'] = 0;
                    $dataUpdate['absence_hours'] = 0;
                    $dataUpdate['is_updated_active_action'] = 1;
                    $dataUpdate['is_updated_active_action_date'] = date("Y-m-d H:i:s");
                    $dataUpdate['is_updated_active_action_by'] = auth()->user()->id;
                    $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("com_code" => $com_code, "id" => $request->id, "employee_code" => $request->employee_code, 'finance_cln_periods_id' => $request->finance_cln_periods_id, "is_archived" => 0));
                    if ($flagUpdateParent) {
                        return json_encode("تم تعديل البيانات بنجاح");
                    }
                }
            }
        }
    }

    public function print_one_fp_details($employee_code, $finance_cln_periods_id)
    {
        $com_code = auth()->user()->com_code;
        $other['employee_data'] = get_Columns_where_row(new Employee(), array("*"), array("com_code" => $com_code, "employee_code" => $employee_code));
        if (empty($other['employee_data'])) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على بيانات الموظف !'])->withInput();
        }

        $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $finance_cln_periods_id));
        $last_attendance_departures_date = get_cols_where_row_orderby(new AttendanceDepartureActionExcel(), array("date_time_action", "created_at", "created_by"), array("com_code" => $com_code, "id" => $finance_cln_periods_id), 'date_time_action', 'DESC');

        if (empty($finance_cln_periods_data)) {
            return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول على البيانات المطلوبه !'])->withInput();
        }


        $other['data'] = get_cols_where(new AttendanceDeparture(), array("*"), array("com_code" => $com_code, "finance_cln_periods_id" => $finance_cln_periods_id, "employee_code" => $employee_code), 'the_day_date', 'ASC');
        $other['total_cut'] = 0;
        $other['total_attendance_delay'] = 0;
        $other['total_early_departure'] = 0;
        $other['total_hours_total'] = 0;
        $other['total_absence_hours'] = 0;
        $other['total_additional_hours'] = 0;
        $other['total_vacations_types'] = 0;
        $other['total_permission_hours'] = 0;
        if (!empty($other['data'])) {
            foreach ($other['data'] as $info) {
                $nameOfDay = date('l', strtotime($info->the_day_date));
                $info->week_day_name_ar = get_field_value(new WeekDay(), "name", array("name_en" => $nameOfDay));
                $info->attendance_departure_actions_counter = get_count_where(new AttendanceDepartureAction(), array("attendance_departure_id" => $info->id, "finance_cln_periods_id" => $finance_cln_periods_id, "employee_code" => $employee_code));

                //حساب الأجمالى
                if ($info->cut != null) {
                    $other['total_cut'] += $info->cut;
                }
                if ($info->total_attendance_delay != null) {
                    $other['total_attendance_delay'] += $info->total_attendance_delay;
                }
                if ($info->early_departure != null) {
                    $other['total_early_departure'] += $info->early_departure;
                }
                if ($info->total_hours != null) {
                    $other['total_hours_total'] += $info->total_hours;
                }
                if ($info->absence_hours != null) {
                    $other['total_absence_hours'] += $info->absence_hours;
                }
                if ($info->additional_hours != null) {
                    $other['total_additional_hours'] += $info->additional_hours;
                }
                if ($info->vacations_types_id != null) {
                    $other['total_vacations_types'] += 1;
                }

                if ($info->permission_hours != null) {
                    $other['total_permission_hours'] += 1;
                }
            }
        }


        return view('dashboard.attendanceDepartures.attendanceDepartures.print_one_fp_details', compact('finance_cln_periods_data',  'last_attendance_departures_date', 'other'));
    }




    public function ajax_search(Request $request)
    {


        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $request->finance_cln_periods_id));
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
            $data = MainSalaryEmployee::select("*")
                ->where($field1, $operator1, $value1)
                ->where($field2, $operator2, $value2)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where($field5, $operator5, $value5)
                ->where($field6, $operator6, $value6)
                ->where($field7, $operator7, $value7)
                ->where('finance_cln_periods_id', '=', $the_finance_cln_periods_id)->where('com_code', '=', $com_code)->orderby('id', 'DESC')->paginate(5);



            if (!empty($data)) {
                foreach ($data as $info) {
                    $info->name = get_field_value(new Employee(), "name", array("com_code" => $com_code, "employee_code" => $info->employee_code));
                }
            }

            return view('dashboard.attendanceDepartures.attendanceDepartures.ajax_search', ['data' => $data, 'finance_cln_periods_data' => $finance_cln_periods_data]);
        }
    }
}
