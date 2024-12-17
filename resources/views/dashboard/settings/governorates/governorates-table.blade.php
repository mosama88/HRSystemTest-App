<div>
    <div class="row row-sm">
        <div class="col-lg-6">
            <div class="form-group">
                <input aria-describedby="basic-addon1" wire:model.live="name_search" aria-label="أبحث بأسم المحافظة"
                    class="form-control" placeholder="أبحث بأسم المحافظة" type="text">
            </div><!-- input-group -->
        </div>
        {{-- Governorate Input --}}
        <div class="col-lg-6">
            <div class="form-group">
                <select wire:model="country_search" id="country_search" class="form-control select2">
                    <option value="">-- اختر البلد التابع لها المحافظة
                        --</option>
                    @if (isset($other['countries']) && !empty($other['countries']))
                        @foreach ($other['countries'] as $info)
                            <option value="{{ $info->id }}">
                                {{ $info->name }}
                            </option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
    </div>
    <div class="table-responsive">
        @if (@isset($data) && !@empty($data))
            <table class="table table-striped mg-b-0 text-md-nowrap">
                <thead>
                    <tr>
                        <th class="wd-15p border-bottom-0"> #</th>
                        <th class="wd-15p border-bottom-0"> المحافظة</th>
                        <th class="wd-15p border-bottom-0"> البلد</th>
                        <th class="wd-10p border-bottom-0">التفعيل</th>
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
                            <td>{{ $info->name }}</td>
                            <td>{{ $info->country->name }}</td>
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
                            <td>{{ $info->createdByAdmin->username }}</td>
                            <td>
                                @if ($info->updated_by > 0)
                                    {{ $info->updatedByAdmin->name }}
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
                                        @can('تعديل المحافظات')
                                            {{-- Edit --}}
                                            <a class="dropdown-item modal-effect btn btn-outline-info btn-sm"
                                                data-effect="effect-scale" data-toggle="modal" href="#"
                                                wire:click.prevent="$dispatch('editGovernorates',{id:{{ $info->id }}})"><i
                                                    class="fas fa-edit ml-1"></i>تعديل</a>
                                        @endcan
                                        @can('حذف المحافظات')
                                            @if ($info->counterUsed == 0)
                                                {{-- Delete --}}
                                                <a class="dropdown-item modal-effect btn btn-outline-danger btn-sm"
                                                    data-effect="effect-scale"
                                                    wire:click.prevent="$dispatch('deleteGovernorates',{id:{{ $info->id }}})"
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
</div>
</div>
