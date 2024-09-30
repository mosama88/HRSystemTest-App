<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdditionalType extends Model
{
    use HasFactory;

    protected $table = "additional_types";

    protected $fillable = [
        'name',
        'active',
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
}
