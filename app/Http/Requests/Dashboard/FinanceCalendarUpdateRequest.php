<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class FinanceCalendarUpdateRequest extends FormRequest
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
            'finance_yr' => 'required',
            'finance_yr_desc' => 'required',
            'start_date' => 'required',
            'end_date' => 'required'
        ];
    }
    public function messages(): array
    {
        return [
            'finance_yr.required' => 'كود السنة المالية مطلوب',
            'finance_yr.unique' => 'كود السنة مسجل من قبل ',
            'finance_yr_desc' => 'وصف السنة المالية مطلوب',
            'start_date' => 'تاريخ بداية السنة المالية مطلوب',
            'end_date' => 'تاريخ نهاية السنة المالية مطلوب'

        ];
    }
}
