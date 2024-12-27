<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class attendanceDeparturesUploadExcel extends FormRequest
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
            'excel_file' => 'required|mimes:xls,xlsx',
        ];
    }

    public function messages()
    {
        return [
            'excel_file.required' => 'برجاء أرفاق الملف',
            'excel_file.mimes' => 'يجب ان يكون نوع الملف من نوع xls,xlsx ',
        ];
    }
}
