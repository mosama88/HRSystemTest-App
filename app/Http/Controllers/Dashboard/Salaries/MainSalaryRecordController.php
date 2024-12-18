<?php

namespace App\Http\Controllers\Dashboard\Salaries;

use App\Models\Employee;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use App\Models\FinanceCalendar;
use App\Models\FinanceClnPeriod;
use App\Models\MainSalaryEmployee;
use App\Models\EmployeeSalaryAbsenceDay;
use App\Models\EmployeeSalaryAdditional;
use App\Models\EmployeeSalaryAllowance;
use App\Models\EmployeeSalaryDiscount;
use App\Models\EmployeeSalaryLoan;
use App\Models\EmployeeSalaryPermanentLoans;
use App\Models\PermanentLoansInstallment;
use App\Models\EmployeeSalaryRewards;
use App\Models\EmployeeSalarySanctions;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class MainSalaryRecordController extends Controller
{

    use GeneralTrait;


    public function index()
    {
        // $com_code = auth()->user()->com_code;

        // $data = FinanceClnPeriod::select("*")->where("com_code", $com_code)
        //     ->orderBy("finance_yr", "DESC")
        //     ->orderBy("start_date_m", "ASC")->paginate(12);
        // if (!empty($data)) {
        //     foreach ($data as $info) {
        //         $info->currentYear = get_Columns_where_row(new FinanceCalendar(), array("is_open"), array("com_code" => $com_code, "finance_yr" => $info->finance_yr));
        //         $info->counterOpenMonth = get_count_where(new FinanceClnPeriod(), array("com_code" => $com_code, "is_open" => 1));
        //         $info->counterPreviousWatingOpen = FinanceClnPeriod::where("com_code", "=", $com_code)
        //             ->where("finance_yr", "=", $info->finance_yr)
        //             ->where("month_id", "<", $info->month_id)
        //             ->where("is_open", "=", 0)->count();
        //     }
        // }

        return view('dashboard.salaries.salaryRecords.index', compact('data'));
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

    public function do_open_month($id, Request $request)
    {
        try {

                    // البحث عن السجل الحالي باستخدام المعرف (ID)
        $finance_cln_period = FinanceClnPeriod::findOrFail($id);

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new FinanceClnPeriod(), ["*"], ["com_code" => $com_code, "id" => $id]);

        if (empty($data)) {
            return redirect()->back()->with(['error' => 'غير قادر على الوصول للبيانات المطلوبة']);
        }

        $currentYear = get_Columns_where_row(new FinanceCalendar(), ["is_open"], ["com_code" => $com_code, "finance_yr" => $data['finance_yr']]);
        if (empty($currentYear)) {
            return redirect()->back()->with(['error' => 'غير قادر على الوصول بيانات السنة المالية المطلوبة']);
        }

        if ($currentYear['is_open'] != 1) {
            return redirect()->back()->with(['error' => 'عفوا، السنة المالية التابعة لهذا الشهر غير مفتوحة!']);
        }

        if ($data['is_open'] == 1 && $request->input('is_open') != 2) {
            // إذا كان الشهر مفتوحًا، ولكن يتم طلب تغييره إلى حالة أخرى (غير الأرشفة)، إظهار رسالة الخطأ
            return redirect()->back()->with(['error' => 'عفوا، هذا الشهر مفتوح حاليا!']);
        }

        if ($data['is_open'] == 2) {
            return redirect()->back()->with(['error' => 'عفوا، هذا الشهر مؤرشف بالفعل!']);
        }

        // التحقق من وجود شهر مفتوح آخر إذا كانت الحالة الجديدة هي الأرشفة (is_open = 2)
        if ($request->input('is_open') == 2) {
            // السماح بالأرشفة حتى إذا كان هناك شهر مفتوح
            // لا حاجة للتحقق من الشهور المفتوحة في حالة الأرشفة
            $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
            if ($counterOpenMonth > 0 && $data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
            }
        } else {
            // التحقق من الشهور المفتوحة في الحالات الأخرى
            $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
            if ($counterOpenMonth > 0) {
                return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
            }
        }

            DB::beginTransaction();
            $dataToUpdate['start_date_fp'] = $request->start_date_fp;
            $dataToUpdate['end_date_fp'] = $request->end_date_fp;
            $dataToUpdate['is_open'] = 1;
            $dataToUpdate['updated_by'] = auth()->user()->name;
            $dataToUpdate['updated_at'] = date("Y-m-d H:i:s");
            $flag = update(new FinanceClnPeriod(), $dataToUpdate, array("com_code" => $com_code, "id" => $id, 'is_open' => 0));


            //كود فتح المرتبات للموظفين
            if ($flag) {
                $get_employee = get_cols_where(
                    new Employee(),
                    array("*"),
                    array('com_code' => $com_code, 'functional_status' => 'Employee'),
                    'employee_code',
                    'ASC'
                );
                if (!empty($get_employee)) {
                    foreach ($get_employee as $info) {
                        $dataSalaryToInsert = array();
                        $dataSalaryToInsert['finance_cln_periods_id'] = $id;
                        $dataSalaryToInsert['employee_code'] = $info->employee_code;
                        $dataSalaryToInsert['com_code'] = $com_code;
                        $checkExistsCounter = get_count_where(new MainSalaryEmployee(), $dataSalaryToInsert);
                        if ($checkExistsCounter == 0) {
                            $dataSalaryToInsert['employee_name'] = $info->name;
                            $dataSalaryToInsert['day_price'] = $info->day_price;
                            $dataSalaryToInsert['is_sensitive_manager_data'] = 1;
                            $dataSalaryToInsert['branch_id'] = $info->branch_id;
                            $dataSalaryToInsert['employee_status'] = $info->functional_status;
                            $dataSalaryToInsert['employee_department_code'] = $info->department_id;
                            $dataSalaryToInsert['employee_jobs_id'] = $info->job_categories_id;

                            $lastSalaryData = get_cols_where_row_orderby(new MainSalaryEmployee(), array("net_salary_after_close_for_deportation"), array("com_code" => $com_code, "employee_code" => $info->employee_code, "is_archived" => 1), "id", "DESC");
                            if (!empty($lastSalaryData)) {
                                $dataSalaryToInsert['last_salary_remain_balance'] = $lastSalaryData['net_salary_after_close_for_deportation'];
                            } else {
                                $dataSalaryToInsert['last_salary_remain_balance'] = 0;
                            }
                            $dataSalaryToInsert['salary_employee'] = $info->salary;
                            $dataSalaryToInsert['financial_year'] = $data['finance_yr'];
                            $dataSalaryToInsert['year_month'] = $data['year_and_month'];
                            $dataSalaryToInsert['cash_visa'] = $info->Type_salary_receipt;
                            $dataSalaryToInsert['created_by'] = auth()->user()->id;
                            $flagInsert = insert(new MainSalaryEmployee(), $dataSalaryToInsert, true);
                            if (!empty($flagInsert)) {
                                $this->recalculateMainSalaryEmployee($flagInsert['id']);
                            }
                        }
                    }
                }
            }
            DB::commit();
            return redirect()->route('dashboard.salaryRecords.index')->with(['success' => 'تم فتح الشهر المالى بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }



    public function load_open_month(Request $request)
    {
        if ($request->ajax()) {
            $id = $request->id;
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new FinanceClnPeriod(), array("*"), array("com_code" => $com_code, "id" => $id));
            return view('dashboard.salaries.SalaryRecords.load_open_month', compact('data'));
        }
    }







    public function editIsClose($id, Request $request)
    {
        try {
            // البحث عن السجل الحالي باستخدام المعرف (ID)
            $finance_cln_period = FinanceClnPeriod::findOrFail($id);
    
            $com_code = auth()->user()->com_code;
            // جلب بيانات الشهر الحالي
            $data = get_Columns_where_row(new FinanceClnPeriod(), ["*"], ["com_code" => $com_code, "id" => $id]);
    
            if (empty($data)) {
                return redirect()->back()->with(['error' => 'غير قادر على الوصول للبيانات المطلوبة']);
            }
    
            // جلب بيانات السنة المالية
            $currentYear = get_Columns_where_row(new FinanceCalendar(), ["is_open"], ["com_code" => $com_code, "finance_yr" => $data['finance_yr']]);
            if (empty($currentYear)) {
                return redirect()->back()->with(['error' => 'غير قادر على الوصول بيانات السنة المالية المطلوبة']);
            }
    
            // التأكد من أن السنة المالية مفتوحة
            if ($currentYear['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا، السنة المالية التابعة لهذا الشهر غير مفتوحة!']);
            }
    
            // التأكد من حالة الشهر (في انتظار الفتح)
            if ($data['is_open'] == 0) {
                return redirect()->back()->with(['error' => 'عفوا، هذا الشهر بأنتظار الفتح!']);
            }
    
            // التأكد من أن الشهر مؤرشف
            if ($data['is_open'] == 2) {
                return redirect()->back()->with(['error' => 'عفوا، هذا الشهر مؤرشف بالفعل!']);
            }
    
            // التحقق من وجود شهر مفتوح قبل الأرشفة
            if ($request->input('is_open') == 2) {
                $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
                if ($counterOpenMonth > 0) {
                    return redirect()->back()->with(['error' => 'عفوا، لا يمكن أرشفة هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
                }
            }
    
            // التحقق من وجود شهر مفتوح قبل فتح شهر جديد
            if ($request->input('is_open') != 0) {
                $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
                if ($counterOpenMonth > 0) {
                    return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
                }
            }
    
            $counterStop = get_count_where(new MainSalaryEmployee(), ['com_code' => $com_code, 'finance_cln_periods_id' => $id, 'is_stopped' => 1]);
    
            if ($counterStop > 0) {
                return redirect()->back()->with(['error' => 'عفوا، توجد مرتبات موقوفه بهذا الشهر المالي. من فضلك خذ لها إجراء أولا. لتتمكن من أرشفة الشهر المالي!']);
            }
    
            DB::beginTransaction();
    
            // تحديث حالة الشهر المالي
            $dataToUpdate['is_open'] = 2;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            $dataToUpdate['updated_at'] = now();
            $flag = update(new FinanceClnPeriod(), $dataToUpdate, ["com_code" => $com_code, "id" => $id, 'is_open' => 1]);
    
            // أرشفة المرتبات
            if ($flag) {
                $all_main_salary_employee = get_cols_where(new MainSalaryEmployee(), array("*"),array('com_code' => $com_code, 'finance_cln_periods_id' => $id) , 'id', 'ASC');
                if (!empty($all_main_salary_employee)) {
                    foreach ($all_main_salary_employee as $info) {
                        $DataUpdate['is_archived'] = 1;
                        $DataUpdate['archived_date'] = now();
                        $DataUpdate['updated_by'] = auth()->user()->id;
    
                        if ($info->net_salary < 0) {
                            $DataUpdate['net_salary_after_close_for_deportation'] = $info->net_salary;
                        } else {
                            $DataUpdate['net_salary_after_close_for_deportation'] = 0;
                        }
    
                       $flagUpdate = update(new MainSalaryEmployee(), $DataUpdate, array('com_code' => $com_code, 'id' => $info->id,'is_archived' => 0, 'is_stopped' => 'unstopped'));
                       if( $flagUpdate) {
                        $DataUpdate_variables['is_archived'] = 1;
                        $DataUpdate_variables['archived_at'] = now();
                        $DataUpdate_variables['updated_by'] = auth()->user()->id;
    
                        update(new EmployeeSalarySanctions(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
update(new EmployeeSalaryAbsenceDay(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
update(new EmployeeSalaryDiscount(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
update(new EmployeeSalaryLoan(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
PermanentLoansInstallment::where('com_code','=',$com_code)->where('year_month',"=",$data['year_and_month'])
->where('is_archived',"=",0)->where('status',"!=",2)->where('employee_code',"=",$info['employee_code'])
->where('main_salary_employees_id',"=",$info->id)->update($DataUpdate_variables);
update(new EmployeeSalaryAdditional(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
update(new EmployeeSalaryAllowance(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
update(new EmployeeSalaryRewards(),$DataUpdate_variables,array('com_code'=>$com_code,'main_salary_employees_id'=>$info->id,'finance_cln_periods_id'=>$id));
                    }
                }
                    
                }
            }
    
            DB::commit();
            return redirect()->route('dashboard.salaryRecords.index')->with(['success' => 'تم غلق و أرشفة الشهر المالي بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ: ' . $ex->getMessage()])->withInput();
        }
    }
    


    public function editISOpen(Request $request, $id)
    {
        // البحث عن السجل الحالي باستخدام المعرف (ID)
        $finance_cln_period = FinanceClnPeriod::findOrFail($id);

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new FinanceClnPeriod(), ["*"], ["com_code" => $com_code, "id" => $id]);

        if (empty($data)) {
            return redirect()->back()->with(['error' => 'غير قادر على الوصول للبيانات المطلوبة']);
        }

        $currentYear = get_Columns_where_row(new FinanceCalendar(), ["is_open"], ["com_code" => $com_code, "finance_yr" => $data['finance_yr']]);
        if (empty($currentYear)) {
            return redirect()->back()->with(['error' => 'غير قادر على الوصول بيانات السنة المالية المطلوبة']);
        }

        if ($currentYear['is_open'] != 1) {
            return redirect()->back()->with(['error' => 'عفوا، السنة المالية التابعة لهذا الشهر غير مفتوحة!']);
        }

        if ($data['is_open'] == 1 && $request->input('is_open') != 2) {
            // إذا كان الشهر مفتوحًا، ولكن يتم طلب تغييره إلى حالة أخرى (غير الأرشفة)، إظهار رسالة الخطأ
            return redirect()->back()->with(['error' => 'عفوا، هذا الشهر مفتوح حاليا!']);
        }

        if ($data['is_open'] == 2) {
            return redirect()->back()->with(['error' => 'عفوا، هذا الشهر مؤرشف بالفعل!']);
        }

        // التحقق من وجود شهر مفتوح آخر إذا كانت الحالة الجديدة هي الأرشفة (is_open = 2)
        if ($request->input('is_open') == 2) {
            // السماح بالأرشفة حتى إذا كان هناك شهر مفتوح
            // لا حاجة للتحقق من الشهور المفتوحة في حالة الأرشفة
            $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
            if ($counterOpenMonth > 0 && $data['is_open'] != 1) {
                return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
            }
        } else {
            // التحقق من الشهور المفتوحة في الحالات الأخرى
            $counterOpenMonth = get_count_where(new FinanceClnPeriod(), ["com_code" => $com_code, "is_open" => 1]);
            if ($counterOpenMonth > 0) {
                return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لوجود شهر مالي آخر مفتوح حاليا!']);
            }
        }

        try {
            DB::beginTransaction();

            // تحديث السجل
            $dataToUpdate = [
                'start_date_fp' => $request->start_date_fp,
                'end_date_fp' => $request->end_date_fp,
                'is_open' => $request->is_open, // تعيين الحالة الجديدة
                'updated_by' => auth()->user()->id, // استخدم id بدلاً من name
                'updated_at' => now()
            ];

            $flag = update(new FinanceClnPeriod(), $dataToUpdate, ["com_code" => $com_code, "id" => $id]);

            if ($flag) {
                // إضافة بيانات الموظفين فقط إذا لم يكن الشهر في حالة أرشفة
                if ($request->input('is_open') != 2) {
                    $get_employee = get_cols_where(
                        new Employee(),
                        ["*"],
                        ['com_code' => $com_code, 'functional_status' => 'Employee'],
                        'employee_code',
                        'ASC'
                    );

                    foreach ($get_employee as $info) {
                        if (empty($info->day_price)) {
                            return redirect()->back()->with(['error' => 'عفوا، لا يمكن فتح هذا الشهر لأن الأجر اليومي للموظف ' . $info->employee_code . ' ليس له قيمة!']);
                        }
                    }

                    if (!empty($get_employee)) {
                        foreach ($get_employee as $info) {
                            $dataSalaryToInsert = [
                                'finance_cln_periods_id' => $id,
                                'employee_code' => $info->employee_code,
                                'com_code' => $com_code,
                                'employee_name' => $info->name,
                                'day_price' => $info->day_price,
                                'is_sensitive_manager_data' => 1,
                                'branch_id' => $info->branch_id,
                                'employee_status' => $info->functional_status,
                                'employee_department_code' => $info->department_id,
                                'employee_jobs_id' => $info->job_categories_id,
                                'last_salary_remain_balance' => get_last_salary_balance($info->employee_code, $com_code),
                                'salary_employee' => $info->salary,
                                'financial_year' => $data['finance_yr'],
                                'year_month' => $data['year_and_month'],
                                'cash_visa' => $info->Type_salary_receipt,
                                'created_by' => auth()->user()->id,
                                'created_at' => now(),
                                'updated_at' => now()
                            ];

                            $flagInsert = insert(new MainSalaryEmployee(), $dataSalaryToInsert, true);
                            if (!empty($flagInsert)) {
                                $this->recalculateMainSalaryEmployee($flagInsert['id']);
                            }
                        }
                    }
                }
            }

            DB::commit();
            return redirect()->back()->with('success', 'تم تعديل الشهر المالي بنجاح');
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'حدث خطأ أثناء التعديل: ' . $e->getMessage());
        }
    }




}
