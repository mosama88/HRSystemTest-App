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

        DB::table('jobs_categories')->insert([
            [
                'name' => 'فني ميكانيكا سيارات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'فني تكييف وتبريد',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'سائق شاحنة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مسؤول لوجستي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'كاتب محتوى',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مترجم',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مندوب مبيعات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'عامل نظافة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'حارس أمن',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'كهربائي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مستشار اقتصادي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'أمين صندوق',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مدير مالي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مستشار ضرائب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مدير مشاريع',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مساعد إداري',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مدير مكتب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مطور تطبيقات موبايل',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('jobs_categories')->insert([
            [
                'name' => 'مصمم واجهات وتجربة المستخدم (UI/UX)',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);
        DB::table('jobs_categories')->insert([
            [
                'name' => 'خبير أمن سيبراني',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);
        
    }
}