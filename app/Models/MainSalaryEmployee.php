<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphOne;

class MainSalaryEmployee extends Model
{
    use HasFactory;

    protected $table = 'main_salary_employees';

    protected $guarded = [];

    public function image(): MorphOne
    {
        return $this->morphOne(Image::class, 'imageable');
    }

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    // في نموذج MainSalaryEmployee
    public function department()
    {
        return $this->belongsTo(Department::class, 'employee_department_code');
    }

    public function FinanceClnPeriod()
    {
        return $this->belongsTo(FinanceClnPeriod::class, 'finance_cln_periods_id');
    }

    public function job()
    {
        return $this->belongsTo(JobsCategory::class, 'employee_jobs_id');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_code');
    }
}
