<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphOne;

class Employee extends Model
{
    use HasFactory;

    protected $table = 'employees';

    protected $guarded = [];

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }

    public function image(): MorphOne
    {
        return $this->morphOne(Image::class, 'imageable');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id');
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
}
