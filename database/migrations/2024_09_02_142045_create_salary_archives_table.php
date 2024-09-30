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
        Schema::create('salary_archives', function (Blueprint $table) {
            $table->id();
            $table->foreignId("employee_id")->nullable()->references("id")->on("employees")->onDelete("cascade")->onUpdate("cascade");
            $table->decimal('value', 10, 2)->nullable()->comment('قيمة الراتب قبل التغيير');
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
        Schema::dropIfExists('salary_archives');
    }
};
