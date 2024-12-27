<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AdditionaTtypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('additional_types')->delete();
        DB::table('additional_types')->insert([
            [
                'name' => 'ساعات أضافية',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('additional_types')->insert([
            [
                'name' => 'مكافأة الأداء',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('additional_types')->insert([
            [
                'name' => 'حوافز الإنتاجية',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

    }
}
