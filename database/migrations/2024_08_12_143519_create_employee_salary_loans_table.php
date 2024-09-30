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
        Schema::create('employee_salary_loans', function (Blueprint $table) {
            $table->id();
            $table->foreignId('main_salary_employees_id')->references('id')->on('main_salary_employees')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId("finance_cln_periods_id")->references("id")->on("finance_cln_periods")->onUpdate("cascade")->comment('كود الشهر المالى');
            $table->bigInteger('employee_code')->comment('كود الموظف');
            $table->decimal('day_price', 10, 2)->comment('أجر يوم الموظف');
            $table->decimal('total', 10, 2)->comment('أجمالى السلف');
            $table->integer('is_archived')->nullable()->default(0)->comment('حالة الأرشفه');
            $table->foreignId('archived_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->dateTime('archived_at')->nullable();
            $table->text('notes')->nullable();
            $table->tinyInteger('active')->default(1);
            $table->integer('com_code');
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
        Schema::dropIfExists('employee_salary_loans');
    }
};
