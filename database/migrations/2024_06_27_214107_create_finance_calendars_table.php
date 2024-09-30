<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('finance_calendars', function (Blueprint $table) {
            $table->id();
            $table->string('finance_yr');
            $table->string('finance_yr_desc', 225); //تفاصيل كود السنه المالية
            $table->date('start_date');
            $table->date('end_date');
            $table->tinyInteger('is_open')->default(0)->comment('صفر = معلق | واحد = مفتوح | اثنين = مؤرشف'); //غير مفعله او مفعله
            $table->integer('com_code')->nullable();
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
        Schema::dropIfExists('finance_calendars');
    }
};


// INSERT INTO `finance_calendars` (`id`, `finance_yr`, `finance_yr_desc`, `start_date`, `end_date`, `is_open`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
// (1, '2024/2025', '2024/2025', '2024-07-01', '2025-06-30', 0, 1, 1, NULL, '2024-07-09 08:32:56', '2024-07-09 08:32:56'),
// (2, '2025/2026', '2025/2026', '2025-07-01', '2026-06-30', 0, 1, 1, NULL, '2024-07-09 08:33:24', '2024-07-09 08:33:24');
