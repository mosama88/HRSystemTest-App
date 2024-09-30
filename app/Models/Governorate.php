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
        'country_id'
    ];


    public function country()
    {
        return $this->belongsTo(Country::class, 'country_id');
    }
}
