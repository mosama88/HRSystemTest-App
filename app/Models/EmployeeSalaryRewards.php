<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmployeeSalaryRewards extends Model
{
    use HasFactory;

    protected $table = 'employee_salary_rewards';

    protected $guarded = [];

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }

    public function mainSalaryEmployees()
    {
        return $this->belongsTo(MainSalaryEmployee::class, 'main_salary_employees_id');
    }

    public function financeClnPeriods()
    {
        return $this->belongsTo(FinanceClnPeriod::class, 'finance_cln_periods_id');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_code');
    }

    public function AdditionalType()
    {
        return $this->belongsTo(AdditionalType::class, 'additional_types_id');
    }
}
