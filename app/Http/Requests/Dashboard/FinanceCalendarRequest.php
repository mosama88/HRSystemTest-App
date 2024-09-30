<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class FinanceCalendarRequest extends FormRequest
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
            'finance_yr' => 'required|string|unique:finance_calendars',
            'finance_yr_desc' => 'required',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after:start_date',
        ];
    }

    public function messages(): array
    {
        return [
            'finance_yr.required' => 'كود السنة المالية مطلوب',
            'finance_yr.string' => 'برجاء كتابة السنه بشكل صحيح ',
            'finance_yr.unique' => 'كود السنة مسجل من قبل ',
            'finance_yr_desc' => 'وصف السنة المالية مطلوب',
            'start_date.required' => 'تاريخ بداية السنة المالية مطلوب',
            'end_date.required' => 'تاريخ نهاية السنة المالية مطلوب',
            'end_date.after' => 'يجب أن يكون تاريخًا بعد بداية السنه المالية.',

        ];
    }
}
