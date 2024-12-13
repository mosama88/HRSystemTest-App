<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PageController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Auth\AdminController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\Dashboard\HomeController;
use App\Http\Controllers\Dashboard\Settings\CityController;
use App\Http\Controllers\Dashboard\Settings\BranchController;
use App\Http\Controllers\Dashboard\Settings\CountryController;
use App\Http\Controllers\Dashboard\Settings\HolidayController;
use App\Http\Controllers\Dashboard\AdminPanelSettingController;
use App\Http\Controllers\Dashboard\Settings\JobGradeController;
use App\Http\Controllers\Dashboard\Settings\VacationController;
use App\Http\Controllers\Dashboard\Settings\BloodTypeController;
use App\Http\Controllers\Dashboard\Settings\DepartmentController;
use App\Http\Controllers\Dashboard\Settings\ShiftsTypeController;
use App\Http\Controllers\Dashboard\Settings\NationalityController;
use App\Http\Controllers\Dashboard\Settings\ResignationController;
use App\Http\Controllers\Dashboard\Settings\JobsCategoryController;
use App\Http\Controllers\Dashboard\Settings\QualificationController;
use App\Http\Controllers\Dashboard\Salaries\SalarySanctionsController;
use App\Http\Controllers\Dashboard\Settings\FinanceCalendarController;
use App\Http\Controllers\Dashboard\AffairsEmployees\EmployeeController;
use App\Http\Controllers\Dashboard\Salaries\MainSalaryRecordController;
use App\Http\Controllers\Dashboard\AffairsEmployees\AllowanceController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryLoanController;
use App\Http\Controllers\Dashboard\Salaries\MainSalaryEmployeeController;
use App\Http\Controllers\Dashboard\AffairsEmployees\DiscountTypeController;
use App\Http\Controllers\Dashboard\Attendance\AttendanceDepartureController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryRewardsController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryDiscountController;
use App\Http\Controllers\Dashboard\AffairsEmployees\AdditionalTypesController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryAllowanceController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryAbsenceDayController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryAdditionalController;
use App\Http\Controllers\Dashboard\Salaries\EmployeeSalaryPermanentLoansController;
use App\Http\Controllers\Dashboard\Vacations\MainEmployeesVacationBalanceController;

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

Route::get('/', function () {
    return view('dashboard.auth.login');
})->middleware(['auth', 'verified']);

// Route::middleware(['auth', 'verified'])->group(function () {
//     Route::get('/dashboard/user', [HomeController::class, 'user']);
// });

// Admin routes
Route::middleware(['auth:admin', 'verified'])->group(function () {
    Route::get('/dashboard/admin', [HomeController::class, 'admin']);
});


Route::middleware(['auth:admin', 'verified'])->name('dashboard.')->group(function () {


    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');


    //موعد أنتهاء الترخيص
    Route::get('/admin/users/{id}/edit', [AdminController::class, 'editUser'])->name('admin.edit_user');
    Route::put('/admin/users/{id}', [AdminController::class, 'updateUser'])->name('admin.update_user');


    // بداية صلاحيات المستخدمين
    Route::resource('roles', RoleController::class)->middleware(['role:super-admin|admin']);
    Route::resource('users', UserController::class)->middleware(['role:super-admin|admin']);
    Route::resource('/permissions', PermissionController::class)->middleware(['role:super-admin|admin']);

    // الضبط العام
    Route::resource('/generalSettings', AdminPanelSettingController::class);

    // بداية تكويد السنوات المالية
    Route::controller(FinanceCalendarController::class)->group(function () {
        Route::resource('/financeCalendars', FinanceCalendarController::class);
        Route::get('financeCalendars/open/{id}',  'open')->name('financeCalendars.open');
        Route::get('financeCalendars/close/{id}',  'close')->name('financeCalendars.close');
    });

    // بداية الفروع
    Route::resource('/branches', BranchController::class);

    // بداية الشفتات
    Route::resource('/shiftsTypes', ShiftsTypeController::class);
    Route::post('/shiftsTypes/search', [ShiftsTypeController::class, 'ajaxSearch'])->name('shiftsTypes.ajax-search');


    // بداية الأدارات
    Route::resource('/departments', DepartmentController::class);

    // بداية أنواع الوظائق
    Route::resource('/jobGrades', JobGradeController::class);

    // بداية أنواع الوظائق
    Route::resource('/jobsCategories', JobsCategoryController::class);

    // بداية مؤهلات الموظفين
    Route::resource('/qualifications', QualificationController::class);

    // بداية العظلات الرسمية
    Route::resource('/holidays', HolidayController::class);

    // بداية الأستقالة
    Route::resource('/resignations', ResignationController::class);

    // بداية الأجازه
    Route::resource('/vacations', VacationController::class);

    // بداية البلاد
    Route::resource('/countries', CountryController::class);

    // بداية المحافظات
    Route::get('/governorates', [CityController::class, 'gevernrateIndex'])->name('governorates.index');

    // بداية المدن
    Route::resource('/cities', CityController::class);

    // بداية الجنسيات
    Route::resource('/nationalities', NationalityController::class);

    // بداية فصيلة الدم
    Route::resource('/bloodTypes', BloodTypeController::class);

    // بداية الموظفين
    Route::resource('/employees', EmployeeController::class);
    Route::controller(EmployeeController::class)->prefix('employees')->name('employees.')->group(function () {
        Route::post("/getcities", 'getcities')->name('getcities');
        Route::post("/get_governorates", 'get_governorates')->name('get_governorates');
        Route::post('/ajax_search', 'ajax_search')->name('ajax_search');
        Route::post('/add_files/{id}', 'add_files')->name('add_files');
        Route::delete('/delete_files/{id}', 'destroy_file')->name('destroy_file');
        Route::post('/add_allowances/{id}', 'add_allowance')->name('add_allowance');
        Route::delete('/delete_allowances/{id}', 'destroy_allowance')->name('destroy_allowance');
        Route::post('/load_edit_allowances', 'load_edit_allowances')->name('load_edit_allowances');
        Route::put('/do_edit_allowances/{id}', 'do_edit_allowances')->name('do_edit_allowances');
        Route::post('/showSalaryArchived', 'showSalaryArchived')->name('showSalaryArchived');
        Route::get('excel/export-excel','export');
        Route::post('/import-excel','import')->name('importData');
    });

    // بداية نوع الأضافة
    Route::resource('/additional_types', AdditionalTypesController::class);

    // بداية نوع الخصم
    Route::resource('/discount_types', DiscountTypeController::class);

    // بداية نوع البدلات
    Route::resource('/allowances', AllowanceController::class);

    // بداية السجلات الرئيسية للرواتب
    Route::resource('/salaryRecords', MainSalaryRecordController::class);
    Route::controller(MainSalaryRecordController::class)->prefix('salaryRecords')->name('salaryRecords.')->group(function () {
        Route::post('/do_open_month/{id}', 'do_open_month')->name('do_open_month');
        Route::post('/load_open_month', 'load_open_month')->name('load_open_month');
        Route::put('/editIsOpen/{id}', 'editIsOpen')->name('editISOpen');
        Route::put('/editIsClose/{id}', 'editIsClose')->name('editIsClose');
    });

    // بداية جزاءات الرواتب
    Route::resource('/sanctions', SalarySanctionsController::class);
    Route::controller(SalarySanctionsController::class)->prefix('sanctions')->name('sanctions.')->group(function () {
        Route::post('/checkExsistsBefor', 'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search', 'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row', 'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية الغيابات الرواتب
    Route::resource('/absences', EmployeeSalaryAbsenceDayController::class);
    Route::controller(EmployeeSalaryAbsenceDayController::class)->prefix('absences')->name('absences.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية الأضافى الرواتب
    Route::resource('/additionals', EmployeeSalaryAdditionalController::class);
    Route::controller(EmployeeSalaryAdditionalController::class)->prefix('additionals')->name('additionals.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية الخصومات الرواتب
    Route::resource('/discounts', EmployeeSalaryDiscountController::class);
    Route::controller(EmployeeSalaryDiscountController::class)->prefix('discounts')->name('discounts.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية المكافئات الرواتب
    Route::resource('/rewards', EmployeeSalaryRewardsController::class);
    Route::controller(EmployeeSalaryRewardsController::class)->prefix('rewards')->name('rewards.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية البدلات الرواتب
    Route::resource('/allowancesSalary', EmployeeSalaryAllowanceController::class);
    Route::controller(EmployeeSalaryAllowanceController::class)->prefix('allowancesSalary')->name('allowancesSalary.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });


    // بداية السلف الشهرية الرواتب
    Route::resource('/loans', EmployeeSalaryLoanController::class);
    Route::controller(EmployeeSalaryLoanController::class)->prefix('loans')->name('loans.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
    });

    // بداية السلف المستديمة الرواتب
    Route::resource('/permanentLoan', EmployeeSalaryPermanentLoansController::class);
    Route::controller(EmployeeSalaryPermanentLoansController::class)->prefix('permanentLoan')->name('permanentLoan.')->group(function () {
        Route::post('/checkExsistsBefor',  'checkExsistsBefor')->name('checkExsistsBefor');
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/load_edit_row',  'load_edit_row')->name('load_edit_row');
        Route::post('/load_installment_details',  'load_installment_details')->name('load_installment_details');
        Route::post('/do_edit_row',  'do_edit_row')->name('do_edit_row');
        Route::post('/print_search',  'print_search')->name('print_search');
        Route::put('/disbursed_done_now/{id}',  'disbursed_done_now')->name('disbursed_done_now');
        Route::post('/doSingleCachPayNow',  'doSingleCachPayNow')->name('doSingleCachPayNow');
    });


    // رواتب الموظفين المفصلة
    Route::resource('/mainSalaryEmployees', MainSalaryEmployeeController::class);
    Route::controller(MainSalaryEmployeeController::class)->prefix('mainSalaryEmployees')->name('mainSalaryEmployees.')->group(function () {
        Route::post('/search',  'ajaxSearch')->name('ajax-search');
        Route::post('/print_search',  'print_search')->name('print_search');
        Route::post('/addManualSalary/{id}',  'addManualSalary')->name('addManualSalary');
        Route::get('/showSalryDetails/{id}',  'showSalryDetails')->name('showSalryDetails');
        Route::put('/doStopSalary/{id}',  'doStopSalary')->name('doStopSalary');
        Route::put('/doUnlockSalary/{id}',  'doUnlockSalary')->name('doUnlockSalary');
        Route::put('/doDeleteSalaryInternal/{id}',  'doDeleteSalaryInternal')->name('doDeleteSalaryInternal');
        Route::post('/loadArchiveSalary',  'loadArchiveSalary')->name('loadArchiveSalary');
        Route::post('/doArchiveSalary/{id}',  'doArchiveSalary')->name('doArchiveSalary');
        Route::get('/printSalary/{id}',  'printSalary')->name('printSalary');
        Route::get('excel/export-excel/{id}','export');
    });

    //البصمه
    Route::resource('/attendanceDepartures', AttendanceDepartureController::class);
    Route::controller(AttendanceDepartureController::class)->prefix('attendanceDepartures')->name('attendanceDepartures.')->group(function () {
        // Route::post('/search', 'ajaxSearch')->name('attendanceDepartures.ajax-search');
        Route::post('/print_one_attendance_search', 'print_one_attendance_search')->name('print_one_attendance_search');
        Route::get('/showAttendanceDetails/{employee_code}/{finance_cln_periods_id}',  'showAttendanceDetails')->name('showAttendanceDetails');
        Route::get('/uploadFileExcel/{id}', 'uploadFileExcel')->name('uploadFileExcel');
        Route::post('/DoUploadFileExcel/{id}', 'DoUploadFileExcel')->name('DoUploadFileExcel');
        Route::post('/load_fp_archive', 'load_fp_archive')->name('load_fp_archive');
        Route::post('/load_active_attendance_departure',  'load_active_attendance_departure')->name('load_active_attendance_departure');
        Route::post('/save_active_attendance_departure',  'save_active_attendance_departure')->name('save_active_attendance_departure');
        Route::post('/redo_update_actions',  'redo_update_actions')->name('redo_update_actions');
        Route::post('/load_my_actions', 'load_my_actions')->name('load_my_actions');
        Route::get('/print_one_fp_details/{employee_code}/{finance_cln_periods_id}',  'print_one_fp_details')->name('print_one_fp_details');
        Route::post('/ajax_search/{employee_code}/{finance_cln_periods_id}', 'ajax_search')->name('ajax_search');
    });


    // بداية الأجازات
    Route::resource('/vacationsBalance', MainEmployeesVacationBalanceController::class);
    Route::controller(MainEmployeesVacationBalanceController::class)->prefix('vacationsBalance')->name('vacationsBalance.')->group(function () {
        Route::post("/getcities", 'getcities')->name('getcities');
        Route::post("/get_governorates", 'get_governorates')->name('get_governorates');
        Route::post('/ajax_search', 'ajax_search')->name('ajax_search');
        Route::post('/add_files/{id}', 'add_files')->name('add_files');
        Route::delete('/delete_files/{id}', 'destroy_file')->name('destroy_file');
        Route::post('/add_allowances/{id}', 'add_allowance')->name('add_allowance');
        Route::delete('/delete_allowances/{id}', 'destroy_allowance')->name('destroy_allowance');
        Route::post('/load_edit_allowances', 'load_edit_allowances')->name('load_edit_allowances');
        Route::put('/do_edit_allowances/{id}', 'do_edit_allowances')->name('do_edit_allowances');
        Route::post('/showSalaryArchived', 'showSalaryArchived')->name('showSalaryArchived');
    });


    


    
});

// بداية صلاحيات المستخدمين
Route::group(['middleware' => ['auth:admin', 'role:super-admin|admin']], function () {
    Route::get('roles/{roleId}/give-permissions', [App\Http\Controllers\RoleController::class, 'addPermissionToRole']);
    Route::put('roles/{roleId}/give-permissions', [App\Http\Controllers\RoleController::class, 'givePermissionToRole']);
    Route::get('permissions/{permissionId}/delete', [App\Http\Controllers\PermissionController::class, 'destroy']);
});


Route::get('/{page}', [PageController::class, 'index']);

Route::middleware('auth')->group(function () {});


require __DIR__ . '/auth.php';