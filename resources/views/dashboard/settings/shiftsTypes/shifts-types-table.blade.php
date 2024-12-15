<div>
    @php
        use Carbon\Carbon;
    @endphp
    <div class="row row-sm">
        <div class="col-lg-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
                </div><input aria-describedby="basic-addon1" wire:model.live="name" aria-label="أبحث بأسم الفرع أو الايميل"
                    class="form-control" placeholder="أبحث بأسم الفرع أو الايميل" type="text">
            </div><!-- input-group -->
        </div>
        <div class="col-lg-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
                </div><input aria-describedby="basic-addon1" wire:model.live="phones" aria-label="Username"
                    class="form-control" placeholder="أبحث بالموبايل" type="text">
            </div><!-- input-group -->
        </div>
    </div>

    @if (session('success'))
        <div class="alert alert-success text-center">
            {{ session('success') }}
        </div>
    @endif
    <div class="table-responsive">
        @if (@isset($data) && !@empty($data) && count($data) > 0)
            <table class="table table-striped mg-b-0 text-md-nowrap">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>نوع الشفت</th>
                        <th>بداية الوقت</th>
                        <th>نهاية الوقت</th>
                        <th>عدد الساعات</th>
                        <th>حالة التفعيل</th>
                        <th>أضافة بواسطة</th>
                        <th>تحديث بواسطة</th>
                        <th>العمليات</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 0; ?>
                    @foreach ($data as $info)
                        <?php $i++; ?>

                        <tr>
                            <td>{{ $i }}</td>
                            <td>
                                @if ($info->type == 1)
                                    صباحى
                                @elseif ($info->type == 2)
                                    مسائى
                                @else
                                    يوم كامل
                                @endif
                            </td>
                            <td>
                                {{ \Carbon\Carbon::parse($info->from_time)->format('g:i') }}
                                {{ \Carbon\Carbon::parse($info->from_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                            </td>
                            <td>
                                {{ \Carbon\Carbon::parse($info->to_time)->format('g:i') }}
                                {{ \Carbon\Carbon::parse($info->to_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                            </td>
                            </td>
                            @php
                                $to_time = Carbon::parse($info['to_time']);
                                $from_time = Carbon::parse($info['from_time']);
                                $diff_in_minutes = $to_time->diffInMinutes($from_time);
                                $hours = floor($diff_in_minutes / 60);
                                $minutes = $diff_in_minutes % 60;
                            @endphp
                            <td>{{ $hours }} ساعة و {{ $minutes }} دقيقة</td>
                            <td>
                                @if ($info->active == 2)
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

                                <div class="dropdown">
                                    <button aria-expanded="false" aria-haspopup="true"
                                        class="btn ripple btn-secondary btn-sm" data-toggle="dropdown"
                                        type="button">العمليات<i class="fas fa-caret-down ml-1"></i></button>
                                    <div class="dropdown-menu tx-13">
                                        <h6 class="dropdown-header tx-uppercase tx-11 tx-bold tx-inverse tx-spacing-1">
                                            حذف وتعديل</h6>
                                        @can('تعديل الشفتات')
                                            {{-- Edit --}}
                                            <a class="dropdown-item modal-effect btn btn-outline-info btn-sm"
                                                data-effect="effect-scale" data-toggle="modal" href="#"
                                                wire:click.prevent="$dispatch('shiftsTypesEdit',{id:{{ $info->id }}})"><i
                                                    class="fas fa-edit ml-1"></i>تعديل</a>
                                        @endcan
                                        @can('حذف الشفتات')
                                            @if ($info->counterUsed == 0)
                                                {{-- Delete --}}
                                                <a class="dropdown-item modal-effect btn btn-outline-danger btn-sm"
                                                    data-effect="effect-scale"
                                                    wire:click.prevent="$dispatch('deleteshiftsTypes',{id:{{ $info->id }}})"
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

    </div>
</div>
