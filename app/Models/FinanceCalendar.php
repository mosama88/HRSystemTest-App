<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FinanceCalendar extends Model
{
    use HasFactory;

    protected $table = 'finance_calendars';

    protected $fillable = [
        'finance_yr',
        'finance_yr_desc',
        'start_date',
        'end_date',
        'is_open',
        'com_code',
        'created_by',
        'updated_by',
    ];

    public function FinanceClnCalendar()
    {
        return $this->belongsTo(FinanceClnPeriod::class);
    }

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }
}
