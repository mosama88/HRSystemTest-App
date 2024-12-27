<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->integer('employee_code')->nullable()->comment('كود الموظف التلقائي لايتغير');
            $table->integer('fp_code')->unique()->nullable()->comment('كود بصمة الموظف من جهاز البصمة لايتغير');
            $table->string('name', 300)->unique();
            $table->enum('gender', ['Male', 'Female'])->default('Male');
            $table->foreignId('branch_id')->comment('الفرع التابع له الموظف ')->references('id')->on('branches')->onUpdate('cascade');
            $table->foreignId('job_grade_id')->comment('الدرجه الوظيفية للموظف')->references('id')->on('job_grades')->onUpdate('cascade')->nullable();
            $table->foreignId('qualification_id')->nullable()->comment('المؤهل التعليمي')->references('id')->on('qualifications')->onUpdate('cascade');
            $table->string('qualification_year', 10)->nullable()->comment('سنة التخرج');
            $table->string('major', 225)->nullable()->comment('تخصص التخرج');
            $table->enum('graduation_estimate', ['Fair', 'Good', 'Very_Good', 'Excellent'])->nullable()->comment('تقدير التخرج ')->default('Fair');
            $table->date('birth_date')->nullable()->comment('تاريخ ميلاد الموظف');
            $table->string('national_id', 50)->unique()->nullable()->comment('رقم البطاقة الشخصية - او رقم الهوية');
            $table->date('end_national_id')->nullable()->comment('تاريخ نهاية البطاقة الشخصية - بطاقة الهوية');
            $table->string('national_id_place', 225)->nullable()->comment('مكان اصدار بطاقة الهوية الشخصية');
            $table->foreignId('blood_types_id')->nullable()->comment('فصيلة الدم')->references('id')->on('blood_types')->onUpdate('cascade');
            $table->enum('religion', ['Muslim', 'Christian'])->nullable()->comment('حقل الديانة')->default('Muslim');
            $table->foreignId('language_id')->nullable()->references('id')->on('languages')->onUpdate('cascade')->comment(' اللغه التي يتكلم بها الاساسية');
            $table->string('email', 100)->unique()->nullable()->comment(' ايميل  الموظف');
            $table->foreignId('country_id')->nullable()->comment('دولة الموظف')->references('id')->on('countries')->onUpdate('cascade');
            $table->foreignId('governorate_id')->nullable()->comment('محافظة الموظف')->references('id')->on('governorates')->onUpdate('cascade');
            $table->foreignId('city_id')->nullable()->comment('مدينة الموظف')->references('id')->on('cities')->onUpdate('cascade');
            $table->string('home_telephone', 50)->nullable()->comment('رقم هاتف المنزل');
            $table->string('work_telephone', 50)->nullable()->comment('رقم هاتف العمل');
            $table->string('mobile', 50)->nullable()->comment('رقم هاتف المحمول');
            $table->enum('military', ['Exemption', 'Exemption_Temporary', 'Complete'])->nullable()->comment('الحالة العسكرية')->default('Exemption_Temporary');
            $table->date('military_date_from')->nullable()->comment('تاريخ بداية الخدمة العسكرية');
            $table->date('military_date_to')->nullable()->comment('تاريخ نهاية الخدمة العسكرية');
            $table->string('military_wepon', 500)->nullable()->comment('نوع سلاح الخدمة العسكرية');
            $table->date('military_exemption_date')->nullable()->comment('تاريخ الاعفاء من الخدمه العسكرية');
            $table->string('military_exemption_reason', 500)->nullable()->comment('سبب الاعفاء من الخدمه العسكرية ');
            $table->string('military_postponement_reason', 500)->nullable()->comment('سبب التأجيل من الخدمه العسكرية ');
            $table->date('date_resignation')->nullable()->comment('تاريخ ترك العمل');
            $table->string('resignation_reason')->nullable()->comment('سبب ترك العمل');
            $table->enum('driving_license', ['Yes', 'No'])->nullable()->comment('هل يمتلك رخصه قياده')->default('No');
            $table->enum('driving_license_type', ['Special', 'First', 'Second', 'Third', 'Fourth', 'Pro', 'Motorcycle'])->nullable()->comment('نوع رخصه القيادة')->default('Special');
            $table->string('driving_License_id', 50)->nullable()->comment('رقم رخصه القيادة');
            $table->enum('has_relatives', ['Yes', 'No'])->nullable()->default('No')->comment('هل له اقارب بالعمل ');
            $table->string('relatives_details', 600)->nullable()->comment('تفاصيل الاقارب بالعمل');
            $table->text('notes')->nullable();
            $table->date('work_start_date')->nullable()->comment('تاريخ بدء العمل للموظف');
            $table->enum('functional_status', ['Employee', 'Unemployed'])->default('Employee')->comment('حالة الموظف');
            $table->foreignId('department_id')->references('id')->on('departments')->onUpdate('cascade');
            $table->foreignId('job_categories_id')->nullable()->references('id')->on('jobs_categories')->onUpdate('cascade');
            $table->enum('has_attendance', ['Yes', 'No'])->nullable()->default('Yes')->comment('هل ملزم الموظف بعمل بصمه حضور وانصراف');
            $table->enum('has_fixed_shift', ['Yes', 'No'])->nullable()->comment('هل للموظف شفت ثابت')->default('Yes');
            $table->foreignId('shift_types_id')->nullable()->references('id')->on('shifts_types')->onUpdate('cascade');
            $table->decimal('daily_work_hour', 20, 2)->nullable()->comment('عدد ساعات العمل للموظف وهذا في حالة ان ليس له شفت ثابت');
            $table->decimal('salary', 20, 2)->nullable()->default(0)->comment('راتب الموظف');
            $table->decimal('day_price', 10, 2)->nullable()->comment('سعر يوم الموظف');
            $table->enum('motivation_type', ['Changeable', 'None', 'Fixed'])->nullable()->default('Fixed')->comment('صفر لايوجد - واحد ثابت - اثنين متغير');
            $table->decimal('motivation', 20, 2)->nullable()->default(0)->comment('قيمة الحافز الثابت ان وجد');
            $table->enum('social_insurance', ['Yes', 'No'])->nullable()->default('Yes')->comment('هل للموظف تأمين اجتماعي');
            $table->decimal('social_insurance_cut_monthely', 20, 2)->nullable()->comment('  قيمة استقطاع التأمين الاجتماعي الشهري للموظف');
            $table->string('social_insurance_number', 50)->nullable();
            $table->enum('medical_insurance', ['Yes', 'No'])->nullable()->default('Yes')->comment('هل للموظف تأمين طبي');
            $table->decimal('medical_insurance_cut_monthely', 20, 2)->nullable()->comment('  قيمة استقطاع التأمين الطبي الشهري للموظف');
            $table->string('medical_insurance_number', 50)->nullable();
            $table->enum('Type_salary_receipt', ['Cach', 'Visa'])->nullable()->default('Visa')->comment('نوع صرف الراتب - واحد كاش - اثنين فيزا بنكي');
            $table->enum('active_vacation', ['Yes', 'No'])->nullable()->default('Yes')->comment('هل هذا الموظف ينزل له رصيد اجازات	');
            $table->string('urgent_person_details', 600)->nullable()->comment('تفاصيل شخص يمكن الرجوع اليه للوصول للموظف');
            $table->text('staies_address')->nullable()->comment('عنوان الاقامة الفعلي للموظف');
            $table->integer('children_number')->nullable()->default(0);
            $table->enum('social_status', ['Divorced', 'Married', 'Single', 'Widowed'])->nullable()->default('Single')->comment('الحالة الاجتماعية');
            $table->foreignId('resignation_id')->nullable()->references('id')->on('resignations')->onUpdate('cascade');
            $table->string('bank_number_account', 50)->nullable()->comment('رقم حساب البنك للموظف');
            $table->enum('disabilities', ['Yes', 'No'])->nullable()->default('Yes')->comment('هل له اعاقة  - واحد يوجد صفر لايوجد');
            $table->string('disabilities_type', 500)->nullable()->comment('نوع الاعاقة');
            $table->foreignId('nationality_id')->nullable()->references('id')->on('nationalities')->onUpdate('cascade');
            $table->string('name_sponsor')->nullable()->comment('اسم الكفيل ');
            $table->string('pasport_identity', 100)->nullable()->comment('رقم الباسبور ان وجد');
            $table->string('pasport_from_place', 100)->nullable()->comment('مكان استخراج الباسبور');
            $table->date('pasport_exp_date')->nullable()->comment('تاريخ انتهاء الباسبور');

            // Vacation
            $table->string('num_vacation_days')->nullable()->comment('عدد ايام رصيد الأجازات');
            $table->string('add_service')->nullable()->comment('أضافة خدمه مثل 3 سنوات تجنيد');
            $table->string('years_service')->nullable()->comment('عدد سنوات الخدمه بالشركة');

            $table->string('cv', 100)->nullable();
            $table->string('basic_address_country', 300)->nullable()->comment('عنوان اقامة الموظف في بلده الام');
            // $table->date("date");
            $table->integer('fixed_allowances')->nullable()->default(0)->comment('هل له بدلات ثابته');
            $table->tinyInteger('is_done_Vacation_formula')->nullable()->default(0)->comment('هل تمت المعادله التلقائية لاحتساب الرصيد السنوي للموظف');
            $table->tinyInteger('is_Sensitive_manager_data')->nullable()->default(0)->comment('هل بيانات حساساه للمديرين مثلا ولاتظهر الا بصلاحيات خاصة	');
            $table->foreignId('created_by')->references('id')->on('admins')->onUpdate('cascade');
            $table->foreignId('updated_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->integer('com_code');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};

// INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `birth_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
// (1, 1, 83, 'محمد اسامه محمد حسين', 'Male', 1, 1, 6, '2009', 'علوم الحاسب', 'Very_Good', '1988-03-28', '564154151515', '2028-08-02', 'بولاق الدكرور', 3, 'Muslim', 1, 'mosama88@hotmail.com', 1, 2, 2, '01228755885', '01228759920', '01228759920', 'Exemption', NULL, NULL, NULL, '2019-08-01', 'ليس لدية أخوات', NULL, NULL, NULL, 'Yes', 'Special', '32432432432423', 'Yes', NULL, NULL, '2016-04-06', 'Employee', 10, 3, 'Yes', 'No', NULL, '7.00', '6000.00', '200.00', 'Fixed', '500.00', 'Yes', '500.00', '500', 'Yes', '500.00', '8755488999', 'Visa', 'Yes', 'احمد السيد ذكى - 01110050006', '8 شارع مدرسة نصرالدين اول الهرم', 3, 'Married', NULL, NULL, 'No', NULL, 1, 'احمد السيد', '28803280102556', 'مجمع التحرير', '2029-08-01', '30', '2', '10', NULL, NULL, 1, 0, NULL, 1, 1, 1, '2024-08-21 12:19:47', '2024-09-26 16:27:11'),
// (2, 2, 12, 'منى طارق سعيد أبو العلا', 'Female', 4, 4, 6, '2012', 'بكالوريوس إدارة أعمال', 'Fair', '1991-01-16', '298195612305612', '2027-08-03', 'م نصر', 5, 'Muslim', 1, 'monat@gmail.com', 1, 1, 3, '0227828958', '01015713256', '01112812255', 'Exemption', NULL, NULL, NULL, '2012-08-01', 'أنثى', NULL, NULL, NULL, 'No', NULL, NULL, 'No', NULL, NULL, '2019-07-31', 'Employee', 7, 4, 'Yes', 'Yes', 1, '8.00', '8000.00', '266.67', 'Changeable', NULL, 'Yes', '1000.00', '521545861205', 'Yes', '800.00', '51512055051051', 'Cach', 'Yes', 'مى سعيد - 01213578556', '12أ شارع الدكتور محمد أحمد سليم – من ش حافظ بدوي – الحي السابع – مدينة نصر', NULL, 'Divorced', NULL, NULL, 'No', NULL, 1, 'احمد عباس مصطفى', '45548548420518548', 'مجمع التحرير', '2029-07-31', '21', '1', '6', '1727253486329.pdf', NULL, 1, 0, NULL, 1, 1, 1, '2024-08-26 00:23:34', '2024-09-25 06:34:19'),
// (3, 3, 510, 'هادى محمود عبدالله', 'Male', 2, 4, 4, '2007', 'إدارة الأعمـال', 'Very_Good', '1986-07-02', '12314815106449', '2026-09-15', 'احمد عرابى', 7, 'Muslim', 1, 'hady@hotmail.com', 1, 2, 6, '0223591420', '0223536720', '01223599920', 'Complete', '2009-09-01', '2010-12-01', 'سلاح الطيران', NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', NULL, 'Yes', 'عبدالراضى اسماعيل بالادارة العليا', NULL, '2012-09-05', 'Employee', 4, 1, 'Yes', 'Yes', 3, '8.00', '9500.00', '316.67', 'Fixed', '500.00', 'Yes', '500.00', '521545861205', 'Yes', '500.00', '521543591205', 'Visa', 'Yes', 'ابن العم 01512589894', '45 شارع جامعه الدول ناصيه شهاب المهندسين', 2, 'Widowed', NULL, NULL, 'No', NULL, 1, 'Thor Leonard', NULL, NULL, NULL, '30', NULL, '12', NULL, NULL, 0, 0, NULL, 1, 1, 1, '2024-09-25 06:43:52', '2024-09-26 16:26:34');
