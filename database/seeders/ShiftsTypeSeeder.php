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
                'type' => 3,
                'from_time' => '00:00:00',
                'to_time' => '12:00:00',
                'total_hours' => '8.00',
                'active' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'com_code' => 1,
                'created_at' => null,
                'updated_at' => '2024-09-07 08:47:47',
            ],
            [
                'id' => 2,
                'type' => 1,
                'from_time' => '11:00:00',
                'to_time' => '19:00:00',
                'total_hours' => '8.00',
                'active' => 1,
                'created_by' => 1,
                'updated_by' => null,
                'com_code' => 1,
                'created_at' => '2024-09-07 08:41:50',
                'updated_at' => '2024-09-07 08:45:00',
            ],
            [
                'id' => 3,
                'type' => 1,
                'from_time' => '08:30:00',
                'to_time' => '15:00:00',
                'total_hours' => '8.00',
                'active' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'com_code' => 1,
                'created_at' => '2024-09-07 08:42:23',
                'updated_at' => '2024-09-07 08:47:14',
            ],
            [
                'id' => 4,
                'type' => 2,
                'from_time' => '13:00:00',
                'to_time' => '21:00:00',
                'total_hours' => '8.00',
                'active' => 1,
                'created_by' => 1,
                'updated_by' => null,
                'com_code' => 1,
                'created_at' => '2024-09-07 08:48:16',
                'updated_at' => '2024-09-07 08:48:16',
            ]
        ]);

    }
}
