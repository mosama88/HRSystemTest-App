<?php

namespace App\Models;

use App\Models\Country;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Governorate extends Model
{
    use HasFactory;
    protected $table = "governorates";

    protected $fillable = [
        'name',
        'country_id',
        'active',
        'com_code',
        'created_by',
        'updated_by',
    ];


    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }



    public function country()
    {
        return $this->belongsTo(Country::class, 'country_id');
    }
}
