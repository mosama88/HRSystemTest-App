<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class FinanceCalendarsSeeder extends Seeder
{
    public function run()
    {
        DB::table('finance_calendars')->insert([
            [
                'id' => 1,
                'finance_yr' => '2024',
                'finance_yr_desc' => 'السنه المالية لسنه 2024',
                'start_date' => '2024-01-01',
                'end_date' => '2024-12-31',
                'is_open' => 0,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ]);
    }
}