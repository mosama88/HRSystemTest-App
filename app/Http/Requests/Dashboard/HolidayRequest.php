<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class HolidayRequest extends FormRequest
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
            'from_date' => 'required',
            'to_date' => 'required',
            'days_counter' => 'required|numeric',
            'active' => 'nullable'
        ];
    }
    public function messages()
    {
        return [
            'name.required' => 'حقل اسم  المناسبة مطلوب',
            'from_date.required' => 'حقل تاريخ البداية مطلوب',
            'to_date.required' => 'حقل تاريخ النهاية مطلوب',
            //'to_date.gt' => 'حقل تاريخ النهاية يجب ان يكون اكبر من او يساوي تاريخ البداية',
            'days_counter.required' => 'حقل عدد الايام  مطلوب',
            'days_counter.numeric' => 'حقل عدد الايام يجب ان يكون رقم ',
        ];
    }
}