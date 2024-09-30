<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class BranchSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        
        DB::table('branches')->delete();

        DB::table('branches')->insert([
            [
                'name' => 'فرع المعادى',
                'address' => ' 6 ش حسن محمد, متفرع من ش حسنين دسوقى, حدائق المعادى, المعادى, القاهرة.',
                'phones' => '01226548830',
                'email' => 'maadi@gmail.com',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('branches')->insert([
            [
                'name' => 'فرع المهندسين',
                'address' => 'رقم 45 شارع جامعه الدول ناصيه شهاب ',
                'phones' => '01060009780',
                'email' => 'mohandessin@gmail.com',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('branches')->insert([
            [
                'name' => 'فرع م نصر',
                'address' => '9 شارع محمد يوسف موسى – تقاطع شارع مصطفى النحاس',
                'phones' => '011186671182',
                'email' => 'nasrcity@gmail.com',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('branches')->insert([
            [
                'name' => 'فرع الأسكندرية',
                'address' => '22 طريق الجيش ، الشاطبى الاسكندرية',
                'phones' => '01550575788',
                'email' => 'alex@gmail.com',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);
    }
}