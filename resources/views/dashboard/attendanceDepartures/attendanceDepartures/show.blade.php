@extends('dashboard.layouts.master')
@section('sanctions', 'active')
@section('title', 'عرض جهاز البصمة')
@section('css')

    <!-- Internal Data table css -->

    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!---Internal  Multislider css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/multislider/multislider.css') }}" rel="stylesheet">
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/css/sweetalert2.min.css') }}" rel="stylesheet">

@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات جهاز البصمة للشهر
                    المالى {{ $finance_cln_periods_data->month->name }}</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;" href="{{ route('dashboard.attendanceDepartures.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> سجلات بصمات الموظفين
                    </a>
                </span>
            </div>
        </div>
        @can('إرفاق ملف البصمة مرتب يدوى')
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="btn btn-block" style="background-color: #295F98;color:white"
                            href="{{ route('dashboard.attendanceDepartures.uploadFileExcel', $finance_cln_periods_data->id) }}">
                            <i class="fas fa-file-upload fa-lg ml-1"></i> إرفاق ملف البصمة </a>
                    </div>
                </div>
            </div>
        @endcan

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
                        <h4 class="card-title mg-b-0">
                            بيانات بصمة الموظفين بالشهر المالى(<span
                                class="text-danger ">{{ $finance_cln_periods_data['month']->name }}</span> لسنه
                            {{ $finance_cln_periods_data['finance_yr'] }})
                        </h4>

                        <span class="text-danger ml-5"> </span>

                    </div>
                </div>

                <form method="POST" action="{{ route('dashboard.mainSalaryEmployees.print_search') }}" target="_blank">
                    @csrf
                    <input type="hidden" id="the_finance_cln_periods_id" name="the_finance_cln_periods_id"
                        value="{{ $finance_cln_periods_data['id'] }}">

                    @can('بحث بصمة الموظفين')
                        <div class="col-10 mx-auto mt-4">
                            <div class="row">
                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بالموظفين </label>
                                        <select name="employee_code" id="employee_code_search" class="form-control select2">
                                            <option value="all">بحث بالكل</option>
                                            @if (@isset($employees) && !@empty($employees))
                                                @foreach ($employees as $emp)
                                                    <option value="{{ $emp->employee_code }}">{{ $emp->name }} / كود البصمه
                                                        ({{ $emp->fp_code }})
                                                    </option>
                                                @endforeach
                                            @else
                                                <div class="alert alert-warning" role="alert" dir="rtl">
                                                    <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                                                    <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                                                        لعرضها!</span>
                                                </div>
                                            @endif
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث الفرع </label>
                                        <select name="branch_id" id="branch_id_search" class="form-control select2">
                                            <option value="all">بحث بالكل</option>
                                            @if (@isset($other['branches']) && !@empty($other['branches']))
                                                @foreach ($other['branches'] as $info)
                                                    <option value="{{ $info->id }}">{{ $info->name }} </option>
                                                @endforeach
                                            @endif
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بالاداره </label>
                                        <select name="employee_department_code" id="employee_department_code_search"
                                            class="form-control select2">
                                            <option value="all">بحث بالكل</option>
                                            @if (@isset($other['departements']) && !@empty($other['departements']))
                                                @foreach ($other['departements'] as $info)
                                                    <option value="{{ $info->id }}">{{ $info->name }} </option>
                                                @endforeach
                                            @endif
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بالوظيفه </label>
                                        <select name="employee_jobs_id" id="employee_jobs_id_search"
                                            class="form-control select2">
                                            <option value="all">بحث بالكل</option>
                                            @if (@isset($other['jobs']) && !@empty($other['jobs']))
                                                @foreach ($other['jobs'] as $info)
                                                    <option value="{{ $info->id }}">{{ $info->name }} </option>
                                                @endforeach
                                            @endif
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بنوع صرف الراتب </label>
                                        <select name="cash_visa" id="cash_visa_search" class="form-control">
                                            <option value="all">بحث بالكل</option>
                                            <option value="Cach">كاش</option>
                                            <option value="Visa">فيزا</option>
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بحالة المرتب </label>
                                        <select name="is_stopped" id="is_stopped_search" class="form-control">
                                            <option value="all">بحث بالكل</option>
                                            <option value="unstopped">سارى</option>
                                            <option value="stopped">موقوف</option>
                                        </select>
                                    </div>
                                </div>

                                <div class=" col-4">
                                    <div class="form-group">
                                        <label> بحث بحالة الأرشفه </label>
                                        <select name="is_archived" id="is_archived_search" class="form-control">
                                            <option value="all">بحث بالكل</option>
                                            <option value="1">مؤرشف</option>
                                            <option value="0">مفتوح</option>
                                        </select>
                                    </div>
                                </div>


                                <div class="col-3">
                                    <label for=""></label>
                                    <div class="dropdown">
                                        <button aria-expanded="false" aria-haspopup="true" class="btn ripple btn-primary"
                                            data-toggle="dropdown" type="button"><i class="fas fa-print"></i> طباعة <i
                                                class="fas fa-caret-down ml-1"></i></button>
                                        <div class="dropdown-menu tx-13">
                                            <button value="in_details" name="submit_button" class="dropdown-item"
                                                href="#">
                                                طباعة بحث مفصل لكل موظف</button>
                                            <button value="in_total" name="submit_button" class="dropdown-item"
                                                href="#">طباعة بحث إجمالى مصغر</button>
                                            <button value="inTotalWithDetails" name="submit_button" class="dropdown-item"
                                                href="#">طباعة بحث إجمالى مفصل</button>
                                        </div>
                                    </div>

                                </div>




                            </div>
                        </div>
                    @endcan
                </form>


                <div class="card-body">
                    @if (isset($last_attendance_departures_date) && !empty($last_attendance_departures_date))
                        <h5 class="text-danger mb-2">أخر تاريخ تم فية رفع الملف :
                            <span class="badge badge-danger">
                                بواسطة:
                                ( {{ $last_attendance_departures_date->createdByAdmin->name }} )

                                @php
                                    $dt = new DateTime($last_attendance_departures_date['created_at']);
                                    $date = $dt->format('Y-m-d');
                                    $time = $dt->format('h:i');
                                    $newDateTime = date('a', strtotime($last_attendance_departures_date['created_at'])); // 'a' returns 'am' or 'pm' in lowercase
                                    $newDateTimeType = $newDateTime == 'AM' ? 'صباحآ' : 'مساءآ'; // Correct comparison with lowercase 'am' and 'pm'
                                @endphp
                                ( {{ $date }} )
                                ( {{ $time }} )
                                ( {{ $newDateTimeType }} )
                            </span>
                        </h5>
                    @else
                        <h5 class="text-danger mb-2">أخر تاريخ تم فية رفع الملف :
                            <span class="badge badge-danger">
                                لا يوجد حركات على سحب البصمه
                            </span>
                        </h5>
                    @endif







                    <div id="ajax_responce_serachDiv" class="table-responsive mt-3">
                        @if (@isset($data) && !@empty($data))
                            <table id="example1" class="table table-bordered table-striped table-hover">
                                <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>صورة</th>
                                        <th>كود بصمة الموظف</th>
                                        <th>كود الموظف</th>
                                        <th>أسم الموظف</th>
                                        <th>الفرع</th>
                                        <th>الأدارة</th>
                                        <th>الوظيفه</th>
                                        <th>الحالة</th>
                                        @if ($finance_cln_periods_data['is_open'] == 1)
                                            <th style="width: 150px">العمليات</th>
                                        @else
                                            <th style="width: 150px">العمليات</th>
                                        @endif
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $i = 0; ?>
                                    @foreach ($data as $info)
                                        <?php $i++; ?>
                                        <tr>
                                            <td>{{ $i }}</td>
                                            <td>
                                                @if ($info->employee_photo)
                                                    <img class="img-thumbnail rounded me-2" alt="200x200"
                                                        style="width: 80px; height:50px"
                                                        src="{{ asset('dashboard/assets/uploads/employees/photo/' . $info->employee_photo) }}"
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
                                            <td>{{ $info->employee->fp_code }}</td>
                                            <td>{{ $info->employee_code }}</td>
                                            <td>{{ $info->employee?->name }}</td>
                                            <td>{{ $info->branch->name }}</td>
                                            <td>{{ $info->department->name }}</td>
                                            <td>{{ $info->job?->name }}</td>
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
                                                @can('عرض بصمات الموظفين')
                                                    <div class="dropdown">
                                                        {{-- show --}}
                                                        <a class="btn btn-sm btn-primary btn-small"
                                                            href="{{ route('dashboard.attendanceDepartures.showAttendanceDetails', ['employee_code' => $info->employee_code, 'finance_cln_periods_id' => $finance_cln_periods_data['id']]) }}"><i
                                                                class="fas fa-eye ml-1"></i>عرض بصمات الموظف</a>
                                                    </div>
                                                @endcan
                                            </td>

                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        @else
                            <div class="alert alert-warning" role="alert" dir="rtl">
                                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                                    لعرضها!</span>
                            </div>
                        @endif
                    </div>
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
    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!--Internal  jquery.maskedinput js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery.maskedinput/jquery.maskedinput.js') }}"></script>
    <!--Internal  spectrum-colorpicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/spectrum-colorpicker/spectrum.js') }}"></script>
    <!-- Internal Select2.min js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!--Internal Ion.rangeSlider.min js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/ion-rangeslider/js/ion.rangeSlider.min.js') }}"></script>
    <!--Internal  jquery-simple-datetimepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/amazeui-datetimepicker/js/amazeui.datetimepicker.min.js') }}">
    </script>
    <!-- Ionicons js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-simple-datetimepicker/jquery.simple-dtpicker.js') }}">
    </script>
    <!--Internal  pickerjs js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/pickerjs/picker.min.js') }}"></script>
    <!-- Internal form-elements js -->
    <script src="{{ URL::asset('dashboard/assets/js/form-elements.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/modal.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/sweetalert2.min.js') }}"></script>
    <!-- Internal Data tables -->
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>

    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.buttons.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.bootstrap4.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jszip.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/pdfmake.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/vfs_fonts.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.html5.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.print.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.colVis.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.bootstrap4.min.js') }}"></script>




    <script>
        // بحث عن طريق Ajax
        function ajax_search() {
            var employee_code = $("#employee_code_search").val();
            var branch_id = $("#branch_id_search").val();
            var employee_department_code = $("#employee_department_code_search").val();
            var employee_jobs_id = $("#employee_jobs_id_search").val();
            var cash_visa = $("#cash_visa_search").val();
            var is_stopped = $("#is_stopped_search").val();
            var is_archived = $("#is_archived_search").val();
            var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();



            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.ajax_search', ['employee_code' => $info->employee_code, 'finance_cln_periods_id' => $finance_cln_periods_data['id']]) }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    branch_id: branch_id,
                    employee_department_code: employee_department_code,
                    employee_jobs_id: employee_jobs_id,
                    cash_visa: cash_visa,
                    is_stopped: is_stopped,
                    is_archived: is_archived,
                    the_finance_cln_periods_id: the_finance_cln_periods_id
                },
                success: function(data) {
                    $("#ajax_responce_serachDiv").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ");
                }
            });
        }

        $(document).on('click', '#ajax_pagination_in_search a', function(e) {
            e.preventDefault();
            var employee_code = $("#employee_code_search").val();
            var branch_id = $("#branch_id_search").val();
            var employee_department_code = $("#employee_department_code_search").val();
            var employee_jobs_id = $("#employee_jobs_id_search").val();
            var cash_visa = $("#cash_visa_search").val();
            var is_stopped = $("#is_stopped_search").val();
            var is_archived = $("#is_archived_search").val();
            var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();

            var linkurl = $(this).attr("href");
            jQuery.ajax({
                url: linkurl,
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    branch_id: branch_id,
                    employee_department_code: employee_department_code,
                    employee_jobs_id: employee_jobs_id,
                    cash_visa: cash_visa,
                    is_stopped: is_stopped,
                    is_archived: is_archived,
                    the_finance_cln_periods_id: the_finance_cln_periods_id
                },
                success: function(data) {
                    $("#ajax_responce_serachDiv").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ");
                }
            });
        });

        // Call ajax_search on change of the select elements
        $('#employee_code_search, #branch_id_search,#employee_department_code_search,#employee_jobs_id_search,#cash_visa_search,#is_stopped_search, #is_archived_search')
            .change(function() {
                ajax_search();
            });
    </script>

    <script>
        $('#modaldemo8').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.edit').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.delete').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>

@endsection
