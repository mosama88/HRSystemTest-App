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
        ['id' => 1, 'name' => 'المعادي', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 2, 'name' => 'مدينة نصر', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 3, 'name' => 'سيدي بشر', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:08:05'],
            ['id' => 4, 'name' => 'الزقازيق', 'active' => 1, 'governorate_id' => 27, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:07:59'],
            ['id' => 5, 'name' => 'طنطا', 'active' => 1, 'governorate_id' => 10, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:07:50'],
            ['id' => 6, 'name' => 'دمنهور', 'active' => 1, 'governorate_id' => 9, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:07:37'],
            ['id' => 7, 'name' => 'باب الشعرية', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:07:11'],
            ['id' => 8, 'name' => 'الشيخ زايد', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:46:18'],
            ['id' => 9, 'name' => 'الهرم', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:00:43'],
            ['id' => 10, 'name' => 'العبور', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 11, 'name' => 'مصر القديمة', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 12, 'name' => 'الزمالك', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 13, 'name' => 'مدينة بدر', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 14, 'name' => 'الشروق', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 15, 'name' => 'الوايلى', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:42'],
            ['id' => 16, 'name' => 'العجمي', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:32'],
            ['id' => 17, 'name' => 'محطة الرمل', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:26'],
            ['id' => 18, 'name' => 'كرموز', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:20'],
            ['id' => 19, 'name' => 'الأنفوشي', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:14'],
            ['id' => 20, 'name' => 'عابدين', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:06:08'],
            ['id' => 21, 'name' => 'بلطيم', 'active' => 1, 'governorate_id' => 12, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:05:51'],
            ['id' => 22, 'name' => 'كفر الدوار', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 23, 'name' => 'أبو حمص', 'active' => 1, 'governorate_id' => 9, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:05:27'],
            ['id' => 24, 'name' => 'الازبكية', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:05:11'],
            ['id' => 25, 'name' => 'سفاجا', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:04:45'],
            ['id' => 26, 'name' => 'دهب', 'active' => 1, 'governorate_id' => 21, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:04:23'],
            ['id' => 27, 'name' => 'طابا', 'active' => 1, 'governorate_id' => 21, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:03:54'],
            ['id' => 28, 'name' => 'مصر الجديدة', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:03:29'],
            ['id' => 29, 'name' => 'العريش', 'active' => 1, 'governorate_id' => 22, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:03:18'],
            ['id' => 30, 'name' => 'م نصر', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:03:08'],
            ['id' => 31, 'name' => 'السلام', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:02:51'],
            ['id' => 32, 'name' => 'حلمية الزيتون', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:02:35'],
            ['id' => 33, 'name' => 'المهندسين', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:01:26'],
            ['id' => 34, 'name' => 'الوراق', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:01:09'],
            ['id' => 35, 'name' => 'العجوزة (حي)', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:00:28'],
            ['id' => 36, 'name' => 'إمبابة', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 08:00:10'],
            ['id' => 37, 'name' => 'البراجيل', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:59:38'],
            ['id' => 38, 'name' => 'مركز ناصر', 'active' => 1, 'governorate_id' => 26, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:58:09'],
            ['id' => 39, 'name' => 'مغاغة ', 'active' => 1, 'governorate_id' => 20, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:57:59'],
            ['id' => 40, 'name' => 'البداري', 'active' => 1, 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:56:54'],
            ['id' => 41, 'name' => 'ديروط', 'active' => 1, 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 42, 'name' => 'أبو قير', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:55:00'],
            ['id' => 43, 'name' => 'مدينة السادات', 'active' => 1, 'governorate_id' => 28, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:54:49'],
            ['id' => 44, 'name' => 'مدينة حلايب', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:54:39'],
            ['id' => 45, 'name' => 'دشنا ', 'active' => 1, 'governorate_id' => 19, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:53:53'],
            ['id' => 46, 'name' => 'حي الأربعين ', 'active' => 1, 'governorate_id' => 7, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:52:48'],
            ['id' => 47, 'name' => 'المحلة الكبرى', 'active' => 1, 'governorate_id' => 10, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:51:56'],
            ['id' => 48, 'name' => 'بلبيس', 'active' => 1, 'governorate_id' => 27, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:51:17'],
            ['id' => 49, 'name' => 'كفر الزيات', 'active' => 1, 'governorate_id' => 10, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:51:08'],
            ['id' => 50, 'name' => 'الزيتون', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 51, 'name' => 'المنصورة', 'active' => 1, 'governorate_id' => 5, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:50:05'],
            ['id' => 52, 'name' => 'بركة السبع', 'active' => 1, 'governorate_id' => 28, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:49:49'],
            ['id' => 53, 'name' => 'والباجور ', 'active' => 1, 'governorate_id' => 28, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:49:29'],
            ['id' => 54, 'name' => 'القصير', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:47:48'],
            ['id' => 55, 'name' => 'التل الكبير', 'active' => 1, 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:47:32'],
            ['id' => 56, 'name' => 'القوصية', 'active' => 1, 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:47:08'],
            ['id' => 57, 'name' => 'بولاق الدكرور', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:46:12'],
            ['id' => 58, 'name' => 'حلوان', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 59, 'name' => 'الرحاب', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:45:22'],
            ['id' => 60, 'name' => 'أبو تيج', 'active' => 1, 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:55:25'],
            ['id' => 61, 'name' => 'الصف', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 62, 'name' => 'العاشر من رمضان', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 63, 'name' => 'أبوزعبل', 'active' => 1, 'governorate_id' => 8, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:44:13'],
            ['id' => 64, 'name' => 'البرلس', 'active' => 1, 'governorate_id' => 12, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:43:55'],
            ['id' => 65, 'name' => 'الجمرك', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => null],
            ['id' => 66, 'name' => 'المنيل', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:43:31'],
            ['id' => 67, 'name' => 'العطارين', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:42:13'],
            ['id' => 68, 'name' => 'الإبراهيمية', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:41:56'],
            ['id' => 69, 'name' => 'أبوزنيمة', 'active' => 1, 'governorate_id' => 21, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:41:48'],
            ['id' => 70, 'name' => 'أبو رديس', 'active' => 1, 'governorate_id' => 21, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => null, 'updated_at' => '2024-12-18 07:41:26'],
            ['id' => 71, 'name' => 'سهل حشيش', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => '2024-12-18 07:40:54', 'updated_at' => '2024-12-18 07:40:54'],
            ['id' => 72, 'name' => 'حوش عيسى', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 73, 'name' => 'القنطرة شرق', 'active' => 1, 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 74, 'name' => 'المطرية', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 75, 'name' => 'البدرشين', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => '2024-12-18 07:40:12', 'updated_at' => NULL],
            ['id' => 76, 'name' => 'المنيب', 'active' => 1, 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => '2024-12-18 07:40:07', 'updated_at' => NULL],
            ['id' => 77, 'name' => 'مينا البصل', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 1, 'created_at' => '2024-12-18 07:40:00', 'updated_at' => NULL],
            ['id' => 78, 'name' => 'الشروق', 'active' => 1, 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 77, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 79, 'name' => 'طلخا', 'active' => 1, 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 78, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 80, 'name' => 'كفر شكر', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 79, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 81, 'name' => 'الخانكة', 'active' => 1, 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 80, 'created_at' => NULL, 'updated_at' => NULL],
            ['id' => 82, 'name' => 'مركز دمياط', 'active' => 1, 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'com_code' => 81, 'created_at' => NULL, 'updated_at' => NULL],
]);

    }
}