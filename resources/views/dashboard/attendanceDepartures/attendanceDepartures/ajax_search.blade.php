@if (isset($data) && $data->isNotEmpty())

    <table id="example1" class="table table-bordered table-striped table-hover">
        <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>صورة</th>
                <th>كود بصمة الموظف</th>
                <th>كود الموظف</th>
                <th>أسم الموظف</th>
                <th>الفرع</th>
                <th>الأدارة</th>
                <th>الوظيفه</th>
                <th>الحالة</th>
                @if ($finance_cln_periods_data['is_open'] == 1)
                    <th style="width: 150px">العمليات</th>
                @else
                    <th style="width: 150px">العمليات</th>
                @endif
            </tr>
        </thead>
        <tbody>
            <?php $i = 0; ?>
            @foreach ($data as $info)
                <?php $i++; ?>
                <tr>
                    <td>{{ $i }}</td>
                    <td>
                        @if ($info->employee_photo)
                            <img class="img-thumbnail rounded me-2" alt="200x200" style="width: 80px; height:50px"
                                src="{{ asset('dashboard/assets/uploads/employees/photo/' . $info->employee_photo) }}"
                                data-holder-rendered="true">
                        @elseif ($info->gender == 'Male')
                            <img alt="Responsive image" class="img-thumbnail rounded me-2" alt="200x200"
                                style="width: 80px; height:50px"
                                src="{{ asset('dashboard/assets/img/employees-default.png') }}">
                        @else
                            <img alt="Responsive image" style="width: 80px; height:50px"
                                src="{{ asset('dashboard/assets/img/employees-female-default.png') }}">
                        @endif
                    </td>
                    <td>{{ $info->employee->fp_code }}</td>
                    <td>{{ $info->employee_code }}</td>
                    <td>{{ $info->employee?->name }}</td>
                    <td>{{ $info->branch->name }}</td>
                    <td>{{ $info->department->name }}</td>
                    <td>{{ $info->job?->name }}</td>
                    <td>
                        <div class="col-12">
                            @if ($info->is_archived == 1)
                                <span class="badge badge-warning">مؤرشف 📂</span>
                            @else
                                <span class="badge badge-success">مفتوح &#x1F60A;
                                </span>
                            @endif

                        </div>
                    </td>
                    <td class="col-2">
                        <div class="dropdown">
                            {{-- show --}}
                            <a class="btn btn-sm btn-primary btn-small"
                                href="{{ route('dashboard.attendanceDepartures.showAttendanceDetails', ['employee_code' => $info->employee_code, 'finance_cln_periods_id' => $finance_cln_periods_data['id']]) }}"><i
                                    class="fas fa-eye ml-1"></i>عرض بصمات الموظف</a>
                        </div>
                    </td>

                </tr>
            @endforeach
        </tbody>
    </table>
    <div class="col-md-12 text-center" id="ajax-pagination_in_search">
        {{ $data->links('pagination::bootstrap-5') }}
    </div>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif
