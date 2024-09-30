@if (@isset($dataParent) and !@empty($dataParent))
    @if (@isset($dataParent['installmentDetails']) and !@empty($dataParent['installmentDetails']))
        @if ($dataParent['has_disbursed_done'] == 1)
            <div class="container">
                <div class="row">
                    <div class="col-12">


                        <div class="table-responsive mt-3">
                            <table class="table table-bordered ">
                                <thead class="thead-light">
                                    <tr>
                                        <th class="text-center">فتح الصرف بواسطة </th>
                                        <th class="text-center">تاريخ فتح الصرف</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="text-center">{{ $dataParent->disbursedBy->name }}</td>
                                        <td class="text-center">
                                            @php
                                                $dt = new DateTime($dataParent->disbursed_at);
                                                $date = $dt->format('Y-m-d');
                                                $time = $dt->format('h:i');
                                                $newDateTime = date('a', strtotime($dataParent->disbursed_at)); // 'a' returns 'am' or 'pm' in lowercase
                                                $newDateTimeType = $newDateTime == 'AM' ? 'صباحآ' : 'مساءآ'; // Correct comparison with lowercase 'am' and 'pm'
                                            @endphp
                                            ( {{ $date }} )
                                            ( {{ $dataParent->created_at->format('h:i') }} )
                                            ( {{ $newDateTimeType }} )
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div>
        @endif
        <table class="table table-bordered table-striped table-hover">
            <thead class="thead-light">
                <tr>
                    <th>#</th>
                    <th>شهر الأستحقاق</th>
                    <th>قيمة القسط </th>
                    <th>حالة الدفع</th>
                    <th>حالة الأرشفه </th>
                    <th>الملاحظات</th>
                </tr>
            </thead>
            <tbody>

                <?php $i = 0; ?>
                @foreach ($dataParent['installmentDetails'] as $info)
                    <?php $i++; ?>

                    <tr>
                        <td>{{ $i }}</td>
                        <td>{{ $info->year_month }}</td>
                        <td>{{ $info->month_installment_value * 1 }}</td>
                        <td>
                            @if ($info->status == 1)
                                <span class="badge badge-primary">تم الدفع على المرتب</span>
                            @elseif($info->status == 2)
                                <span class="badge badge-success">تم الدفع كاش</span>
                            @else
                                <span class="badge badge-warning">بإنتظار الدفع</span>
                            @endif


                            @if (
                                $info->status == 0 && $info->counterBeforeNotPaid == 0 && $info->is_archived == 0 and
                                    $dataParent['has_disbursed_done'] == 1)
                                <button data-id="{{ $info->id }}" data-idparent="{{ $dataParent['id'] }}"
                                    class="btn btn-primary-gradient doSingleCachPayNow btn-sm">الدفع كاش مفرد</button>
                            @endif
                        </td>
                        <td>
                            @if ($info->is_archived == 1)
                                <span class="badge badge-primary">نعم</span>
                            @else
                                <span class="badge badge-danger">لا</span>
                            @endif
                        </td>

                        <td>{{ Str::limit($info->notes, 20) }}</td>
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
