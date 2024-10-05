@extends('dashboard.layouts.master')
@section('sanctions', 'active')
@section('title', 'بصمة الموظف')
@section('css')
    <style>
        .modal-dialog.modal-fullscreen {
            max-width: 90%;
            margin: auto;
        }
    </style>
    <!-- Internal Data table css -->

    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!---Internal  Multislider css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/multislider/multislider.css') }}" rel="stylesheet">
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/css/sweetalert2.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/css/style-load_active_attendance.css') }}" rel="stylesheet">
@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">بيانات بصمة الموظف للشهر
                    المالى {{ $finance_cln_periods_data->month->name }}</h5><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.attendanceDepartures.show', $finance_cln_periods_data['id']) }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> بيانات بصمة الموظفين بالشهر المالى
                    </a>
                </span>
            </div>
        </div>

        <div class="d-flex my-xl-auto right-content">
            <div class="mb-3 mb-xl-0">
                <div class="btn-group dropdown">

                </div>
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
                        <h4 class="card-title mg-b-0">
                            بيانات بصمة <span class="text-danger">{{ $employee_data['name'] }}</span> كود الموظف <span
                                class="text-danger">( {{ $employee_data['employee_code'] }} )</span> بالشهر
                            المالى(<span class="text-danger ">{{ $finance_cln_periods_data['month']->name }}</span> لسنه
                            {{ $finance_cln_periods_data['finance_yr'] }})
                        </h4>
                        <div class="col-md-3 col-sm-3 col-lg-3">


                            <button style="background-color:#10467d;color:white" data-toggle="dropdown"
                                class="btn btn-primary">تحميل وعرض أرشيف <i
                                    class="icon ion-ios-arrow-down tx-11 mg-l-3"></i></button>
                            <div class="dropdown-menu">
                                @can('تحميل بصمات الموظفين')
                                    <button data-empcode="{{ $employee_data['employee_code'] }}"
                                        data-finclnid="{{ $finance_cln_periods_data['id'] }}"
                                        id="load_active_attendance_departure" class="dropdown-item"><i
                                            class="far fa-arrow-alt-circle-down fa-lg ml-1"></i> تحميل البصمه</button>
                                @endcan
                                @can('عرض سجل أرشيف بصمات الموظفين')
                                    <button id="show_archive_attendance" data-empcode="{{ $employee_data['employee_code'] }}"
                                        data-finclnid="{{ $finance_cln_periods_data['id'] }}" class="dropdown-item"><i
                                            class="fas fa-fingerprint fa-lg ml-1"></i> عرض سجل أرشيف البصمة</button>
                                @endcan

                            </div><!-- dropdown-menu -->






                        </div>

                    </div>
                </div>
                <div class="col-4">
                    <a class="modal-effect btn btn-primary" data-effect="effect-super-scaled" data-toggle="modal"
                        href="#modaldemo8"> <i class="fas fa-info-circle fa-lg ml-1"></i> تفاصيل الموظف</a>
                    @include('dashboard.attendanceDepartures.attendanceDepartures.employeeDetails')
                </div>

                <div class="card-body">
                    <input type="hidden" id="the_finance_cln_periods_id" value="{{ $finance_cln_periods_data['id'] }}">
                    <input type="hidden" id="the_employee_code" value="{{ $employee_data['employee_code'] }}">

                    <div id="ajax_response_searchDiv">

                        {{-- ############## load_active_attendance_departure ################## --}}
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



    <!-- Details Basic modal -->
    <div class="modal fade" id="AttendanceDepartureActionExcelModal">
        <div class="modal-dialog modal-dialog-centered modal-fullscreen" role="document">
            <div class="modal-content text-center">
                <div class="modal-header">

                    <h6 class="modal-title">عرض أرشيف سجلات بصمة
                        <span class="text-danger"> {{ $employee_data['name'] }} </span> كود
                        @if ($employee_data['gender'] == 'Male')
                            الموظف
                        @else
                            الموظفه
                        @endif
                        <span class="text-danger">(
                            {{ $employee_data['employee_code'] }} )</span>
                        كود البصمة
                        <span class="text-danger">(
                            {{ $employee_data['fp_code'] }} )</span>


                    </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="AttendanceDepartureActionExcelBody">
                    <!-- سيتم تحميل تفاصيل الأقساط هنا -->
                </div>
            </div>
        </div>
    </div>

    <!-- End Details Basic modal -->


    <!-- Details Basic modal -->
    <div class="modal fade load_my_actionsStatic" id="load_my_actionsModal">
        <div class="modal-dialog modal-dialog-centered modal-fullscreen" role="document">
            <div class="modal-content text-center">
                <div class="modal-header">
                    <h6 class="modal-title">عرض حركات البصمة باليوم
                        <span class="text-danger"> {{ $employee_data['name'] }} </span> كود
                        @if ($employee_data['gender'] == 'Male')
                            الموظف
                        @else
                            الموظفه
                        @endif <span class="text-danger">(
                            {{ $employee_data['employee_code'] }} )</span>
                        كود البصمة
                        <span class="text-danger">(
                            {{ $employee_data['fp_code'] }} )</span>
                    </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="load_my_actionsBody">
                    <!-- سيتم تحميل تفاصيل الأقساط هنا -->
                </div>
            </div>
        </div>
    </div>

    <!-- End Details Basic modal -->


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

    <!-- Moment js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/raphael/raphael.min.js') }}"></script>
    <!-- Internal Piety js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/peity/jquery.peity.min.js') }}"></script>
    <!-- Internal Chart js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/chart.js/Chart.bundle.min.js') }}"></script>
    {{-- Show Attendance --}}

    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '#show_archive_attendance', function(e) {
            var employee_code = $(this).data("empcode");
            var finance_cln_periods_id = $(this).data("finclnid");

            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.load_fp_archive') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    finance_cln_periods_id: finance_cln_periods_id
                },
                success: function(data) {
                    $("#AttendanceDepartureActionExcelBody").html(data);
                    $("#AttendanceDepartureActionExcelModal").modal("show");
                    $('.select2').select2();
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            })
        });
    </script>
    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '.load_my_actions', function(e) {
            var attendance_departure_id = $(this).data("id");
            var finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
            var employee_code = $("#the_employee_code").val();

            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.load_my_actions') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    finance_cln_periods_id: finance_cln_periods_id,
                    attendance_departure_id: attendance_departure_id
                },
                success: function(data) {
                    $("#load_my_actionsBody").html(data);
                    $("#load_my_actionsModal").modal("show");
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            })
        });
    </script>
    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '#load_active_attendance_departure', function(e) {
            var employee_code = $(this).data("empcode");
            var finance_cln_periods_id = $(this).data("finclnid");

            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.load_active_attendance_departure') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    finance_cln_periods_id: finance_cln_periods_id
                },
                success: function(data) {
                    $("#ajax_response_searchDiv").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            })
        });
    </script>



    <script>
        $(document).on('click', '.make_save_changes_row', function(e) {
            var id = $(this).data("id");
            var variables = $("#variables" + id).val(); // Use # to select by ID
            var cut = $("#cut" + id).val();
            var vacations_types_id = $("#vacations_types_id" + id).val();
            var attendance_delay = $("#attendance_delay" + id).val();
            var early_departure = $("#early_departure" + id).val();
            var permission_hours = $("#permission_hours" + id).val();
            var total_hours = $("#total_hours" + id).val();
            var absence_hours = $("#absence_hours" + id).val();
            var additional_hours = $("#additional_hours" + id).val();
            var finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
            var employee_code = $("#the_employee_code").val();

            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.save_active_attendance_departure') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                    variables: variables,
                    cut: cut,
                    vacations_types_id: vacations_types_id,
                    attendance_delay: attendance_delay,
                    early_departure: early_departure,
                    permission_hours: permission_hours,
                    total_hours: total_hours,
                    absence_hours: absence_hours,
                    additional_hours: additional_hours,
                    employee_code: employee_code,
                    finance_cln_periods_id: finance_cln_periods_id
                },
                success: function(data) {
                    Swal.fire({
                        icon: 'success',
                        title: 'تم حفظ البيانات',
                        text: 'تم حفظ البيانات بنجاح.',
                        timer: 1000, // عرض لمدة 1 ثانية
                        timerProgressBar: true,
                        showConfirmButton: false, // إخفاء زر OK
                        didClose: () => {
                            // عند انتهاء التحذير، نقوم بتنفيذ نقر على زر تحميل البصمة تلقائيًا
                            $("#load_active_attendance_departure").click();
                        }
                    });
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'خطأ!',
                        text: 'عفوا لقد حدث خطأ. الرجاء المحاولة مرة أخرى.',
                        footer: '<span>تفاصيل الخطأ: ' + error + '</span>'
                    });
                }
            })
        });
    </script>


    <script>
        $('#AttendanceDepartureActionExcelModal').modal({
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

        $('.load_my_actionsStatic').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.EmployeeDetails').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>


    <script>
        $(document).on('click', '#zeroResetdate_time_in', function(e) {
            e.preventDefault();
            // مسح قيمة الحقل
            $("#date_time_in_update").val("");
            // إظهار زر undo وإخفاء زر reset
            $("#undozero_date_time_in").removeClass('d-none').show();
            $("#zeroResetdate_time_in").hide();
        });

        $(document).on('click', '#zeroResetdate_time_out', function(e) {
            e.preventDefault();
            // مسح قيمة الحقل
            $("#date_time_out_update").val("");
            // إظهار زر undo وإخفاء زر reset
            $("#undozero_date_time_out").removeClass('d-none').show();
            $("#zeroResetdate_time_out").hide();
        });

        $(document).on('click', '#undozero_date_time_in', function(e) {
            e.preventDefault();
            // استعادة القيمة السابقة من الخاصية data-old
            let oldValue = $("#date_time_in_update").data('old');
            $("#date_time_in_update").val(oldValue);
            // إخفاء زر undo وإظهار زر reset
            $("#undozero_date_time_in").addClass('d-none').hide();
            $("#zeroResetdate_time_in").show();
        });

        $(document).on('click', '#undozero_date_time_out', function(e) {
            e.preventDefault();
            // استعادة القيمة السابقة من الخاصية data-old
            let oldValue = $("#date_time_out_update").data('old');
            $("#date_time_out_update").val(oldValue);
            // إخفاء زر undo وإظهار زر reset
            $("#undozero_date_time_out").addClass('d-none').hide();
            $("#zeroResetdate_time_out").show();
        });
    </script>


    <script>
        $(document).on('click', '#redo_update', function(e) {
            e.preventDefault();

            // احصل على القيم
            var date_time_in = $("#date_time_in_update").val();
            var date_time_out_update = $("#date_time_out_update").val();

            // تحقق من أن وقت الإنصراف ليس أقل من وقت الحضور
            if ((date_time_out_update != "" && date_time_in != "") && date_time_out_update < date_time_in) {
                // إخفاء المودال قبل عرض رسالة SweetAlert
                $('.load_my_actionsStatic').modal('hide');

                // إظهار رسالة SweetAlert
                Swal.fire({
                    icon: 'error',
                    title: 'خطأ',
                    text: 'عفوآ، لا يمكن أن يكون توقيت الإنصراف أقل من توقيت الحضور.',
                    confirmButtonText: 'حسنًا',
                    customClass: {
                        confirmButton: 'btn btn-primary'
                    }
                }).then((result) => {
                    // بعد إغلاق رسالة SweetAlert، إعادة إظهار المودال
                    if (result.isConfirmed) {
                        $('.load_my_actionsStatic').modal('show');
                    }
                });

                return false;
            }

            // تعديل القيم
            var id = $(this).data("id");
            var finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
            var employee_code = $("#the_employee_code").val();

            jQuery.ajax({
                url: '{{ route('dashboard.attendanceDepartures.redo_update_actions') }}',
                type: 'post',
                dataType: 'json',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                    employee_code: employee_code,
                    finance_cln_periods_id: finance_cln_periods_id,
                    date_time_in: date_time_in, // تأكد من استخدام المتغير الصحيح
                    date_time_out: date_time_out_update // تأكد من استخدام المتغير الصحيح
                },
                success: function(data) {
                    // إخفاء المودال عند النجاح
                    $('.load_my_actionsStatic').modal('hide');

                    Swal.fire({
                        icon: 'success',
                        title: 'تم تعديل البيانات',
                        text: 'تم تعديل البيانات بنجاح.',
                        timer: 1000, // عرض لمدة 1 ثانية
                        timerProgressBar: true,
                        showConfirmButton: false // إخفاء زر OK
                    }).then(() => {
                        // إعادة إظهار المودال بعد انتهاء الرسالة
                        $('.load_my_actionsStatic').modal('show');
                    });

                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);

                    // إخفاء المودال عند حدوث الخطأ
                    $('.load_my_actionsStatic').modal('hide');

                    // إظهار رسالة SweetAlert للخطأ
                    Swal.fire({
                        icon: 'error',
                        title: 'خطأ',
                        text: 'عفوا لقد حدث خطأ',
                        confirmButtonText: 'حسنًا',
                        customClass: {
                            container: 'swal2-override',
                            confirmButton: 'btn btn-primary'
                        }
                    }).then((result) => {
                        // عند الضغط على OK في SweetAlert، إعادة إظهار المودال
                        if (result.isConfirmed) {
                            $('.load_my_actionsStatic').modal('show');
                        }
                    });
                }
            });
        });
    </script>




@endsection
