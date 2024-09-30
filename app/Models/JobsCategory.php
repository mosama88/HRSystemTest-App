<?php

namespace App\Models;

use App\Models\Admin;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class JobsCategory extends Model
{
    use HasFactory;

    protected $table = "jobs_categories";

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
