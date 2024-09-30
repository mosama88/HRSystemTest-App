<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MainSalaryEmployeesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('main_salary_employees')->insert([
            [
                'id' => 1,
                'finance_cln_periods_id' => 1,
                'employee_code' => 1,
                'employee_name' => 'سها السيد محمود خليل',
                'day_price' => '170.00',
                'is_sensitive_manager_data' => 'yes',
                'branch_id' => 1,
                'employee_status' => 'Employee',
                'employee_department_code' => 2,
                'employee_jobs_id' => 6,
                'total_rewards_salary' => '0.00',
                'motivation' => '0.00',
                'additional_days_counter' => '0.00',
                'additional_days_total' => '0.00',
                'absence_days_counter' => '0.00',
                'absence_days_total' => '0.00',
                'monthly_loan' => '0.00',
                'permanent_loan' => '0.00',
                'discount' => '0.00',
                'phones_bill' => '0.00',
                'medical_insurance_monthly' => '0.00',
                'medical_social_monthly' => '0.00',
                'fixed_allowance' => '0.00',
                'changeable_allowance' => '0.00',
                'total_benefits' => '0.00',
                'total_deductions' => '0.00',
                'sanctions_days_counter' => '0.00',
                'sanctions_days_total' => '0.00',
                'salary_employee' => '5000.00',
                'archive_by' => NULL,
                'is_archived' => 'yes',
                'archived_date' => NULL,
                'last_salary_remain_balance' => '0.00',
                'last_main_salary_record_id' => NULL,
                'net_salary' => NULL,
                'net_salary_after_close_for_deportation' => NULL,
                'year_month' => '2024-01',
                'financial_year' => 2024,
                'cash_visa' => 'visa',
                'is_stopped' => 'unstopped',
                'is_archived' => 0,
                'is_take_action_disbursed_collect' => 0,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => NULL,
                'created_at' => '2024-07-29 16:46:16',
                'updated_at' => '2024-07-29 16:46:16',
            ],
            [
                'id' => 2,
                'finance_cln_periods_id' => 1,
                'employee_code' => 2,
                'employee_name' => 'محمود احمد عبدالحميد على',
                'day_price' => '270.00',
                'is_sensitive_manager_data' => 'yes',
                'branch_id' => 3,
                'employee_status' => 'Employee',
                'employee_department_code' => 2,
                'employee_jobs_id' => 6,
                'total_rewards_salary' => '0.00',
                'motivation' => '0.00',
                'additional_days_counter' => '0.00',
                'additional_days_total' => '0.00',
                'absence_days_counter' => '0.00',
                'absence_days_total' => '0.00',
                'monthly_loan' => '0.00',
                'permanent_loan' => '0.00',
                'discount' => '0.00',
                'phones_bill' => '0.00',
                'medical_insurance_monthly' => '0.00',
                'medical_social_monthly' => '0.00',
                'fixed_allowance' => '0.00',
                'changeable_allowance' => '0.00',
                'total_benefits' => '0.00',
                'total_deductions' => '0.00',
                'sanctions_days_counter' => '0.00',
                'sanctions_days_total' => '0.00',
                'salary_employee' => '8000.00',
                'archive_by' => NULL,
                'is_archived' => 'yes',
                'archived_date' => NULL,
                'last_salary_remain_balance' => '0.00',
                'last_main_salary_record_id' => NULL,
                'net_salary' => NULL,
                'net_salary_after_close_for_deportation' => NULL,
                'year_month' => '2024-01',
                'financial_year' => 2024,
                'cash_visa' => 'visa',
                'is_stopped' => 'unstopped',
                'is_archived' => 0,
                'is_take_action_disbursed_collect' => 0,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => NULL,
                'created_at' => '2024-07-29 16:46:16',
                'updated_at' => '2024-07-29 16:46:16',
            ],
        ]);
    }
}
