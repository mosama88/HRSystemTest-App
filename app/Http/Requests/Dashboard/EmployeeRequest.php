<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class EmployeeRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */

    public function rules(): array
    {
        return [
            'employee_code' => 'required|unique:employees,employee_code', // كود بصمة الموظف
            'fp_code' => 'required|unique:employees,fp_code', // كود بصمة الموظف
            'name' => 'required|min:7|unique:employees,name', // اسم الموظف
            'gender' => 'required|in:Male,Female', // نوع الجنس
            'branch_id' => 'required|exists:branches,id', // الفرع التابع له الموظف
            'job_grade_id' => 'required|exists:job_grades,id', // الفرع التابع له الموظف
            'national_id' => 'required|unique:employees,national_id|max:14|min:14', //رقم الهوية
            'end_national_id' => 'required|date', //
            'national_id_place' => 'required', //
            'qualification_id' => 'nullable|exists:qualifications,id', // المؤهل الدراسي
            'qualification_year' => 'nullable', // سنة التخرج
            'major' => 'nullable', // تخصص التخرج
            'graduation_estimate' => 'nullable|in:Fair,Good,Very_Good,Excellent', // تقدير التخرج
            'birth_date' => 'required|date', // تاريخ الميلاد
            'blood_types_id' => 'nullable|exists:blood_types,id', // فصيلة الدم
            'religion' => 'nullable|in:Muslim,Christian', //الديانة
            'language_id' => 'nullable|exists:languages,id', // اللغة الاساسية
            'email' => 'required|email|unique:employees,email', // البريد الالكترونى
            'country_id' => 'required|exists:countries,id', // الدول
            'governorate_id' => 'required|exists:governorates,id', // المحافظات
            'city_id' => 'required|exists:cities,id', // المدينة/المركز
            'home_telephone' => 'nullable', //  هاتف المنزل
            'work_telephone' => 'nullable', // هاتف العمل
            'mobile' => 'required', // هاتف المحمول
            'military' => 'nullable|in:Exemption,Exemption_Temporary,Complete', // حالة الخدمة العسكرية
            'military_date_from' => 'nullable|date', // تاريخ بداية الخدمة العسكرية
            'military_date_to' => 'nullable|date', // تاريخ نهاية الخدمة العسكرية
            'military_exemption_date' => 'nullable|date', // تاريخ اعفاء الخدمة العسكرية
            'military_wepon' => 'nullable', // سلاح الخدمة العسكرية
            'military_exemption_reason' => 'nullable|max:150', // سبب اعفاء الخدمة العسكرية
            'military_postponement_reason' => 'nullable|max:150', // سبب ومدة تأجيل الخدمة العسكرية
            'date_resignation' => 'nullable|date', // تاريخ ترك العمل
            'resignation_reason' => 'nullable', // سبب ترك العمل
            'driving_license' => 'nullable|in:Yes,No', // رخصه قياده
            'driving_license_type' => 'nullable|in:Special,First,Second,Third,Fourth,Pro,Motorcycle', // نوع رخصه القيادة
            'driving_License_id' => 'nullable|unique:employees,driving_License_id', // رخصه قياده
            'has_relatives' => 'nullable|in:Yes,No', // اقارب بالعمل
            'relatives_details' => 'nullable|max:150', // تفاصيل الاقارب بالعمل
            'notes' => 'nullable|max:200', // ملاحظات عن الموظف
            'work_start_date' => 'required|date', // تاريخ بدء العمل للموظف
            'functional_status' => 'required|in:Employee,Unemployed', // حالة الموظف
            'department_id' => 'required|exists:departments,id', // إدارة الموظف
            'job_categories_id' => 'required|exists:jobs_categories,id', // وظيفة الموظف
            'has_attendance' => 'required|in:Yes,No', //هل ملزم الموظف بعمل بصمه حضور وانصراف
            'has_fixed_shift' => 'required|in:Yes,No', // هل للموظف شفت ثابت
            'shift_types_id' => 'nullable|exists:shifts_types,id', // هل للموظف شفت ثابت
            'daily_work_hour' => 'nullable', // هل للموظف شفت ثابت
            'salary' => 'required', // هل للموظف شفت ثابت
            'day_price' => 'required', // هل للموظف شفت ثابت
            'motivation_type' => 'required|in:Changeable,None,Fixed', // هل له حافز
            'motivation' => 'nullable', // قيمة الحافز الثابت ان وجد
            'social_insurance' => 'nullable|in:Yes,No', // قيمة استقطاع التأمين الاجتماعي الشهري للموظف
            'social_insurance_number' => 'nullable', // رقم التامين الاجتماعي للموظف
            'social_insurance_cut_monthely' => 'nullable', // رقم التامين الاجتماعي للموظف
            'medical_insurance' => 'nullable|in:Yes,No', // هل للموظف تأمين طبي
            'medical_insurance_cut_monthely' => 'nullable', // قيمة استقطاع التأمين الطبي الشهري للموظف
            'medical_insurance_number' => 'nullable', // رقم التامين الطبي للموظف
            'Type_salary_receipt' => 'required|in:Cach,Visa', // نوع صرف الراتب - واحد كاش - اثنين فيزا بنكي
            'active_vacation' => 'nullable|in:Yes,No', // هل هذا الموظف ينزل له رصيد اجازات
            'urgent_person_details' => 'nullable', // تفاصيل شخص يمكن الرجوع اليه للوصول للموظف
            'social_status' => 'nullable|in:Divorced,Married,Single,Widowed', // الحالة الاجتماعية
            'children_number' => 'nullable', // عدد الأطفال
            'num_vacation_days' => 'nullable', // عدد الأطفال
            'add_service' => 'nullable', // عدد الأطفال
            'years_service' => 'nullable', // عدد الأطفال
            'resignation_id' => 'nullable|exists:resignations,id', // الاستقاله
            'bank_number_account' => 'nullable', // رقم حساب البنك للموظف
            'staies_address' => 'nullable', // رقم حساب البنك للموظف
            'disabilities' => 'nullable|in:Yes,No', // هل له اعاقة
            'disabilities_type' => 'nullable', // نوع الاعاقة
            'nationality_id' => 'required|exists:nationalities,id', // الجنسية
            'name_sponsor' => 'nullable', // اسم الكفيل
            'pasport_identity' => 'nullable', // رقم الباسبور
            'pasport_from_place' => 'nullable', // مكان استخراج الباسبور
            'pasport_exp_date' => 'nullable|date', // تاريخ انتهاء الباسبور
            'basic_address_country' => 'nullable', // عنوان اقامة الموظف في بلده الام
            'fixed_allowances' => 'required', // هل له بدلات ثابته
            'cv' => 'nullable|mimes:png,jpg,jpeg,webp,pdf,doc,docx|max:5000', //
            'photo' => 'nullable|mimes:png,jpg,jpeg,webp|max:5000', //
        ];
    }

    public function messages(): array
    {
        return [
            'fp_code.required' => 'كود بصمة الموظف مطلوب.',
            'fp_code.unique' => 'رقم كود بصمة الموظف موجود بالفعل، يرجى كتابة رقم مختلف.',
            'name.required' => 'اسم الموظف مطلوب.',
            'name.min' => 'يرجى كتابة الاسم بالكامل.',
            'name.unique' => 'اسم الموظف موجود بالفعل.',
            'gender.required' => 'نوع الجنس مطلوب.',
            'branch_id.required' => 'الفرع التابع له الموظف مطلوب.',
            'branch_id.exists' => 'الفرع المحدد غير موجود في السجلات.',
            'national_id.required' => 'رقم الهوية مطلوب.',
            'national_id.unique' => 'رقم الهوية مسجل بالفعل.',
            'national_id.max' => 'رقم الهوية يجب ألا يتجاوز 14 رقماً.',
            'national_id.min' => 'رقم الهوية يجب أن يكون 14 رقماً.',
            'end_national_id.required' => 'تاريخ انتهاء الهوية مطلوب.',
            'end_national_id.date' => 'تاريخ انتهاء الهوية يجب أن يكون بتنسيق صحيح.',
            'national_id_place.required' => 'مكان إصدار الهوية مطلوب.',
            'qualification_id.exists' => 'المؤهل الدراسي المحدد غير موجود.',
            'birth_date.required' => 'تاريخ الميلاد مطلوب.',
            'birth_date.date' => 'تاريخ الميلاد يجب أن يكون بتنسيق صحيح.',
            'email.required' => 'البريد الإلكتروني مطلوب.',
            'email.unique' => 'البريد الإلكتروني مسجل بالفعل.',
            'email.email' => 'يرجى إدخال بريد إلكتروني صالح.',
            'mobile.required' => 'رقم الهاتف المحمول مطلوب.',
            'military.in' => 'حالة الخدمة العسكرية يجب أن تكون ضمن القيم المحددة.',
            'work_start_date.required' => 'تاريخ بدء العمل مطلوب.',
            'functional_status.required' => 'حالة الموظف الوظيفية مطلوبة.',
            'functional_status.in' => 'حالة الموظف الوظيفية يجب أن تكون "موظف" أو "عاطل".',
            'department_id.required' => 'الإدارة المطلوبة للموظف مطلوبة.',
            'department_id.exists' => 'الإدارة المحددة غير موجودة.',
            'job_categories_id.required' => 'فئة الوظيفة مطلوبة.',
            'job_categories_id.exists' => 'فئة الوظيفة المحددة غير موجودة.',
            'has_attendance.required' => 'حالة الحضور مطلوبة.',
            'has_attendance.in' => 'حالة الحضور يجب أن تكون "نعم" أو "لا".',
            'salary.required' => 'الراتب مطلوب.',
            'day_price.required' => 'سعر اليوم مطلوب.',
            'Type_salary_receipt.required' => 'نوع صرف الراتب مطلوب.',
            'cv.mimes' => 'ملف السيرة الذاتية يجب أن يكون بصيغة png, jpg, jpeg, webp, pdf, doc, docx.',
            'cv.max' => 'حجم ملف السيرة الذاتية لا يجب أن يتجاوز 5 ميجا.',
            'photo.mimes' => 'ملف الصورة يجب أن يكون بصيغة png, jpg, jpeg, webp.',
            'photo.max' => 'حجم ملف الصورة لا يجب أن يتجاوز 5 ميجا.',
            'nationality_id.exists' => 'الجنسية غير موجود',
            'nationality_id.required' => 'من فضلك أختر الجنسية.',
            'country_id.required' => 'من فضلك أختر الدولة',
            'governorate_id.required' => 'من فضلك أختر المحافظة',
            'city_id.required' => 'من فضلك أختر المدينة/المركز ',
            'has_fixed_shift.required' => 'من فضلك أختر الشفت الثابت ',
            'motivation_type.required' => 'من فضلك أختر الحافز ',
            'fixed_allowances.required' => 'من فضلك أختر نوع البدلات الثابته ',
        ];
    }
}