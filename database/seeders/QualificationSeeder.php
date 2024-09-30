<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class QualificationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('qualifications')->delete();
        DB::table('qualifications')->insert([
            [
                'name' => 'ليسانس حقوق',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('qualifications')->insert([
            [
                'name' => 'بكالوريوس نظم و معلومات إدارية',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('qualifications')->insert([
            [
                'name' => 'بكالوريوس تجارة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('qualifications')->insert([
            [
                'name' => 'بكالوريوس تجارة خارجية',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('qualifications')->insert([
            [
                'name' => 'بكالوريوس إدارة أعمال',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);


        DB::table('qualifications')->insert([
            [
                'name' => 'بكالوريوس علوم حاسب',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);
    }
}