<?php

namespace Database\Factories;

use App\Models\Admin;
use App\Models\BloodType;
use App\Models\Branch;
use App\Models\City;
use App\Models\Country;
use App\Models\Department;
use App\Models\Governorate;
use App\Models\JobGrade;
use App\Models\JobsCategory;
use App\Models\Language;
use App\Models\Nationality;
use App\Models\Qualification;
use App\Models\ShiftsType;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Employee>
 */
class EmployeeFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {

  // تعريف أسماء البنات
  $femaleNames = [
    'منى', 'فاطمة', 'عائشة', 'ريم', 'سارة', 'نجوى', 'أسماء', 'سعاد', 'هالة', 'دنيا',
    'علا', 'رنا', 'غادة', 'نجلاء', 'فريدة', 'نور', 'آية', 'زينب', 'هند', 'مريم',
    'ليلى', 'عبير', 'نادية', 'أميرة', 'سلمى', 'لبنى', 'روان', 'دعاء', 'فرح', 'حنان',
    'جميلة', 'صفاء', 'لينا', 'يسرا', 'رغد', 'لمى', 'ماريا', 'حلا', 'شهد', 'ديما',
    'سيرين', 'ندى', 'رولا', 'تسنيم', 'سهى', 'آلاء', 'بتول', 'إيمان', 'بسمة', 'هدى',
    'رحمة', 'ياسمين', 'روى', 'جود', 'ديمة', 'نسرين', 'أريج', 'ميس', 'لارا', 'كارما',
    'مي', 'رشا', 'جمانة', 'هناء', 'فايزة', 'ثريا', 'وفاء', 'نوران', 'رينا', 'صابرين',
    'كنزي', 'جوري', 'ميرال', 'تالين', 'ليان', 'مها', 'ناهد', 'رباب', 'ميادة', 'وسام',
    'روز', 'مارين', 'تالة', 'ساجدة', 'أماني', 'سارة', 'جنى', 'هاجر', 'تولين', 'آنا',
    'شهد', 'صفا', 'لميس', 'سمر', 'نورا', 'هيا', 'مايا', 'هيفاء', 'رانيا', 'لجين'
];


// تعريف أسماء الأولاد
$maleNames = [
    'أحمد', 'محمد', 'علي', 'يوسف', 'عمر', 'حسن', 'إبراهيم', 'إسماعيل', 'مالك', 'أيمن', 
    'سالم', 'حمزة', 'آدم', 'سعيد', 'زيد', 'عبدالله', 'عبدالرحمن', 'سليمان', 'مصطفى', 'حسين',
    'فارس', 'رامي', 'ماهر', 'جمال', 'كريم', 'نور', 'صهيب', 'شادي', 'أنس', 'باسل', 
    'زياد', 'طارق', 'ياسر', 'هيثم', 'عبدالعزيز', 'مهند', 'عبداللطيف', 'علاء', 'حاتم', 'رائد', 
    'سامي', 'عماد', 'وائل', 'حامد', 'عدنان', 'عامر', 'بكر', 'توفيق', 'يحيى', 'حذيفة', 
    'عمار', 'نادر', 'باسم', 'رامز', 'إلياس', 'يوسف', 'نبيل', 'صابر', 'إبراهيم', 'منصور', 
    'ربيع', 'شريف', 'بدر', 'عبدالباسط', 'عبدالحكيم', 'عبدالسلام', 'عبدالكريم', 'عبدالحميد', 'عبدالفتاح', 'عبدالرزاق', 
    'عامر', 'عبدالحي', 'محمود', 'عصام', 'رشيد', 'أمجد', 'أكرم', 'تامر', 'سامر', 'لؤي', 
    'سهيل', 'رياض', 'رفيق', 'وجيه', 'أديب', 'قاسم', 'نبيل', 'ناجي', 'زين', 'مازن', 
    'أنور', 'أيوب', 'عادل', 'ثامر', 'معاذ', 'راغب', 'شاكر', 'سيف', 'طلال', 'جواد'
];

        // خلط الأسماء
        shuffle($maleNames);
        shuffle($femaleNames);

        // 'name' => fake()->randomElement(array_merge($male, $female)),
        // 'gender' => $gender = fake()->randomElement(['Male', 'Female']),
        // 'birth_date' => fake()->date('Y-m-d', '-25 years'),

        return [
   'fp_code' => fake()->unique()->numberBetween(0, 3000),
    'employee_code' => fake()->unique()->numberBetween(1000, 9999),
    'gender' => $gender = fake()->randomElement(['Male', 'Female']),
    'name' => $gender === 'Male'
        ? implode(' ', array_slice($maleNames, 0, 3))  // أسماء ذكور فقط
        : fake()->randomElement($femaleNames) . ' ' . implode(' ', array_slice($maleNames, 0, 2)),  // اسم بنت + اسمين ذكور
    'branch_id' => Branch::inRandomOrder()->first()->id,
            'qualification_id' => Qualification::all()->random()->id,
            'qualification_year' => fake()->year('-10 years'),
            'major' => fake()->randomElement(['علوم الحاسوب', 'الرياضيات', 'الفيزياء', 'الهندسة', 'إدارة الأعمال', 'علم الأحياء']),
            'graduation_estimate' => fake()->randomElement(['Fair', 'Good', 'Very_Good', 'Excellent']),

            // تأكد من أن عمود birth_date موجود في جدول الموظفين

            'brith_date' => fake()->dateTimeBetween('-25 years', 'now')->format('Y-m-d'),
            'national_id' => fake()->numerify('##############'),

            'end_national_id' => fake()->dateTimeBetween('now', '+5 years')->format('Y-m-d'),


            'national_id_place' => fake()->city(),
            'blood_types_id' => BloodType::all()->random()->id,
            'religion' => fake()->randomElement(['Muslim', 'Christian']),
            'language_id' => Language::all()->random()->id,

            // تأكد من عدم وجود مسافة في اسم الحقل
            'email' => fake()->unique()->safeEmail(),

            'country_id' => Country::all()->random()->id,
            'governorate_id' => Governorate::all()->random()->id,
            'city_id' => City::all()->random()->id,
            'home_telephone' => fake()->regexify('/^(022|023)[0-9]{7}$/'),
            'work_telephone' => fake()->regexify('/^(022|023)[0-9]{7}$/'),
            'mobile' => fake()->regexify('/^(012|015|010|011)[0-9]{8}$/'),
            'military' => fake()->randomElement(['Exemption', 'Exemption_Temporary', 'Complete']),
            'driving_license' => fake()->randomElement(['Yes', 'No']),
            'driving_license_type' => fake()->randomElement(['Special', 'First', 'Second', 'Third', 'Fourth', 'Pro', 'Motorcycle']),
            'driving_License_id' => fake()->numerify('##############'),
            'has_relatives' => fake()->randomElement(['Yes', 'No']),
            'work_start_date' => fake()->dateTimeBetween('-5 years', 'now')->format('Y-m-d'), // تعديل هنا
            'functional_status' =>'Employee',
            'department_id' => Department::all()->random()->id,
            'job_categories_id' => JobsCategory::all()->random()->id,
            'has_attendance' => fake()->randomElement(['Yes', 'No']),
            'has_fixed_shift' => fake()->randomElement(['Yes', 'No']),
            'shift_types_id' => ShiftsType::all()->random()->id,
            'daily_work_hour' => rand(7, 12),
            'job_grade_id' => JobGrade::all()->random()->id,
            'salary' => $salary = fake()->randomFloat(2, 5000, 50000),
            'day_price' => $salary / 30,
            'motivation_type' => $motivation_type = fake()->randomElement(['Changeable', 'Fixed']),
            'motivation' => $motivation_type === 'Fixed' ? fake()->randomFloat(2, 1000, 2000) : null,
            'social_insurance' => $social_insurance = fake()->randomElement(['Yes', 'No']),
            'social_insurance_cut_monthely' => $social_insurance === 'Yes' ? fake()->randomFloat(2, 500, 1000) : null,
            'social_insurance_number' => $social_insurance === 'Yes' ? fake()->numerify('##############') : null,
            'medical_insurance' => $medical_insurance = fake()->randomElement(['Yes', 'No']),
            'medical_insurance_cut_monthely' => $medical_insurance === 'Yes' ? fake()->randomFloat(2, 500, 1000) : null,
            'medical_insurance_number' => $medical_insurance === 'Yes' ? fake()->numerify('##############') : null,
            'Type_salary_receipt' => fake()->randomElement(['Cach', 'Visa']), // تصحيح هنا
            'active_vacation' => fake()->randomElement(['Yes', 'No']),
            'staies_address' => fake()->address(),
            'social_status' => fake()->randomElement(['Divorced', 'Single', 'Married', 'Widowed']),
            'bank_number_account' => fake()->bankAccountNumber(),
            'nationality_id' => Nationality::all()->random()->id,
            'name_sponsor' => fake()->name(),
            'pasport_identity' => fake()->numerify('##############'),
            'pasport_from_place' => fake()->city(),
            'pasport_exp_date' => fake()->dateTimeBetween('now', '+5 years')->format('Y-m-d'),
            'fixed_allowances' => fake()->numberBetween([0, 1]),
            'created_by' => Admin::all()->random()->id,
            'com_code' => 1,
        ];
    }
}