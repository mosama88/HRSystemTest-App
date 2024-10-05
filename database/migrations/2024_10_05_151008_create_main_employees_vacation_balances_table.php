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
        Schema::create('main_employees_vacation_balances', function (Blueprint $table) {
            $table->id();
            $table->integer('employee_code')->comment('كود الموظف');
            $table->string('year_month', 30)->comment('الشهر المالى المرتب')->nullable();
            $table->string('financial_year', 10)->comment('السنه المالية ');
            $table->decimal('carryover_from_previous_month', 10, 2)->comment('الرصيد المرحل من الشهر السابق')->nullable()->default('0');
            $table->decimal('current_month_balance', 10, 2)->comment('رصيد الشهر الحالى')->nullable()->default('0');
            $table->decimal('total_available_balance', 10, 2)->comment('اجمالى الرصيد المتاح')->nullable()->default('0');
            $table->decimal('spent_balance', 10, 2)->comment('الرصيد المستهلك')->nullable()->default('0');
            $table->decimal('net_balance', 10, 2)->comment('صافى الرصيد')->nullable()->default('0');
            $table->foreignId('created_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
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
        Schema::dropIfExists('main_employees_vacation_balances');
    }
};
