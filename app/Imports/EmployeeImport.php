<?php

namespace App\Imports;

use App\Models\Employee;
use Maatwebsite\Excel\Concerns\ToModel;

class EmployeeImport implements ToModel
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        return new Employee([
            'employee_code' => $row[0],
            'fp_code' => $row[1],
            'name' => $row[2],
            'gender' => $row[3],
            'branch_id' => $row[4],
            'job_grade_id' => $row[5],
            'qualification_id' => $row[6],
            'qualification_year' => $row[7],
            'major' => $row[8],
            'graduation_estimate' => $row[9],
        ]);
    }
}