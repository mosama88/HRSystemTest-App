@if (isset($data) && $data->isNotEmpty())

    <div class="row">
        <div class="col-8 mx-auto">
            <div class="table-responsive">
                @if (@isset($data) && !@empty($data))
                    <div class="table-responsive mt-3">
                        <table id="example1" class="table table-bordered table-striped table-hover">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">عدد الرواتب</th>
                                    <th class="text-center">عدد بأنتظار الأرشفه</th>
                                    <th class="text-center">عدد المؤرشف</th>
                                    <th class="text-center">عدد الموقوف راتبه</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td class="text-center">{{ $other['counter_salaries'] * 1 }}</td>
                                    <td class="text-center">{{ $other['counter_salaries_waiting_archive'] * 1 }}</td>
                                    <td class="text-center">{{ $other['counter_salaries_done_archive'] * 1 }}</td>
                                    <td class="text-center">{{ $other['counter_salaries_stopped'] * 1 }}</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                @else
                    <div class="alert alert-warning" role="alert" dir="rtl">
                        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                            لعرضها!</span>
                    </div>
                @endif




            </div>

        </div>
    </div>
    <table id="example1" class="table table-bordered table-striped table-hover">
        <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>كود الموظف</th>
                <th>أسم الموظف</th>
                <th>الفرع</th>
                <th>الأدارة</th>
                <th>الوظيفه</th>
                <th>صافى الراتب</th>
                <th>الحالة</th>
                <th style="width: 150px">العمليات</th>
            </tr>
        </thead>
        <tbody>

            <?php $i = 0; ?>
            @foreach ($data as $info)
                <?php $i++; ?>

                <tr>
                    <td>{{ $i }}</td>
                    <td>{{ $info->employee_code }}</td>
                    <td>{{ $info->employee_name }}</td>
                    <td>{{ $info->branch->name }}</td>
                    <td>{{ $info->department->name }}</td>
                    <td>{{ $info->employee_jobs_id }}</td>
                    <td>{{ $info->net_salary }}</td>
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
                            <button aria-expanded="false" aria-haspopup="true" class="btn ripple btn-sm btn-primary"
                                data-toggle="dropdown" id="dropdownMenuButton" type="button">العمليات <i
                                    class="fas fa-caret-down ml-1"></i></button>
                            <div class="dropdown-menu tx-13">
                                {{-- show --}}
                                <a class="btn dropdown-item text-primary btn-sm"
                                    href="{{ route('dashboard.mainSalaryEmployees.showSalryDetails', $info->id) }}"><i
                                        class="fas fa-eye ml-1"></i>بيانات الموظف</a>

                                {{-- طباعة --}}
                                <a class="btn dropdown-item text-success btn-sm"
                                    href="{{ route('dashboard.mainSalaryEmployees.printSalary', $info->id) }}"><i
                                        class="fas fa-print"></i> طباعة</a>

                                {{-- Delete --}}
                                <a class="modal-effect btn btn-outline-danger text-danger dropdown-item btn-sm"
                                    data-effect="effect-scale" data-toggle="modal" href="#delete{{ $info->id }}">
                                    <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                            </div>
                        </div>
                        @include('dashboard.salaries.mainSalaryEmployees.delete')
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>


    <div class="col-md-12 text-center" id="ajax_pagination_in_search">
        {{ $data->links('pagination::bootstrap-5') }}
    </div>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif
