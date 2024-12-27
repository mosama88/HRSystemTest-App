<?php

namespace App\Exports;

use App\Models\MainSalaryEmployee;
use Maatwebsite\Excel\Concerns\FromCollection;

class MainSalaryEmployeeExport implements FromCollection
{
    private $finance_cln_periods_id;

    public function __construct($finance_cln_periods_id)
    {
        $this->finance_cln_periods_id = $finance_cln_periods_id;
    }

    public function collection()
    {
        return MainSalaryEmployee::where('finance_cln_periods_id', $this->finance_cln_periods_id)->get();
    }

    // public function collection()
    // {
    //     return MainSalaryEmployee::where('finance_cln_period_id', $this->finance_cln_periods_id)->get([
    //         'employee_code',
    //         'fp_code',
    //         'name',
    //         'gender',
    //         'branch_id',
    //         'job_grade_id',
    //         'qualification_id',
    //         'qualification_year',
    //         'major',
    //         'graduation_estimate',
    //         'brith_date',
    //     ]);
    // }

    // public function headings(): array
    // {
    //     return [
    //         'Employee Code', // كود الموظف
    //         'FP Code',       // كود البصمة
    //         'Name',          // الاسم
    //         'Gender',        // الجنس
    //         'Branch',        // الفرع
    //         'Job Grade',     // الدرجة الوظيفية
    //         'Qualification', // المؤهل
    //         'Qualification Year', // سنة المؤهل
    //         'Major',         // التخصص
    //         'Graduation Estimate', // تقدير التخرج
    //         'Birth Date',    // تاريخ الميلاد
    //     ];
    // }

}
