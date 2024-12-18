<div class="table-responsive">
    @if ($data->isNotEmpty())
        <div class="table-responsive mt-3">
            <table class="table table-bordered table-striped table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>اسم الشهر </th>
                        <th>سنة</th>
                        <th>تاريخ البداية</th>
                        <th>تاريخ النهاية</th>
                        <th>بداية البصمة</th>
                        <th>نهاية البصمة</th>
                        <th>عدد الأيام</th>
                        <th>حالة الشهر</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($data as $info)
                        <tr>
                            <td>{{ $info->month->name ?? 'غير محدد' }}</td>
                            <td>{{ $info->finance_yr ?? 'غير محدد' }}</td>
                            <td>{{ $info->start_date_m ?? 'غير محدد' }}</td>
                            <td>{{ $info->end_date_m ?? 'غير محدد' }}</td>
                            <td>{{ $info->start_date_fp ?? 'غير محدد' }}</td>
                            <td>{{ $info->end_date_fp ?? 'غير محدد' }}</td>
                            <td>{{ $info->number_of_days ?? 'غير محدد' }}</td>
                            <td>
                                @if ($info->is_open == 0)
                                    <a class="badge badge-warning" href="#">معلق</a>
                                @elseif ($info->is_open == 1)
                                    <a class="badge badge-success" href="#">مفتوح</a>
                                @else
                                    <a class="badge badge-danger" href="#">مؤرشف</a>
                                @endif


                                @if (!@empty($info->currentYear))
                                    @if ($info->currentYear['is_open'] == 1)
                                        @if ($info->is_open == 0 and $info->counterOpenMonth == 0 and $info->counterPreviousWatingOpen == 0)
                                            {{-- @if ($info['is_open'] != 2 && $info['is_open'] != 1) --}}
                                            {{-- Edit To Open --}}
                                            <a class="modal-effect btn btn-outline-primary btn-sm mx-2"
                                                data-effect="effect-scale" data-toggle="modal"
                                                href="#editIsOpen{{ $info->id }}"><i
                                                    class="fas fa-edit ml-1"></i>فتح الشهر
                                                المالى</a>
                                            @include('dashboard.salaries.SalaryRecords.editISOpen')
                                        @endif

                                        @if ($info['is_open'] == 1)
                                            {{-- Edit To Open --}}
                                            {{-- Delete --}}
                                            <a class="modal-effect btn btn-outline-danger btn-sm"
                                                data-effect="effect-scale" data-toggle="modal"
                                                href="#editIsClose{{ $info->id }}">
                                                <i class="fas fa-folder-open"></i> أرشفة الشهر
                                                المالى
                                            </a>
                                            @include('dashboard.salaries.SalaryRecords.load_close_month')
                                        @endif
                                    @endif
                                @endif
                                {{-- @include('dashboard.salaries.SalaryRecords.load_open_month') --}}
                            </td>

                        </tr>
                    @endforeach

                </tbody>
            </table>

        </div>
    @else
        <div class="alert alert-warning" role="alert" dir="rtl">
            <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
            <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
        </div>
    @endif

    <div class="row float-left mx-auto mt-4">
        {{ $data->links() }}
    </div>
</div>

</div>
</div>
</div>
