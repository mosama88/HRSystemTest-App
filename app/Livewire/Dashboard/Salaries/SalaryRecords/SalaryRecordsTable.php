<?php

namespace App\Livewire\Dashboard\Salaries\SalaryRecords;

use Livewire\Component;
use Livewire\WithPagination;
use App\Models\FinanceCalendar;
use App\Models\FinanceClnPeriod;

class SalaryRecordsTable extends Component
{


use WithPagination;

    public function render()
    {

        $com_code = auth()->user()->com_code;

        $data = FinanceClnPeriod::select("*")->where("com_code", $com_code)
            ->orderBy("finance_yr", "DESC")
            ->orderBy("start_date_m", "ASC")->paginate(12);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->currentYear = get_Columns_where_row(new FinanceCalendar(), array("is_open"), array("com_code" => $com_code, "finance_yr" => $info->finance_yr));
                $info->counterOpenMonth = get_count_where(new FinanceClnPeriod(), array("com_code" => $com_code, "is_open" => 1));
                $info->counterPreviousWatingOpen = FinanceClnPeriod::where("com_code", "=", $com_code)
                    ->where("finance_yr", "=", $info->finance_yr)
                    ->where("month_id", "<", $info->month_id)
                    ->where("is_open", "=", 0)->count();
            }
        }


        return view('dashboard.salaries.SalaryRecords.salary-records-table',compact('data'));
    }
}
