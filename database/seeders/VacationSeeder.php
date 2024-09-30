<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class VacationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('vacation_types')->delete();

        DB::table('vacation_types')->insert([
            [
                'name' => 'راحة أسبوعية',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('vacation_types')->insert([
            [
                'name' => 'سنوى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('vacation_types')->insert([
            [
                'name' => 'بدل راحة',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('vacation_types')->insert([
            [
                'name' => 'اجازه رسمية',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('vacation_types')->insert([
            [
                'name' => 'غياب بدون إذن',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('vacation_types')->insert([
            [
                'name' => 'غياب بدون آجر',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'وضع',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'ميلاد',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'وفاة',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'مرضى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'زواج',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('vacation_types')->insert([
            [
                'name' => 'آخرى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);
    }
}
