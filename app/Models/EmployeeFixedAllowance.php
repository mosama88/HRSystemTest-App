<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmployeeFixedAllowance extends Model
{
    use HasFactory;
    protected $table = "employee_fixed_allowances";

    protected $fillable = [
        'employee_id',
        'allowance_id',
        'value',
        'notes',
        'created_by',
        'updated_by',
        'com_code',
    ];

    
    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }

    public function allowance()
    {
        return $this->belongsTo(Allowance::class, 'allowance_id');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }
}