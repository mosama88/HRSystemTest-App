<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Dashboard\HomeController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/license-expired', function () {
    return view('dashboard.user.license_expired');
});

Route::middleware(['auth', 'check.license'])->group(function () {
    Route::get('/dashboard/user', [HomeController::class, 'user']);

});

