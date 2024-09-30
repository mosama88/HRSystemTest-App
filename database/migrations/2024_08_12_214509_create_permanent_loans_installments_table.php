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
        Schema::create('permanent_loans_installments', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('employee_code')->comment('كود الموظف');
            $table->foreignId('employee_permanent_loans_id')->nullable()->references('id')->on('employee_salary_permanent_loans')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('main_salary_employees_id')->nullable()->references('id')->on('main_salary_employees')->onUpdate('cascade');
            $table->decimal('month_installment_value', 10, 2)->nullable()->comment('قيمة القسط');
            $table->string('year_month', 20)->nullable()->comment('تاريخ الاستحقاق');
            $table->integer('status')->nullable()->default(0)->comment('حالة الدفع: صفر معلق - واحد تم الدفع على المرتب - أثنين تم الدفع كاش ');
            $table->integer('has_parent_disbursed_done')->nullable()->default(0)->comment('حالة الصرف');
            $table->integer('is_archived')->nullable()->default(0)->comment('حالة الأرشفه');
            $table->foreignId('archived_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->dateTime('archived_at')->nullable();
            $table->text('notes')->nullable();
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
        Schema::dropIfExists('employee_salary_permanent_loans_installments');
    }
};
