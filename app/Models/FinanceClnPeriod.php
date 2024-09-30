<?php

namespace App\Models;

use App\Models\Month;
use App\Models\FinanceCalendar;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class FinanceClnPeriod extends Model
{
    use HasFactory;

    protected $table = "finance_cln_periods";

    protected $fillable = [
        'finance_calendars_id',
        'number_of_days',
        'year_and_month',
        'finance_yr',
        'month_id',
        'start_date_m',
        'end_date_m',
        'is_open',
        'start_date_fb',
        'end_date_fb',
        'created_by',
        'updated_by',
        'com_code',
    ];


    public function FinanceCalendar()
    {
        return $this->belongsTo(FinanceCalendar::class, 'finance_calendars_id');
    }

    public function createdByAdmin()
    {
        return $this->belongsTo(Admin::class, 'created_by');
    }

    public function updatedByAdmin()
    {
        return $this->belongsTo(Admin::class, 'updated_by');
    }
    
    public function month()
    {
        return $this->belongsTo(Month::class, 'month_id');
    }
}
