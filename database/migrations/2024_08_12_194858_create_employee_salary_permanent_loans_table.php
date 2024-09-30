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
        Schema::create('employee_salary_permanent_loans', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('employee_code')->comment('كود الموظف');
            $table->decimal('employee_salary', 10., 2)->comment('مرتب الموظف');
            $table->decimal('total', 10, 2)->comment('أجمالى القرض أو السلفه');
            $table->integer('month_number_installment')->nullable()->comment('عدد الشهور للأقساط');
            $table->decimal('month_installment_value', 10, 2)->nullable()->comment('قيمة القسط الشهرى');
            $table->string('year_month_start', 20)->nullable()->comment('يبدأ السداد من الشهر المالى');
            $table->date('year_month_start_date')->nullable()->comment('يبدأ سداد أول قسط بتاريخ ');
            $table->decimal('installment_paid', 10, 2)->nullable()->default(0)->comment('قيمة القسط المدفوع');
            $table->decimal('installment_remain', 10, 2)->nullable()->default(0)->comment('قيمة القسط المتبقى');
            $table->integer('has_disbursed_done')->nullable()->default(0)->comment('حالة الصرف');
            $table->foreignId('disbursed_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->date('disbursed_at')->nullable()->comment('متى صرف');
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
        Schema::dropIfExists('employee_salary_permanent_loans');
    }
};
