<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class MonthSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('months')->insert(
            [
                ['name' => 'يناير', 'name_en' => 'January'],
                ['name' => 'فبراير', 'name_en' => 'February'],
                ['name' => 'مارس', 'name_en' => 'March'],
                ['name' => 'أبريل', 'name_en' => 'April'],
                ['name' => 'مايو', 'name_en' => 'May'],
                ['name' => 'يونيو', 'name_en' => 'June'],
                ['name' => 'يوليو', 'name_en' => 'July'],
                ['name' => 'أغسطس', 'name_en' => 'August'],
                ['name' => 'سبتمبر', 'name_en' => 'September'],
                ['name' => 'اكتوبر', 'name_en' => 'October'],
                ['name' => 'نوفمبر', 'name_en' => 'November'],
                ['name' => 'ديسمبر', 'name_en' => 'December'],

            ]
        );
    }
}