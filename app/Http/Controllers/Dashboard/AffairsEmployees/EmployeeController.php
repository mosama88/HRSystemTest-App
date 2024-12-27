<?php

namespace App\Http\Controllers\Dashboard\AffairsEmployees;

use App\Exports\EmployeeExport;
use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\EmployeeRequest;
use App\Http\Requests\Dashboard\EmployeeUpdateRequest;
use App\Models\Allowance;
use App\Models\BloodType;
use App\Models\Branch;
use App\Models\City;
use App\Models\Country;
use App\Models\Department;
use App\Models\Employee;
use App\Models\EmployeeFile;
use App\Models\EmployeeFixedAllowance;
use App\Models\Governorate;
use App\Models\JobGrade;
use App\Models\JobsCategory;
use App\Models\Language;
use App\Models\MainSalaryEmployee;
use App\Models\Nationality;
use App\Models\Qualification;
use App\Models\SalaryArchive;
use App\Models\ShiftsType;
use App\Traits\GeneralTrait;
use App\Traits\UploadTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;

class EmployeeController extends Controller
{
    use GeneralTrait;
    use UploadTrait;

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(
            new Employee,
            ['id', 'employee_code', 'fp_code', 'name', 'branch_id', 'job_grade_id', 'job_categories_id', 'work_start_date', 'functional_status', 'gender', 'created_by', 'updated_by'],
            ['com_code' => $com_code],
            'id',
            'DESC'
        )->get();
        $other['branches'] = get_cols_where(new Branch, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['qualifications'] = get_cols_where(new Qualification, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['blood_types'] = get_cols_where(new BloodType, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['nationalities'] = Nationality::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['languages'] = get_cols_where(new Language, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['countires'] = Country::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['governorates'] = Governorate::orderBy('id', 'ASC')->get();
        $other['cities'] = get_cols_where(new City, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['departements'] = get_cols_where(new Department, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['jobs'] = get_cols_where(new JobsCategory, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['shifts_types'] = get_cols_where(new ShiftsType, ['id', 'type', 'from_time', 'to_time', 'total_hours'], ['com_code' => $com_code, 'active' => 1]);
        $other['job_grades'] = get_cols_where(new JobGrade, ['id', 'job_grades_code', 'name', 'min_salary', 'max_salary'], ['com_code' => $com_code, 'active' => 1]);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->CounterUsedBefore = get_count_where(new MainSalaryEmployee, ['com_code' => $com_code, 'employee_code' => $info['employee_code']]);
            }
        }

        return view('dashboard.affairs_employees.employees.index', compact('data', 'other'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $com_code = auth()->user()->com_code;
        $other['branches'] = get_cols_where(new Branch, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['qualifications'] = get_cols_where(new Qualification, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['blood_types'] = get_cols_where(new BloodType, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['nationalities'] = Nationality::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['languages'] = get_cols_where(new Language, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['countires'] = Country::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['governorates'] = Governorate::orderBy('id', 'ASC')->get();
        $other['cities'] = get_cols_where(new City, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['departements'] = get_cols_where(new Department, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['jobs'] = get_cols_where(new JobsCategory, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['shifts_types'] = get_cols_where(new ShiftsType, ['id', 'type', 'from_time', 'to_time', 'total_hours'], ['com_code' => $com_code, 'active' => 1]);
        $other['job_grades'] = get_cols_where(new JobGrade, ['id', 'job_grades_code', 'name', 'min_salary', 'max_salary'], ['com_code' => $com_code, 'active' => 1]);

        return view('dashboard.affairs_employees.employees.create', compact('other'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(EmployeeRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            DB::beginTransaction();
            $last_employee = get_cols_where_row_orderby(new Employee, ['employee_code'], ['com_code' => $com_code], 'employee_code', 'DESC');

            if (! empty($last_employee)) {  // لو القيم مش فاضية
                $dataToInsert['employee_code'] = $last_employee['employee_code'] + 1;          //هيزود رقم على كل موظف
            } else { //أول موظف يتم تسجيلة
                $dataToInsert['employee_code'] = 1; //بداية الترقيم
            }

            // جلب الدرجة الوظيفية بناءً على com_code و job_grade_id
            $jobGrade = JobGrade::where('com_code', $com_code)
                ->where('id', $request->job_grade_id)
                ->first();

            if ($jobGrade) {
                // التحقق مما إذا كان الراتب ضمن النطاق المسموح به
                if ($request->salary < $jobGrade->min_salary || $request->salary > $jobGrade->max_salary) {
                    return redirect()->back()->with(['error' => 'عفوا، يجب أن يكون المرتب بين الحد الأدنى والحد الأقصى للدرجة الوظيفية ('.$jobGrade->min_salary.' - '.$jobGrade->max_salary.')'])->withInput();
                } elseif (empty($dataToInsert['salary'])) {
                    $dataToInsert['salary'] = $request->salary;
                } else {
                    return redirect()->back()->with(['error' => 'الدرجة الوظيفية غير موجودة.'])->withInput();
                }

                $dataToInsert['fp_code'] = $request->fp_code;
                $dataToInsert['name'] = $request->name;
                $dataToInsert['gender'] = $request->gender;
                $dataToInsert['branch_id'] = $request->branch_id;
                $dataToInsert['qualification_id'] = $request->qualification_id;
                $dataToInsert['qualification_year'] = $request->qualification_year;
                $dataToInsert['major'] = $request->major;
                $dataToInsert['graduation_estimate'] = $request->graduation_estimate;
                $dataToInsert['birth_date'] = $request->birth_date;
                $dataToInsert['national_id'] = $request->national_id;
                $dataToInsert['end_national_id'] = $request->end_national_id;
                $dataToInsert['national_id_place'] = $request->national_id_place;
                $dataToInsert['blood_types_id'] = $request->blood_types_id;
                $dataToInsert['religion'] = $request->religion;
                $dataToInsert['language_id'] = $request->language_id;
                $dataToInsert['email'] = $request->email;
                $dataToInsert['country_id'] = $request->country_id;
                $dataToInsert['governorate_id'] = $request->governorate_id;
                $dataToInsert['city_id'] = $request->city_id;
                $dataToInsert['home_telephone'] = $request->home_telephone;
                $dataToInsert['work_telephone'] = $request->work_telephone;
                $dataToInsert['mobile'] = $request->mobile;

                $military = $request->military;

                if (in_array($military, ['Complete', 'Exemption', 'Exemption_Temporary'])) {
                    $dataToInsert['military'] = $military;
                    if ($military == 'Complete') {
                        $dataToInsert['military_date_from'] = $request->military_date_from;
                        $dataToInsert['military_date_to'] = $request->military_date_to;
                        $dataToInsert['military_wepon'] = $request->military_wepon;
                    } elseif ($military == 'Exemption') {
                        $dataToInsert['military_exemption_date'] = $request->military_exemption_date;
                        $dataToInsert['military_exemption_reason'] = $request->military_exemption_reason;
                    } elseif ($military == 'Exemption_Temporary') {
                        $dataToInsert['military_exemption_date'] = $request->military_exemption_date;
                        $dataToInsert['military_postponement_reason'] = $request->military_postponement_reason;
                    }
                } else {
                    $dataToInsert['military'] = null;
                }

                $dataToInsert['date_resignation'] = $request->date_resignation;
                $dataToInsert['resignation_reason'] = $request->resignation_reason;
                $dataToInsert['driving_license'] = $request->driving_license;
                $dataToInsert['driving_license_type'] = $request->driving_license_type;
                $dataToInsert['driving_License_id'] = $request->driving_License_id;
                $dataToInsert['has_relatives'] = $request->has_relatives;
                $dataToInsert['relatives_details'] = $request->relatives_details;
                $dataToInsert['notes'] = $request->notes;
                $dataToInsert['work_start_date'] = $request->work_start_date;
                $dataToInsert['functional_status'] = $request->functional_status;
                $dataToInsert['department_id'] = $request->department_id;
                $dataToInsert['job_categories_id'] = $request->job_categories_id;
                $dataToInsert['job_grade_id'] = $request->job_grade_id;
                $dataToInsert['has_attendance'] = $request->has_attendance;
                $dataToInsert['has_fixed_shift'] = $request->has_fixed_shift;
                $dataToInsert['shift_types_id'] = $request->shift_types_id;
                if ($request->has_fixed_shift == 'Yes') {
                    $shiftData = get_Columns_where_row(new ShiftsType, 'total_hours', ['com_code' => $com_code, 'id' => $request->shift_types_id]);
                    if (! empty($shiftData)) {
                        $dataToInsert['daily_work_hour'] = $shiftData['total_hours'];
                    } else {
                        return redirect()->back()->with(['error' => 'عفوآ غير قادر على الوصول الى بيانات الشيفت المحدد للموظف'])->withInput();
                    }
                } else {
                    $dataToInsert['daily_work_hour'] = $request->daily_work_hour;
                }

                $dataToInsert['day_price'] = $request->day_price;
                $dataToInsert['motivation_type'] = $request->motivation_type;
                $dataToInsert['motivation'] = $request->motivation;
                $dataToInsert['social_insurance'] = $request->social_insurance;
                $dataToInsert['social_insurance_cut_monthely'] = $request->social_insurance_cut_monthely;
                $dataToInsert['social_insurance_number'] = $request->social_insurance_number;
                $dataToInsert['medical_insurance'] = $request->medical_insurance;
                $dataToInsert['medical_insurance_cut_monthely'] = $request->medical_insurance_cut_monthely;
                $dataToInsert['medical_insurance_number'] = $request->medical_insurance_number;
                $dataToInsert['Type_salary_receipt'] = $request->Type_salary_receipt;
                $dataToInsert['active_vacation'] = $request->active_vacation;
                $dataToInsert['urgent_person_details'] = $request->urgent_person_details;
                $dataToInsert['staies_address'] = $request->staies_address;
                $dataToInsert['children_number'] = $request->children_number;
                $dataToInsert['social_status'] = $request->social_status;
                $dataToInsert['resignation_id'] = $request->resignation_id;
                $dataToInsert['bank_number_account'] = $request->bank_number_account;
                $dataToInsert['disabilities'] = $request->disabilities;
                $dataToInsert['disabilities_type'] = $request->disabilities_type;
                $dataToInsert['nationality_id'] = $request->nationality_id;
                $dataToInsert['name_sponsor'] = $request->name_sponsor;
                $dataToInsert['pasport_identity'] = $request->pasport_identity;
                $dataToInsert['pasport_from_place'] = $request->pasport_from_place;
                $dataToInsert['pasport_exp_date'] = $request->pasport_exp_date;
                $dataToInsert['fixed_allowances'] = $request->fixed_allowances;
                $dataToInsert['num_vacation_days'] = $request->num_vacation_days;
                $dataToInsert['add_service'] = $request->add_service;
                $dataToInsert['years_service'] = $request->years_service;
                $dataToInsert['is_Sensitive_manager_data'] = $request->is_Sensitive_manager_data;

                if (! empty($request->salary)) {

                    $dataToInsert['day_price'] = $request->day_price;
                }

                $dataToInsert['created_by'] = auth()->user()->id;
                $dataToInsert['com_code'] = $com_code;

                if ($request->has('cv')) {

                    $request->validate([
                        'cv' => 'nullable|mimes:png,jpg,jpeg,pdf,doc,docx|max:5000',
                    ], [
                        'cv.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png, jpg, jpeg, pdf, doc, docx',
                        'cv.max' => 'اقصى مساحة للملف 5 ميجا',
                    ]);

                    $the_file_path = uploadImage('dashboard/assets/uploads/employees/cv/', $request->cv);
                    $dataToInsert['cv'] = $the_file_path;
                }

                $employee = insert(new Employee, $dataToInsert, true);
                if ($employee) {
                    if ($dataToInsert['salary'] > 0) {
                        $dataToInsertSalaryArchive['employee_id'] = $employee['id'];
                        $dataToInsertSalaryArchive['value'] = $dataToInsert['salary'];
                        $dataToInsertSalaryArchive['created_by'] = auth()->user()->id;
                        $dataToInsertSalaryArchive['com_code'] = $com_code;
                        insert(new SalaryArchive, $dataToInsertSalaryArchive);
                    }
                }
                // Upload Photo
                $this->verifyAndStoreImage($request, 'photo', 'employees/photo/', 'upload_image', $employee->id, 'App\Models\Employee');

                DB::commit();

                return redirect()->route('dashboard.employees.index')->with('success', 'تم أضافة بيانات الموظف بنجاح');
            }
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Employee, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->back()->with(['error' => 'عفوا اسم الموظف مسجل من قبل !'])->withInput();
        }

        $other['branches'] = get_cols_where(new Branch, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['branch_id']]);
        $other['qualifications'] = get_cols_where(new Qualification, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['qualification_id']]);
        $other['blood_types'] = get_cols_where(new BloodType, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['blood_types_id']]);
        $other['nationalities'] = get_cols_where(new Nationality, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['nationality_id']]);
        $other['languages'] = get_cols_where(new Language, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['language_id']]);
        $other['countires'] = get_cols_where(new Country, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['country_id']]);
        $other['governorates'] = get_cols_where(new Governorate, ['id', 'name'], ['id' => $data['governorate_id']]);
        $other['cities'] = get_cols_where(new City, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['city_id']]);
        $other['departements'] = get_cols_where(new Department, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['departement_id']]);
        $other['jobs_categories'] = get_cols_where(new JobsCategory, ['id', 'name'], ['com_code' => $com_code, 'id' => $data['job_categories_id']]);
        $other['shifts_types'] = get_cols_where(new ShiftsType, ['id', 'type', 'from_time', 'to_time', 'total_hours'], ['com_code' => $com_code, 'active' => 1]);
        $other['job_grades'] = get_cols_where(new JobGrade, ['id', 'job_grades_code', 'name', 'min_salary', 'max_salary'], ['com_code' => $com_code, 'active' => 1]);

        $other['employee_files'] = get_cols_where(new EmployeeFile, ['*'], ['com_code' => $com_code, 'employee_id' => $id]);
        if ($data['fixed_allowances'] == 1) {
            $data['employee_fixed_allowances'] = get_cols_where(new EmployeeFixedAllowance, ['*'], ['com_code' => $com_code, 'employee_id' => $id]);
            $other['allowances'] = get_cols_where(new Allowance, ['id', 'name'], ['active' => 1, 'com_code' => $com_code], 'id', 'ASC');
        }

        return view('dashboard.affairs_employees.employees.show', compact('data', 'other'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Employee, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->back()->with(['error' => 'عفوا اسم الموظف مسجل من قبل !'])->withInput();
        }

        $other['branches'] = get_cols_where(new Branch, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['qualifications'] = get_cols_where(new Qualification, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['blood_types'] = get_cols_where(new BloodType, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['nationalities'] = Nationality::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['languages'] = get_cols_where(new Language, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['countires'] = Country::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['governorates'] = Governorate::orderBy('id', 'ASC')->get();
        $other['cities'] = get_cols_where(new City, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['departements'] = get_cols_where(new Department, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['jobs'] = get_cols_where(new JobsCategory, ['id', 'name'], ['com_code' => $com_code, 'active' => 1]);
        $other['shifts_types'] = get_cols_where(new ShiftsType, ['id', 'type', 'from_time', 'to_time', 'total_hours'], ['com_code' => $com_code, 'active' => 1]);
        $other['job_grades'] = get_cols_where(new JobGrade, ['id', 'job_grades_code', 'name', 'min_salary', 'max_salary'], ['com_code' => $com_code, 'active' => 1]);

        return view('dashboard.affairs_employees.employees.edit', compact('data', 'other'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(EmployeeUpdateRequest $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $employee = get_Columns_where_row(new Employee, ['*'], ['com_code' => $com_code, 'id' => $id]);

            if (empty($employee)) {
                return redirect()->back()->with(['error' => 'عفوا اسم الموظف مسجل من قبل !']);
            }

            $CheckExsists_fb_code = Employee::select('id')->where('com_code', '=', $com_code)->where('fp_code', '=', $request->fp_code)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists_fb_code)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الكود مسجل من قبل '])->withInput();
            }

            // جلب الدرجة الوظيفية بناءً على com_code و job_grade_id
            $jobGrade = JobGrade::where('com_code', $com_code)
                ->where('id', $request->job_grade_id)
                ->first();

            if ($jobGrade) {
                // التحقق مما إذا كان الراتب ضمن النطاق المسموح به
                if ($request->salary < $jobGrade->min_salary || $request->salary > $jobGrade->max_salary) {
                    return redirect()->back()->with(['error' => 'عفوا، يجب أن يكون المرتب بين الحد الأدنى والحد الأقصى للدرجة الوظيفية ('.$jobGrade->min_salary.' - '.$jobGrade->max_salary.')'])->withInput();
                } elseif (empty($dataToInsert['salary'])) {
                    $dataToUpdate['salary'] = $request->salary;
                } else {
                    return redirect()->back()->with(['error' => 'الدرجة الوظيفية غير موجودة.'])->withInput();
                }

                DB::beginTransaction();

                $dataToUpdate['fp_code'] = $request->fp_code;
                $dataToUpdate['name'] = $request->name;
                $dataToUpdate['gender'] = $request->gender;
                $dataToUpdate['branch_id'] = $request->branch_id;
                $dataToUpdate['qualification_id'] = $request->qualification_id;
                $dataToUpdate['qualification_year'] = $request->qualification_year;
                $dataToUpdate['job_grade_id'] = $request->job_grade_id;
                $dataToUpdate['major'] = $request->major;
                $dataToUpdate['graduation_estimate'] = $request->graduation_estimate;
                $dataToUpdate['birth_date'] = $request->birth_date;
                $dataToUpdate['national_id'] = $request->national_id;
                $dataToUpdate['end_national_id'] = $request->end_national_id;
                $dataToUpdate['national_id_place'] = $request->national_id_place;
                $dataToUpdate['blood_types_id'] = $request->blood_types_id;
                $dataToUpdate['religion'] = $request->religion;
                $dataToUpdate['language_id'] = $request->language_id;
                $dataToUpdate['email'] = $request->email;
                $dataToUpdate['country_id'] = $request->country_id;
                $dataToUpdate['governorate_id'] = $request->governorate_id;
                $dataToUpdate['city_id'] = $request->city_id;
                $dataToUpdate['home_telephone'] = $request->home_telephone;
                $dataToUpdate['work_telephone'] = $request->work_telephone;
                $dataToUpdate['mobile'] = $request->mobile;

                $military = $request->military;

                if (in_array($military, ['Complete', 'Exemption', 'Exemption_Temporary'])) {
                    $dataToUpdate['military'] = $military;
                    if ($military == 'Complete') {
                        $dataToUpdate['military_date_from'] = $request->military_date_from;
                        $dataToUpdate['military_date_to'] = $request->military_date_to;
                        $dataToUpdate['military_wepon'] = $request->military_wepon;
                    } elseif ($military == 'Exemption') {
                        $dataToUpdate['military_exemption_date'] = $request->military_exemption_date;
                        $dataToUpdate['military_exemption_reason'] = $request->military_exemption_reason;
                    } elseif ($military == 'Exemption_Temporary') {
                        $dataToUpdate['military_exemption_date'] = $request->military_exemption_date;
                        $dataToUpdate['military_postponement_reason'] = $request->military_postponement_reason;
                    }
                } else {
                    $dataToUpdate['military'] = null;
                }

                $dataToUpdate['date_resignation'] = $request->date_resignation;
                $dataToUpdate['resignation_reason'] = $request->resignation_reason;
                $dataToUpdate['driving_license'] = $request->driving_license;
                $dataToUpdate['driving_license_type'] = $request->driving_license_type;
                $dataToUpdate['driving_License_id'] = $request->driving_License_id;
                $dataToUpdate['has_relatives'] = $request->has_relatives;
                $dataToUpdate['relatives_details'] = $request->relatives_details;
                $dataToUpdate['notes'] = $request->notes;
                $dataToUpdate['work_start_date'] = $request->work_start_date;
                $dataToUpdate['functional_status'] = $request->functional_status;
                $dataToUpdate['department_id'] = $request->department_id;
                $dataToUpdate['job_categories_id'] = $request->job_categories_id;
                $dataToUpdate['has_attendance'] = $request->has_attendance;
                $dataToUpdate['has_fixed_shift'] = $request->has_fixed_shift;
                $dataToUpdate['shift_types_id'] = $request->shift_types_id;
                if ($request->has_fixed_shift == 'Yes') {
                    $shiftData = get_Columns_where_row(new ShiftsType, 'total_hours', ['com_code' => $com_code, 'id' => $request->shift_types_id]);
                    if (! empty($shiftData)) {
                        $dataToUpdate['daily_work_hour'] = $shiftData['total_hours'];
                    } else {
                        return redirect()->back()->with(['error' => 'عفوآ غير قادر على الوصول الى بيانات الشيفت المحدد للموظف'])->withInput();
                    }
                } else {
                    $dataToUpdate['daily_work_hour'] = $request->daily_work_hour;
                }
                $dataToUpdate['salary'] = $request->salary;
                $dataToUpdate['day_price'] = $request->day_price;

                $dataToUpdate['num_vacation_days'] = $request->num_vacation_days;
                $dataToUpdate['add_service'] = $request->add_service;
                $dataToUpdate['years_service'] = $request->years_service;

                $dataToUpdate['motivation_type'] = $request->motivation_type;
                $dataToUpdate['motivation'] = $request->motivation;
                $dataToUpdate['social_insurance'] = $request->social_insurance;
                $dataToUpdate['social_insurance_cut_monthely'] = $request->social_insurance_cut_monthely;
                $dataToUpdate['social_insurance_number'] = $request->social_insurance_number;
                $dataToUpdate['medical_insurance'] = $request->medical_insurance;
                $dataToUpdate['medical_insurance_cut_monthely'] = $request->medical_insurance_cut_monthely;
                $dataToUpdate['medical_insurance_number'] = $request->medical_insurance_number;
                $dataToUpdate['Type_salary_receipt'] = $request->Type_salary_receipt;
                $dataToUpdate['active_vacation'] = $request->active_vacation;
                $dataToUpdate['urgent_person_details'] = $request->urgent_person_details;
                $dataToUpdate['staies_address'] = $request->staies_address;
                $dataToUpdate['children_number'] = $request->children_number;
                $dataToUpdate['social_status'] = $request->social_status;
                $dataToUpdate['resignation_id'] = $request->resignation_id;
                $dataToUpdate['bank_number_account'] = $request->bank_number_account;
                $dataToUpdate['disabilities'] = $request->disabilities;
                $dataToUpdate['disabilities_type'] = $request->disabilities_type;
                $dataToUpdate['nationality_id'] = $request->nationality_id;
                $dataToUpdate['name_sponsor'] = $request->name_sponsor;
                $dataToUpdate['pasport_identity'] = $request->pasport_identity;
                $dataToUpdate['pasport_from_place'] = $request->pasport_from_place;
                $dataToUpdate['pasport_exp_date'] = $request->pasport_exp_date;
                $dataToUpdate['fixed_allowances'] = $request->fixed_allowances;
                $dataToUpdate['is_Sensitive_manager_data'] = $request->is_Sensitive_manager_data;
                $dataToUpdate['updated_by'] = auth()->user()->id;
                $dataToUpdate['com_code'] = $com_code;

                // التحقق من وجود الصورة وتحديثها إذا لزم الأمر
                if ($request->has('photo')) {
                    // حذف الصورة القديمة
                    if ($employee->image) {
                        $old_img = $employee->image->filename;
                        $this->Delete_attachment('upload_image', 'employees/photo/'.$old_img, $request->id);
                        $employee->image()->delete(); // حذف السجل القديم للصورة من قاعدة البيانات
                    }
                    // رفع الصورة الجديدة وتخزينها في قاعدة البيانات
                    $this->verifyAndStoreImage($request, 'photo', 'employees/photo/', 'upload_image', $employee->id, 'App\Models\Employee');
                }

                // التحقق من وجود CV جديد وتحديثه إذا لزم الأمر
                if ($request->has('cv')) {
                    $request->validate([
                        'cv' => 'nullable|mimes:png,jpg,jpeg,pdf,doc,docx|max:5000',
                    ], [
                        'cv.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png, jpg, jpeg, pdf, doc, docx',
                        'cv.max' => 'اقصى مساحة للملف 5 ميجا',
                    ]);

                    // حذف ال CV القديم
                    if ($employee->cv) {
                        $old_cv_path = 'dashboard/assets/uploads/employees/cv/'.$employee->cv;
                        if (file_exists(public_path($old_cv_path))) {
                            unlink(public_path($old_cv_path));
                        }
                    }

                    // رفع ال CV الجديد وتخزين مساره في قاعدة البيانات
                    $the_file_path = uploadImage('dashboard/assets/uploads/employees/cv/', $request->cv);
                    $employee->update(['cv' => $the_file_path]);
                }

                // تحديث بيانات الموظف
                $flag = update(new Employee, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);

                if ($flag) {

                    //إذا كان فى اختلاف فى الراتب قيمة الراتب الحديث عن الراتب القديم ينزل له أرشيف

                    if ($dataToUpdate['salary'] != $employee['salary']) {
                        $dataToInsertSalaryArchive['employee_id'] = $id;
                        $dataToInsertSalaryArchive['value'] = $dataToUpdate['salary'];
                        $dataToInsertSalaryArchive['created_by'] = auth()->user()->id;
                        $dataToInsertSalaryArchive['com_code'] = $com_code;
                        insert(new SalaryArchive, $dataToInsertSalaryArchive);
                    }

                    // استدعاء إعادة حساب المرتب بعد أي تحديث
                    $currentSalaryData = get_Columns_where_row(new MainSalaryEmployee, ['id'], ['com_code' => $com_code, 'employee_code' => $employee['employee_code'], 'is_archived' => 0]);

                    if (! empty($currentSalaryData)) {
                        $this->recalculateMainSalaryEmployee($currentSalaryData['id']);
                    }
                }

                DB::commit();
            }

            return redirect()->route('dashboard.employees.index')->with(['success' => 'تم تحديث بيانات الموظف بنجاح']);
        } catch (\Exception $ex) {

            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy(Request $request, $id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Employee, ['*'], ['com_code' => $com_code, 'id' => $id]);

        if (empty($data)) {
            return redirect()->back()->with(['error' => 'عفوا، اسم الموظف مسجل من قبل!'])->withInput();
        }

        // معالجة الحذف الفردي
        if ($request->page_id == 1) {
            // التحقق من وجود صورة
            if ($data->image) {
                $filename = $data->image->filename;
                $path = 'employees/photo/'.$filename;

                // حذف الصورة
                $this->Delete_attachment('upload_image', $path, $data->image->id);
            }

            $CounterUsedBefore = get_count_where(new MainSalaryEmployee, ['com_code' => $com_code, 'employee_code' => $data['employee_code']]);
            if ($CounterUsedBefore != 0) {
                return redirect()->back()->with('error', 'عفوآ . هذا الموظف له سجلات للراوتب من قبل  ومتاح فقط تعطيلة لخارج الخدمه');
            }

            // حذف الموظف
            Employee::destroy($id);

            session()->flash('success', 'تم حذف الموظف بنجاح');

            return back();
        }

        // العودة مع رسالة خطأ إذا لم يكن $request->page_id يساوي 1
        session()->flash('error', 'خطأ في عملية الحذف');

        return back();
    }

    public function getcities(Request $request)
    {
        if ($request->ajax()) {
            $governorate_id = $request->governorate_id;
            $other['cities'] = get_cols_where(new City, ['id', 'name'], ['com_code' => auth()->user()->com_code, 'governorate_id' => $governorate_id], 'id', 'ASC');

            return view('dashboard.affairs_employees.employees.get_cities', ['other' => $other]);
        }
    }

    public function get_governorates(Request $request)
    {
        if ($request->ajax()) {
            $country_id = $request->country_id;
            $other['governorates'] = get_cols_where(new Governorate, ['id', 'name'], ['country_id' => $country_id], 'id', 'ASC');

            return view('dashboard.affairs_employees.employees.get_governorates', ['other' => $other]);
        }
    }

    public function ajax_search(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $byCode_search = $request->byCode_search;
            $name = $request->name;
            $branch_id = $request->branch_id;
            $department_id = $request->department_id;
            $job_categories_id = $request->job_categories_id;
            $job_grade_id = $request->job_grade_id;
            $functional_status = $request->functional_status;
            $Type_salary_receipt = $request->Type_salary_receipt;
            $gender = $request->gender;
            $searchByRadioCode = $request->searchByRadioCode;

            $query = Employee::query();

            if ($request->filled('byCode')) {
                if ($request->searchByRadioCode == 'employee_code') {
                    $query->where('employee_code', $request->byCode);
                } elseif ($request->searchByRadioCode == 'fp_code') {
                    $query->where('fp_code', $request->byCode);
                }
            }

            // اضف باقي شروط البحث هنا
            // مثال:
            if ($request->filled('name')) {
                $query->where('name', 'like', '%'.$request->name.'%');
            }

            if ($name != '') {
                $query->where('name', 'like', '%'.$name.'%');
            }

            if ($branch_id != 'all') {
                $query->where('branch_id', $branch_id);
            }

            if ($department_id != 'all') {
                $query->where('department_id', $department_id);
            }

            if ($job_categories_id != 'all') {
                $query->where('job_categories_id', $job_categories_id);
            }

            if ($job_grade_id != 'all') {
                $query->where('job_grade_id', $job_grade_id);
            }

            if ($functional_status != 'all') {
                $query->where('functional_status', $functional_status);
            }

            if ($Type_salary_receipt != 'all') {
                $query->where('Type_salary_receipt', $Type_salary_receipt);
            }

            if ($gender != 'all') {
                $query->where('gender', $gender);
            }

            if (! empty($data)) {
                foreach ($data as $info) {
                    $info->CounterUsedBefore = get_count_where(new MainSalaryEmployee, ['com_code' => $com_code, 'employee_code' => $info['employee_code']]);
                }
            }

            $data = $query->orderby('id', 'DESC')->paginate(10);

            return view('dashboard.affairs_employees.employees.ajax_search', ['data' => $data]);
        }
    }

    public function add_files(Request $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Employee, ['id'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->back()->with(['error' => 'عفوا اغير قادر للوصول على البيانات المطلوبة !']);
            }

            $checkExists = EmployeeFile::select('id')->where('com_code', '=', $com_code)->where('desc_file', '=', $request->desc_file)->where('employee_id', '=', $id)->first();
            if (! empty($checkExists)) {
                return redirect()->back()->with(['error' => 'عفوا اسم الملف موجود من قبل!']);
            }
            DB::beginTransaction();

            $dataToInsert['desc_file'] = $request->desc_file;
            $dataToInsert['employee_id'] = $id;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['updated_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;

            if ($request->has('file_path')) {

                $request->validate([
                    'file_path' => 'nullable|mimes:png,jpg,jpeg,pdf,doc,docx|max:5000',
                ], [
                    'file_path.mimes' => 'الملفات المسموح بها يجب ان تكون من نوع png, jpg, jpeg, pdf, doc, docx',
                    'file_path.max' => 'اقصى مساحة للملف 5 ميجا',
                ]);

                $the_file_path = uploadImage('dashboard/assets/uploads/employees/new/', $request->file_path);
                $dataToInsert['file_path'] = $the_file_path;
            }

            insert(new EmployeeFile, $dataToInsert);

            DB::commit();

            return redirect()->back()->with(['success' => 'تم أضافة المرفقات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()]);
        }
    }

    public function destroy_file(Request $request, $id)
    {
        $com_code = auth()->user()->com_code;
        $employee_files = get_Columns_where_row(new EmployeeFile, ['*'], ['com_code' => $com_code, 'id' => $id]);

        if (empty($employee_files)) {
            return redirect()->back()->with(['error' => 'عفوا، اسم الموظف مسجل من قبل!'])->withInput();
        }

        // معالجة الحذف الفردي
        if ($request->page_id == 1) {
            // التحقق من وجود صورة
            if ($employee_files['file_path']) {
                $filename = $employee_files['file_path'];
                $path = 'dashboard/assets/uploads/employees/new/'.$filename;

                // التحقق من وجود الملف على الخادم وحذفه
                if (file_exists(public_path($path))) {
                    unlink(public_path($path));
                }
            }

            // حذف الموظف
            EmployeeFile::destroy($id);

            session()->flash('success', 'تم حذف الملف بنجاح');

            return back();
        }

        // العودة مع رسالة خطأ إذا لم يكن $request->page_id يساوي 1
        session()->flash('error', 'خطأ في عملية الحذف');

        return back();
    }

    public function add_allowance(Request $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $dataEmployee = get_Columns_where_row(new Employee, ['id', 'employee_code'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($dataEmployee)) {
                return redirect()->back()->with(['error' => 'عفوا اغير قادر للوصول على البيانات المطلوبة !']);
            }
            $checkExists = EmployeeFixedAllowance::select('id')->where('com_code', '=', $com_code)->where('allowance_id', '=', $request->allowance_id)->where('employee_id', '=', $id)->first();
            if (! empty($checkExists)) {
                return redirect()->back()->with(['error' => 'عفوا البدل الثابت موجود من قبل!']);
            }
            DB::beginTransaction();

            $dataToInsert['employee_id'] = $id;
            $dataToInsert['allowance_id'] = $request->allowance_id;
            $dataToInsert['value'] = $request->value;
            $dataToInsert['notes'] = $request->notes;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['updated_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;
            $flag = insert(new EmployeeFixedAllowance, $dataToInsert);

            if ($flag) {
                // إذا كان حدث تعديل على المرتب يتم أحتسابة
                $currentSalaryData = get_Columns_where_row(new MainSalaryEmployee, ['id'], ['com_code' => $com_code, 'employee_code' => $dataEmployee['employee_code'], 'is_archived' => 0]);

                if (! empty($currentSalaryData)) {
                    $this->recalculateMainSalaryEmployee($currentSalaryData['id']);
                }
            }

            DB::commit();

            return redirect()->back()->with(['success' => 'تم أضافة البدلات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()]);
        }
    }

    public function load_edit_allowances(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;

            $data = get_Columns_where_row(new EmployeeFixedAllowance, ['*'], ['com_code' => $com_code, 'id' => $request->id]);
            $other['allowances'] = get_cols_where(new Allowance, ['id', 'name'], ['active' => 1, 'com_code' => $com_code], 'id', 'ASC');

            return view('dashboard.affairs_employees.employees.load_edit_allowances', ['data' => $data, 'other' => $other]);
        }
    }

    public function do_edit_allowances(Request $request)
    {
        try {
            $com_code = auth()->user()->com_code;

            // تحقق من وجود السماح الثابت
            $allowance = EmployeeFixedAllowance::select('id', 'employee_id')->where('com_code', $com_code)->where('id', $request->id)->first();
            if (! $allowance) {
                return redirect()->back()->with(['error' => 'عفوا، البدل الثابت غير موجود!']);
            }
            $dataEmployee = get_Columns_where_row(new Employee, ['employee_code'], ['com_code' => $com_code, 'id' => $allowance['employee_id']]);
            if (! $dataEmployee) {
                return redirect()->back()->with(['error' => 'عفوا، البدل الثابت غير موجود!']);
            }
            DB::beginTransaction();

            // تحديث البيانات
            $flag = $allowance->update([
                'value' => $request->value,
                'notes' => $request->notes,
                'updated_by' => auth()->user()->id,
            ]);

            if ($flag) {
                // إذا كان حدث تعديل على المرتب يتم أحتسابة
                $currentSalaryData = get_Columns_where_row(new MainSalaryEmployee, ['id'], ['com_code' => $com_code, 'employee_code' => $dataEmployee['employee_code'], 'is_archived' => 0]);

                if (! empty($currentSalaryData)) {
                    $this->recalculateMainSalaryEmployee($currentSalaryData['id']);
                }
            }

            DB::commit();

            return redirect()->back()->with(['success' => 'تم تحديث البدل الثابت بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا، حدث خطأ ما: '.$ex->getMessage()]);
        }
    }

    public function destroy_allowance(Request $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $allowance = EmployeeFixedAllowance::select('id', 'employee_id')->where('com_code', $com_code)->where('id', $id)->first();

            $dataEmployee = get_Columns_where_row(new Employee, ['employee_code'], ['com_code' => $com_code, 'id' => $allowance['employee_id']]);
            if (! $dataEmployee) {
                return redirect()->back()->with(['error' => 'عفوا، البدل الثابت غير موجود!']);
            }
            DB::beginTransaction();

            // حذف السماح الثابت للموظف
            $flag = EmployeeFixedAllowance::destroy($id);
            if ($flag) {
                // إذا كان حدث تعديل على المرتب يتم أحتسابة
                $currentSalaryData = get_Columns_where_row(new MainSalaryEmployee, ['id'], ['com_code' => $com_code, 'employee_code' => $dataEmployee['employee_code'], 'is_archived' => 0]);

                if (! empty($currentSalaryData)) {
                    $this->recalculateMainSalaryEmployee($currentSalaryData['id']);
                }
            }
            // التحقق مما إذا كان page_id لا يساوي 1
            if ($request->page_id != 1) {
                session()->flash('error', 'خطأ في عملية الحذف');

                return back();
            }

            // العودة مع رسالة نجاح إذا كانت العملية ناجحة
            DB::commit();
            session()->flash('success', 'تم حذف البدل الثابت للموظف بنجاح');

            return redirect()->back()->with(['success' => 'تم تحديث البدل الثابت بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا، حدث خطأ ما: '.$ex->getMessage()]);
        }
    }

    public function showSalaryArchived(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;
            $data = get_cols_where(new SalaryArchive, ['*'], ['com_code' => $com_code, 'employee_id' => $request->id]);

            return view('dashboard.affairs_employees.employees.showSalaryArchived', compact('data'));
        }
    }

    public function checkExsistsSalaryMax(Request $request)
    {
        if ($request->ajax()) {
            $com_code = auth()->user()->com_code;

            // البحث عن الدرجة الوظيفية المناسبة بناءً على com_code واسم الدرجة
            $jobGrade = JobGrade::where('com_code', $com_code)
                ->where('name', $request->name)
                ->where('min_salary', '<=', $request->salary) // الحد الأدنى أقل من أو يساوي الراتب
                ->where('max_salary', '>=', $request->salary) // الحد الأقصى أكبر من أو يساوي الراتب
                ->first();

            // تحقق مما إذا كان قد تم العثور على الدرجة الوظيفية
            if ($jobGrade) {
                return response()->json('لقد تخطيت المرتب', 200);
            } else {
                return response()->json('no_exsists_befor', 200);
            }
        }
    }

    public function export()
    {
        return Excel::download(new EmployeeExport, 'employees.xlsx');
    }

    public function import()
    {
        //
    }
}
