<div>
    <div class="row row-sm">
        <div class="col-lg-6">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
                </div><input aria-describedby="basic-addon1" wire:model.live="name" aria-label="أبحث بأسم الفرع أو الايميل"
                    class="form-control" placeholder="أبحث بأسم الدرجه الوظيفية" type="text">
            </div><!-- input-group -->
        </div>

    </div>
    <div class="table-responsive">
        @if (@isset($data) && !@empty($data))
            <table class="table text-md-nowrap" id="example2">
                <thead>
                    <tr>
                        <th>#</th>
                        <th class="wd-15p border-bottom-0">كود الدرجه</th>
                        <th class="wd-15p border-bottom-0">أسم الدرجه</th>
                        <th class="wd-20p border-bottom-0">الحد الادنى للمرتب</th>
                        <th class="wd-20p border-bottom-0">الحد الأقصى للمرتب</th>
                        <th class="wd-15p border-bottom-0">ملاحظات</th>
                        <th class="wd-10p border-bottom-0">الأضافة بواسطة</th>
                        <th class="wd-25p border-bottom-0">التحديث بواسطة</th>
                        <th class="wd-25p border-bottom-0">العمليات</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 0; ?>
                    @foreach ($data as $info)
                        <?php $i++; ?>

                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $info->job_grades_code }}</td>
                            <td>{{ $info->name }}</td>
                            <td>{{ $info->min_salary }}</td>
                            <td>{{ $info->max_salary }}</td>
                            <td>{{ Str::limit($info->notes, 50) }}</td>
                            <td>{{ $info->createdBy->name }}</td>
                            <td>
                                @if (!@empty($info->updatedBy))
                                    {{ $info->updatedBy->name }}
                                @else
                                    <span class="text">لا يوجد</span>
                                @endif
                            </td>
                            <td>

                                <div class="dropdown">
                                    <button aria-expanded="false" aria-haspopup="true"
                                        class="btn ripple btn-secondary btn-sm" data-toggle="dropdown"
                                        type="button">العمليات<i class="fas fa-caret-down ml-1"></i></button>
                                    <div class="dropdown-menu tx-13">
                                        <h6 class="dropdown-header tx-uppercase tx-11 tx-bold tx-inverse tx-spacing-1">
                                            حذف وتعديل</h6>
                                        @can('تعديل الدرجات الوظيفية')
                                            {{-- Edit --}}
                                            <a class="dropdown-item modal-effect btn btn-outline-info btn-sm"
                                                data-effect="effect-scale" data-toggle="modal" href="#"
                                                wire:click.prevent="$dispatch('editjobGrades',{id:{{ $info->id }}})"><i
                                                    class="fas fa-edit ml-1"></i>تعديل</a>
                                        @endcan
                                        @can('حذف الدرجات الوظيفية')
                                            @if ($info->counterUsed == 0)
                                                {{-- Delete --}}
                                                <a class="dropdown-item modal-effect btn btn-outline-danger btn-sm"
                                                    data-effect="effect-scale"
                                                    wire:click.prevent="$dispatch('deletejobGrades',{id:{{ $info->id }}})"
                                                    data-toggle="modal" href="#">
                                                    <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                            @endif
                                        @endcan
                                    </div>
                                </div>
                            </td>

                        </tr>
                    @endforeach
                </tbody>
            </table>
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
