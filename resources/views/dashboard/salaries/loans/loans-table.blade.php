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
                        <th>العمليات</th>
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
                                @if ($info->is_open == 1)
                                    <span class="badge badge-success">مفتوح &#x1F60A;</span>
                                @elseif ($info->is_open == 2)
                                    <span class="badge badge-danger">مغلق ومؤرشف &#x2716;</span>
                                @else
                                    <span class="badge badge-warning">معلق &#x23F3;
                                    </span>
                                @endif
                            </td>
                            <td>

                                @if ($info->is_open != 0)
                                    <a href="{{ route('dashboard.loans.show', $info->id) }}"
                                        class="btn-sm btn btn-info mr-2">
                                        <i class="fas fa-eye ml-1"></i> عرض</a>
                                @endif

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
