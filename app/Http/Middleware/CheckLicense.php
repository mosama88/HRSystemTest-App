<?php

namespace App\Http\Middleware;

use Carbon\Carbon;
use Closure;
use Illuminate\Support\Facades\Auth;

class CheckLicense
{
    public function handle($request, Closure $next)
    {
        $user = Auth::user();

        if ($user && $user->license_expiry_date && Carbon::now()->gt(Carbon::parse($user->license_expiry_date))) {
            // سجل خروج المستخدم
            Auth::logout();

            // إعادة توجيه المستخدم إلى صفحة انتهاء الترخيص
            return redirect('/license-expired');
        }

        return $next($request);
    }
}
