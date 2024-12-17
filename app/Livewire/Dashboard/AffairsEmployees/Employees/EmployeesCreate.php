<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Employees;

use Livewire\Component;
use App\Models\Employee;
use App\Models\JobGrade;
use App\Models\ShiftsType;
use App\Traits\UploadTrait;
use App\Traits\GeneralTrait;
use App\Http\Requests\Dashboard\EmployeeRequest;
use App\Models\City;
use App\Models\Branch;
use App\Models\Country;
use App\Models\Language;
use App\Models\BloodType;
use App\Models\Department;
use App\Models\Governorate;
use App\Models\Nationality;
use App\Models\JobsCategory;
use App\Models\Qualification;
class EmployeesCreate extends Component
{

    use UploadTrait;
    use GeneralTrait;



    public 
    $employee_code,$fp_code,$name ,$gender,$branch_id ,$job_grade_id ,$qualification_id ,$qualification_year,$major,$graduation_estimate,$birth_date,$national_id ,$end_national_id,$national_id_place,$blood_types_id ,$religion,$language_id ,
    $email ,$country_id ,$governorate_id ,$city_id ,$home_telephone,$work_telephone,
    $mobile,$military,$military_date_from,$military_date_to,$military_wepon,$military_exemption_date,$military_exemption_reason,$military_postponement_reason,
    $date_resignation,$resignation_reason,$driving_license,$driving_license_type,
    $driving_License_id,$has_relatives,$relatives_details,$notes,$work_start_date,$functional_status,$department_id ,$job_categories_id ,$has_attendance,$has_fixed_shift,$shift_types_id ,
    $daily_work_hour,$salary,$day_price,$motivation_type,$motivation,$social_insurance,$social_insurance_cut_monthely,$social_insurance_number,$medical_insurance,$medical_insurance_cut_monthely,
    $medical_insurance_number,$Type_salary_receipt,$active_vacation,$urgent_person_details,$staies_address,$children_number,$social_status,$resignation_id ,$bank_number_account,$disabilities,$disabilities_type,
    $nationality_id ,$name_sponsor,$pasport_identity,$pasport_from_place,$pasport_exp_date,$num_vacation_days,$add_service,$years_service,$cv,$basic_address_country,$fixed_allowances,$is_done_Vacation_formula,$is_Sensitive_manager_data,$photo;
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
    $this->validate();
    }

    public function render()
    {
        $com_code = auth()->user()->com_code;
        $other['branches'] = get_cols_where(new Branch, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['qualifications'] = get_cols_where(new Qualification, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['blood_types'] = get_cols_where(new BloodType, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['nationalities'] = Nationality::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['languages'] = get_cols_where(new Language, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['countires'] = Country::orderBy('id', 'ASC')->where(['com_code' => $com_code, 'active' => 1])->get();
        $other['governorates'] = Governorate::orderBy('id', 'ASC')->get();
        $other['cities'] = get_cols_where(new City, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['departements'] = get_cols_where(new Department, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['jobs'] = get_cols_where(new JobsCategory, array('id', 'name'), array('com_code' => $com_code, "active" => 1));
        $other['shifts_types'] = get_cols_where(new ShiftsType, array('id', 'type', 'from_time', 'to_time', 'total_hours'), array('com_code' => $com_code, "active" => 1));
        $other['job_grades'] = get_cols_where(new JobGrade(), array('id', 'job_grades_code', 'name', 'min_salary', 'max_salary'), array('com_code' => $com_code, "active" => 1));

        return view('dashboard.affairs_employees.employees.employees-create',compact('other'));
    }
}

