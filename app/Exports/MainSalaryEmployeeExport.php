<?php

namespace App\Exports;

use App\Models\MainSalaryEmployee;
use Maatwebsite\Excel\Concerns\FromCollection;

class MainSalaryEmployeeExport implements FromCollection
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return MainSalaryEmployee::all();
    }
}