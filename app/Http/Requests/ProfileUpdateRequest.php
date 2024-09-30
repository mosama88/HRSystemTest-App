<?php

namespace App\Http\Requests;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ProfileUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', Rule::unique(User::class)->ignore($this->user()->id)],
        ];
    }

    public function messages()
    {
        return [
            'name.required' => ' الأسم مطلوب',
            'name.max' => ' يجب الا يتجاز الاسم عن 255 حرف',
            'username.required' => ' أسم المستخدم مطلوب',
            'username.max' => ' يجب الا يتجاز أسم المستخدم عن 255 حرف',
            'email.required' => ' البريد الألكترونى مطلوب',
            'email.email' => ' برجاء كتابة البريد الالكترونى بطريقة صحيحة',
            'email.max' => ' يجب الا يتجاز البريد الالكترونى المستخدم عن 255 حرف',
        ];
    }
}
