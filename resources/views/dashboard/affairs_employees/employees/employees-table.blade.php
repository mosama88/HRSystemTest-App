<div>
    {{-- Search Form --}}
    <div class="row mb-4">
        {{-- employee_code_search --}}
        <div class="form-group col-4">
            <label> بحث بكود الموظف </label>
            <input type="text" wire:model.live.debounce.debounce="employee_code_search" id="employee_code_search"
                class="form-control" value="">
        </div>
        {{-- fp_search --}}
        <div class="form-group col-4">
            <label> بحث بكود بصمة الموظف </label>
            <input type="text" wire:model.live.debounce="fp_search" id="fp_search" class="form-control" value="">
        </div>
        {{-- name_search --}}
        <div class="form-group col-4">
            <label> بحث بأسم أو الايميل او الرقم القومى</label>
            <input type="text" wire:model.live.debounce="name_search" id="name_search" class="form-control"
                value="">
        </div>

        {{-- gender_search --}}
        <div class="form-group col-4">
            <label> بحث بنوع الجنس</label>
            <select wire:model.live.debounce="gender_search" id="gender_search" class="form-control">
                <option value="">-- بحث بالكل --</option>
                <option value="Male">ذكر</option>
                <option value="Female">انثي</option>
            </select>
        </div>


        {{-- branch_id_search --}}
        <div class="form-group col-4">
            <label> بحث بأسم الفرع</label>
            <select wire:model.live.debounce="branch_id_search" id="branch_id_search" class="form-control select2">
                <option value="">-- بحث بالكل --</option>
                @if (@isset($other['branches']) && !@empty($other['branches']))
                    @foreach ($other['branches'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }} </option>
                    @endforeach
                @endif
            </select>
        </div>


        {{-- job_grade_id_search --}}
        <div class="form-group col-4">
            <label> الدرجه الوظيفية</label>
            <select wire:model.live.debounce="job_grade_id_search" id="job_grade_id_search"
                class="form-control select2">
                <option value="">-- بحث بالكل --</option>
                @if (@isset($other['job_grades']) && !@empty($other['job_grades']))
                    @foreach ($other['job_grades'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }} </option>
                    @endforeach
                @endif
            </select>
        </div>

        {{-- department_id_search --}}
        <div class="form-group col-4">
            <label>بحث بالادارة </label>
            <select wire:model.live.debounce="department_id_search" id="department_id_search"
                class="form-control select2 ">
                <option value="">-- بحث بالكل --</option>
                @if (@isset($other['departements']) && !@empty($other['departements']))
                    @foreach ($other['departements'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }} </option>
                    @endforeach
                @endif
            </select>
        </div>

        {{-- job_categories_id_search --}}
        <div class="form-group col-4">
            <label> بحث بوظيفة الموظف</label>
            <select wire:model.live.debounce="job_categories_id_search" id="job_categories_id_search"
                class="form-control select2">
                <option value="">-- بحث بالكل --</option>
                @if (@isset($other['jobs']) && !@empty($other['jobs']))
                    @foreach ($other['jobs'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }} </option>
                    @endforeach
                @endif
            </select>
        </div>

        {{-- functional_status_search --}}
        <div class="form-group col-4">
            <label>بحث بأسم الحالة الوظيفية</label>
            <select wire:model.live.debounce="functional_status_search" id="functional_status_search"
                class="form-control">
                <option value="">-- بحث بالكل --</option>
                <option value="Employee">موظف</option>
                <option value="Unemployed">لا يعمل
                </option>
            </select>
        </div>

        {{-- Type_salary_receipt_search --}}
        <div class="form-group col-4">
            <label> بحث بنوع صرف راتب الموظف</label>
            <select wire:model.live.debounce="Type_salary_receipt_search" id="Type_salary_receipt_search"
                class="form-control">
                <option value="">-- بحث بالكل --</option>
                <option value="Cach">كاش</option>
                <option value="Visa">فيزا</option>
            </select>
        </div>

        <div class="form-group col-3">
            <label></label>
            <div class="mg-t-10">
                @if (empty($Type_salary_receipt_search) &&
                        empty($employee_code_search) &&
                        empty($fp_search) &&
                        empty($name_search) &&
                        empty($gender_search) &&
                        empty($branch_id_search) &&
                        empty($job_grade_id_search) &&
                        empty($department_id_search) &&
                        empty($job_categories_id_search) &&
                        empty($functional_status_search))
                    <div class="mg-t-10">
                        <button class="btn  btn-light btn-block" disabled>أمسح</button>
                    </div>
                @else
                    <div class="mg-t-10">
                        <button wire:click.prevent="clear()" class="btn btn-primary btn-block">أمسح</button>
                    </div>
                @endif

            </div>





        </div>
        {{-- End Row --}}
        <div class="table-responsive" id="resultsTable">
            @if (isset($data) && !@empty($data))
                <table class="table table-striped mg-b-0 text-md-nowrap">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>الصورة</th>
                            <th>كود الموظف</th>
                            <th>الأسم</th>
                            <th>الفرع</th>
                            <th>الأدارة</th>
                            <th>الوظيفه</th>
                            <th>الحالة الوظيفية</th>
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
                                        <img class="img-thumbnail rounded me-2" alt="200x200"
                                            style="width: 80px; height:50px"
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
                                    @if ($info->functional_status == 'Employee')
                                        موظف
                                    @else
                                        لا يعمل
                                    @endif
                                </td>
                                <td>{{ $info->createdByAdmin?->name }}</td>
                                <td class="col-2">
                                    <div class="dropdown">
                                        <button aria-expanded="false" aria-haspopup="true"
                                            class="btn ripple btn-sm btn-primary" data-toggle="dropdown"
                                            id="dropdownMenuButton" type="button">العمليات <i
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

                                            @if ($info->CounterUsedBefore == 0)
                                                {{-- Delete --}}
                                                <a class="modal-effect btn btn-outline-danger text-danger dropdown-item btn-sm"
                                                    data-effect="effect-scale" data-toggle="modal"
                                                    href="#delete{{ $info->id }}">
                                                    <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                            @endif

                                        </div>
                                    </div>

                                    @include('dashboard.affairs_employees.employees.delete')
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
                <div class="col-md-12 text-center" id="ajax-pagination_in_search">
                    {{-- {{ $data->links('pagination::bootstrap-5') }} --}}
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
