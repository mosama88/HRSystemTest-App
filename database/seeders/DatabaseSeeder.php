<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        // $this->call(FinanceSeeder::class);

        $this->call([
            AdminSeeder::class,
            MonthSeeder::class,
            FinanceCalendarsSeeder::class,
            FinanceClnPeriodsSeeder::class,
            AdminPanelSettingSeeder::class,
            UserRolePermissionSeeder::class,
            BranchSeeder::class,
            ShiftsTypeSeeder::class,
            LanguageSeeder::class,
            DepartmentSeeder::class,
            JobsCategorieSeeder::class,
            JobGradeSeeder::class,
            QualificationSeeder::class,
            BloodTypeSeeder::class,
            HolidaySeeder::class,
            ResignationSeeder::class,
            NationalitySeeder::class,
            CountrySeeder::class,
            GovernorateSeeder::class,
            CitySeeder::class,
            VacationSeeder::class,
            AdditionaTtypeSeeder::class,
            DiscountTypeSeeder::class,
            AllowancesSeeder::class,
            EmployeeSeeder::class,
        ]);
    }
}
