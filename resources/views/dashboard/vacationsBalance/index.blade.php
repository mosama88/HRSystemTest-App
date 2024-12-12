@extends('dashboard.layouts.master')
@section('title', 'بيانات الأجازات المرحله')
@section('css')
    <!-- Internal Data table css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/buttons.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/jquery.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات بيانات الأجازات المرحله</h4><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول
                    بيانات بيانات الأجازات المرحله</span>
            </div>
        </div>
        <div class="d-flex my-xl-auto right-content">
            <div class="mb-3 mb-xl-0">
                <div class="btn-group dropdown">
                    <a class="btn btn-outline-primary btn-block" href="{{ route('dashboard.employees.create') }}"> <i
                            class="fas fa-plus-circle"></i> أضافة موظف جديد</a>
                </div>
            </div>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row">
        <!--div-->
        <div class="col-xl-12">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="d-flex justify-content-between">
                        <h4 class="card-title mg-b-0">جدول بيانات الأجازات المرحله</h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>
                    {{-- <p class="tx-12 tx-gray-500 mb-2">Example of Valex Striped Rows.. <a href="">Learn more</a></p> --}}
                </div>
                <div class="card-body">
                    {{-- Search --}}
                    <div id="alertMessage" class="alert alert-danger mb-0 show d-none" role="alert">
                        <span class="alert-inner--icon"><i class="fe fe-slash"></i></span>
                        <span class="alert-inner--text"><strong>Danger!</strong> قم بتغيير بعض الأمور وحاول إرسال
                            الطلب مرة أخرى.!</span>
                    </div>
                    {{-- Search Form --}}
                    <div class="row mb-4">
                        <div class="form-group col-3">
                            <label>

                                <input checked name="searchByRadioCode" value="employee_code" id="employee_code_radio"
                                    type="radio">
                                <label for="employee_code_radio">كود الموظف</label>

                                <input name="searchByRadioCode" value="fp_code" id="fp_code_radio" type="radio"> <label
                                    for="fp_code_radio">بصمة الموظف</label>

                            </label>
                            <input autofocus type="text" name="byCode_search" id="byCode_search"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control" value="">
                        </div>
                        {{-- name_search --}}
                        <div class="form-group col-3">
                            <label> بحث بأسم الموظف بالكامل</label>
                            <input type="text" name="name_search" id="name_search" class="form-control" value="">
                        </div>

                        {{-- gender_search --}}
                        <div class="form-group col-3">
                            <label> بحث بنوع الجنس</label>
                            <select name="gender_search" id="gender_search" class="form-control">
                                <option value="all">-- بحث بالكل --</option>
                                <option value="Male">ذكر</option>
                                <option value="Female">انثي</option>
                            </select>
                        </div>


                        {{-- branch_id_search --}}
                        <div class="form-group col-3">
                            <label> بحث بأسم الفرع</label>
                            <select name="branch_id_search" id="branch_id_search" class="form-control select2">
                                <option value="all">-- بحث بالكل --</option>
                                @if (@isset($other['branches']) && !@empty($other['branches']))
                                    @foreach ($other['branches'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                        </div>


                        {{-- job_grade_id_search --}}
                        <div class="form-group col-3">
                            <label> الدرجه الوظيفية</label>
                            <select name="job_grade_id_search" id="job_grade_id_search" class="form-control select2">
                                <option value="all">-- بحث بالكل --</option>
                                @if (@isset($other['job_grades']) && !@empty($other['job_grades']))
                                    @foreach ($other['job_grades'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                        </div>

                        {{-- department_id_search --}}
                        <div class="form-group col-3">
                            <label>بحث بالادارة </label>
                            <select name="department_id_search" id="department_id_search" class="form-control select2 ">
                                <option value="all">-- بحث بالكل --</option>
                                @if (@isset($other['departements']) && !@empty($other['departements']))
                                    @foreach ($other['departements'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                        </div>

                        {{-- job_categories_id_search --}}
                        <div class="form-group col-3">
                            <label> بحث بوظيفة الموظف</label>
                            <select name="job_categories_id_search" id="job_categories_id_search"
                                class="form-control select2">
                                <option value="all">-- بحث بالكل --</option>
                                @if (@isset($other['jobs']) && !@empty($other['jobs']))
                                    @foreach ($other['jobs'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                        </div>

                        {{-- functional_status_search --}}
                        <div class="form-group col-3">
                            <label>بحث بأسم الحالة الوظيفية</label>
                            <select name="functional_status_search" id="functional_status_search" class="form-control">
                                <option value="all">-- بحث بالكل --</option>
                                <option value="Employee">موظف</option>
                                <option value="Unemployed">لا يعمل
                                </option>
                            </select>
                        </div>

                        {{-- Type_salary_receipt_search --}}
                        <div class="form-group col-3">
                            <label> بحث بنوع صرف راتب الموظف</label>
                            <select name="Type_salary_receipt_search" id="Type_salary_receipt_search"
                                class="form-control">
                                <option value="all">-- بحث بالكل --</option>
                                <option value="Cach">كاش</option>
                                <option value="Visa">فيزا</option>
                            </select>
                        </div>




                    </div>
                    {{-- End Row --}}


                    <div class="table-responsive" id="resultsTable">
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
                                                    <img alt="Responsive image" class="img-thumbnail rounded me-2"
                                                        alt="200x200" style="width: 80px; height:50px"
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

                    </div><!-- bd -->
                </div><!-- bd -->
            </div><!-- bd -->
        </div>
        <!--/div-->
    </div>
    <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    <!-- main-content closed -->
@endsection
@section('js')
    <!-- Internal Data tables -->
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.bootstrap4.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.buttons.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.bootstrap4.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jszip.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/pdfmake.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/vfs_fonts.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.html5.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.print.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.colVis.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.bootstrap4.min.js') }}"></script>
    <!--Internal  Datatable js -->
    <script src="{{ URL::asset('dashboard/assets/js/table-data.js') }}"></script>

    <script>
        $(document).ready(function() {
            // Event listeners for search inputs
            $(document).on('input',
                '#byCode_search, #job_grade_id_search, #name_search, #branch_id_search, #department_id_search, #job_categories_id_search, #functional_status_search, #Type_salary_receipt_search, #gender_search',
                function(e) {
                    ajax_search();
                });

            $(document).on('change', 'input[name="searchByRadioCode"]', function(e) {
                ajax_search();
            });

            // AJAX search function
            function ajax_search() {
                var byCode = $("#byCode_search").val();
                var name = $("#name_search").val();
                var branch_id = $("#branch_id_search").val();
                var department_id = $("#department_id_search").val();
                var job_categories_id = $("#job_categories_id_search").val();
                var job_grade_id = $("#job_grade_id_search").val();
                var functional_status = $("#functional_status_search").val();
                var Type_salary_receipt = $("#Type_salary_receipt_search").val();
                var gender = $("#gender_search").val();
                var searchByRadioCode = $("input[name='searchByRadioCode']:checked").val();

                jQuery.ajax({
                    url: '{{ route('dashboard.vacationsBalance.ajax_search') }}',
                    type: 'post',
                    dataType: 'html',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        byCode: byCode,
                        name: name,
                        branch_id: branch_id,
                        department_id: department_id,
                        job_categories_id: job_categories_id,
                        job_grade_id: job_grade_id,
                        functional_status: functional_status,
                        Type_salary_receipt: Type_salary_receipt,
                        gender: gender,
                        searchByRadioCode: searchByRadioCode,
                    },
                    success: function(data) {
                        $("#resultsTable").html(data);
                    },
                    error: function() {
                        alert("عفوا لقد حدث خطأ ");
                    }
                });
            }

            // AJAX pagination function
            $(document).on('click', '#ajax-pagination_in_search a', function(e) {
                e.preventDefault();
                var byCode = $("#byCode_search").val();
                var name = $("#name_search").val();
                var branch_id = $("#branch_id_search").val();
                var department_id = $("#department_id_search").val();
                var job_grade_id = $("#job_grade_id_search").val();
                var job_categories_id = $("#job_categories_id_search").val();
                var functional_status = $("#functional_status_search").val();
                var Type_salary_receipt = $("#Type_salary_receipt_search").val();
                var gender = $("#gender_search").val();
                var searchByRadioCode = $("input[name='searchByRadioCode']:checked").val();
                var linkurl = $(this).attr("href");

                jQuery.ajax({
                    url: linkurl,
                    type: 'post',
                    dataType: 'html',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        byCode: byCode,
                        name: name,
                        branch_id: branch_id,
                        department_id: department_id,
                        job_categories_id: job_categories_id,
                        job_grade_id: job_grade_id,
                        functional_status: functional_status,
                        Type_salary_receipt: Type_salary_receipt,
                        gender: gender,
                        searchByRadioCode: searchByRadioCode,
                    },
                    success: function(data) {
                        $("#resultsTable").html(data);
                    },
                    error: function() {
                        alert("عفوا لقد حدث خطأ ");
                    }
                });
            });
        });
    </script>

@endsection
