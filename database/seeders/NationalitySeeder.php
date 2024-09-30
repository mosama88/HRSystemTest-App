<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class NationalitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('nationalities')->delete();

        DB::table('nationalities')->insert([
            [
                'name' => 'مصرى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('nationalities')->insert([
            [
                'name' => 'سورى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('nationalities')->insert([
            [
                'name' => 'لبنانى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('nationalities')->insert([
            [
                'name' => 'يمنى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);

        DB::table('nationalities')->insert([
            [
                'name' => 'هندى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);


        DB::table('nationalities')->insert([
            [
                'name' => 'إنجليزى',
                'created_by' => 1,
                'updated_by' => 1,
                'active' => 1,
                'com_code' => 1,
            ],
        ]);
    }
}