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
        Schema::create('admin_panel_settings', function (Blueprint $table) {
            $table->id();
            $table->string('company_name', 250);
            $table->tinyInteger('system_status')->default('1')->comment('واحد مفعل - صفر معطل');
            $table->string('image', 250)->nullable();
            $table->string('photo_cover', 250)->nullable();
            $table->string('phons', 250);
            $table->string('address', 250);
            $table->string('email', 100);
            $table->decimal('max_hours_take_fp_as_addtional', 10, 2)->default(4)->comment('الحد الأقصى لاحتساب عدد ساعات عمل اضافية عند انصراف الموظف واحتسا بصمة الانصراف و الاستحتسب على انها بصمة حضور شفت جديد ');
            $table->integer('less_than_minute_neglecting_fp')->default(3)->comment('أقل من كام دقيقة يتم إهمال البصمة التالية التأكدية للموظف خلال نفس الشيفت');
            $table->decimal('after_minute_calculate_delay', 10, 2)->default(0)->comment('بعد كام دقيقة نحسب تاخير حضور');
            $table->decimal('after_minute_calculate_early_departure', 10, 2)->default(0)->comment('بعد كام دقيقة نحسب انصراف مبكر');
            $table->decimal('after_minute_quarterday', 10, 2)->default(0)->comment('بعد كام مره تأخير او إنصراف مبكر نخصم ربع يوم');
            $table->decimal('after_time_half_daycut', 10, 2)->default(0)->comment('بعد كام مرة تأخير او انصراف مبكر نخصم نص يوم');
            $table->decimal('after_time_allday_daycut', 10, 2)->default(0)->comment('نخصم بعد كام مره تاخير او انصراف مبكر يوم كامل');
            $table->decimal('monthly_vacation_balance', 10, 2)->default(0)->comment('رصيد اجازات الموظف الشهري');
            $table->decimal('after_days_begin_vacation', 10, 2)->default(0)->comment('بعد كام يوم ينزل للموظف رصيد اجازات');
            $table->decimal('first_balance_begin_vacation', 10, 2)->default(0)->comment('الرصيد الاول المرحل عند تفعيل الاجازات للموظف مثل نزول 10 ايام ونص بعد 6 شهور للموظف');
            $table->decimal('sanctions_value_first_absence', 10, 2)->default(0)->comment('قيمة خصم الايام بعد اول مرة غياب بدون اذن	');
            $table->decimal('sanctions_value_second_absence', 10, 2)->default(0)->comment('قيمة خصم الايام بعد ثاني مرة غياب بدون اذن');
            $table->decimal('sanctions_value_thaird_absence', 10, 2)->default(0)->comment('قيمة خصم الايام بعد ثالث مرة غياب بدون اذن');
            $table->decimal('sanctions_value_forth_absence', 10, 2)->default(0)->comment('قيمة خصم الايام بعد رابع مرة غياب بدون اذن');
            $table->integer('created_by');
            $table->integer('updated_by')->nullable();
            $table->integer('com_code');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admin_panel_settings');
    }
};
