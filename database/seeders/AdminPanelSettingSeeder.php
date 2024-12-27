<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AdminPanelSettingSeeder extends Seeder
{
    public function run()
    {
        DB::table('admin_panel_settings')->insert([
            [
                'id' => 1,
                'company_name' => 'مستشفى المروة',
                'system_status' => 1,
                'image' => null,
                'phons' => '01228759920',
                'address' => '45 شارع جامعه الدول ناصيه شهاب',
                'email' => 'info@almarwa.com',
                'created_by' => 1,
                'updated_by' => 1,
                'com_code' => 1,
                'after_minute_calculate_delay' => '15.00',
                'after_minute_calculate_early_departure' => '15.00',
                'after_minute_quarterday' => '30.00',
                'after_time_half_daycut' => '2.00',
                'after_time_allday_daycut' => '4.00',
                'monthly_vacation_balance' => '1.75',
                'after_days_begin_vacation' => '180',
                'first_balance_begin_vacation' => '10.50',
                'sanctions_value_first_absence' => '9.00',
                'sanctions_value_second_absence' => '10.00',
                'sanctions_value_thaird_absence' => '10.00',
                'sanctions_value_forth_absence' => '11.00',
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'id' => 2,
                'company_name' => 'شركة FBA',
                'system_status' => 1,
                'image' => null,
                'phons' => '01550565699',
                'address' => '45 شارع المعز ناصيه المحمدى مصر الجدية',
                'email' => 'info@fba.com',
                'created_by' => 1,
                'updated_by' => 1,
                'com_code' => 2,
                'after_minute_calculate_delay' => '0.00',
                'after_minute_calculate_early_departure' => '0.00',
                'after_minute_quarterday' => '0.00',
                'after_time_half_daycut' => '0.00',
                'after_time_allday_daycut' => '0.00',
                'monthly_vacation_balance' => '0.00',
                'after_days_begin_vacation' => '0.00',
                'first_balance_begin_vacation' => '0.00',
                'sanctions_value_first_absence' => '0.00',
                'sanctions_value_second_absence' => '0.00',
                'sanctions_value_thaird_absence' => '0.00',
                'sanctions_value_forth_absence' => '0.00',
                'created_at' => null,
                'updated_at' => null,
            ],
        ]);
    }
}
