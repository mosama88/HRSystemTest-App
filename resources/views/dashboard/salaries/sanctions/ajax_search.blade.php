@if (isset($data) && $data->isNotEmpty())
    <table class="table table-bordered table-striped table-hover">
        <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>كود الموظف</th>
                <th>أسم الموظف</th>
                <th>نوع الجزاء</th>
                <th>عدد الأيام</th>
                <th>أجمالى</th>
                <th>الملاحظات</th>
                <th>الحالة</th>
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
                    <td>
                        @if ($info->sanctions_type == 1)
                            جزاء أيام
                        @elseif($info->sanctions_type == 2)
                            جزاء بصمة
                        @elseif($info->sanctions_type == 3)
                            جزاء تحقيق
                        @else
                            لا يوجد جزاء
                        @endif
                    </td>
                    <td>{{ $info->value * 1 }}</td>
                    <td>{{ $info->total * 1 }}</td>
                    <td>{{ $info->notes }}</td>
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
