<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class HolidaySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('holidays')->delete();
        DB::table('holidays')->insert([
            'name' => 'عيد الميلاد المجيد',
            'from_date' => '2024-01-07',
            'to_date' => '2024-01-07',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'عيد الشرطة',
            'from_date' => '2024-01-25',
            'to_date' => '2024-01-25',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);


        DB::table('holidays')->insert([
            'name' => 'عيد الفطر المبارك',
            'from_date' => '2024-04-9',
            'to_date' => '2024-04-14',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);


        DB::table('holidays')->insert([
            'name' => 'عيد تحرير سيناء',
            'from_date' => '2024-04-25',
            'to_date' => '2024-04-25',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);


        DB::table('holidays')->insert([
            'name' => 'عيد العمال',
            'from_date' => '2024-05-01',
            'to_date' => '2024-05-01',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'عيد شم النسيم',
            'from_date' => '2024-05-06',
            'to_date' => '2024-05-06',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'وقفة عيد الأضحى',
            'from_date' => '2024-06-15',
            'to_date' => '2024-06-15',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'عيد الأضحى المبارك',
            'from_date' => '2024-06-16',
            'to_date' => '2024-06-19',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'ثورة ٣٠ يونيو',
            'from_date' => '2024-06-30',
            'to_date' => '2024-06-30',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);


        DB::table('holidays')->insert([
            'name' => 'رأس السنة الهجرية',
            'from_date' => '2024-07-08',
            'to_date' => '2024-07-08',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);


        DB::table('holidays')->insert([
            'name' => 'ثورة ٢٣ يوليو ١٩٥٢',
            'from_date' => '2024-07-23',
            'to_date' => '2024-07-23',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => 'المولد النبوي الشريف',
            'from_date' => '2024-09-16',
            'to_date' => '2024-09-16',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

        DB::table('holidays')->insert([
            'name' => '٦ أكتوبر',
            'from_date' => '2024-10-06',
            'to_date' => '2024-10-06',
            'days_counter' => 1,
            'active' => 1,
            'com_code' => 1,
            'created_by' => 1,
            'updated_by' => 1,
        ],);

    }
}