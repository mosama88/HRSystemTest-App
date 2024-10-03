<?php

namespace App\Traits;

use App\Models\Employee;
use App\Models\FinanceClnPeriod;
use App\Models\EmployeeSalaryLoan;
use App\Models\MainSalaryEmployee;
use App\Models\EmployeeSalaryRewards;
use App\Models\EmployeeSalaryDiscount;
use App\Models\EmployeeSalaryAllowance;
use App\Models\EmployeeSalarySanctions;
use App\Models\EmployeeSalaryAbsenceDay;
use App\Models\EmployeeSalaryAdditional;
use App\Models\PermanentLoansInstallment;
use App\Models\EmployeeFixedAllowance;
use App\Models\EmployeeSalaryPermanentLoans;

trait GeneralTrait
{

    function recalculateMainSalaryEmployee($mainSalaryEmployee_id)
    {

        $com_code = auth()->user()->com_code;
        $mainSalaryEmployeeData = get_Columns_where_row(new MainSalaryEmployee(), array("*"), array("com_code" => $com_code, "id" => $mainSalaryEmployee_id, "is_archived" => 0));
        if (!empty($mainSalaryEmployeeData)) {
            $employee_data = get_Columns_where_row(new Employee(), array("motivation", "social_insurance_cut_monthely", "medical_insurance_cut_monthely", "salary", "day_price", "id"), array("com_code" => $com_code, "employee_code" => $mainSalaryEmployeeData['employee_code']));
            $finance_cln_periods_data = get_Columns_where_row(new FinanceClnPeriod(), array("year_and_month"), array("com_code" => $com_code, "is_open" => 1, "id" => $mainSalaryEmployeeData['finance_cln_periods_id']));
            if (!empty($employee_data) and !empty($finance_cln_periods_data)) {
                // أولا المستحق للموظف الأستحقاقات
                $dataToUpdate['day_price'] = $employee_data['day_price'];
                $dataToUpdate['salary_employee'] = $employee_data['salary'];
                $dataToUpdate['motivation'] = $employee_data['motivation'];
                $dataToUpdate['fixed_allowances'] = get_sum_where(new EmployeeFixedAllowance(), array("value"), array("com_code" => $com_code, "employee_id" => $employee_data['id']));
                // البدلات المتغيرة
                $dataToUpdate['changeable_allowance'] = get_sum_where(new EmployeeSalaryAllowance(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                // المكافئات المالية
                $dataToUpdate['total_rewards_salary'] = get_sum_where(new EmployeeSalaryRewards(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                // أضافى الأيام
                $dataToUpdate['additional_days_counter'] = get_sum_where(new EmployeeSalaryAdditional(), array("value"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                $dataToUpdate['additional_days_total'] = get_sum_where(new EmployeeSalaryAdditional(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));


                $dataToUpdate['total_benefits'] = $dataToUpdate['salary_employee'] + $dataToUpdate['motivation'] + $dataToUpdate['fixed_allowances']
                    + $dataToUpdate['changeable_allowance'] + $dataToUpdate['total_rewards_salary'] + $dataToUpdate['additional_days_total'];

                // ثانيآ المستحق على الموظف الأستقاطاعات
                $dataToUpdate['medical_insurance_monthly'] = $employee_data['medical_insurance_cut_monthely'];
                $dataToUpdate['medical_social_monthly'] = $employee_data['social_insurance_cut_monthely'];
                // الجزاءات
                $dataToUpdate['sanctions_days_counter'] = get_sum_where(new EmployeeSalarySanctions(), array("value"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                $dataToUpdate['sanctions_days_total'] = get_sum_where(new EmployeeSalarySanctions(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                // الغياب
                $dataToUpdate['absence_days_counter'] = get_sum_where(new EmployeeSalaryAbsenceDay(), array("value"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                $dataToUpdate['absence_days_total'] = get_sum_where(new EmployeeSalaryAbsenceDay(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                // الخصومات
                $dataToUpdate['discount'] = get_sum_where(new EmployeeSalaryDiscount(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));
                //  السلف الشهرية
                $dataToUpdate['monthly_loan'] = get_sum_where(new EmployeeSalaryLoan(), array("total"), array("com_code" => $com_code, "main_salary_employees_id" => $mainSalaryEmployee_id));

                // السلف المستديمة
                $dataToUpdate['permanent_loan'] = PermanentLoansInstallment::where("com_code", "=", $com_code)
                    ->where("year_month", "=", $finance_cln_periods_data['year_and_month'])
                    ->where("is_archived", "=", 0)
                    ->where("employee_code", "=", $mainSalaryEmployeeData['employee_code'])
                    ->where("status", "!=", 2)
                    ->where("has_parent_disbursed_done", "=", 1)
                    ->sum("month_installment_value");

                // تحديث حالة القسط وربطه بالسجل الأساسي للرواتب
                $dataToUpdateInstallment = [
                    'status' => 1,
                    'main_salary_employees_id' => $mainSalaryEmployee_id
                ];

                PermanentLoansInstallment::where("com_code", "=", $com_code)
                    ->where("year_month", "=", $finance_cln_periods_data['year_and_month'])
                    ->where("is_archived", "=", 0)
                    ->where("employee_code", "=", $mainSalaryEmployeeData['employee_code'])
                    ->where("status", "!=", 2)
                    ->update($dataToUpdateInstallment);

                // استرجاع القسط المستديم
                $installment = PermanentLoansInstallment::where("com_code", "=", $com_code)
                    ->where("year_month", "=", $finance_cln_periods_data['year_and_month'])
                    ->where("is_archived", "=", 0)
                    ->where("employee_code", "=", $mainSalaryEmployeeData['employee_code'])
                    ->where("status", "!=", 2)
                    ->first();

                if ($installment) {
                    // التحقق مما إذا كانت جميع الأقساط مدفوعة
                    $remainingInstallments = PermanentLoansInstallment::where('com_code', $com_code)
                        ->where('employee_permanent_loans_id', $installment->employee_permanent_loans_id)
                        ->where('status', 0)
                        ->count();

                    if ($remainingInstallments == 0) {
                        // إذا تم دفع جميع الأقساط، يتم أرشفة القرض
                        $dataToUpdateLoanStatus = [
                            'is_archived' => 1
                        ];
                        EmployeeSalaryPermanentLoans::where('com_code', $com_code)
                            ->where('id', $installment->employee_permanent_loans_id)
                            ->update($dataToUpdateLoanStatus);
                    }

                    // التحقق من الأقساط غير المدفوعة قبل القسط الحالي
                    $counterBeforeNotPaid = PermanentLoansInstallment::where('com_code', $com_code)
                        ->where('employee_permanent_loans_id', $installment->employee_permanent_loans_id)
                        ->where('status', 0)
                        ->where('id', '<', $installment->id)
                        ->count();

                    if ($counterBeforeNotPaid == 0) {
                        // تحديث القسط الحالي إلى مدفوع نقدًا
                        $dataToUpdateInstallmentPayCash = [
                            'status' => 2,  // الدفع كاش
                            'archived_by' => auth()->user()->id,
                            'is_archived' => 1,
                            'archived_at' => now(),
                            'updated_by' => auth()->user()->id
                        ];

                        PermanentLoansInstallment::where('com_code', $com_code)
                            ->where('id', $installment->id)
                            ->where('is_archived', 0)
                            ->where('status', 0)
                            ->update($dataToUpdateInstallmentPayCash);

                        // حساب قيمة الأقساط المتبقية بعد تحديث القسط
                        $dataParentLoan = EmployeeSalaryPermanentLoans::where('com_code', $com_code)
                            ->where('id', $installment->employee_permanent_loans_id)
                            ->first();

                        if ($dataParentLoan) {
                            $installmentPaid = $dataParentLoan->installment_paid + $installment->month_installment_value;
                            $installmentRemain = $dataParentLoan->total - $installmentPaid;

                            // تحديث الحقول installment_remain و installment_paid في جدول القروض
                            EmployeeSalaryPermanentLoans::where('com_code', $com_code)
                                ->where('id', $installment->employee_permanent_loans_id)
                                ->update([
                                    'installment_remain' => $installmentRemain,
                                    'installment_paid' => $installmentPaid
                                ]);
                        }
                    }
                }
                // ################################################################################


                $dataToUpdate['total_deductions'] = $dataToUpdate['medical_insurance_monthly'] + $dataToUpdate['medical_social_monthly']
                    + $dataToUpdate['sanctions_days_total'] + $dataToUpdate['absence_days_total'] + $dataToUpdate['discount'] +
                    $dataToUpdate['monthly_loan'] + $dataToUpdate['permanent_loan'];


                $dataToUpdate['net_salary'] = $mainSalaryEmployeeData['last_salary_remain_balance'] + ($dataToUpdate['total_benefits'] - $dataToUpdate['total_deductions']);
                update(new MainSalaryEmployee, $dataToUpdate, array("com_code" => $com_code, "id" => $mainSalaryEmployee_id, "is_archived" => 0));
            }
        }
    }
}
