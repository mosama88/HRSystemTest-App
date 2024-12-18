<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class EmployeeUpdateRequest extends FormRequest
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
            'name' => 'required',
            'fp_code' => 'required',
            'gender' => 'required',
            'branch_id' => 'required',
            'national_id' => 'required',
            'work_start_date' => 'required',
            'functional_status' => 'required',
            'department_id' => 'required|exists:departments,id',
            'photo' => 'nullable|mimes:png,jpg,jpeg,webp|max:5000',

        ];
    }
    public function messages(): array
    {
        return [
            'name.required' => 'أسم الموظف مطلوب.',
            'gender.required' => 'نوع الجنس مطلوب.',
            'branch_id.required' => 'حقل الفرع مطلوب.',
            'national_id.required' => 'حقل بطاقة الهوية مطلوب.',
            'work_start_date.required' => 'حقل تاريخ التعيين مطلوب.',
            'functional_status.required' => 'حقل الحالة الوظيفية مطلوب.',
            'department_id.required' => 'حقل الادارة التابع لها الموظف مطلوب.',
            'photo.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png, jpg, jpeg , webp',
            'photo.max' => 'اقصى مساحة للملف 5 ميجا',
        ];
    }
}