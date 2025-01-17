<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EmployeesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('employees')->insert([
            [
                'id' => 1,
                'employee_code' => 1,
                'fp_code' => 1,
                'name' => 'محمد اسامه محمد حسين',
                'gender' => 'Male',
                'branch_id' => 1,
                'qualification_id' => 6,
                'qualification_year' => '2009',
                'major' => 'علوم الحاسب',
                'graduation_estimate' => 'Very_Good',
                'brith_date' => '1988-03-28',
                'national_id' => '564154151515',
                'end_national_id' => '2028-08-02',
                'national_id_place' => 'بولاق الدكرور',
                'blood_types_id' => 3,
                'job_grade_id' => 3,
                'religion' => 'Muslim',
                'language_id' => 1,
                'email' => 'mosama88@hotmail.com',
                'country_id' => 1,
                'governorate_id' => 2,
                'city_id' => 2,
                'home_telephone' => '01228755885',
                'work_telephone' => '01228759920',
                'mobile' => '01228759920',
                'military' => 'Exemption',
                'military_exemption_date' => '2019-08-01',
                'military_exemption_reason' => 'ليس لدية أخوات',
                'has_relatives' => 'Yes',
                'relatives_details' => 'Special',
                'driving_license' => 'Yes',
                'driving_license_type' => 'Special',
                'driving_License_id' => '32432432432423',
                'work_start_date' => '2016-04-06',
                'functional_status' => 'Employee',
                'department_id' => 10,
                'job_categories_id' => 3,
                'has_attendance' => 'Yes',
                'has_fixed_shift' => 'Yes',
                'shift_types_id' => 1,
                'daily_work_hour' => '7.00',
                'salary' => '10000.00',
                'day_price' => '333.33',
                'motivation_type' => 'Fixed',
                'motivation' => '500.00',
                'social_insurance' => 'Yes',
                'social_insurance_cut_monthely' => '500.00',
                'social_insurance_number' => '500',
                'medical_insurance' => 'Yes',
                'medical_insurance_cut_monthely' => '500.00',
                'medical_insurance_number' => '8755488999',
                'Type_salary_receipt' => 'Visa',
                'urgent_person_details' => 'احمد السيد ذكى - 01110050006',
                'staies_address' => '8 شارع مدرسة نصرالدين اول الهرم',
                'children_number' => 3,
                'social_status' => 'Married',
                'num_vacation_days' => '30',
                'add_service' => '2',
                'years_service' => '10',
                'nationality_id' => 1,
                'name_sponsor' => 'احمد السيد',
                'pasport_identity' => '28803280102556',
                'pasport_from_place' => 'مجمع التحرير',
                'pasport_exp_date' => '2029-08-01',
                'is_done_Vacation_formula' => 1,
                'is_Sensitive_manager_data' => 0,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'id' => 2,
                'employee_code' => 2,
                'fp_code' => 4,
                'name' => 'منى طارق سعيد أبو العلا',
                'gender' => 'Female',
                'branch_id' => 4,
                'qualification_id' => 6,
                'qualification_year' => '2012',
                'major' => 'بكالوريوس إدارة أعمال',
                'graduation_estimate' => 'Fair',
                'brith_date' => '1991-01-16',
                'national_id' => '299195612305612',
                'end_national_id' => '2027-08-03',
                'national_id_place' => 'م نصر',
                'blood_types_id' => 5,
                'job_grade_id' => 2,
                'religion' => 'Muslim',
                'language_id' => 1,
                'email' => 'monat@gmail.com',
                'country_id' => 1,
                'governorate_id' => 1,
                'city_id' => 3,
                'home_telephone' => '0227828958',
                'work_telephone' => '01015713256',
                'mobile' => '01112812255',
                'military' => 'Exemption',
                'military_exemption_date' => '2012-08-01',
                'military_exemption_reason' => 'أنثى',
                'has_relatives' => 'No',
                'work_start_date' => '2019-07-31',
                'functional_status' => 'Employee',
                'department_id' => 7,
                'job_categories_id' => 4,
                'has_attendance' => 'Yes',
                'has_fixed_shift' => 'Yes',
                'shift_types_id' => 1,
                'daily_work_hour' => '7.00',
                'salary' => '25000.00',
                'day_price' => '833.33',
                'motivation_type' => 'Changeable',
                'social_insurance' => 'Yes',
                'social_insurance_cut_monthely' => '1000.00',
                'social_insurance_number' => '521545861205',
                'medical_insurance' => 'Yes',
                'medical_insurance_cut_monthely' => '800.00',
                'medical_insurance_number' => '51512055051051',
                'Type_salary_receipt' => 'Cach',
                'urgent_person_details' => 'مى سعيد - 01213578556',
                'staies_address' => '12أ شارع الدكتور محمد أحمد سليم – من ش حافظ بدوي – الحي السابع – مدينة نصر',
                'social_status' => 'Divorced',
                'num_vacation_days' => '21',
                'add_service' => '1',
                'years_service' => '6',
                'nationality_id' => 1,
                'name_sponsor' => 'احمد عباس',
                'pasport_identity' => '45548548420518548',
                'pasport_from_place' => 'مجمع التحرير',
                'pasport_exp_date' => '2029-07-31',
                'is_done_Vacation_formula' => 1,
                'is_Sensitive_manager_data' => 0,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ]);
    }
}
