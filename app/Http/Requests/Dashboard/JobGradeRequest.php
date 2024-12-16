<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class JobGradeRequest extends FormRequest
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
            'job_grades_code' => 'nullable',
            'name' => 'required',   
            'min_salary' => 'required',
            'max_salary' => 'required|gt:min_salary',
            'notes' => 'nullable',
            'active' => 'nullable',
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'اسم نوع الدرجه مطلوب',
            'min_salary.required' => 'الحد الأدنى للمرتب مطلوب',
            'max_salary.required' => 'الحد الأقصى مطلوب',
            'max_salary.gt' => 'يجب أن يكون الحد الأقصى للراتب أكبر من الحد الأدنى للراتب',
        ];
    }
}