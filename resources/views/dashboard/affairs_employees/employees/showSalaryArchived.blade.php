@if (@isset($data) && !@empty($data))
    <table class="table table-bordered table-striped">
        <thead class="thead-light">
            <tr>
                <th>قيمة الراتب</th>
                <th>تاريخ الأرشفه</th>
                <th>الأضافة بواسطة</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($data as $info)
                <tr>
                    <td class="back">{{ $info->value * 1 }}</td>

                        <td class="back">
                            @php
                                $dt = new DateTime($info->created_at);
                                $date = $dt->format('Y-m-d');
                                $time = $dt->format('h:i');
                                $newDateTime = date('a', strtotime($info->created_at)); // 'a' returns 'am' or 'pm' in lowercase
                                $newDateTimeType = $newDateTime == 'am' ? 'صباحآ' : 'مساءآ';  // Correct comparison with lowercase 'am' and 'pm'
                            @endphp
                            {{ $date }}
                            {{ $time }}
                            {{ $newDateTimeType }}
                    </td>

                    <td class="back">{{ $info->createdByAdmin->name }}</td>
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
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
    </div>
@endif




{{-- 
strtotime($info->created_at):

هذه الدالة تأخذ التاريخ والوقت الموجود في المتغير $info->created_at وتقوم بتحويله إلى طابع زمني (timestamp) باستخدام strtotime().
created_at غالبًا ما يكون بتنسيق تاريخ ووقت مثل "2024-09-07 15:30:00"، ويتم تحويله إلى قيمة رقمية تمثل الوقت بالأجزاء الزمنية الدقيقة.
date('a', ...):

دالة date() تستخدم لتنسيق التاريخ أو الوقت بناءً على طابع زمني (timestamp).
حرف 'a' في هذه الحالة يستخدم لتحديد ما إذا كان الوقت في الصباح (AM) أو المساء (PM).
يعرض 'am' إذا كان الوقت صباحًا.
يعرض 'pm' إذا كان الوقت مساءً.
المحصلة:

السطر يقوم بإرجاع إما 'am' أو 'pm' بناءً على الوقت الموجود في حقل created_at. --}}
