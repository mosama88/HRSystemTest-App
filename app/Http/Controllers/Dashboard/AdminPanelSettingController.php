<?php

namespace App\Http\Controllers\Dashboard;

use Illuminate\Http\Request;
use App\Models\AdminPanelSetting;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\AdminPanelSettingRequest;
use App\Traits\UploadTrait;

class AdminPanelSettingController extends Controller
{

    use UploadTrait;

    public function __construct()
    {
        $this->middleware('permission:الضبط العام', ['only' => ['index']]);
        $this->middleware('permission:تعديل الضبط العام', ['only' => ['update', 'edit']]);
    }


    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = AdminPanelSetting::select('*')->where('com_code', $com_code)->first();
        return view('dashboard.settings.generalSetting.index', compact('data'));
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
    public function edit()
    {
        $com_code = auth()->user()->com_code;
        $data = AdminPanelSetting::select('*')->where('com_code', $com_code)->first();
        return view('dashboard.settings.generalSetting.edit', compact('data'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $admin_setting = AdminPanelSetting::where('com_code', $com_code)->firstOrFail();

            // تحديث البيانات الأساسية
            $dataToUpdate = [
                'company_name' => $request->company_name,
                'phons' => $request->phons,
                'address' => $request->address,
                'email' => $request->email,
                'max_hours_take_fp_as_addtional' => $request->max_hours_take_fp_as_addtional,
                'less_than_minute_neglecting_fp' => $request->less_than_minute_neglecting_fp,
                'after_minute_calculate_delay' => $request->after_minute_calculate_delay,
                'after_minute_calculate_early_departure' => $request->after_minute_calculate_early_departure,
                'after_minute_quarterday' => $request->after_minute_quarterday,
                'after_time_half_daycut' => $request->after_time_half_daycut,
                'after_time_allday_daycut' => $request->after_time_allday_daycut,
                'monthly_vacation_balance' => $request->monthly_vacation_balance,
                'after_days_begin_vacation' => $request->after_days_begin_vacation,
                'first_balance_begin_vacation' => $request->first_balance_begin_vacation,
                'sanctions_value_first_absence' => $request->sanctions_value_first_absence,
                'sanctions_value_second_absence' => $request->sanctions_value_second_absence,
                'sanctions_value_thaird_absence' => $request->sanctions_value_thaird_absence,
                'sanctions_value_forth_absence' => $request->sanctions_value_forth_absence,
                'updated_by' => auth()->user()->id,
            ];

            // التحقق من وجود الصورة وتحديثها
            if ($request->hasFile('image')) {
                $request->validate([
                    'image' => 'nullable|mimes:png,jpg,jpeg|max:5000',
                ], [
                    'image.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png,jpg,jpeg',
                    'image.max' => 'اقصى مساحة للملف 5 ميجا',
                ]);

                // حذف الصورة القديمة إذا كانت موجودة
                if ($admin_setting->image) {
                    $old_image_path = public_path('dashboard/assets/uploads/admin_setting/' . $admin_setting->image);
                    if (file_exists($old_image_path)) {
                        unlink($old_image_path);
                    }
                }

                // رفع الصورة الجديدة وتخزين مسارها
                $the_file_path = uploadImage('dashboard/assets/uploads/admin_setting/', $request->file('image'));
                $dataToUpdate['image'] = $the_file_path;
            }

            // photo_cover
            // التحقق من وجود الصورة وتحديثها
            if ($request->hasFile('photo_cover')) {
                $request->validate([
                    'photo_cover' => 'nullable|mimes:png,jpg,jpeg|max:5000',
                ], [
                    'imagephoto_cover.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png,jpg,jpeg',
                    'photo_cover.max' => 'اقصى مساحة للملف 5 ميجا',
                ]);

                // حذف الصورة القديمة إذا كانت موجودة
                if ($admin_setting->photo_cover) {
                    $old_image_path = public_path('dashboard/assets/uploads/company/photo/' . $admin_setting->photo_cover);
                    if (file_exists($old_image_path)) {
                        unlink($old_image_path);
                    }
                }

                // رفع الصورة الجديدة وتخزين مسارها
                $the_file_path = uploadImage('dashboard/assets/uploads/company/photo/', $request->file('photo_cover'));
                $dataToUpdate['photo_cover'] = $the_file_path;
            }


            // تحديث السجل
            $admin_setting->update($dataToUpdate);

            session()->flash('success', 'تم تعديل البيانات بنجاح');
            return redirect()->route('dashboard.generalSettings.index');
        } catch (\Exception $e) {
            DB::rollback();
            return redirect()->back()->withErrors(['error' => $e->getMessage()]);
        }
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
