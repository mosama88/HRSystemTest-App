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
        Schema::create('attendance_departures', function (Blueprint $table) {
            $table->id();
            $table->foreignId("finance_cln_periods_id")->comment('كود الشهر المالى');
            $table->bigInteger('employee_code')->comment('كود الموظف');
            $table->decimal('shift_hour_contract', 10, 2)->nullable()->comment('عدد ساعات العمل اليومى المتعاقد عليها فى تلك الوقت');
            $table->tinyInteger('status_move')->nullable()->comment('(1-Check in حضور)(2-Check out انصراف)');
            $table->date('the_day_date')->comment('تاريخ اليوم الفعلى من المفترض يكون فى سحب  بصمة و النظام من الممكن ان يضع له قيمه حتى اذا لم يتم وضع بصمه له');
            $table->date('date_in')->nullable();
            $table->date('date_out')->nullable();
            $table->time('time_in')->nullable();
            $table->time('time_out')->nullable();
            $table->string('variables', 250)->comment('المتغيرات')->nullable();
            $table->decimal('attendance_delay', 10, 2)->default(0)->comment('قيمة عدد دقائق  الحضور المتأخر ان وجد')->nullable();
            $table->decimal('early_departure', 20, 2)->default(0)->comment('قيمة عدد الانصراف المبكر ان وجد')->nullable();
            $table->string('permission_hours', 250)->comment('تفاصيل الإذن إن وجد')->nullable();
            $table->decimal('total_hours', 10, 2)->default(0)->nullable()->comment('عدد ساعات العمل بين الحضور والأنصراف');
            $table->decimal('absence_hours', 10, 2)->default(0)->nullable()->comment('عدد ساعات الغياب بهذا اليوم');
            $table->decimal('additional_hours', 10, 2)->default(0)->nullable()->comment('عدد ساعات الأضافى بهذا اليوم');
            $table->dateTime('date_time_in')->comment('توقيت البصمه الحضور')->nullable();
            $table->dateTime('date_time_out')->comment('توقيت البصمه الأنصراف')->nullable();
            $table->tinyInteger('is_make_action_on_employee')->default(0)->comment('هل تم أخذ إجراء على الموظف')->nullable();
            $table->tinyInteger('is_archived')->nullable()->default(0)->comment('حالة الأرشفه');
            $table->dateTime('archived_date')->nullable();
            $table->foreignId('archived_by')->nullable()->references('id')->on('admins')->onUpdate('cascade');
            $table->tinyInteger('is_updated_active_action')->nullable()->default(0)->comment('هل تم التعديل على البصمات الفعلية');
            $table->dateTime('is_updated_active_action_date')->nullable()->comment('تاريخ التعديل على البصمات الفعلية');
            $table->foreignId('is_updated_active_action_by')->nullable()->references('id')->on('admins')->onUpdate('cascade')->comment('من قام بآخر تعديل على البصمات الفعلية');
            $table->integer('vacations_types_id')->nullable()->comment('لو اجازه سيكون كود الأجازه');
            $table->integer('occasions_id')->nullable()->comment('اجازات رسمية فى حالة نوع الأجازه رسمى');
            $table->tinyInteger('cut')->default(0)->nullable()->comment('nothing == 0 | quarter Day = 25| half day = 5| one day = 1');
            $table->string('year_month', 30)->comment('الشهر المالى للبصمة')->nullable();
            $table->enum('employee_status', ["Employee", "Unemployed"])->nullable()->default('Employee')->comment('حالة الموظف لحظة البصمة'); //Functional Status
            $table->foreignId("branch_id")->comment("كود الفرع لحظة البصمة ")->references("id")->on("branches")->onUpdate("cascade");
            $table->foreignId('main_salary_employees_id')->nullable()->comment('كود الراتب بالشهر المالى ان وجد')->nullable();
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
        Schema::dropIfExists('attendance_departures');
    }
};
