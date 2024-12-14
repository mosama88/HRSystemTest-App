<div>
    <div class="row row-sm">
        <div class="col-lg-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">بحث بأسم الفرع</span>
                </div><input aria-describedby="basic-addon1" wire:model.live="name" aria-label="أبحث بأسم الفرع أو الايميل"
                    class="form-control" placeholder="أبحث بأسم الفرع أو الايميل" type="text">
                <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
            </div><!-- input-group -->
        </div>
        <div class="col-lg-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">بحث بالهاتف</span>
                </div><input aria-describedby="basic-addon1" wire:model.live="phones" aria-label="Username"
                    class="form-control" placeholder="أبحث بالموبايل" type="text">
                <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
            </div><!-- input-group -->
        </div>
    </div>

    <div class="table-responsive">
        @if (@isset($data) && !@empty($data))
            <table class="table table-striped mg-b-0 text-md-nowrap">
                <thead>
                    <tr>
                        <th>#</th>
                        <th class="wd-15p border-bottom-0">الأسم</th>
                        <th class="wd-20p border-bottom-0">العنوان</th>
                        <th class="wd-10p border-bottom-0">الهاتف</th>
                        <th class="wd-15p border-bottom-0">البريد الالكتورنى</th>
                        <th class="wd-10p border-bottom-0">التفعيل</th>
                        <th class="wd-10p border-bottom-0">الأضافة بواسطة</th>
                        <th class="wd-10p border-bottom-0">التحديث بواسطة</th>
                        <th class="wd-25p border-bottom-0">العمليات</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 0; ?>
                    @foreach ($data as $info)
                        <?php $i++; ?>

                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $info->name }}</td>
                            <td>{{ Str::limit($info->address, 30) }}</td>
                            <td>{{ $info->phones }}</td>
                            <td>{{ $info->email }}</td>
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
                                @can('تعديل الفروع')
                                    {{-- Edit --}}
                                    <a class="modal-effect btn btn-outline-info btn-sm" data-effect="effect-scale"
                                        data-toggle="modal" href="#edit{{ $info->id }}"><i
                                            class="fas fa-edit ml-1"></i>تعديل</a>
                                @endcan
                                @can('حذف الفروع')
                                    @if ($info->counterUsed == 0)
                                        {{-- Delete --}}
                                        <a class="modal-effect btn btn-outline-danger btn-sm" data-effect="effect-scale"
                                            data-toggle="modal" href="#delete{{ $info->id }}">
                                            <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                    @endif
                                @endcan


                            </td>
                            @include('dashboard.settings.branches.edit')
                            @include('dashboard.settings.branches.delete')
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="row mt-2">
                {{ $data->links() }}
            </div>
        @else
            <div class="alert alert-warning" role="alert" dir="rtl">
                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
            </div>
        @endif

    </div>

</div>
