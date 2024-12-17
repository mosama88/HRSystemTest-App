<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Employees;

use Livewire\Component;
use App\Models\Employee;
use App\Models\JobGrade;
use App\Models\ShiftsType;
use App\Traits\UploadTrait;
use App\Traits\GeneralTrait;
use App\Models\SalaryArchive;
use App\Http\Requests\Dashboard\EmployeeRequest;

class EmployeesCreate extends Component
{

    use UploadTrait;
    use GeneralTrait;

    public function rules()
    {
        return (new EmployeeRequest())->rules();
    }


    public function messages()
    {
        return (new EmployeeRequest())->messages();
    }

 public function submit()
    {
        $com_code = auth()->user()->com_code;
        $last_employee = get_cols_where_row_orderby(new Employee(), array("employee_code"), array("com_code" => $com_code), "employee_code", "DESC");

        if (!empty($last_employee)) {  // لو القيم مش فاضية
            $dataToInsert['employee_code'] =  $last_employee['employee_code'] + 1;          //هيزود رقم على كل موظف
        } else //أول موظف يتم تسجيلة
        {
            $dataToInsert['employee_code'] = 1; //بداية الترقيم
        }

        // جلب الدرجة الوظيفية بناءً على com_code و job_grade_id
        $jobGrade = JobGrade::where('com_code', $com_code)
            ->where('id', $request->job_grade_id)
            ->first();

        if ($jobGrade) {
            // التحقق مما إذا كان الراتب ضمن النطاق المسموح به
            if ($request->salary < $jobGrade->min_salary || $request->salary > $jobGrade->max_salary) {
                return redirect()->back()->with(['error' => 'عفوا، يجب أن يكون المرتب بين الحد الأدنى والحد الأقصى للدرجة الوظيفية (' . $jobGrade->min_salary . ' - ' . $jobGrade->max_salary . ')'])->withInput();
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
            if ($request->has_fixed_shift == "Yes") {
                $shiftData = get_Columns_where_row(new ShiftsType(), "total_hours", array("com_code" => $com_code, "id" => $request->shift_types_id));
                if (!empty($shiftData)) {
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

            if (!empty($request->salary)) {

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

            $employee = insert(new Employee(), $dataToInsert, true);
            if ($employee) {
                if ($dataToInsert['salary'] > 0) {
                    $dataToInsertSalaryArchive['employee_id'] = $employee['id'];
                    $dataToInsertSalaryArchive['value'] = $dataToInsert['salary'];
                    $dataToInsertSalaryArchive['created_by'] = auth()->user()->id;
                    $dataToInsertSalaryArchive['com_code'] = $com_code;
                    insert(new SalaryArchive(), $dataToInsertSalaryArchive);
                }
            }
            // Upload Photo
            $this->verifyAndStoreImage($request, 'photo', 'employees/photo/', 'upload_image', $employee->id, 'App\Models\Employee');

    }
}
    public function render()
    {
        return view('dashboard.affairs_employees.employees.employees-create');
    }
}
