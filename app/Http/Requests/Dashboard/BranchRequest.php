<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class BranchRequest extends FormRequest
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
            'phones' => 'required',
            'address' => 'required',
        ];
    }
    public function messages()
    {
        return [
            'name.required' => 'اسم الفرع مطلوب',
            'phones.required' => 'هاتف الفرع مطلوب',
            'address.required' => 'عنوان الفرع مطلوب',

        ];
    }
}
