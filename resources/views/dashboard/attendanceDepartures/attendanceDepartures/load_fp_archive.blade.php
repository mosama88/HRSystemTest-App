<style>
    .table-hover tbody tr:hover {
        background-color: #3d7fc5;
        /* لون primary */
        color: white;
        /* لون النص عند hover */
    }
</style>
@if(isset($AttendanceDepartureActionExcel) && $AttendanceDepartureActionExcel->isNotEmpty())
    <table id="example1" class="table table-bordered table-striped table-hover">
        <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>التاريخ</th>
                <th>التوقيت</th>
                <th>نوع البصمة</th>
                <th>سحب البصمة بواسطة</th>
            </tr>
        </thead>
        <tbody>
            <?php $i = 0; ?>
            @foreach ($AttendanceDepartureActionExcel as $info)
                <?php $i++; ?>
                <tr>
                    <td>{{ $i }}</td>
                    <td>
                        @php
                            $dt = new DateTime($info->date_time_action);
                            $date = $dt->format('Y-m-d');
                            $time = $dt->format('h:i');
                            $day = $dt->format('l'); // للحصول على اليوم باللغة الإنجليزية (مثل Sunday)
                            $newDateTime = date('a', strtotime($info->date_time_action)); // 'a' returns 'am' or 'pm' in lowercase
                            $newDateTimeType = $newDateTime == 'am' ? 'صباحاً' : 'مساءاً'; // Correct comparison with lowercase 'am' and 'pm'
                        @endphp
                        {{ $info->week_day_name_ar }} {{ $date }}
                    </td>
                    <td>
                        {{ $time }}
                        {{ $newDateTimeType }}
                    </td>
                    <td>
                        @if ($info->action_type == 1)
                            حضور
                        @else
                            إنصراف
                        @endif
                    </td>
                    <td>
                        @php
                            $dt2 = new DateTime($info['created_at']);
                            $date2 = $dt2->format('Y-m-d');
                            $time2 = $dt2->format('h:i');
                            $newDateTime2 = date('a', strtotime($info['created_at'])); // 'a' returns 'am' or 'pm' in lowercase
                            $newDateTimeType2 = $newDateTime2 == 'AM' ? 'صباحآ' : 'مساءآ'; // Correct comparison with lowercase 'am' and 'pm'
                        @endphp
                        {{ $info->createdByAdmin->name }} ( {{ $date2 }} ) ( {{ $time2 }} )
                        ({{ $newDateTimeType2 }})
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    <div class="modal-footer">
        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
    </div>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif
