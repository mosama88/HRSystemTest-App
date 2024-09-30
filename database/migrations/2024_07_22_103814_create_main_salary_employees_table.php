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
        Schema::create('main_salary_employees', function (Blueprint $table) {
            $table->id();
            $table->foreignId("finance_cln_periods_id")->references("id")->on("finance_cln_periods")->onUpdate("cascade")->comment('كود الشهر المالى');
            $table->string('financial_year', 10)->comment('السنه المالية ');
            $table->string('year_month', 30)->comment('الشهر المالى المرتب')->nullable();
            $table->integer('employee_code')->comment('كود الموظف');
            $table->string('employee_name', 300)->comment('أسم الموظف لحظة فتح الراتب');
            $table->decimal('salary_employee', 10, 2)->comment('قيمة مرتب الموظف');
            $table->decimal('day_price', 10, 2)->comment('قيمة يوم الموظفمن الراتب');
            $table->foreignId("branch_id")->comment("كود الفرع لحظة الراتب ")->references("id")->on("branches")->onUpdate("cascade");
            $table->enum('employee_status', ["Employee", "Unemployed"])->nullable()->default('Employee')->comment('حالة الموظف لحظة الراتب'); //Functional Status
            $table->integer('employee_department_code')->comment('إدارة الموظف لحظة الراتب');
            $table->integer('employee_jobs_id')->comment('وظيفة الموظف لحظة الراتب');
            $table->decimal('total_rewards_salary', 10, 2)->comment('إجمالى الاضافى مكافأت للمرتب')->nullable()->default('0');
            $table->decimal('motivation', 10, 2)->comment('إجمالى الحافز مع العلم ممكن ان يكون ثابت او متغير')->nullable()->default('0');
            $table->decimal('additional_days_counter', 10, 2)->comment('إجمالى أيام الاضافى للمرتب')->nullable()->default('0');
            $table->decimal('additional_days_total', 10, 2)->comment('إجمالى قيمة أيام الاضافى للمرتب')->nullable()->default('0');
            $table->decimal('fixed_allowances', 10, 2)->comment('قيمة البدلات الثابته للمرتب')->nullable()->default('0');
            $table->decimal('changeable_allowance', 10, 2)->comment('قيمة البدلات المتغيره للمرتب')->nullable()->default('0');
            $table->decimal('total_benefits', 10, 2)->comment('إجمالى الأستحقاقات للموظف')->nullable()->default('0');
            $table->decimal('sanctions_days_counter', 10, 2)->comment('عدد جزاءات الأيام')->nullable()->default('0');
            $table->decimal('sanctions_days_total', 10, 2)->comment('إجمالى قيمة ايام الجزاءات')->nullable()->default('0');
            $table->decimal('absence_days_counter', 10, 2)->comment('عدد أيام الغياب للبصمة')->nullable()->default('0');
            $table->decimal('absence_days_total', 10, 2)->comment('إجمالى قيمة أيام الغياب للمرتب')->nullable()->default('0');
            $table->decimal('monthly_loan', 10, 2)->comment('إجمالى قيمة المستقطع سلف شهرية للمرتب')->nullable()->default('0');
            $table->decimal('permanent_loan', 10, 2)->comment('إجمالى قيمة المستقطع سلف مستديمة للمرتب')->nullable()->default('0');
            $table->decimal('discount', 10, 2)->comment('إجمالى قيمة الخصومات للمرتب')->nullable()->default('0');
            $table->decimal('phones_bill', 10, 2)->comment('إجمالى قيمة خصومات الهاتف للمرتب')->nullable()->default('0');
            $table->decimal('medical_insurance_monthly', 10, 2)->comment('إجمالى قيمة خصم التأمين الطبى للمرتب')->nullable()->default('0');
            $table->decimal('medical_social_monthly', 10, 2)->comment('إجمالى قيمة خصم التأمين الأجتماعى للمرتب')->nullable()->default('0');
            $table->decimal('total_deductions', 10, 2)->comment('إجمالى المستقطع للموظف')->nullable()->default('0');
            $table->decimal('net_salary', 10, 2)->comment('صافى قيمة المرتب')->nullable();
            $table->decimal('net_salary_after_close_for_deportation', 10, 2)->default(0)->comment('صافى قيمة المرتب بعد أخذ إجراء ويعتبر الرصيد المرحل للشهر الجديد فقط')->nullable();
            $table->foreignId('archive_by')->nullable()->references('id')->on('admins')->onUpdate('cascade')->comment('من قام بأرشفة الراتب');
            $table->integer('is_archived')->nullable()->default(0)->comment('حالة الموظف لحظة الراتب')->nullable();
            $table->dateTime('archived_date')->nullable()->comment('تاريخ ارشفه الراتب')->nullable();
            $table->decimal('last_salary_remain_balance', 10, 2)->comment('قيمة الراتب المرحل من الشهر السابق')->nullable();
            $table->decimal('last_main_salary_record_id', 10, 2)->comment('رقم الراتب للشهر السابق')->nullable();
            $table->integer('is_take_action_disbursed_collect')->nullable()->default(0)->comment('هل تم أخذ إجرا لصرف أو تحصيل المرتب خلال الشهر');
            $table->enum('cash_visa', ['Cach', 'Visa'])->nullable()->default('Cach')->comment('قبض المرتب كاش ام فيزا');
            $table->enum('is_sensitive_manager_data', ['yes', 'no'])->nullable()->default('yes')->comment('هل الموظف بإدارة عليا بها بيانات حساسة');
            $table->enum('is_stopped', ['stopped', 'unstopped'])->nullable()->default('unstopped')->comment('المرتب موقوف ام سارى');
            $table->integer("com_code")->comment('كود الشركة التابع لها الموظف');
            $table->foreignId('created_by')->references('id')->on('admins')->onUpdate('cascade');
            $table->foreignId('updated_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('main_salary_employees');
    }
};
