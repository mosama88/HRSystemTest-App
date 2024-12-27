<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MainEmployeesVacationBalance extends Model
{
    use HasFactory;

    protected $table = 'main_employees_vacation_balances';

    protected $guarded = [];

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_code');
    }
}
