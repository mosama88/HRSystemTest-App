<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class JobGradeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('job_grades')->delete();
        DB::table('job_grades')->insert([
            [
                'job_grades_code' => 4,
                'name' => 'الدرجه الرابعه',
                'min_salary' => '5000',
                'max_salary' => '6000',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
            ],
        ]);


        DB::table('job_grades')->insert([
            [
                'job_grades_code' => 3,
                'name' => 'الدرجه الثالثه',
                'min_salary' => '6000',
                'max_salary' => '7000',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
            ],
        ]);


        DB::table('job_grades')->insert([
            [
                'job_grades_code' => 2,
                'name' => 'الدرجه الثانية',
                'min_salary' => '7000',
                'max_salary' => '8000',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
            ],
        ]);


        DB::table('job_grades')->insert([
            [
                'job_grades_code' => 1,
                'name' => 'الدرجه الأولى',
                'min_salary' => '8000',
                'max_salary' => '10000',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,            ],
        ]);
    }
}