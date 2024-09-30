<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AttendanceDeparture extends Model
{
    use HasFactory;
    protected $table = "attendance_departures";

    protected $guarded = [];



    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }


    public function isUpdatedActiveActionBy()
    {
        return $this->belongsTo(Admin::class, 'is_updated_active_action_by');
    }



    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }


    public function jobCategories()
    {
        return $this->belongsTo(JobsCategory::class, 'job_categories_id');
    }

    public function qualification()
    {
        return $this->belongsTo(Qualification::class);
    }


    public function country()
    {
        return $this->belongsTo(Country::class);
    }

    public function governorate()
    {
        return $this->belongsTo(Governorate::class);
    }

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    public function bloodTypes()
    {
        return $this->belongsTo(BloodType::class, 'blood_types_id');
    }

    public function nationality()
    {
        return $this->belongsTo(Nationality::class);
    }

    public function shiftTypes()
    {
        return $this->belongsTo(ShiftsType::class, 'shift_types_id');
    }


    public function resignation()
    {
        return $this->belongsTo(Resignation::class);
    }


    public function language()
    {
        return $this->belongsTo(Language::class, 'language_id');
    }

    public function jobGrade()
    {
        return $this->belongsTo(JobGrade::class, 'job_grade_id');
    }

    public function VacationType()
    {
        return $this->belongsTo(VacationType::class, 'vacations_types_id');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_code');
    }
}
