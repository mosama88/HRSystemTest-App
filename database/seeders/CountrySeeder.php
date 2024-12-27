<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CountrySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('countries')->delete();

        DB::table('countries')->insert([
            [
                'name' => 'مصر',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('countries')->insert([
            [
                'name' => 'سوريا',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('countries')->insert([
            [
                'name' => 'لبنان',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('countries')->insert([
            [
                'name' => 'اليمن',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('countries')->insert([
            [
                'name' => 'الهند',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('countries')->insert([
            [
                'name' => 'أنجلترا',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);
    }
}
