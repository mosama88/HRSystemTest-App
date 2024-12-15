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
            'email' => 'required|email',
            'phones' => 'required',
            'address' => 'required',
            'active' => 'nullable|in:2,1',

        ];
    }
    public function messages()
    {
        return [
            'name.required' => 'اسم الفرع مطلوب',
            'email.required' => 'البريد الالكترونى للفرع مطلوب',
            'email.email' => 'برجاء كتابة البريد الالكترونى بطريقة صحيحة',
            'phones.required' => 'هاتف الفرع مطلوب',
            'address.required' => 'عنوان الفرع مطلوب',

        ];
    }
}
