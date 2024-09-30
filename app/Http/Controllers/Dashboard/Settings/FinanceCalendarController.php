<?php

namespace App\Http\Controllers\Dashboard\Settings;

use DateTime;
use DatePeriod;
use DateInterval;
use App\Models\Month;
use App\Models\Employee;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use App\Models\FinanceCalendar;
use Illuminate\Validation\Rule;
use App\Models\FinanceClnPeriod;
use App\Models\MainSalaryEmployee;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use App\Http\Requests\Dashboard\FinanceCalendarRequest;
use App\Http\Requests\Dashboard\FinanceCalendarUpdateRequest;


class FinanceCalendarController extends Controller
{


    public function __construct()
    {
        $this->middleware('permission:السنوات المالية', ['only' => ['index']]);
        $this->middleware('permission:اضافة السنوات المالية', ['only' => ['create','store']]);
        $this->middleware('permission:تعديل السنوات المالية', ['only' => ['update','edit']]);
        $this->middleware('permission:حذف السنوات المالية', ['only' => ['destroy']]);
    }



    use GeneralTrait;



    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new FinanceCalendar(), array("*"), array("com_code" => $com_code), "id", "DESC")->get();
        return view('dashboard.settings.financeCalendars.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('dashboard.settings.financeCalendars.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(FinanceCalendarRequest $request)
    {
        try {
            DB::beginTransaction();

            $FinanceCalendar = new FinanceCalendar();
            $FinanceCalendar->finance_yr = $request->finance_yr;
            $FinanceCalendar->finance_yr_desc = $request->finance_yr_desc;
            $FinanceCalendar->start_date = $request->start_date;
            $FinanceCalendar->end_date = $request->end_date;
            $FinanceCalendar->created_by = auth()->user()->id;
            $FinanceCalendar->is_open = 0;
            $FinanceCalendar->com_code = auth()->user()->com_code;
            $financeClnPeriod = $FinanceCalendar->save();

            if ($financeClnPeriod) {
                $insertdataOfFinanceCalendar = FinanceCalendar::select('id', 'finance_yr')->where('id', $FinanceCalendar->id)->first();

                $startDate = new DateTime($request->start_date);
                $endDate = new DateTime($request->end_date);
                $endDate->modify('first day of next month'); // To include the end date month in the period
                $dateInterval = new DateInterval('P1M'); // P1M = Period of 1 Month
                $datePeriod = new DatePeriod($startDate, $dateInterval, $endDate);

                foreach ($datePeriod as $date) {
                    $dataMonth = [];
                    $dataMonth['finance_calendars_id'] = $insertdataOfFinanceCalendar->id;

                    $MonthName_en = $date->format('F'); // 'F': Full month name in English
                    $dataParentMonth = Month::select("id")->where('name_en', $MonthName_en)->first();
                    $dataMonth['month_id'] = $dataParentMonth ? $dataParentMonth->id : null;
                    $dataMonth['finance_yr'] = $insertdataOfFinanceCalendar->finance_yr;
                    $dataMonth['start_date_m'] = $date->format('Y-m-01');
                    $dataMonth['end_date_m'] = $date->format('Y-m-t');
                    $dataMonth['year_and_month'] = $date->format('Y-m');
                    $CalcnumOfDays = strtotime($dataMonth['end_date_m']) - strtotime($dataMonth['start_date_m']);
                    $dataMonth['number_of_days'] = round($CalcnumOfDays / (60 * 60 * 24)) + 1;
                    $dataMonth['com_code'] = auth()->user()->com_code;
                    $dataMonth['updated_at'] = now();
                    $dataMonth['created_at'] = now();
                    $dataMonth['created_by'] = auth()->user()->id;
                    $dataMonth['updated_by'] = auth()->user()->id;
                    $dataMonth['start_date_fp'] = $dataMonth['start_date_m'];
                    $dataMonth['end_date_fp'] = $dataMonth['end_date_m'];

                    FinanceClnPeriod::insert($dataMonth);
                }
            }
            DB::commit();
            session()->flash('success', 'تم أضافة البيانات بنجاح');
            return redirect()->route('dashboard.financeCalendars.index');
        } catch (\Exception $e) {
            DB::rollback();
            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()]);
        }
    }


    /**
     * Display the specified resource.
     */
    public function show(Request $request, $id)
    {
        $com_code = auth()->user()->com_code;
        // استرجاع مجموعة من السجلات بناءً على finance_calendars_id
        $finance_cln_periods = FinanceClnPeriod::where('com_code', '=', $com_code)->where('finance_calendars_id', $id)->get();

        // تمرير البيانات إلى العرض
        return view("dashboard.settings.financeCalendars.show", ['finance_cln_periods' => $finance_cln_periods]);
    }



    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        try {
            $financeCalendar = FinanceCalendar::findOrFail($id);

            if ($financeCalendar->is_open != 0) {
                return redirect()->back()->withErrors(['error' => 'عفوآ سنه مالية مفتوحة لا يمكن تعديلها ']);
            }
            return view('dashboard.settings.financeCalendars.edit');
        } catch (\Exception $e) {
            DB::rollback();
            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()]);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(FinanceCalendarUpdateRequest $request, $id)
    {
        try {
            $data = FinanceCalendar::select("*")->where(['id' => $id])->first();
            if (empty($data)) {
                return redirect()->back()->with(['error' => ' عفوا حدث خطأ ']);
            }
            if ($data['is_open'] != 0) {
                return redirect()->back()->with(['error' => ' عفوا لايمكن تعديل السنة المالية في هذه الحالة'])->withInput();
            }
            $validator = Validator::make($request->all(), [
                'finance_yr' => ['required', Rule::unique('finance_calendars')->ignore($id)],
            ]);
            if ($validator->fails()) {
                return redirect()->back()->with(['error' => ' عفوا اسم السنة المالية مسجل من قبل'])->withInput();
            }
            DB::beginTransaction();
            $FinanceCalendar['finance_yr'] = $request->finance_yr;
            $FinanceCalendar['finance_yr_desc'] = $request->finance_yr_desc;
            $FinanceCalendar['start_date'] = $request->start_date;
            $FinanceCalendar['end_date'] = $request->end_date;
            $FinanceCalendar['updated_by'] = auth()->user()->id;
            $UpdateData = FinanceCalendar::where(['id' => $id])->update($FinanceCalendar);
            if ($UpdateData) {
                if ($data['start_date'] != $request->start_date or $data['end_date'] != $request->end_date) {
                    $flagDelete = FinanceClnPeriod::where(['finance_calendars_id' => $id])->delete();
                    if ($flagDelete) {
                        $startDate = new DateTime($request->start_date);
                        $endDate = new DateTime($request->end_date);
                        $dareInterval = new DateInterval('P1M');
                        $datePerioud = new DatePeriod($startDate, $dareInterval, $endDate);
                        foreach ($datePerioud as $date) {
                            $dataMonth['finance_calendars_id'] = $id;
                            $Montname_en = $date->format('F');
                            $dataParentMonth = Month::select("id")->where(['name_en' => $Montname_en])->first();
                            $dataMonth['month_id'] = $dataParentMonth['id'];
                            $dataMonth['finance_yr'] = $FinanceCalendar['finance_yr'];
                            $dataMonth['start_date_m'] = date('Y-m-01', strtotime($date->format('Y-m-d')));
                            $dataMonth['end_date_m'] = date('Y-m-t', strtotime($date->format('Y-m-d')));
                            $dataMonth['year_and_month'] = date('Y-m', strtotime($date->format('Y-m-d')));
                            $datediff = strtotime($dataMonth['end_date_m']) - strtotime($dataMonth['start_date_m']);
                            $dataMonth['number_of_days'] = round($datediff / (60 * 60 * 24)) + 1;
                            $dataMonth['com_code'] = auth()->user()->com_code;
                            $dataMonth['updated_at'] = date("Y-m-d H:i:s");
                            $dataMonth['created_at'] = date("Y-m-d H:i:s");
                            $dataMonth['created_by'] = auth()->user()->id;
                            $dataMonth['updated_by'] = auth()->user()->id;
                            $dataMonth['start_date_fp'] = date('Y-m-01', strtotime($date->format('Y-m-d')));
                            $dataMonth['end_date_fp'] = date('Y-m-t', strtotime($date->format('Y-m-d')));
                            FinanceClnPeriod::insert($dataMonth);
                        }
                    }
                }
            }

            DB::commit();
            session()->flash('success', 'تم تعديل البيانات بنجاح');
            return redirect()->route('dashboard.financeCalendars.index');
        } catch (\Exception $e) {
            DB::rollback();
            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        try {
            $financeCalendar = FinanceCalendar::findOrFail($request->id);

            if ($financeCalendar->is_open != 0) {
                return redirect()->back()->withErrors(['error' => 'عفوآ سنه مالية مفتوحة لا يمكن حذفها ']);
            }

            $financeCalendar->delete();

            session()->flash('success', 'تم حذف البيانات بنجاح');
            return redirect()->route('dashboard.financeCalendars.index');
        } catch (\Exception $e) {
            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء حذف البيانات: ' . $e->getMessage()]);
        }
    }



    public function open($id)
    {
        try {
            $com_code = auth()->user()->com_code;

            $data = FinanceCalendar::select("*")->where(['com_code' => $com_code, 'id' => $id])->first();
            if (empty($data)) {
                return redirect()->back()->with(['error' => ' عفوا حدث خطأ ']);
            }
            if ($data['is_open'] != 0) {
                return redirect()->back()->with(['error' => ' عفوا لايمكن فتح السنة المالية في هذه الحالة']);
            }
            $CheckDataOpenCounter = FinanceCalendar::where(['is_open' => 1])->count();
            if ($CheckDataOpenCounter > 0) {
                return redirect()->back()->with(['error' => '   عفوا هناك بالفعل سنة مالية مازالت مفتوحة ']);
            }
            $dataToUpdate['is_open'] = 1;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            $flag = FinanceCalendar::where(['id' => $id])->update($dataToUpdate);
            return redirect()->route('dashboard.financeCalendars.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            return redirect()->back()->with(['error' => ' عفوا حدث خطأ '] . $ex->getMessage());
        }
    }



  
    public function close($id)
    {
        try {
            $com_code = auth()->user()->com_code;
    
            // ابدأ معاملة قاعدة البيانات
            DB::beginTransaction();
    
            // البحث عن بيانات السنة المالية باستخدام المعرف المقدم
            $data = FinanceCalendar::select("*")->where('id', $id)->first();
    
            // التحقق من وجود البيانات
            if (empty($data)) {
                return redirect()->back()->with(['error' => 'عفوا، لا توجد بيانات للسنة المالية المحددة.']);
            }
    
            // البحث عن الشهور المفتوحة أو المعلقة
            $finance_cln_periods = FinanceClnPeriod::where('com_code', '=', $com_code)
                                                    ->where('finance_calendars_id', $id)
                                                    ->whereIn('is_open', [0, 1]) // تحقق من الشهور المعلقة أو المفتوحة
                                                    ->count();
    
            // إذا كان هناك شهور معلقة أو مفتوحة
            if ($finance_cln_periods > 0) {
                return redirect()->back()->with(['error' => 'عفوا، هناك شهور مالية معلقة أو مفتوحة. لا يمكن غلق السنة المالية حتى يتم أرشفة جميع الشهور.']);
            }
    
            // تحديث حالة السنة المالية إلى مؤرشف (مغلقة)
            $dataToUpdate = [
                'is_open' => 2,
                'updated_by' => auth()->user()->id
            ];
    
            $flag = FinanceCalendar::where('id', $id)->update($dataToUpdate);
    
            if ($flag) {
                // إذا تم التحديث بنجاح، قم بتأكيد المعاملة
                DB::commit();
                return redirect()->route('dashboard.financeCalendars.index')->with(['success' => 'تم غلق السنة المالية بنجاح.']);
            } else {
                // إذا لم يتم التحديث، ارجع بخطأ
                DB::rollBack();
                return redirect()->back()->with(['error' => 'حدث خطأ أثناء تحديث البيانات.']);
            }
        } catch (\Exception $e) {
            // في حالة حدوث خطأ، قم بالتراجع عن المعاملة
            DB::rollBack();
            return redirect()->back()->with('error', 'حدث خطأ أثناء التعديل: ' . $e->getMessage());
        }
    }
    
}


    // public function editISOpen(Request $request, $id)
    // {
    //     // البحث عن السجل الحالي باستخدام المعرف (ID)
    //     $finance_cln_period = FinanceClnPeriod::findOrFail($id);

    //     // تحديث الحالة
    //     $finance_cln_period->is_open = $request->input('is_open');

    //     // حفظ التحديثات
    //     $finance_cln_period->save();

    //     // إعادة التوجيه إلى الصفحة السابقة مع رسالة نجاح
    //     return redirect()->back()->with('success', 'تم تعديل الشهر المالي بنجاح');
    // }

















    

// إذا حدث مشكلة مراجعه الكود

//     public function close($id)
//     {
//         try {
//             $com_code = auth()->user()->com_code;
    
//             // ابدأ معاملة قاعدة البيانات
//             DB::beginTransaction();
    
//             // البحث عن بيانات السنة المالية باستخدام المعرف المقدم
//             $data = FinanceCalendar::select("*")->where('id', $id)->first();
    
//             // التحقق من وجود البيانات
//             if (empty($data)) {
//                 return redirect()->back()->with(['error' => 'عفوا، لا توجد بيانات للسنة المالية المحددة.']);
//             }
    
//             // البحث عن الشهور المفتوحة أو المعلقة
//             $finance_cln_periods = FinanceClnPeriod::where('com_code', '=', $com_code)
//                                                     ->where('finance_calendars_id', $id)
//                                                     ->whereIn('is_open', [0, 1]) // تحقق من الشهور المعلقة أو المفتوحة
//                                                     ->count();
    
//             // إذا كان هناك شهور معلقة أو مفتوحة
//             if ($finance_cln_periods > 0) {
//                 return redirect()->back()->with(['error' => 'عفوا، هناك شهور مالية معلقة أو مفتوحة. لا يمكن غلق السنة المالية حتى يتم أرشفة جميع الشهور.']);
//             }
    
//             // تحديث حالة السنة المالية إلى مؤرشف (مغلقة)
//             $dataToUpdate = [
//                 'is_open' => 2,
//                 'updated_by' => auth()->user()->id
//             ];
    
//             $flag = FinanceCalendar::where('id', $id)->update($dataToUpdate);
    
//             if ($flag) {
//                 // إذا تم التحديث بنجاح، قم بتأكيد المعاملة
//                 DB::commit();
//                 return redirect()->route('dashboard.financeCalendars.index')->with(['success' => 'تم غلق السنة المالية بنجاح.']);
//             } else {
//                 // إذا لم يتم التحديث، ارجع بخطأ
//                 DB::rollBack();
//                 return redirect()->back()->with(['error' => 'حدث خطأ أثناء تحديث البيانات.']);
//             }
//         } catch (\Exception $e) {
//             // في حالة حدوث خطأ، قم بالتراجع عن المعاملة
//             DB::rollBack();
//             return redirect()->back()->with('error', 'حدث خطأ أثناء التعديل: ' . $e->getMessage());
//         }
//     }
    
// }