<?php

namespace App\Imports;

use App\Models\AttendanceDepartureActionExcel;
use App\Models\Employee;
use App\Models\AttendanceDepartureAction;
use App\Models\AdminPanelSetting;
use App\Models\MainSalaryEmployee;
use App\Models\ShiftsType;
use App\Models\AttendanceDeparture;
use Maatwebsite\Excel\Concerns\ToModel;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;


// طريقة العمل على البصمات
// ##########################
// 1- أول بصمة بالشهر
// 2- بصمات غير منضبطة من حيث النوع
// 3- البصمات التأكيدية المتكرره
// 4- له شفت ثابت
// 5- ليس له شفت ثابت
// 6- خصومات الانصراف المبكر
// 7- خصومات الحضور المتأخر
// 8- سياسة الوقت الأضافى
// 9- مشكلة الشفت الذلا يكون حضوره بتاريخ وانصرافة بتاريخ يوم جديد
// 10- تخزين البصمات الفعلية وعنوانتها مع كل يوم


class AttendanceDepartureImport implements ToCollection
{

    private $finance_cln_periods_data;

    public function __construct($finance_cln_periods_data)
    {
        $this->finance_cln_periods_data = $finance_cln_periods_data;
    }


    public function collection(Collection $rows)
    {
        $com_code = auth()->user()->com_code;
        $dataSetting = get_Columns_where_row(new AdminPanelSetting(), array("*"), array("com_code" => $com_code));

        foreach ($rows as $row) {

            // سيتم إهمال اى بصمة خارج نطاق فترة الشهر المالى
            $check_the_date = date("Y-m-d", strtotime($row[3]));
            if ($check_the_date < $this->finance_cln_periods_data['start_date_fp'] || $check_the_date > $this->finance_cln_periods_data['end_date_fp']) {
                continue;
            }




            if ($row[4] == 'C/In') {
                $action_type = 1;
            } else {
                $action_type = 2;
            }


            $employee_data =  get_Columns_where_row(new Employee(), array("employee_code", "has_fixed_shift", "shift_types_id", "daily_work_hour", "branch_id", "functional_status"), array("com_code" => $com_code, 'fp_code' => $row[2]));
            if (!empty($employee_data)) {

                $checkExistsBefore = get_Columns_where_row(new AttendanceDepartureActionExcel(), array("id"), array("com_code" => $com_code, "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "employee_code" => $employee_data['employee_code'], "date_time_action" => date("Y-m-d H:i:s", strtotime($row[3])), "action_type" =>  $action_type));
                $checkExistsBeforeSalary = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "employee_code" => $employee_data['employee_code']));
                if (!empty($checkExistsBeforeSalary)) {
                    $dataToInsert['main_salary_employees_id'] = $checkExistsBeforeSalary["id"];
                }
                if (empty($checkExistsBefore)) {
                    $dataToInsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                    $dataToInsert['employee_code'] = $employee_data['employee_code'];
                    $dataToInsert['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                    $dataToInsert['action_type'] =  $action_type;
                    $dataToInsert['created_by'] = auth()->user()->id;
                    $dataToInsert['com_code'] = $com_code;
                    $dataToInsert['created_at'] = date('Y-m-d H:i:s');


                    $AttendanceDepartureActionExcel_data = insert(new AttendanceDepartureActionExcel(), $dataToInsert, true);

                    // ########################################################################
                    // بشكل مؤقت هنفعل الالجوريزم هنا وثم هيتم فصلة فى عدة دوال  فى Trait

                    // التأكد من حالة شفت الموظف
                    if ($employee_data['has_fixed_shift'] == 'Yes') {
                        $shift_data = get_Columns_where_row(new ShiftsType(), array("from_time", "to_time", "total_hours"), array("com_code" => $com_code, "id" => $employee_data['shift_types_id']));
                        if (empty($shift_data)) {
                            continue;
                        } else {
                            $shift_hours = $shift_data['total_hours'];
                        }
                    } else {
                        if ($employee_data['daily_work_hour'] == 0 or $employee_data['daily_work_hour'] == NULL) {
                            continue;
                        } else {
                            $shift_hours = $employee_data['daily_work_hour'];
                        }
                    }
                    // ثانيآ: نشوف هل يوجد يوم فاضى مسجل بهذا التاريخ
                    $check_for_empty_recored = get_Columns_where_row(new AttendanceDeparture(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "the_day_date" => date("Y-m-d", strtotime($row[3])), "date_time_in" => Null));
                    if (!empty($check_for_empty_recored)) {
                        // لو البصمة الحالية حضور  نقوم بحذف البصمة الفاضية
                        if ($action_type == 1) {
                            destroy(new AttendanceDeparture(), array("id" => $check_for_empty_recored["id"]));
                        }
                    }

                    //ثالثآ هنجيب أخر سجل بصمة مسجل
                    // Check For Last Recored   أخر سجل بصمة مسجل فعلى وليس أرشيف
                    $last = AttendanceDeparture::select("*")
                        ->where("employee_code", "=", $employee_data['employee_code'])
                        ->where("finance_cln_periods_id", "=", $this->finance_cln_periods_data['id'])
                        ->where("com_code", "=", $com_code)
                        ->where("date_in", "!=", NULL)
                        ->where("date_in", "<=", date("Y-m-d", strtotime($row[3])))
                        ->orderBy("date_in", "DESC")
                        ->first();
                    if (!empty($last)) {
                        //سوف نرى فرق الدقائق بين البصمة المسجله و البصمة الحالية
                        $last_Attendance = $last['date_time_in'];
                        $seconds = strtotime($row[3]) - strtotime($last['date_time_in']);
                        $hourdiff = $seconds / 60 / 60;
                        $hourdiff = number_format((float)$hourdiff, 2, '.', '');
                        $minuitdiff = $seconds / 60;
                        $minuitdiff = number_format((float)$minuitdiff, 2, '.', '');
                        if ($hourdiff < 0) $hourdiff = $hourdiff * (-1);
                        if ($minuitdiff < 0) $minuitdiff = $minuitdiff * (-1);
                        // إذا كان تاريخ البصمة المسجله هو نفس تاريخ البصمة الحالية فى نفس اليوم
                        if ($last['date_in'] == date('Y-m-d', strtotime($row[3]))) {
                            // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
                            if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
                                //سوف نعمل على متغيرات أقفال البصمة الحالية

                                $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
                                $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
                                $dataUpdate['total_hours'] = $hourdiff;
                                if ($hourdiff < $shift_hours) {
                                    $dataUpdate['additional_hours'] = 0;
                                    $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
                                }
                                if ($hourdiff > $shift_hours) {
                                    $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
                                    $dataUpdate['absence_hours'] = 0;
                                }
                                // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
                                $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out
                                if ($employee_data['has_fixed_shift'] == 'Yes') {
                                    if ($shift_data['to_time'] > $timeEnter) {

                                        $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
                                        $minutesIfNow = $secondsNow / 60;
                                        $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
                                        // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
                                        if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
                                            $dataUpdate['early_departure'] = $minutesIfNow;
                                            $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
                                            $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
                                            $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
                                            if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
                                                $dataUpdate['cut'] = 1 + $counterCutOneDay;
                                            } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
                                                $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
                                            } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
                                                $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
                                            } else {
                                                // مؤقتآ
                                                // $dataUpdate['cut'] = 0;
                                            }
                                        }
                                    }
                                }
                                $dataUpdate['vacations_types_id'] = 0;
                                $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
                                if ($flagUpdateParent) {
                                    $dataInsertAction['attendance_departure_id'] =  $last['id'];
                                    $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                                    $dataInsertAction['employee_code'] = $employee_data['employee_code'];
                                    $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                    $dataInsertAction['action_type'] =  $action_type;
                                    $dataInsertAction['is_active_with_parent'] = 0;
                                    $dataInsertAction['added_method'] = 1;
                                    $dataInsertAction['is_make_action_on_employee'] = 0;
                                    $dataInsertAction['created_by'] = auth()->user()->id;
                                    $dataInsertAction['com_code'] = $com_code;
                                    $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
                                    $dataToUpdateAction['is_active_with_parent'] = 1;
                                    insert(new AttendanceDepartureAction(), $dataInsertAction);
                                    update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "action_type" => $action_type, "attendance_departure_id" => $last['id'], "date_time_action" => $dataUpdate['date_time_out']));
                                }
                            }
                        } else {
                            //بصمة الحضور والأنصراف للموظف فى تواريخ مختلفه
                            //هنا لو عدد ساعات فرق بين بصمة الحضور او الانصراف  أقل من او يساوى شفت الموظف
                            if ($hourdiff <= $shift_hours) {
                                //تقفيلة الشفت

                                // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
                                if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
                                    //سوف نعمل على متغيرات أقفال البصمة الحالية

                                    $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                    $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
                                    $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
                                    $dataUpdate['total_hours'] = $hourdiff;
                                    if ($hourdiff < $shift_hours) {
                                        $dataUpdate['additional_hours'] = 0;
                                        $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
                                    }
                                    if ($hourdiff > $shift_hours) {
                                        $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
                                        $dataUpdate['absence_hours'] = 0;
                                    }
                                    // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
                                    $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out

                                    if ($employee_data['has_fixed_shift'] == 'Yes') {
                                        if ($shift_data['to_time'] > $timeEnter) {
                                            $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
                                            $minutesIfNow = $secondsNow / 60;
                                            $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
                                            // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
                                            if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
                                                $dataUpdate['early_departure'] = $minutesIfNow;
                                                $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
                                                $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
                                                $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
                                                if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
                                                    $dataUpdate['cut'] = 1 + $counterCutOneDay;
                                                } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
                                                    $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
                                                } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
                                                    $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
                                                } else {
                                                    // مؤقتآ
                                                    // $dataUpdate['cut'] = 0;
                                                }
                                            }
                                        }
                                    }
                                    $dataUpdate['vacations_types_id'] = 0;
                                    $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
                                    if ($flagUpdateParent) {
                                        $dataInsertAction['attendance_departure_id'] =  $last['id'];
                                        $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                                        $dataInsertAction['employee_code'] = $employee_data['employee_code'];
                                        $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                        $dataInsertAction['action_type'] =  $action_type;
                                        $dataInsertAction['is_active_with_parent'] = 0;
                                        $dataInsertAction['added_method'] = 1;
                                        $dataInsertAction['is_make_action_on_employee'] = 0;
                                        $dataInsertAction['created_by'] = auth()->user()->id;
                                        $dataInsertAction['com_code'] = $com_code;
                                        $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
                                        $dataToUpdateAction['is_active_with_parent'] = 1;
                                        insert(new AttendanceDepartureAction(), $dataInsertAction);
                                        update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "action_type" => $action_type, "attendance_departure_id" => $last['id'], "date_time_action" => $dataUpdate['date_time_out']));
                                    }
                                }
                            } else {
                                // if $hourdiff greater than shift hours
                                //هنا نشوف الضبط العام والحد الاقصى  لاحتساب عدد ساعات الاضافى  والا سيكون حضور شفت جديد
                                if (($hourdiff - $shift_hours) <= $dataSetting['max_hours_take_fp_as_addtional']) {





                                    // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
                                    if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
                                        //سوف نعمل على متغيرات أقفال البصمة الحالية

                                        $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                        $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
                                        $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
                                        $dataUpdate['total_hours'] = $hourdiff;
                                        if ($hourdiff < $shift_hours) {
                                            $dataUpdate['additional_hours'] = 0;
                                            $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
                                        }
                                        if ($hourdiff > $shift_hours) {
                                            $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
                                            $dataUpdate['absence_hours'] = 0;
                                        }
                                        // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
                                        $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out

                                        if ($employee_data['has_fixed_shift'] == 'Yes') {

                                            if ($shift_data['to_time'] > $timeEnter) {
                                                $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
                                                $minutesIfNow = $secondsNow / 60;
                                                $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
                                                // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
                                                // هنا هذه الحالة لن تطبق
                                                if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
                                                    $dataUpdate['early_departure'] = $minutesIfNow;
                                                    $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
                                                    $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
                                                    $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
                                                    if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
                                                        $dataUpdate['cut'] = 1 + $counterCutOneDay;
                                                    } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
                                                        $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
                                                    } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
                                                        $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
                                                    } else {
                                                        // مؤقتآ
                                                        // $dataUpdate['cut'] = 0;
                                                    }
                                                }
                                            }
                                        }
                                        $dataUpdate['vacations_types_id'] = 0;
                                        $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
                                        if ($flagUpdateParent) {
                                            $dataInsertAction['attendance_departure_id'] =  $last['id'];
                                            $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                                            $dataInsertAction['employee_code'] = $employee_data['employee_code'];
                                            $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                            $dataInsertAction['action_type'] =  $action_type;
                                            $dataInsertAction['is_active_with_parent'] = 0;
                                            $dataInsertAction['added_method'] = 1;
                                            $dataInsertAction['is_make_action_on_employee'] = 0;
                                            $dataInsertAction['created_by'] = auth()->user()->id;
                                            $dataInsertAction['com_code'] = $com_code;
                                            $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
                                            $dataToUpdateAction['is_active_with_parent'] = 1;
                                            insert(new AttendanceDepartureAction(), $dataInsertAction);
                                            update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "action_type" => $action_type, "attendance_departure_id" => $last['id'], "date_time_action" => $dataUpdate['date_time_out']));
                                        }
                                    }
                                } else {
                                    //هنا سيتم تسكين شيفت جديد
                                    // تعتبر كأول بصمة للموظف خلال الشهر المالى المفتوح حاليآ
                                    // After Check Empty Last
                                    $datainsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                                    $datainsert['shift_hour_contract'] = $shift_hours;
                                    $datainsert['status_move'] = 1;
                                    $datainsert['employee_code'] = $employee_data['employee_code'];
                                    $datainsert['date_in'] =  date("Y-m-d", strtotime($row[3]));
                                    $datainsert['time_in'] =  date("H:i:s", strtotime($row[3]));
                                    $timeEnter =  $datainsert['time_in'];
                                    $datainsert['date_time_in'] =  date("Y-m-d H:i:s", strtotime($row[3]));
                                    $datainsert['created_by'] = auth()->user()->id;
                                    $datainsert['com_code'] = $com_code;

                                    // هنا نتأكد إذا كان الموظف  له شيفت ثابت  سنقوم بالتطبيق علية بعض متغيرات الضبط العام
                                    if ($employee_data['has_fixed_shift'] == 'Yes') {
                                        if ($shift_data['from_time'] < $timeEnter) {
                                            $secondsNow = strtotime($timeEnter) - strtotime($shift_data['from_time']);
                                            $minutesIfNow = $secondsNow / 60;
                                            $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');

                                            // نتاكد هل الموظف أجتاز عدد دقائق التأخير المسموح بها فى الضبط العام فى هذه الحالة نطبق علية متغيرات
                                            if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
                                                // Task
                                                $datainsert['attendance_delay'] = $minutesIfNow;
                                                $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
                                                $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
                                                $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
                                                if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
                                                    $datainsert['cut'] = 1;
                                                } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
                                                    $datainsert['cut'] = .5;
                                                } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
                                                    $datainsert['cut'] = .25;
                                                } else {
                                                    $datainsert['cut'] = 0;
                                                }
                                            }
                                        }
                                    }

                                    $datainsert['year_month'] =  $this->finance_cln_periods_data['year_and_month'];
                                    $datainsert['branch_id'] =  $employee_data['branch_id'];
                                    $datainsert['employee_status'] =  $employee_data['functional_status'];

                                    $main_salary_employees = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "is_archived" => 0));
                                    if (!empty($main_salary_employees)) {
                                        $datainsert['main_salary_employees_id'] =  $main_salary_employees['id'];
                                    }
                                    $datainsert['created_by'] = auth()->user()->id;
                                    $datainsert['com_code'] = $com_code;
                                    // سيتم تغييرة لاحقآ
                                    $datainsert['the_day_date'] = date("Y-m-d", strtotime($row[3]));
                                    $flagInsertParent = insert(new AttendanceDeparture(), $datainsert, true);
                                    if ($flagInsertParent) {
                                        // سيتم تسجيل البصمات الفعلية للموظف
                                        $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                                        $dataInsertAction['attendance_departure_id'] = $flagInsertParent['id'];
                                        $dataInsertAction['employee_code'] = $employee_data['employee_code'];
                                        $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                                        $dataInsertAction['action_type'] =  $action_type;
                                        $dataInsertAction['is_active_with_parent'] =  0;
                                        $dataInsertAction['added_method'] =  1;
                                        $dataInsertAction['is_make_action_on_employee'] =  0;
                                        $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
                                        $dataInsertAction['created_by'] = auth()->user()->id;
                                        $dataInsertAction['com_code'] = $com_code;
                                        insert(new AttendanceDepartureAction(), $dataInsertAction);
                                        $dataToUpdateAction['is_active_with_parent'] =  1;
                                        update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "action_type" => $action_type, "attendance_departure_id" => $flagInsertParent['id'], "date_time_action" => $datainsert['date_time_in']));
                                    }
                                }
                            }
                        }
                    } else {
                        // تعتبر كأول بصمة للموظف خلال الشهر المالى المفتوح حاليآ
                        // After Check Empty Last
                        $datainsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                        $datainsert['shift_hour_contract'] = $shift_hours;
                        $datainsert['status_move'] = 1;
                        $datainsert['employee_code'] = $employee_data['employee_code'];
                        $datainsert['date_in'] =  date("Y-m-d", strtotime($row[3]));
                        $datainsert['time_in'] =  date("H:i:s", strtotime($row[3]));
                        $timeEnter =  $datainsert['time_in'];
                        $datainsert['date_time_in'] =  date("Y-m-d H:i:s", strtotime($row[3]));
                        $datainsert['created_by'] = auth()->user()->id;
                        $datainsert['com_code'] = $com_code;

                        // هنا نتأكد إذا كان الموظف  له شيفت ثابت  سنقوم بالتطبيق علية بعض متغيرات الضبط العام
                        if ($employee_data['has_fixed_shift'] == 'Yes') {
                            if ($shift_data['from_time'] < $timeEnter) {
                                $secondsNow = strtotime($timeEnter) - strtotime($shift_data['from_time']);
                                $minutesIfNow = $secondsNow / 60;
                                $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');

                                // نتاكد هل الموظف أجتاز عدد دقائق التأخير المسموح بها فى الضبط العام فى هذه الحالة نطبق علية متغيرات
                                if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
                                    $datainsert['attendance_delay'] = $minutesIfNow;
                                    $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
                                    $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
                                    $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
                                    if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
                                        $datainsert['cut'] = 1;
                                    } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
                                        $datainsert['cut'] = .5;
                                    } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
                                        $datainsert['cut'] = .25;
                                    } else {
                                        $datainsert['cut'] = 0;
                                    }
                                }
                            }
                        }

                        $datainsert['year_month'] =  $this->finance_cln_periods_data['year_and_month'];
                        $datainsert['branch_id'] =  $employee_data['branch_id'];
                        $datainsert['employee_status'] =  $employee_data['functional_status'];

                        $main_salary_employees = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "is_archived" => 0));
                        if (!empty($main_salary_employees)) {
                            $datainsert['main_salary_employees_id'] =  $main_salary_employees['id'];
                        }
                        $datainsert['created_by'] = auth()->user()->id;
                        $datainsert['com_code'] = $com_code;
                        // سيتم تغييرة لاحقآ
                        $datainsert['the_day_date'] = date("Y-m-d", strtotime($row[3]));
                        $flagInsertParent = insert(new AttendanceDeparture(), $datainsert, true);
                        if ($flagInsertParent) {
                            // سيتم تسجيل البصمات الفعلية للموظف
                            $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
                            $dataInsertAction['attendance_departure_id'] = $flagInsertParent['id'];
                            $dataInsertAction['employee_code'] = $employee_data['employee_code'];
                            $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
                            $dataInsertAction['action_type'] =  $action_type;
                            $dataInsertAction['is_active_with_parent'] =  0;
                            $dataInsertAction['added_method'] =  1;
                            $dataInsertAction['is_make_action_on_employee'] =  0;
                            $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
                            $dataInsertAction['created_by'] = auth()->user()->id;
                            $dataInsertAction['com_code'] = $com_code;
                            insert(new AttendanceDepartureAction(), $dataInsertAction);
                            $dataToUpdateAction['is_active_with_parent'] =  1;
                            update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "action_type" => $action_type, "attendance_departure_id" => $flagInsertParent['id'], "date_time_action" => $datainsert['date_time_in']));
                        }
                    }
                }
            }
        }
    }
}






























// <?php

// namespace App\Imports;

// use App\Models\AttendanceDepartureActionExcel;
// use App\Models\Employee;
// use App\Models\AttendanceDepartureAction;
// use App\Models\AdminPanelSetting;
// use App\Models\MainSalaryEmployee;
// use App\Models\ShiftsType;
// use App\Models\AttendanceDeparture;
// use Maatwebsite\Excel\Concerns\ToModel;
// use Illuminate\Support\Collection;
// use Maatwebsite\Excel\Concerns\ToCollection;


// // طريقة العمل على البصمات
// // ##########################
// // 1- أول بصمة بالشهر
// // 2- بصمات غير منضبطة من حيث النوع
// // 3- البصمات التأكيدية المتكرره
// // 4- له شفت ثابت
// // 5- ليس له شفت ثابت
// // 6- خصومات الانصراف المبكر
// // 7- خصومات الحضور المتأخر
// // 8- سياسة الوقت الأضافى
// // 9- مشكلة الشفت الذلا يكون حضوره بتاريخ وانصرافة بتاريخ يوم جديد
// // 10- تخزين البصمات الفعلية وعنوانتها مع كل يوم


// class AttendanceDepartureImport implements ToCollection
// {

//     private $finance_cln_periods_data;

//     public function __construct($finance_cln_periods_data)
//     {
//         $this->finance_cln_periods_data = $finance_cln_periods_data;
//     }


//     public function collection(Collection $rows)
//     {
//         $com_code = auth()->user()->com_code;
//         $dataSetting = get_Columns_where_row(new AdminPanelSetting(), array("*"), array("com_code" => $com_code));

//         foreach ($rows as $row) {

//             // سيتم إهمال اى بصمة خارج نطاق فترة الشهر المالى
//             $check_the_date = date("Y-m-d", strtotime($row[3]));
//             if ($check_the_date < $this->finance_cln_periods_data['start_date_fp'] || $check_the_date > $this->finance_cln_periods_data['end_date_fp']) {
//                 continue;
//             }




//             if ($row[4] == 'C/In') {
//                 $action_type = 1;
//             } else {
//                 $action_type = 2;
//             }


//             $employee_data =  get_Columns_where_row(new Employee(), array("employee_code", "has_fixed_shift", "shift_types_id", "daily_work_hour", "branch_id", "functional_status"), array("com_code" => $com_code, 'fp_code' => $row[2]));
//             if (!empty($employee_data)) {

//                 $checkExistsBefore = get_Columns_where_row(new AttendanceDepartureActionExcel(), array("id"), array("com_code" => $com_code, "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "employee_code" => $employee_data['employee_code'], "date_time_action" => date("Y-m-d H:i:s", strtotime($row[3])), "action_type" =>  $action_type));
//                 $checkExistsBeforeSalary = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "employee_code" => $employee_data['employee_code']));
//                 if (!empty($checkExistsBeforeSalary)) {
//                     $dataToInsert['main_salary_employees_id'] = $checkExistsBeforeSalary["id"];
//                 }
//                 if (empty($checkExistsBefore)) {
//                     $dataToInsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                     $dataToInsert['employee_code'] = $employee_data['employee_code'];
//                     $dataToInsert['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                     $dataToInsert['action_type'] =  $action_type;
//                     $dataToInsert['created_by'] = auth()->user()->id;
//                     $dataToInsert['com_code'] = $com_code;
//                     $dataToInsert['created_at'] = date('Y-m-d H:i:s');


//                     $AttendanceDepartureActionExcel_data = insert(new AttendanceDepartureActionExcel(), $dataToInsert, true);

//                     // ########################################################################
//                     // بشكل مؤقت هنفعل الالجوريزم هنا وثم هيتم فصلة فى عدة دوال  فى Trait

//                     // التأكد من حالة شفت الموظف
//                     if ($employee_data['has_fixed_shift'] == 'Yes') {
//                         $shift_data = get_Columns_where_row(new ShiftsType(), array("from_time", "to_time", "total_hours"), array("com_code" => $com_code, "id" => $employee_data['shift_types_id']));
//                         if (empty($shift_data)) {
//                             continue;
//                         } else {
//                             $shift_hours = $shift_data['total_hours'];
//                         }
//                     } else {
//                         if ($employee_data['daily_work_hour'] == 0 or $employee_data['daily_work_hour'] == NULL) {
//                             continue;
//                         } else {
//                             $shift_hours = $employee_data['daily_work_hour'];
//                         }
//                     }
//                     // ثانيآ: نشوف هل يوجد يوم فاضى مسجل بهذا التاريخ
//                     $check_for_empty_recored = get_Columns_where_row(new AttendanceDeparture(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "finance_cln_periods_id" => $this->finance_cln_periods_data['id'], "the_day_date" => date("Y-m-d", strtotime($row[3])), "date_time_in" => Null));
//                     if (!empty($check_for_empty_recored)) {
//                         // لو البصمة الحالية حضور  نقوم بحذف البصمة الفاضية
//                         if ($action_type == 1) {
//                             destroy(new AttendanceDeparture(), array("id" => $check_for_empty_recored["id"]));
//                         }
//                     }

//                     //ثالثآ هنجيب أخر سجل بصمة مسجل
//                     // Check For Last Recored   أخر سجل بصمة مسجل فعلى وليس أرشيف
//                     $last = AttendanceDeparture::select("*")
//                         ->where("employee_code", "=", $employee_data['employee_code'])
//                         ->where("finance_cln_periods_id", "=", $this->finance_cln_periods_data['id'])
//                         ->where("com_code", "=", $com_code)
//                         ->where("date_in", "!=", NULL)
//                         ->where("date_in", "<=", date("Y-m-d", strtotime($row[3])))
//                         ->orderBy("date_in", "DESC")
//                         ->first();
//                     if (!empty($last)) {
//                         //سوف نرى فرق الدقائق بين البصمة المسجله و البصمة الحالية
//                         $last_Attendance = $last['date_time_in'];
//                         $seconds = strtotime($row[3]) - strtotime($last['date_time_in']);
//                         $hourdiff = $seconds / 60 / 60;
//                         $hourdiff = number_format((float)$hourdiff, 2, '.', '');
//                         $minuitdiff = $seconds / 60;
//                         $minuitdiff = number_format((float)$minuitdiff, 2, '.', '');
//                         if ($hourdiff < 0) $hourdiff = $hourdiff * (-1);
//                         if ($minuitdiff < 0) $minuitdiff = $minuitdiff * (-1);
//                         // إذا كان تاريخ البصمة المسجله هو نفس تاريخ البصمة الحالية فى نفس اليوم
//                         if ($last['date_in'] == date('Y-m-d', strtotime($row[3]))) {
//                             // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
//                             if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
//                                 //سوف نعمل على متغيرات أقفال البصمة الحالية

//                                 $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                 $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
//                                 $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
//                                 $dataUpdate['total_hours'] = $hourdiff;
//                                 if ($hourdiff < $shift_hours) {
//                                     $dataUpdate['additional_hours'] = 0;
//                                     $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
//                                 }
//                                 if ($hourdiff > $shift_hours) {
//                                     $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
//                                     $dataUpdate['absence_hours'] = 0;
//                                 }
//                                 // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
//                                 $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out
//                                 if ($employee_data['has_fixed_shift'] == 'Yes') {
//                                     if ($shift_data['to_time'] > $timeEnter) {

//                                         $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
//                                         $minutesIfNow = $secondsNow / 60;
//                                         $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
//                                         // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
//                                         if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
//                                             $dataUpdate['early_departure'] = $minutesIfNow;
//                                             $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
//                                             $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
//                                             $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
//                                             if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
//                                                 $dataUpdate['cut'] = 1 + $counterCutOneDay;
//                                             } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
//                                                 $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
//                                             } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
//                                                 $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
//                                             } else {
//                                                 // مؤقتآ
//                                                 // $dataUpdate['cut'] = 0;
//                                             }
//                                         }
//                                     }
//                                 }
//                                 $dataUpdate['vacations_types_id'] = 0;
//                                 $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
//                                 if ($flagUpdateParent) {
//                                     $dataInsertAction['attendance_departure_id'] =  $last['id'];
//                                     $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                                     $dataInsertAction['employee_code'] = $employee_data['employee_code'];
//                                     $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                     $dataInsertAction['action_type'] =  $action_type;
//                                     $dataInsertAction['is_active_with_parent'] = 1;
//                                     $dataInsertAction['added_method'] = 1;
//                                     $dataInsertAction['is_make_action_on_employee'] = 0;
//                                     $dataInsertAction['created_by'] = auth()->user()->id;
//                                     $dataInsertAction['com_code'] = $com_code;
//                                     $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
//                                     $dataToUpdateAction['is_active_with_parent'] = 0;
//                                     update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "is_active_with_parent" => 1, "action_type" => $action_type, "attendance_departure_id" => $last['id']));
//                                     insert(new AttendanceDepartureAction(), $dataInsertAction);
//                                 }
//                             }
//                         } else {
//                             //بصمة الحضور والأنصراف للموظف فى تواريخ مختلفه
//                             //هنا لو عدد ساعات فرق بين بصمة الحضور او الانصراف  أقل من او يساوى شفت الموظف
//                             if ($hourdiff <= $shift_hours) {
//                                 //تقفيلة الشفت

//                                 // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
//                                 if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
//                                     //سوف نعمل على متغيرات أقفال البصمة الحالية

//                                     $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                     $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
//                                     $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
//                                     $dataUpdate['total_hours'] = $hourdiff;
//                                     if ($hourdiff < $shift_hours) {
//                                         $dataUpdate['additional_hours'] = 0;
//                                         $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
//                                     }
//                                     if ($hourdiff > $shift_hours) {
//                                         $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
//                                         $dataUpdate['absence_hours'] = 0;
//                                     }
//                                     // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
//                                     $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out

//                                     if ($employee_data['has_fixed_shift'] == 'Yes') {
//                                         if ($shift_data['to_time'] > $timeEnter) {
//                                             $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
//                                             $minutesIfNow = $secondsNow / 60;
//                                             $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
//                                             // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
//                                             if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
//                                                 $dataUpdate['early_departure'] = $minutesIfNow;
//                                                 $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
//                                                 $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
//                                                 $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
//                                                 if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
//                                                     $dataUpdate['cut'] = 1 + $counterCutOneDay;
//                                                 } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
//                                                     $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
//                                                 } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
//                                                     $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
//                                                 } else {
//                                                     // مؤقتآ
//                                                     // $dataUpdate['cut'] = 0;
//                                                 }
//                                             }
//                                         }
//                                     }
//                                     $dataUpdate['vacations_types_id'] = 0;
//                                     $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
//                                     if ($flagUpdateParent) {
//                                         $dataInsertAction['attendance_departure_id'] =  $last['id'];
//                                         $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                                         $dataInsertAction['employee_code'] = $employee_data['employee_code'];
//                                         $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                         $dataInsertAction['action_type'] =  $action_type;
//                                         $dataInsertAction['is_active_with_parent'] = 1;
//                                         $dataInsertAction['added_method'] = 1;
//                                         $dataInsertAction['is_make_action_on_employee'] = 0;
//                                         $dataInsertAction['created_by'] = auth()->user()->id;
//                                         $dataInsertAction['com_code'] = $com_code;
//                                         $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
//                                         $dataToUpdateAction['is_active_with_parent'] = 0;
//                                         update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "is_active_with_parent" => 1, "action_type" => $action_type, "attendance_departure_id" => $last['id']));
//                                         insert(new AttendanceDepartureAction(), $dataInsertAction);
//                                     }
//                                 }
//                             } else {
//                                 // if $hourdiff greater than shift hours
//                                 //هنا نشوف الضبط العام والحد الاقصى  لاحتساب عدد ساعات الاضافى  والا سيكون حضور شفت جديد
//                                 if (($hourdiff - $shift_hours) <= $dataSetting['max_hours_take_fp_as_addtional']) {





//                                     // سوف نرى هل البصمة ديه تأكيدية ام بصمة فعلية للحضور والأنصراف
//                                     if ($minuitdiff >  $dataSetting['less_than_minute_neglecting_fp']) {
//                                         //سوف نعمل على متغيرات أقفال البصمة الحالية

//                                         $dataUpdate['date_time_out'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                         $dataUpdate['date_out'] = date("Y-m-d", strtotime($row[3]));
//                                         $dataUpdate['time_out'] = date("H:i:s", strtotime($row[3]));
//                                         $dataUpdate['total_hours'] = $hourdiff;
//                                         if ($hourdiff < $shift_hours) {
//                                             $dataUpdate['additional_hours'] = 0;
//                                             $dataUpdate['absence_hours'] = $shift_hours - $hourdiff;
//                                         }
//                                         if ($hourdiff > $shift_hours) {
//                                             $dataUpdate['additional_hours'] = $hourdiff - $shift_hours;
//                                             $dataUpdate['absence_hours'] = 0;
//                                         }
//                                         // إذا كان الموظف له شفت ثابت نشوف موضوع الانصراف المبكر والجزاء علية
//                                         $timeEnter =  date("Y-m-d H:i:s", strtotime($row[3]));    //meaning time out

//                                         if ($employee_data['has_fixed_shift'] == 'Yes') {

//                                             if ($shift_data['to_time'] > $timeEnter) {
//                                                 $secondsNow =  strtotime($shift_data['to_time']) - strtotime($timeEnter);
//                                                 $minutesIfNow = $secondsNow / 60;
//                                                 $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');
//                                                 // نشوف هلى الموظف أجتاز عدد دقائق الانصراف المبكر المسموح بها فى الضبط العام يبقى ينزل علية متغيرات
//                                                 // هنا هذه الحالة لن تطبق
//                                                 if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
//                                                     $dataUpdate['early_departure'] = $minutesIfNow;
//                                                     $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
//                                                     $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
//                                                     $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
//                                                     if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
//                                                         $dataUpdate['cut'] = 1 + $counterCutOneDay;
//                                                     } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
//                                                         $dataUpdate['cut'] = .5 + ($counterCutHalfDay * .5);
//                                                     } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
//                                                         $dataUpdate['cut'] = .25 + ($counterCutQuarterDay * .25);
//                                                     } else {
//                                                         // مؤقتآ
//                                                         // $dataUpdate['cut'] = 0;
//                                                     }
//                                                 }
//                                             }
//                                         }
//                                         $dataUpdate['vacations_types_id'] = 0;
//                                         $flagUpdateParent = update(new AttendanceDeparture(), $dataUpdate, array("id" => $last['id'], "com_code" => $com_code));
//                                         if ($flagUpdateParent) {
//                                             $dataInsertAction['attendance_departure_id'] =  $last['id'];
//                                             $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                                             $dataInsertAction['employee_code'] = $employee_data['employee_code'];
//                                             $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                             $dataInsertAction['action_type'] =  $action_type;
//                                             $dataInsertAction['is_active_with_parent'] = 1;
//                                             $dataInsertAction['added_method'] = 1;
//                                             $dataInsertAction['is_make_action_on_employee'] = 0;
//                                             $dataInsertAction['created_by'] = auth()->user()->id;
//                                             $dataInsertAction['com_code'] = $com_code;
//                                             $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
//                                             $dataToUpdateAction['is_active_with_parent'] = 0;
//                                             update(new AttendanceDepartureAction(), $dataToUpdateAction, array("com_code" => $com_code, "is_active_with_parent" => 1, "action_type" => $action_type, "attendance_departure_id" => $last['id']));
//                                             insert(new AttendanceDepartureAction(), $dataInsertAction);
//                                         }
//                                     }
//                                 } else {
//                                     //هنا سيتم تسكين شيفت جديد
//                                     // تعتبر كأول بصمة للموظف خلال الشهر المالى المفتوح حاليآ
//                                     // After Check Empty Last
//                                     $datainsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                                     $datainsert['shift_hour_contract'] = $shift_hours;
//                                     $datainsert['status_move'] = 1;
//                                     $datainsert['employee_code'] = $employee_data['employee_code'];
//                                     $datainsert['date_in'] =  date("Y-m-d", strtotime($row[3]));
//                                     $datainsert['time_in'] =  date("H:i:s", strtotime($row[3]));
//                                     $timeEnter =  $datainsert['time_in'];
//                                     $datainsert['date_time_in'] =  date("Y-m-d H:i:s", strtotime($row[3]));
//                                     $datainsert['created_by'] = auth()->user()->id;
//                                     $datainsert['com_code'] = $com_code;

//                                     // هنا نتأكد إذا كان الموظف  له شيفت ثابت  سنقوم بالتطبيق علية بعض متغيرات الضبط العام
//                                     if ($employee_data['has_fixed_shift'] == 'Yes') {
//                                         if ($shift_data['from_time'] < $timeEnter) {
//                                             $secondsNow = strtotime($timeEnter) - strtotime($shift_data['from_time']);
//                                             $minutesIfNow = $secondsNow / 60;
//                                             $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');

//                                             // نتاكد هل الموظف أجتاز عدد دقائق التأخير المسموح بها فى الضبط العام فى هذه الحالة نطبق علية متغيرات
//                                             if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
//                                                 $datainsert['attendance_delay'] = $minutesIfNow;
//                                                 $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
//                                                 $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
//                                                 $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
//                                                 if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
//                                                     $datainsert['cut'] = 1;
//                                                 } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
//                                                     $datainsert['cut'] = .5;
//                                                 } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
//                                                     $datainsert['cut'] = .25;
//                                                 } else {
//                                                     $datainsert['cut'] = 0;
//                                                 }
//                                             }
//                                         }
//                                     }

//                                     $datainsert['year_month'] =  $this->finance_cln_periods_data['year_and_month'];
//                                     $datainsert['branch_id'] =  $employee_data['branch_id'];
//                                     $datainsert['employee_status'] =  $employee_data['functional_status'];

//                                     $main_salary_employees = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "is_archived" => 0));
//                                     if (!empty($main_salary_employees)) {
//                                         $datainsert['main_salary_employees_id'] =  $main_salary_employees['id'];
//                                     }
//                                     $datainsert['created_by'] = auth()->user()->id;
//                                     $datainsert['com_code'] = $com_code;
//                                     // سيتم تغييرة لاحقآ
//                                     $datainsert['the_day_date'] = date("Y-m-d", strtotime($row[3]));
//                                     $flagInsertParent = insert(new AttendanceDeparture(), $datainsert, true);
//                                     if ($flagInsertParent) {
//                                         // سيتم تسجيل البصمات الفعلية للموظف
//                                         $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                                         $dataInsertAction['attendance_departure_id'] = $flagInsertParent['id'];
//                                         $dataInsertAction['employee_code'] = $employee_data['employee_code'];
//                                         $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                                         $dataInsertAction['action_type'] =  $action_type;
//                                         $dataInsertAction['is_active_with_parent'] =  1;
//                                         $dataInsertAction['added_method'] =  1;
//                                         $dataInsertAction['is_make_action_on_employee'] =  0;
//                                         $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
//                                         $dataInsertAction['created_by'] = auth()->user()->id;
//                                         $dataInsertAction['com_code'] = $com_code;
//                                         insert(new AttendanceDepartureAction(), $dataInsertAction);
//                                     }
//                                 }
//                             }
//                         }
//                     } else {
//                         // تعتبر كأول بصمة للموظف خلال الشهر المالى المفتوح حاليآ
//                         // After Check Empty Last
//                         $datainsert['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                         $datainsert['shift_hour_contract'] = $shift_hours;
//                         $datainsert['status_move'] = 1;
//                         $datainsert['employee_code'] = $employee_data['employee_code'];
//                         $datainsert['date_in'] =  date("Y-m-d", strtotime($row[3]));
//                         $datainsert['time_in'] =  date("H:i:s", strtotime($row[3]));
//                         $timeEnter =  $datainsert['time_in'];
//                         $datainsert['date_time_in'] =  date("Y-m-d H:i:s", strtotime($row[3]));
//                         $datainsert['created_by'] = auth()->user()->id;
//                         $datainsert['com_code'] = $com_code;

//                         // هنا نتأكد إذا كان الموظف  له شيفت ثابت  سنقوم بالتطبيق علية بعض متغيرات الضبط العام
//                         if ($employee_data['has_fixed_shift'] == 'Yes') {
//                             if ($shift_data['from_time'] < $timeEnter) {
//                                 $secondsNow = strtotime($timeEnter) - strtotime($shift_data['from_time']);
//                                 $minutesIfNow = $secondsNow / 60;
//                                 $minutesIfNow = number_format((float) $minutesIfNow, 2, '.', '');

//                                 // نتاكد هل الموظف أجتاز عدد دقائق التأخير المسموح بها فى الضبط العام فى هذه الحالة نطبق علية متغيرات
//                                 if ($minutesIfNow >= $dataSetting['after_minute_calculate_delay']) {
//                                     $datainsert['attendance_delay'] = $minutesIfNow;
//                                     $counterCutQuarterDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .25));
//                                     $counterCutHalfDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => .5));
//                                     $counterCutOneDay = get_count_where(new AttendanceDeparture(), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], 'finance_cln_periods_id' => $this->finance_cln_periods_data['id'], 'cut' => 1));
//                                     if (($counterCutOneDay) >= $dataSetting['after_time_allday_daycut']) {
//                                         $datainsert['cut'] = 1;
//                                     } elseif (($counterCutHalfDay) >= $dataSetting['after_time_half_daycut']) {
//                                         $datainsert['cut'] = .5;
//                                     } elseif (($counterCutQuarterDay) >= $dataSetting['after_minute_quarterday']) {
//                                         $datainsert['cut'] = .25;
//                                     } else {
//                                         $datainsert['cut'] = 0;
//                                     }
//                                 }
//                             }
//                         }

//                         $datainsert['year_month'] =  $this->finance_cln_periods_data['year_and_month'];
//                         $datainsert['branch_id'] =  $employee_data['branch_id'];
//                         $datainsert['employee_status'] =  $employee_data['functional_status'];

//                         $main_salary_employees = get_Columns_where_row(new MainSalaryEmployee(), array("id"), array("com_code" => $com_code, "employee_code" => $employee_data['employee_code'], "is_archived" => 0));
//                         if (!empty($main_salary_employees)) {
//                             $datainsert['main_salary_employees_id'] =  $main_salary_employees['id'];
//                         }
//                         $datainsert['created_by'] = auth()->user()->id;
//                         $datainsert['com_code'] = $com_code;
//                         // سيتم تغييرة لاحقآ
//                         $datainsert['the_day_date'] = date("Y-m-d", strtotime($row[3]));
//                         $flagInsertParent = insert(new AttendanceDeparture(), $datainsert, true);
//                         if ($flagInsertParent) {
//                             // سيتم تسجيل البصمات الفعلية للموظف
//                             $dataInsertAction['finance_cln_periods_id'] = $this->finance_cln_periods_data['id'];
//                             $dataInsertAction['attendance_departure_id'] = $flagInsertParent['id'];
//                             $dataInsertAction['employee_code'] = $employee_data['employee_code'];
//                             $dataInsertAction['date_time_action'] = date("Y-m-d H:i:s", strtotime($row[3]));
//                             $dataInsertAction['action_type'] =  $action_type;
//                             $dataInsertAction['is_active_with_parent'] =  1;
//                             $dataInsertAction['added_method'] =  1;
//                             $dataInsertAction['is_make_action_on_employee'] =  0;
//                             $dataInsertAction['attendance_departure_action_excel_id'] = $AttendanceDepartureActionExcel_data['id'];
//                             $dataInsertAction['created_by'] = auth()->user()->id;
//                             $dataInsertAction['com_code'] = $com_code;
//                             insert(new AttendanceDepartureAction(), $dataInsertAction);
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
