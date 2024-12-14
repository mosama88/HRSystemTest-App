<?php

namespace App\Livewire\Dashboard\Auth;

use Livewire\Component;
use App\Models\AdminPanelSetting;
use App\Http\Requests\Auth\AdminLoginRequest;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Auth;

class LoginComponent extends Component
{


    public $username,$password,$remember,$data;


public function rules(){
    return (new AdminLoginRequest())->rules();
}


public function messages(){
    return (new AdminLoginRequest())->messages();
}


public function submit(){
    $this->validate();

        if(!Auth::guard('admin')->attempt(['username' => $this->username, 'password' => $this->password],$this->remember)){
            throw ValidationException::withMessages([
                'username' => 'خطأ فى بيانات المستخدم',
            ]);
    }

    return redirect('dashboard/admin');
}



    public function render()
    {
        return view('dashboard.auth.login-component');
    }
}
