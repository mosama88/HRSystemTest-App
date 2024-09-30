@if (isset($parent) && !empty($parent))
    @if ($parent['is_archived'] == 0)
        @can('إعادة ضبط بصمات الموظفين')
            <div class="row">
                {{-- بصمة الحضور المفعلة --}}
                <div class="col-md-4">
                    <div class="form-group text-right">
                        <label>بصمة الحضور المفعلة</label> <i class="fas fa-user-clock"></i>
                        {{-- Reset date_time_in --}}
                        <button class="btn btn-sm btn-danger float-left btn-small" id="zeroResetdate_time_in">
                            <i class="fas fa-window-restore"></i> Reset</button>
                        {{-- Undo date_time_in --}}
                        <button class="btn btn-sm d-none btn-primary float-left btn-small ml-1"
                            data-old="{{ $parent['date_time_in'] }}" id="undozero_date_time_in">
                            <i class="fas fa-trash-restore-alt"></i> Undo</button>
                        {{-- date_time_in --}}
                        <input autofocus type="datetime-local" data-old="{{ $parent['date_time_in'] }}"
                            id="date_time_in_update" class="form-control" value="{{ $parent['date_time_in'] }}">
                    </div>
                </div>


                {{-- بصمة الإنصراف المفعلة --}}
                <div class="col-md-4">
                    <div class="form-group text-right">
                        <label>بصمة الإنصراف المفعلة</label> <i class="fas fa-user-lock"></i>
                        {{-- Reset date_time_out --}}
                        <button class="btn btn-sm btn-danger float-left btn-small" id="zeroResetdate_time_out">
                            <i class="fas fa-window-restore"></i> Reset</button>
                        {{-- Undo date_time_out --}}
                        <button class="btn d-none btn-sm btn-primary float-left btn-small ml-1"
                            data-old="{{ $parent['date_time_out'] }}" id="undozero_date_time_out">
                            <i class="fas fa-trash-restore-alt"></i> Undo</button>
                        {{-- date_time_out --}}
                        <input autofocus type="datetime-local" data-old="{{ $parent['date_time_out'] }}"
                            id="date_time_out_update" class="form-control" value="{{ $parent['date_time_out'] }}">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group mt-4">
                        <button class="btn btn-md btn-success float-left" type="submit" data-id="{{ $parent['id'] }}"
                            id="redo_update">
                            <i class="fas fa-user-edit"></i> تحديث</button>
                    </div>
                </div>
            </div>
        @endcan

        @if ($parent['is_updated_active_action'] == 1)
            <div class="text-center my-2">
                <strong>
                    تم التعديل على البصمات بواسطة:
                    <span class="text-danger">{{ $parent->isUpdatedActiveActionBy->name }}</span>
                    @php
                        $dt = new DateTime($parent['is_updated_active_action_date']);
                        $date = $dt->format('Y-m-d');
                        $time = $dt->format('h:i');
                        $newDateTime = date('a', strtotime($parent['is_updated_active_action_date'])); // 'a' returns 'am' or 'pm' in lowercase
                        $newDateTimeType = $newDateTime == 'AM' ? 'صباحآ' : 'مساءآ'; // Correct comparison with lowercase 'am' and 'pm'
                    @endphp
                    <span class="text-danger">
                        ( {{ $date }} )
                        ( {{ $time }} )
                        ( {{ $newDateTimeType }} )
                    </span>
                </strong>
            </div>
        @endif
    @endif
    @if (isset($AttendanceDepartureAction) && $AttendanceDepartureAction->isNotEmpty())
        <table id="example1" class="table table-bordered table-striped table-hover">
            <thead class="thead-light">
                <tr>
                    <th>نوع البصمة</th>
                    <th>التاريخ</th>
                    <th>التوقيت</th>
                    <th>هل البصمة مفعلة</th>
                    <th>طريقة الأضافة</th>
                    <th>سحب البصمة بواسطة</th>
                </tr>
            </thead>
            <tbody>
                <?php $i = 0; ?>
                @foreach ($AttendanceDepartureAction as $info)
                    <tr>
                        <td>
                            @if ($info->action_type == 1)
                                حضور
                            @elseif ($info->action_type == 2)
                                إنصراف
                            @endif

                        </td>
                        <td>
                            @php
                                // تحويل التاريخ والتوقيت من السجل
                                $dt = new DateTime($info->date_time_action);
                                $date = $dt->format('Y-m-d'); // تنسيق التاريخ
                                $time = $dt->format('h:i'); // تنسيق الوقت 12 ساعة
                                $newDateTime = $dt->format('a'); // للحصول على am أو pm
                                $newDateTimeType = $newDateTime == 'am' ? 'صباحاً' : 'مساءاً'; // التحقق من am أو pm

                                // الحصول على اسم اليوم
                                $day = $dt->format('l');
                            @endphp
                            {{ $info->week_day_name_ar }} {{ $date }} {{-- اليوم والتاريخ --}}
                        </td>
                        <td>
                            {{ $time }}
                            {{ $newDateTimeType }}
                        </td>
                        <td>
                            @if ($info->is_active_with_parent == 1)
                                نعم
                                @php
                                    $dateTimeAction = new DateTime($info->date_time_action);
                                    $dateTimeIn = new DateTime($parent['date_time_in']);
                                    $dateTimeOut = new DateTime($parent['date_time_out']);
                                @endphp

                                @if ($dateTimeAction->format('Y-m-d H:i') == $dateTimeIn->format('Y-m-d H:i'))
                                    (أخذت كحضور)
                                @elseif ($dateTimeAction->format('Y-m-d H:i') == $dateTimeOut->format('Y-m-d H:i'))
                                    ( أخذت كإنصراف )
                                @endif
                            @else
                                لا
                            @endif
                        </td>

                        <td>
                            @if ($info->added_method == 1)
                                آلى
                            @else
                                يدوى
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
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif
