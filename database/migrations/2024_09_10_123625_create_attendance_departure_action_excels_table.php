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
        Schema::create('attendance_departure_action_excels', function (Blueprint $table) {
            $table->id();
            $table->foreignId('finance_cln_periods_id')->comment('كود الشهر المالى');
            $table->bigInteger('employee_code')->comment('كود الموظف');
            $table->dateTime('date_time_action')->comment('توقيت البصمه من جهاز البصمة');
            $table->tinyInteger('action_type')->comment('(1 حضور) - (2 انصراف)نوع حركة البصمة');
            $table->foreignId('main_salary_employees_id')->nullable()->comment('كود الراتب بالشهر المالى ان وجد');
            $table->foreignId('created_by')->references('id')->on('admins')->onUpdate('cascade');
            $table->dateTime('created_at')->comment('تاريخ الأضافة');
            $table->integer('com_code');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_departure_action_excels');
    }
};
