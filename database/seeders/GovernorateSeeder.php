<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class GovernorateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('governorates')->insert(
            [
                ['name' => 'القاهرة', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الجيزه', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الاسكندرية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الإسماعيلية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الدقهلية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'أسيوط', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'السويس', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'القليوبية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'البحيرة', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الغربية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'دمياط', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'كفرالشيخ', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'سوهاج', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الأقصر', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'أسوان', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الواحات', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الوادي الجديد', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'البحر الأحمر', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'قنا', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'المنيا', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'جنوب سيناء', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'شمال سيناء', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'مطروح', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'بنها', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الفيوم', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'بنى سويف', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'الشرقيه', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
                ['name' => 'المنوفية', 'country_id' => 1, 'created_by' => 1, 'updated_by' => 1, 'active' => 1, 'com_code' => 1],
            ]
        );
    }
}