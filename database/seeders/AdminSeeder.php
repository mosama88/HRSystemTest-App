<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('admins')->insert([
            [
                'name' => 'محمد أسامه',
                'username' => 'mosama',
                'email' => "mosama@dt.com",
                'password' => Hash::make('password'), // Hashing the password using bcrypt
                'created_by' => 1,
                'updated_by' => 1,
                'status' => 'active',
                'date' => date('Y-m-d'),
                'com_code' => 1,
            ],
        ]);
    }
}