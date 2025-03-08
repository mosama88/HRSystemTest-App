<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Dashboard\Api\BranchController;
use App\Http\Controllers\Dashboard\Api\CountryController;
use App\Http\Controllers\Dashboard\Api\DepartmentController;
use App\Http\Controllers\Dashboard\Api\GovernorateController;
use App\Http\Controllers\Dashboard\Api\ShiftsTypesController;
use App\Http\Controllers\Dashboard\Api\AdminPanelSettingsController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


//.................................................branches
Route::get('branches', BranchController::class);

//.................................................adminPanelSettings
Route::get('adminPanelSettings', AdminPanelSettingsController::class);

//.................................................shiftsTypes
Route::get('shiftsTypes', ShiftsTypesController::class);

//.................................................departments
Route::get('departments', DepartmentController::class);

//.................................................countries
Route::get('countries', CountryController::class);

//.................................................governorates
Route::get('governorates', GovernorateController::class);