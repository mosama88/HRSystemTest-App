<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Employees;

use App\Http\Requests\Dashboard\EmployeeRequest;
use App\Models\BloodType;
use App\Models\Branch;
use App\Models\City;
use App\Models\Country;
use App\Models\Department;
use App\Models\Governorate;
use App\Models\JobGrade;
use App\Models\JobsCategory;
use App\Models\Language;
use App\Models\Nationality;
use App\Models\Qualification;
use App\Models\ShiftsType;
use App\Traits\GeneralTrait;
use App\Traits\UploadTrait;
use Livewire\Component;
use Livewire\WithFileUploads;

class EmployeesCreate extends Component
{
    use GeneralTrait;
    use UploadTrait;
    use WithFileUploads;

    public $employee_code;

    public $fp_code;

    public $name;

    public $gender;

    public $branch_id;

    public $job_grade_id;

    public $qualification_id;

    public $qualification_year;

    public $major;

    public $graduation_estimate;

    public $birth_date;

    public $national_id;

    public $end_national_id;

    public $national_id_place;

    public $blood_types_id;

    public $religion;

    public $language_id;

    public $email;

    public $country_id;

    public $governorate_id;

    public $city_id;

    public $home_telephone;

    public $work_telephone;

    public $mobile;

    public $military;

    public $military_date_from;

    public $military_date_to;

    public $military_wepon;

    public $military_exemption_date;

    public $military_exemption_reason;

    public $military_postponement_reason;

    public $date_resignation;

    public $resignation_reason;

    public $driving_license;

    public $driving_license_type;

    public $driving_License_id;

    public $has_relatives;

    public $relatives_details;

    public $notes;

    public $work_start_date;

    public $functional_status;

    public $department_id;

    public $job_categories_id;

    public $has_attendance;

    public $has_fixed_shift;

    public $shift_types_id;

    public $daily_work_hour;

    public $salary;

    public $day_price;

    public $motivation_type;

    public $motivation;

    public $social_insurance;

    public $social_insurance_cut_monthely;

    public $social_insurance_number;

    public $medical_insurance;

    public $medical_insurance_cut_monthely;

    public $medical_insurance_number;

    public $Type_salary_receipt;

    public $active_vacation;

    public $urgent_person_details;

    public $staies_address;

    public $children_number;

    public $social_status;

    public $resignation_id;

    public $bank_number_account;

    public $disabilities;

    public $disabilities_type;

    public $nationality_id;

    public $name_sponsor;

    public $pasport_identity;

    public $pasport_from_place;

    public $pasport_exp_date;

    public $num_vacation_days;

    public $add_service;

    public $years_service;

    public $cv;

    public $basic_address_country;

    public $fixed_allowances;

    public $is_done_Vacation_formula;

    public $is_Sensitive_manager_data;

    public $photo;

    public function rules()
    {
        return (new EmployeeRequest)->rules();
    }

    public function messages()
    {
        return (new EmployeeRequest)->messages();
    }

    public function submit()
    {
        $this->validate();
    }

    public function render()
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

        return view('dashboard.affairs_employees.employees.employees-create', compact('other'));
    }
}
