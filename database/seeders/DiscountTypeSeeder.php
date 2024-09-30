<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class DiscountTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('discount_types')->delete();
        DB::table('discount_types')->insert([
            [
                'name' => 'الضرائب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'التأمين الاجتماعي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'التأمين الصحي',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'التأمين على الحياة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('discount_types')->insert([
            [
                'name' => 'خصم القروض',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('discount_types')->insert([
            [
                'name' => 'غياب غير مبرر',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('discount_types')->insert([
            [
                'name' => 'تأخير عن العمل',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('discount_types')->insert([
            [
                'name' => 'خصم جزاءات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('discount_types')->insert([
            [
                'name' => 'خصم مبيعات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => ' خصم سلف',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'خصم تأمينات إضافية',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'خصم نفقات تدريب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('discount_types')->insert([
            [
                'name' => 'خصم اشتراكات',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

    }
}