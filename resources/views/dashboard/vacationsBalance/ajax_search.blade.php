@if (isset($data) && !@empty($data))
    <table class="table text-md-nowrap" id="example1">
        <thead>
            <tr>
                <th>#</th>
                <th>الصورة</th>
                <th>كود الموظف</th>
                <th>الأسم</th>
                <th>الفرع</th>
                <th>الأدارة</th>
                <th>الوظيفه</th>
                <th>رصيد الاجازات</th>
                <th>الأضافه بواسطة</th>
                <th>العمليات</th>
            </tr>
        </thead>
        <tbody>
            <?php $i = 0; ?>
            @foreach ($data as $info)
                <?php $i++; ?>
                <tr>
                    <th scope="row">{{ $i }}</th>
                    <td>
                        @if ($info->image)
                            <img class="img-thumbnail rounded me-2" alt="200x200" style="width: 80px; height:50px"
                                src="{{ asset('dashboard/assets/uploads/employees/photo/' . $info->image->filename) }}"
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
                    <td>{{ $info->employee_code }}</td>
                    <td>{{ $info->name }}</td>
                    <td>{{ $info->branch->name }}</td>
                    <td>{{ $info->jobCategories?->name }}</td>
                    <td>{{ $info->work_start_date }}</td>
                    <td>
                        @if ($info->active_vacation == 'Yes')
                            <span class="badge badge-pill badge-primary">له رصيد</span>
                        @else
                            <span class="badge badge-pill badge-danger">ليس لدية رصيد</span>
                        @endif
                    </td>
                    <td>{{ $info->createdByAdmin?->name }}</td>
                    <td class="col-2">
                        <div class="dropdown">
                            <button aria-expanded="false" aria-haspopup="true" class="btn ripple btn-sm btn-primary"
                                data-toggle="dropdown" id="dropdownMenuButton" type="button">العمليات <i
                                    class="fas fa-caret-down ml-1"></i></button>
                            <div class="dropdown-menu tx-13">
                                {{-- show --}}
                                <a class="btn dropdown-item text-primary btn-sm"
                                    href="{{ route('dashboard.employees.show', $info->id) }}"><i
                                        class="fas fa-eye ml-1"></i>بيانات الموظف</a>
                                {{-- Edit --}}
                                <a class="btn dropdown-item text-info btn-outline-info btn-sm"
                                    href="{{ route('dashboard.employees.edit', $info->id) }}"><i
                                        class="fas fa-edit ml-1"></i>تعديل</a>

                                {{-- Delete --}}
                                <a class="modal-effect btn btn-outline-danger text-danger dropdown-item btn-sm"
                                    data-effect="effect-scale" data-toggle="modal" href="#delete{{ $info->id }}">
                                    <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                            </div>
                        </div>

                        @include('dashboard.affairs_employees.employees.delete')
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    <br>
    <div class="col-md-12 text-center" id="ajax-pagination_in_search">
        {{ $data->links('pagination::bootstrap-5') }}
    </div>
@else
    <p class="bg-danger text-center">عفوا لاتوجد بيانات لعرضها</p>
@endif
