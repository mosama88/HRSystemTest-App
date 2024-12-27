<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AttendanceDepartureActionExcel extends Model
{
    use HasFactory;

    protected $table = 'attendance_departure_action_excels';

    protected $guarded = [];

    public $timestamps = false;

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
