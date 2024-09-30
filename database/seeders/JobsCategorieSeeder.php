<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class JobsCategorieSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {


        DB::table('jobs_categories')->delete();
        DB::table('jobs_categories')->insert([
            [
                'name' => 'محاسب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('jobs_categories')->insert([
            [
                'name' => 'محامى',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('jobs_categories')->insert([
            [
                'name' => 'IT',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'HR',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);



        DB::table('jobs_categories')->insert([
            [
                'name' => 'المبيعات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('jobs_categories')->insert([
            [
                'name' => 'المشتريات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مدير مالى',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('jobs_categories')->insert([
            [
                'name' => 'مهندس شبكات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);



        DB::table('jobs_categories')->insert([
            [
                'name' => 'مهندس تطوير الويب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);



        DB::table('jobs_categories')->insert([
            [
                'name' => 'مصمم جرافيك',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);
    }
}
