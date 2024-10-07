@if (isset($data) && $data->isNotEmpty())
    <table class="table table-bordered table-striped table-hover">
        <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>كود الموظف</th>
                <th>أسم الموظف</th>
                <th>قيمة السلفة </th>
                <th>عدد شهور الأقساط</th>
                <th>قيمة القسط </th>
                <th>يبدأ سداد أول قسط فى تاريخ</th>
                <th>هل صرفت</th>
                <th> هل الأقساط أنتهت</th>
                <th>الملاحظات</th>
                <th>العمليات</th>
            </tr>
        </thead>
        <tbody>

            <?php $i = 0; ?>
            @foreach ($data as $info)
                <?php $i++; ?>

                <tr>
                    <td>{{ $i }}</td>
                    <td>{{ $info->employee_code }}</td>
                    <td>{{ $info->emp_name }}</td>
                    <td>{{ $info->total * 1 }}</td>
                    <td>{{ $info->month_number_installment }}</td>
                    <td>{{ $info->month_installment_value }}</td>
                    <td>{{ $info->year_month_start_date }}</td>
                    <td>
                        @if ($info->has_disbursed_done == 1)
                            <span class="badge badge-primary">نعم</span>
                        @else
                            <span class="badge badge-danger">لا</span>
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

                    <td class="col-2">
                        <div class="dropdown">
                            <button aria-expanded="false" aria-haspopup="true"
                                class="btn ripple btn-sm btn-primary dropdown-toggle" data-toggle="dropdown"
                                id="dropdownMenuButton" type="button">العمليات <i class="fas ml-1"></i></button>

                            <div class="dropdown-menu tx-13" aria-labelledby="dropdownMenuButton">
                                <!-- Details EditModal -->
                                <button data-id="{{ $info->id }}"
                                    class="dropdown-item d-flex align-items-center load_installment_details"
                                    data-effect="effect-scale" data-toggle="modal">
                                    <i class="fas fa-eye ml-2"></i>تفاصيل السلفه
                                </button>
                                <!-- Edit EditModal -->
                                <button data-id="{{ $info->id }}"
                                    class="dropdown-item d-flex align-items-center load_edit_this_row">
                                    <i class="fas fa-edit ml-2"></i>تعديل
                                </button>
                                <!-- Delete -->
                                <button class="dropdown-item d-flex align-items-center text-danger"
                                    data-effect="effect-scale" data-toggle="modal" href="#delete{{ $info->id }}">
                                    <i class="fas fa-trash-alt ml-2"></i>حذف
                                </button>
                            </div>
                        </div>

                        @include('dashboard.salaries.permanentLoan.delete')
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
