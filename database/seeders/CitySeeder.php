<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class CitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        
        DB::table('cities')->delete();

        DB::table('cities')->insert([
            [
                'name' => 'السبتيه',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'الهرم',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'مدية نصر',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'مصر الجديده',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'حلمية الزيتون',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'المهندسين',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'الدقى',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'فيصل',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'العمرانية',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => '٦ أكتوبر',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'بولاق الدكرور',
                'governorate_id' => 2,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'بولاق ابوالعلا',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'جسر السويس',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('cities')->insert([
            [
                'name' => 'الزمالك',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('cities')->insert([
            [
                'name' => 'القاهرة الجديده',
                'governorate_id' => 1,
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);
    }
}