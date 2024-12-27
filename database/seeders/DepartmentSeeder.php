<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DepartmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        DB::table('departments')->delete();
        DB::table('departments')->insert([
            [
                'name' => 'إدارة المخاطر ',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'الإدارة المالية ',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'إدارة التغيير ',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'الإدارة التنفيذية',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'الإدارة الوسطى',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'إدارة الفريق',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'إدارة الموارد البشرية',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'إدارة الانتاج',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'الإدارة العامه',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

        DB::table('departments')->insert([
            [
                'name' => 'إدارة التكنولوجيا وعلوم الحاسب',
                'phones' => '01228759920',
                'notes' => 'إدارة مستقلة',
                'active' => 1,
                'com_code' => 1,
                'created_by' => 1,
                'updated_by' => 1,
            ],
        ]);

    }
}
