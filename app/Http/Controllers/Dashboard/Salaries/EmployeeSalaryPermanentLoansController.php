<?php

namespace App\Http\Controllers\Dashboard\Salaries;

use App\Http\Controllers\Controller;
use App\Models\AdminPanelSetting;
use App\Models\Employee;
use App\Models\EmployeeSalaryPermanentLoans;
use App\Models\MainSalaryEmployee;
use App\Models\PermanentLoansInstallment;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmployeeSalaryPermanentLoansController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:السلف المستديمة', ['only' => ['index']]);
        $this->middleware('permission:عرض السلف المستديمة', ['only' => ['show']]);
        $this->middleware('permission:اضافة السلف المستديمة', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل السلف المستديمة', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف السلف المستديمة', ['only' => ['destroy']]);
        $this->middleware('permission:طباعه السلف المستديمة', ['only' => ['print_search']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code], 'id', 'DESC')->paginate(12);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->emp_name = get_field_value(new Employee, 'name', ['com_code' => $com_code, 'employee_code' => $info->employee_code]);
            }
        }

        $other['employees'] = Employee::select('employee_code', 'name', 'salary', 'day_price', 'fp_code')->where('com_code', '=', $com_code)->where('functional_status', '=', 'Employee')->orderBy('id', 'DESC')->get();

        return view('dashboard.salaries.permanentLoan.index', compact('data', 'other'));
    }

    use GeneralTrait;

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
            $employeeData = Employee::select('id')
                ->where('employee_code', $request->employee_code)
                ->where('com_code', $com_code)
                ->where('functional_status', 'Employee')
                ->first();

            if ($employeeData) {
                DB::beginTransaction();
                try {
                    $dataToInsert = [
                        'employee_code' => $request->employee_code,
                        'employee_salary' => $request->employee_salary,
                        'total' => $request->total,    //أجمالى القرض أو السلفه
                        'month_number_installment' => $request->month_number_installment,   //	عدد الشهور للأقساط
                        'month_installment_value' => $request->month_installment_value,   //قيمة القسط الشهرى
                        'installment_paid' => 0,   //قيمة القسط المدفوع
                        'installment_remain' => 0,   //قيمة القسط المتبقى
                        'year_month_start_date' => $request->year_month_start_date,  //يبدأ سداد أول قسط بتاريخ
                        'year_month_start' => date('Y-m', strtotime($request->year_month_start_date)),  //	يبدأ السداد من الشهر المالى
                        'notes' => $request->notes,
                        'created_at' => date('Y-m-d H:i:s'),  //	يبدأ السداد من الشهر المالى
                        'created_by' => auth()->user()->id,
                        'com_code' => $com_code,
                    ];

                    // Insert main record
                    $flagParent = EmployeeSalaryPermanentLoans::create($dataToInsert);

                    if ($flagParent) {
                        // تقسيم الأقساط الشهرية تلقائيآ
                        $i = 1;
                        $effictiveData = $dataToInsert['year_month_start']; //	يبدأ السداد من الشهر المالى

                        while ($i <= $dataToInsert['month_number_installment']) {
                            $dataToInstallment = [
                                'employee_permanent_loans_id' => $flagParent->id,
                                'employee_code' => $request->employee_code,
                                'main_salary_employees_id' => $employeeData->id,
                                'month_installment_value' => $dataToInsert['month_installment_value'],   //قيمة القسط
                                'year_month' => $effictiveData,  //تاريخ الاستحقاق
                                'status' => 0,
                                'created_by' => auth()->user()->id,
                                'com_code' => $com_code,
                            ];

                            PermanentLoansInstallment::create($dataToInstallment);
                            $i++;
                            $effictiveData = date('Y-m', strtotime('+1 months', strtotime($effictiveData)));
                        }
                    }

                    DB::commit();

                    return response()->json('done');
                } catch (\Exception $e) {
                    DB::rollBack();

                    return response()->json(['error' => $e->getMessage()], 500);
                }
            } else {
                return response()->json(['error' => 'Employee not found or not active'], 404);
            }
        }
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
    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $dataParent = get_Columns_where_row(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($dataParent)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة!']);
            }
            if (! empty($dataParent['has_disbursed_done'] == 1)) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن حذف سلفه تم صرفها بالفعل!']);
            }
            if (! empty($dataParent['is_archived'] == 1)) {
                return redirect()->back()->with(['error' => 'عفوا لا يمكن حذف سلفه تم صرفها وأرشفتها بالفعل!']);
            }
            DB::beginTransaction();
            destroy(new EmployeeSalaryPermanentLoans, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->back()->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function checkExsistsBefor(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $checkExsistsBeforCounter = get_count_where(new EmployeeSalaryPermanentLoans, ['com_code' => $com_code, 'employee_code' => $request->employee_code, 'is_archived' => 0]);
            if ($checkExsistsBeforCounter > 0) {
                return json_encode('exsists_befor');
            } else {
                return json_encode('no_exsists_befor');
            }
        }
    }

    public function ajaxSearch(Request $request)
    {

        if ($request->ajax()) {
            $employee_code = $request->employee_code;
            $month_number_installment = $request->month_number_installment;
            $is_archived = $request->is_archived;
            $has_disbursed_done = $request->has_disbursed_done;
            if ($employee_code == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field1 = 'id';
                $operator1 = '>';
                $value1 = 0;
            } else {
                $field1 = 'employee_code';
                $operator1 = '=';
                $value1 = $employee_code;
            }

            if ($is_archived == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field3 = 'id';
                $operator3 = '>';
                $value3 = 0;
            } else {
                $field3 = 'is_archived';
                $operator3 = '=';
                $value3 = $is_archived;
            }
            if ($has_disbursed_done == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field4 = 'id';
                $operator4 = '>';
                $value4 = 0;
            } else {
                $field4 = 'has_disbursed_done';
                $operator4 = '=';
                $value4 = $has_disbursed_done;
            }
            $com_code = auth()->user()->com_code;
            $data = EmployeeSalaryPermanentLoans::select('*')->where($field1, $operator1, $value1)
                ->where($field3, $operator3, $value3)
                ->where($field4, $operator4, $value4)
                ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->paginate(100);
            if (! empty($data)) {
                foreach ($data as $info) {
                    $info->emp_name = get_field_value(new Employee, 'name', ['com_code' => $com_code, 'employee_code' => $info->employee_code]);
                }
            }

            return view('dashboard.salaries.permanentLoan.ajax_search', ['data' => $data]);
        }
    }

    public function load_installment_details(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $dataParent = get_Columns_where_row(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code, 'id' => $request->id]);
            if (! empty($dataParent)) {
                $dataParent['installmentDetails'] = PermanentLoansInstallment::where('com_code', $com_code)->where('employee_permanent_loans_id', $request->id)->orderBy('id', 'ASC')->get();
                if (! empty($dataParent['installmentDetails'])) {
                    foreach ($dataParent['installmentDetails'] as $info) {
                        // 1- التأكد ان القسط له الدور فى الدفع
                        // 2- انه غير مؤرشف
                        // 3- غير مدفوع على الراتب الشهر
                        // 4- و انه ممكن يدفع المبلغ كاش
                        $info->counterBeforeNotPaid = PermanentLoansInstallment::where('com_code', $com_code)
                            ->where('employee_permanent_loans_id', '=', $request->id)->where('status', '=', 0)->where('id', '<', $info->id)->count();
                    }
                    $dataParent->emp_name = get_field_value(new Employee, 'name', ['com_code' => $com_code, 'employee_code' => $info->employee_code]);

                }
            }

            return view('dashboard.salaries.permanentLoan.load_installment_details', ['dataParent' => $dataParent]);
        }
    }

    public function load_edit_row(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $data_row = get_Columns_where_row(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code, 'id' => $request->id]);

            // Check if the data_row exists
            if (! $data_row) {
                return response()->json(['error' => 'عفوا، السجل غير موجود!'], 404);
            }

            if (! empty($data_row['has_disbursed_done']) && $data_row['has_disbursed_done'] == 1) {
                return response()->json(['error' => 'عفوا لا يمكن تعديل سلفة تم صرفها بالفعل!']);
            }
            if (! empty($data_row['is_archived']) && $data_row['is_archived'] == 1) {
                return response()->json(['error' => 'عفوا لا يمكن تعديل سلفة تم صرفها وأرشفتها بالفعل!']);
            }

            $employees = get_cols_where(new Employee, ['employee_code', 'name', 'salary', 'day_price'], ['com_code' => $com_code], 'employee_code', 'ASC');

            return response()->json([
                'html' => view('dashboard.salaries.permanentLoan.load_edit_row', ['data_row' => $data_row, 'employees' => $employees])->render(),
            ]);
        }

        return response()->json(['error' => 'Invalid request'], 400);
    }

    public function do_edit_row(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;

            // Fetch the related row
            $data_row = EmployeeSalaryPermanentLoans::where([
                ['com_code', '=', $com_code],
                ['id', '=', $request->id],
                ['is_archived', '=', 0],
            ])->first();

            if ($data_row) {
                $employeeData = Employee::where([
                    ['employee_code', '=', $request->employee_code],
                    ['com_code', '=', $com_code],
                    ['functional_status', '=', 'Employee'],
                ])->first();

                if ($employeeData) {
                    DB::beginTransaction();

                    try {
                        // Update the data_row
                        $dataToUpdate = [
                            'employee_code' => $request->employee_code,
                            'employee_salary' => $request->employee_salary,
                            'total' => $request->total,
                            'month_number_installment' => $request->month_number_installment,
                            'month_installment_value' => $request->month_installment_value,
                            'year_month_start_date' => $request->year_month_start_date,
                            'year_month_start' => date('Y-m', strtotime($request->year_month_start_date)),
                            'notes' => $request->notes,
                            'updated_by' => auth()->user()->id,
                            'com_code' => $com_code,
                        ];

                        $flagParent = $data_row->update($dataToUpdate);

                        if ($flagParent) {
                            // Fetch existing installments
                            $installments = PermanentLoansInstallment::where([
                                ['com_code', '=', $com_code],
                                ['employee_permanent_loans_id', '=', $data_row->id],
                            ])->get();

                            $effectiveDate = $dataToUpdate['year_month_start'];
                            $i = 1;

                            // Update existing installments or create new ones if needed
                            foreach ($installments as $installment) {
                                if ($i <= $dataToUpdate['month_number_installment']) {
                                    $installment->update([
                                        'month_installment_value' => $dataToUpdate['month_installment_value'],
                                        'year_month' => $effectiveDate,
                                        'status' => 0,
                                        'updated_by' => auth()->user()->id,
                                    ]);

                                    $effectiveDate = date('Y-m', strtotime('+1 month', strtotime($effectiveDate)));
                                    $i++;
                                } else {
                                    // If there are more installments than needed, you can delete the extra ones
                                    $installment->delete();
                                }
                            }

                            // If more installments are needed, create them
                            while ($i <= $dataToUpdate['month_number_installment']) {
                                PermanentLoansInstallment::create([
                                    'employee_code' => $request->employee_code,
                                    'employee_permanent_loans_id' => $data_row->id,
                                    'month_installment_value' => $dataToUpdate['month_installment_value'],
                                    'year_month' => $effectiveDate,
                                    'status' => 0,
                                    'created_by' => auth()->user()->id,
                                    'com_code' => $com_code,
                                ]);

                                $effectiveDate = date('Y-m', strtotime('+1 month', strtotime($effectiveDate)));
                                $i++;
                            }

                            DB::commit();

                            return response()->json(['message' => 'تم التعديل بنجاح']);
                        }
                    } catch (\Exception $e) {
                        DB::rollBack();

                        return response()->json(['error' => 'حدث خطأ أثناء تحديث السجل!.'], 500);
                    }
                } else {
                    return response()->json(['error' => 'تم إدخال بيانات غير صالحة. الموظف غير موجود!.'], 400);
                }
            } else {
                return response()->json(['error' => 'تم إدخال بيانات غير صالحة!.'], 400);
            }
        }

        return response()->json(['error' => 'الطلب غير صالح.'], 400);
    }

    public function print_search(Request $request)
    {

        $employee_code = $request->employee_code;
        $month_number_installment = $request->month_number_installment;
        $is_archived = $request->is_archived;
        $has_disbursed_done = $request->has_disbursed_done;
        if ($employee_code == 'all') {
            //هنا نعمل شرط دائم التحقق
            $field1 = 'id';
            $operator1 = '>';
            $value1 = 0;
        } else {
            $field1 = 'employee_code';
            $operator1 = '=';
            $value1 = $employee_code;
        }

        if ($is_archived == 'all') {
            //هنا نعمل شرط دائم التحقق
            $field3 = 'id';
            $operator3 = '>';
            $value3 = 0;
        } else {
            $field3 = 'is_archived';
            $operator3 = '=';
            $value3 = $is_archived;
        }
        if ($has_disbursed_done == 'all') {
            //هنا نعمل شرط دائم التحقق
            $field4 = 'id';
            $operator4 = '>';
            $value4 = 0;
        } else {
            $field4 = 'has_disbursed_done';
            $operator4 = '=';
            $value4 = $has_disbursed_done;
        }
        $com_code = auth()->user()->com_code;
        $other['total_sum'] = 0;

        $data = EmployeeSalaryPermanentLoans::select('*')->where($field1, $operator1, $value1)->where($field3, $operator3, $value3)
            ->where($field4, $operator4, $value4)
            ->where('com_code', '=', $com_code)->orderby('id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->name = get_field_value(new Employee, 'name', ['com_code' => $com_code, 'employee_code' => $info->employee_code]);
                $other['total_sum'] += $info->total;
            }
        }
        $systemData = get_Columns_where_row(new AdminPanelSetting, ['phons', 'address', 'image', 'company_name'], ['com_code' => $com_code]);

        return view('dashboard.salaries.permanentLoan.print_search', ['data' => $data, 'systemData' => $systemData, 'other' => $other]);
    }

    public function disbursed_done_now($id)
    {
        try {
            $com_code = auth()->user()->com_code;

            // الحصول على بيانات القرض الرئيسي باستخدام معرف القرض المحدد
            $dataParentLoan = get_Columns_where_row(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($dataParentLoan)) {
                return redirect()->back()->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة!']);
            }

            DB::beginTransaction();

            // تحديث حالة القرض الرئيسي ليصبح "تم صرفه"
            $dataToUpdate['has_disbursed_done'] = 1;
            $dataToUpdate['disbursed_by'] = auth()->user()->id;
            $dataToUpdate['disbursed_at'] = date('Y-m-d H:i:s');
            $dataToUpdate['com_code'] = $com_code;

            // تحديث القرض المحدد فقط وليس كل القروض
            $flagParent = update(new EmployeeSalaryPermanentLoans, $dataToUpdate, ['com_code' => $com_code, 'id' => $id, 'has_disbursed_done' => 0]);

            if ($flagParent) {
                // تحديث الأقساط الخاصة بالقرض المحدد فقط باستخدام 'employee_permanent_loans_id'
                $dataToUpdateInstallment['has_parent_disbursed_done'] = 1;

                // هنا نستخدم employee_permanent_loans_id للتحديث
                update(new PermanentLoansInstallment, $dataToUpdateInstallment, ['com_code' => $com_code, 'employee_permanent_loans_id' => $id]);

                // إعادة حساب راتب الموظف إذا كان لديه راتب مفتوح
                $mainSalaryEmployeeOpen = get_Columns_where_row(new MainSalaryEmployee, ['id'], ['com_code' => $com_code, 'employee_code' => $dataParentLoan['employee_code'], 'is_archived' => 0]);
                if (! empty($mainSalaryEmployeeOpen)) {
                    $this->recalculateMainSalaryEmployee($mainSalaryEmployeeOpen['id']);
                }
            }

            DB::commit();

            return redirect()->back()->with(['success' => 'تم صرف السلفه بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    // public function doSingleCachPayNow(Request $request)
    // {
    //     if ($request->ajax()) {
    //         $com_code = auth()->user()->com_code;
    //         $dataParentLoan = get_Columns_where_row(new EmployeeSalaryPermanentLoans(), ["*"], ["com_code" => $com_code, "id" => $request->idparent, 'is_archived' => 0, 'has_disbursed_done' => 1]);

    //         if (!empty($dataParentLoan)) {
    //             $dataInstallment = get_Columns_where_row(new PermanentLoansInstallment(), ["*"], ["com_code" => $com_code, "id" => $request->id, 'is_archived' => 0, 'status' => 0]);

    //             if (!empty($dataInstallment)) {
    //                 // التحقق من وجود أي أقساط غير مدفوعة قبل القسط الحالي
    //                 $counterBeforeNotPaid = PermanentLoansInstallment::where('com_code', $com_code)
    //                     ->where('employee_permanent_loans_id', $request->idparent)
    //                     ->where('status', 0)
    //                     ->where('id', '<', $request->id)
    //                     ->count();

    //                 if ($counterBeforeNotPaid == 0) {
    //                     // تحديث القسط الحالي إلى مدفوع نقدًا
    //                     $dataToUpdateInstallmentPayCach['status'] = 2; // الدفع كاش
    //                     $dataToUpdateInstallmentPayCach['archived_by'] = auth()->user()->id;
    //                     $dataToUpdateInstallmentPayCach['is_archived'] = 1;
    //                     $dataToUpdateInstallmentPayCach['archived_at'] = date("Y-m-d H:i:s");
    //                     $dataToUpdateInstallmentPayCach['updated_by'] = auth()->user()->id;

    //                     $flag = update(new PermanentLoansInstallment(), $dataToUpdateInstallmentPayCach, ["com_code" => $com_code, "id" => $request->id, 'is_archived' => 0, 'status' => 0]);

    //                     if ($flag) {
    //                         // التحقق مما إذا كانت جميع الأقساط مدفوعة
    //                         $remainingInstallments = PermanentLoansInstallment::where('com_code', $com_code)
    //                             ->where('employee_permanent_loans_id', $request->idparent)
    //                             ->where('status', 0)
    //                             ->count();

    //                         // إذا تم دفع جميع الأقساط
    //                         if ($remainingInstallments == 0) {
    //                             $dataToUpdateLoanStatus['is_archived'] = 1; // تم دفع جميع الأقساط
    //                             update(new EmployeeSalaryPermanentLoans(), $dataToUpdateLoanStatus, ["com_code" => $com_code, "id" => $request->idparent]);
    //                         }

    //                         return json_encode("Done Insert Cash");
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }

    public function doSingleCachPayNow(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $dataParentLoan = get_Columns_where_row(new EmployeeSalaryPermanentLoans, ['*'], ['com_code' => $com_code, 'id' => $request->idparent, 'is_archived' => 0, 'has_disbursed_done' => 1]);

            if (! empty($dataParentLoan)) {
                $dataInstallment = get_Columns_where_row(new PermanentLoansInstallment, ['*'], ['com_code' => $com_code, 'id' => $request->id, 'is_archived' => 0, 'status' => 0]);

                if (! empty($dataInstallment)) {
                    // التحقق من وجود أي أقساط غير مدفوعة قبل القسط الحالي
                    $counterBeforeNotPaid = PermanentLoansInstallment::where('com_code', $com_code)
                        ->where('employee_permanent_loans_id', $request->idparent)
                        ->where('status', 0)
                        ->where('id', '<', $request->id)
                        ->count();

                    if ($counterBeforeNotPaid == 0) {
                        // تحديث القسط الحالي إلى مدفوع نقدًا
                        $dataToUpdateInstallmentPayCach['status'] = 2; // الدفع كاش
                        $dataToUpdateInstallmentPayCach['archived_by'] = auth()->user()->id;
                        $dataToUpdateInstallmentPayCach['is_archived'] = 1;
                        $dataToUpdateInstallmentPayCach['archived_at'] = date('Y-m-d H:i:s');
                        $dataToUpdateInstallmentPayCach['updated_by'] = auth()->user()->id;

                        $flag = update(new PermanentLoansInstallment, $dataToUpdateInstallmentPayCach, ['com_code' => $com_code, 'id' => $request->id, 'is_archived' => 0, 'status' => 0]);

                        if ($flag) {
                            // حساب قيمة الأقساط المتبقية بعد تحديث القسط
                            $totalLoan = $dataParentLoan['total']; // إجمالي القرض
                            $installmentPaid = $dataParentLoan['installment_paid'] + $dataInstallment['month_installment_value']; // إضافة قيمة القسط المدفوع
                            $installmentRemain = $totalLoan - $installmentPaid; // حساب القيمة المتبقية

                            // تحديث الحقل installment_remain في جدول EmployeeSalaryPermanentLoans
                            EmployeeSalaryPermanentLoans::where('com_code', $com_code)
                                ->where('id', $request->idparent)
                                ->update(['installment_remain' => $installmentRemain, 'installment_paid' => $installmentPaid]);

                            // التحقق مما إذا كانت جميع الأقساط مدفوعة
                            $remainingInstallments = PermanentLoansInstallment::where('com_code', $com_code)
                                ->where('employee_permanent_loans_id', $request->idparent)
                                ->where('status', 0)
                                ->count();

                            // إذا تم دفع جميع الأقساط
                            if ($remainingInstallments == 0) {
                                $dataToUpdateLoanStatus['is_archived'] = 1; // تم دفع جميع الأقساط
                                update(new EmployeeSalaryPermanentLoans, $dataToUpdateLoanStatus, ['com_code' => $com_code, 'id' => $request->idparent]);
                            }

                            return json_encode('Done Insert Cash');
                        }
                    }
                }
            }
        }
    }
}
