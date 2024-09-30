<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\EmployeeSalaryPermanentLoans;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PermanentLoansInstallment extends Model
{
    use HasFactory;

    protected $table = "permanent_loans_installments";

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

    public function employeeSalaryPermanentLoans()
    {
        return $this->belongsTo(EmployeeSalaryPermanentLoans::class, 'employee_permanent_loans_id');
    }
}
