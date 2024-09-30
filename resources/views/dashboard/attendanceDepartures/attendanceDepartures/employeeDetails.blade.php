<style>
    .table-hover tbody tr:hover {
        background-color: #3d7fc5;
        /* لون primary */
        color: white;
        /* لون النص عند hover */
    }
</style>
<!-- Scroll modal -->
<div class="modal EmployeeDetails" id="modaldemo8">
    <div class="modal-dialog modal-dialog-centered modal-fullscreen" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تفاصيل الموظف</h6><button aria-label="Close" class="close" data-dismiss="modal"
                    type="button"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">


                <table id="example1" class="table table-bordered table-striped table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>كود بصمة الموظف</th>
                            <th>كود الموظف</th>
                            <th>أسم الموظف</th>
                            <th>الفرع</th>
                            <th>الأدارة</th>
                            <th>تاريخ التعيين</th>
                            <th>الوظيفة</th>
                            <th>هل له شفت ثابت</th>
                            <th>توقيت الشفت</th>
                            <th>عدد ساعات العمل اليومي</th>
                            <th>رصيد الأجازات</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>{{ $employee_data['fp_code'] }}</td>
                            <td>{{ $employee_data['employee_code'] }}</td>
                            <td>{{ $employee_data['name'] }}</td>
                            <td>{{ $employee_data->branch->name }}</td>
                            <td>{{ $employee_data->department->name }}</td>
                            <td>{{ $employee_data['work_start_date'] }}</td>
                            <td>{{ $employee_data->jobCategories->name }}</td>
                            <td>
                                @if ($employee_data['has_fixed_shift'] == 'Yes')
                                    نعم
                                @else
                                    لا
                                @endif
                            </td>
                            <td>


                                @if ($employee_data->shiftTypes->type == 1)
                                    صباحى
                                @elseif ($employee_data->shiftTypes->type == 2)
                                    مسائى
                                @elseif($employee_data->shiftTypes->type == 3)
                                    يوم كامل
                                @else
                                    لا يوجد له شفت ثابت
                                @endif

                                @php
                                    // تحويل from_time و to_time إلى كائنات Carbon
                                    $fromTime = \Carbon\Carbon::parse($employee_data->shiftTypes->from_time);
                                    $toTime = \Carbon\Carbon::parse($employee_data->shiftTypes->to_time);

                                    // تنسيق الوقت بنظام 12 ساعة مع AM/PM
                                    $formattedFromTime = $fromTime->format('g:i A'); // تنسيق 12 ساعة
                                    $formattedToTime = $toTime->format('g:i A');

                                    // تحويل AM/PM إلى النص العربي (صباحًا/مساءً)
                                    $formattedFromTimeArabic = $fromTime->format('A') == 'AM' ? 'صباحًا' : 'مساءً';
                                    $formattedToTimeArabic = $toTime->format('A') == 'AM' ? 'صباحًا' : 'مساءً';
                                @endphp

                                <!-- عرض التوقيت بنظام 12 ساعة مع النص العربي -->
                                {{ $fromTime->format('g:i') }}
                                {{ $formattedFromTimeArabic }} إلى
                                {{ $toTime->format('g:i') }}
                                {{ $formattedToTimeArabic }} عدد ساعات العمل
                                {{ $employee_data->shiftTypes->total_hours }} ساعة

                            </td>
                            <td>{{ $employee_data['daily_work_hour'] }}</td>
                            <td>{{ $employee_data['num_vacation_days'] }}</td>
                        </tr>
                    </tbody>
                </table>
                <div class="modal-footer">
                    <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                </div>










            </div>
        </div>
    </div>
</div>
<!--End Scroll modal -->
