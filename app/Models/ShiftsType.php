<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShiftsType extends Model
{
    use HasFactory;

    protected $table = "shifts_types";

    protected $fillable = [
        'type',
        'from_time',
        'to_time',
        'total_hours',
        'created_by',
        'updated_by',
        'com_code',

    ];

    public function createdBy()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }


    public function updatedBy()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }


}











