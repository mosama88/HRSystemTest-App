<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class ShiftsTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        DB::table('shifts_types')->delete();
        DB::table('shifts_types')->insert([
            [
                'id' => 1,
                'employee_id' => 3,
                'start_time' => '00:00:00',
                'end_time' => '12:00:00',
                'total_hours' => '8.00',
                'is_active' => 1,
                'branch_id' => 1,
                'department_id' => 1,
                'job_id' => 1,
                'created_at' => null,
                'updated_at' => '2024-09-07 05:47:47'
            ],
            [
                'id' => 2,
                'employee_id' => 1,
                'start_time' => '11:00:00',
                'end_time' => '19:00:00',
                'total_hours' => '8.00',
                'is_active' => 1,
                'branch_id' => 1,
                'department_id' => null,
                'job_id' => 1,
                'created_at' => '2024-09-07 05:41:50',
                'updated_at' => '2024-09-07 05:45:00'
            ],
            [
                'id' => 3,
                'employee_id' => 1,
                'start_time' => '08:30:00',
                'end_time' => '15:00:00',
                'total_hours' => '8.00',
                'is_active' => 1,
                'branch_id' => 1,
                'department_id' => 1,
                'job_id' => 1,
                'created_at' => '2024-09-07 05:42:23',
                'updated_at' => '2024-09-07 05:47:14'
            ],
            [
                'id' => 4,
                'employee_id' => 2,
                'start_time' => '13:00:00',
                'end_time' => '21:00:00',
                'total_hours' => '8.00',
                'is_active' => 1,
                'branch_id' => 1,
                'department_id' => null,
                'job_id' => 1,
                'created_at' => '2024-09-07 05:48:16',
                'updated_at' => '2024-09-07 05:48:16'
            ],
            [
                'id' => 5,
                'employee_id' => 1,
                'start_time' => '00:00:00',
                'end_time' => '08:00:00',
                'total_hours' => '8.00',
                'is_active' => 1,
                'branch_id' => 1,
                'department_id' => null,
                'job_id' => 1,
                'created_at' => '2024-10-10 07:37:36',
                'updated_at' => '2024-10-10 07:37:36'
            ],
        ]);
    }
}
