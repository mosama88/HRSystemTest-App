    @if (@isset($data) && !@empty($data))
        <table class="table text-md-nowrap" id="example2">
            <thead>
                <tr>
                    <th>#</th>
                    <th>نوع الشفت</th>
                    <th>بداية الوقت</th>
                    <th>نهاية الوقت</th>
                    <th>عدد الساعات</th>
                    <th>حالة التفعيل</th>
                    <th>أضافة بواسطة</th>
                    <th>تحديث بواسطة</th>
                    <th>العمليات</th>
                </tr>
            </thead>
            <tbody>
                <?php $i = 0; ?>
                @foreach ($data as $info)
                    <?php $i++; ?>

                    <tr>
                        <td>{{ $i }}</td>
                        <td>
                            @if ($info->type == 1)
                                صباحى
                            @elseif ($info->type == 2)
                                مسائى
                            @else
                                يوم كامل
                            @endif
                        </td>
                        <td>
                            {{ \Carbon\Carbon::parse($info->from_time)->format('g:i') }}
                            {{ \Carbon\Carbon::parse($info->from_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                        </td>
                        <td>
                            {{ \Carbon\Carbon::parse($info->to_time)->format('g:i') }}
                            {{ \Carbon\Carbon::parse($info->to_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                        </td>
                        </td>
                        @php
                            $to_time = Carbon::parse($info['to_time']);
                            $from_time = Carbon::parse($info['from_time']);
                            $diff_in_minutes = $to_time->diffInMinutes($from_time);
                            $hours = floor($diff_in_minutes / 60);
                            $minutes = $diff_in_minutes % 60;
                        @endphp
                        <td>{{ $hours }} ساعة و {{ $minutes }} دقيقة</td>
                        <td>
                            @if ($info->active == 0)
                                <span class="label text-danger d-flex">
                                    <div class="dot-label bg-danger ml-1"></div>{{ __('معطل') }}
                                </span>
                            @else
                                <span class="label text-success d-flex">
                                    <div class="dot-label bg-success ml-1"></div>{{ __('مفعل') }}
                                </span>
                            @endif
                        </td>
                        <td>{{ $info->createdBy->username }}</td>
                        <td>
                            @if ($info->updated_by > 0)
                                {{ $info->updatedby->name }}
                            @else
                                <span class="text">لا يوجد</span>
                            @endif
                        </td>
                        <td>

                            {{-- Edit --}}
                            <a class="modal-effect btn btn-outline-info btn-sm"
                                data-effect="effect-scale" data-toggle="modal"
                                href="#edit{{ $info->id }}"><i
                                    class="fas fa-edit ml-1"></i>تعديل</a>

                            {{-- Delete --}}
                            <a class="modal-effect btn btn-outline-danger btn-sm"
                                data-effect="effect-scale" data-toggle="modal"
                                href="#delete{{ $info->id }}">
                                <i class="fas fa-trash-alt ml-1"></i>حذف</a>

                        </td>
                        @include('dashboard.settings.shiftsTypes.edit')
                        @include('dashboard.settings.shiftsTypes.delete')
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <p class="bg-danger text-center"> عفوا لاتوجد بيانات لعرضها</p>
    @endif

