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
    ['name' => 'المعادي', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'مدينة نصر', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'سيدي بشر', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'الزقازيق', 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'طنطا', 'governorate_id' => 5, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'دمنهور', 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'الغردقة', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'الشيخ زايد', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'الهرم', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'العبور', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
    ['name' => 'مصر القديمة', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الزمالك', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'مدينة بدر', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الشروق', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الأسكندرية', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العجمي', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'محطة الرمل', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'كرموز', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الأنفوشي', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الشيخ عبد الله', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'بلطيم', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'كفر الدوار', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أبو حمص', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'رأس غارب', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'سفاجا', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'دهب', 'governorate_id' => 14, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'طابا', 'governorate_id' => 14, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'شرم الشيخ', 'governorate_id' => 14, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العريش', 'governorate_id' => 15, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'رفح', 'governorate_id' => 15, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الشيخ زويد', 'governorate_id' => 15, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'منوف', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'شبين الكوم', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الباجور', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أشمون', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'السادات', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الفيوم', 'governorate_id' => 17, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'بني سويف', 'governorate_id' => 17, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'المنيا', 'governorate_id' => 17, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الشرقية', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'ديروط', 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أبو قير', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'مدينة السادات', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'رأس غارب', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'مرسى مطروح', 'governorate_id' => 19, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'السويس', 'governorate_id' => 7, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العاشر من رمضان', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'بلبيس', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'كفر الزيات', 'governorate_id' => 5, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الزيتون', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'المنصورة', 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'شبين الكوم', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أشمون', 'governorate_id' => 16, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'القصير', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'النبابيه', 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'ديروط', 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الشيخ زايد', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'حلوان', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العاشر من رمضان', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'ديروط', 'governorate_id' => 6, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الصف', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العاشر من رمضان', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أبوزعبل', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'البرلس', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الجمرك', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الروضة', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'العطارين', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'الإبراهيمية', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أبوزنيمة', 'governorate_id' => 14, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'أبو رديس', 'governorate_id' => 14, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'سهل حشيش', 'governorate_id' => 13, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'حوش عيسى', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'القنطرة شرق', 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'المطرية', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'البدرشين', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'المنيب', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>  1],
    ['name' => 'مينا البصل', 'governorate_id' => 2, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' =>1],
     ['name' => 'الشروق', 'governorate_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 77],
    ['name' => 'طلخا', 'governorate_id' => 4, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 78],
    ['name' => 'كفر شكر', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 79],
    ['name' => 'الخانكة', 'governorate_id' => 18, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 80],
    ['name' => 'مركز دمياط', 'governorate_id' => 3, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 81]
]);

    }
}