@extends('dashboard.layouts.master')
@section('loans', 'active')
@section('title', 'عرض السلف الموظفين الشهر المالى')
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
                <h5 class="content-title mb-0 my-auto">بيانات السلف الشهرية للموظفين لشهر
                    المالى {{ $finance_cln_periods_data->month->name }}</h5><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;" href="{{ route('dashboard.loans.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> سجلات سلف شهرية للموظفين
                    </a>
                </span>
            </div>
        </div>

        @if ($finance_cln_periods_data['is_open'] == 1)
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                            data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة سلفه جديدة</a>
                    </div>
                </div>
            </div>
        @endif
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
                            بيانات السلف الشهرية لرواتب للشهر المالى (<span
                                class="text-danger ">{{ $finance_cln_periods_data['month']->name }}</span> لسنه
                            {{ $finance_cln_periods_data['finance_yr'] }})
                        </h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>

                </div>
                <form method="POST" action="{{ route('dashboard.loans.print_search') }}" target="_blank">
                    @csrf
                    <input type="hidden" id="the_finance_cln_periods_id" name="the_finance_cln_periods_id"
                        value="{{ $finance_cln_periods_data['id'] }}">

                    <div class="col-10 mx-auto mt-4">

                        <div class="row">
                            <div class=" col-3">
                                <div class="form-group">
                                    <label> بحث بالموظفين </label>
                                    <select name="employee_code_search" id="employee_code_search"
                                        class="form-control select2">
                                        <option value="all">بحث بالكل</option>
                                        @if (@isset($employees_for_search) && !@empty($employees_for_search))
                                            @foreach ($employees_for_search as $emp)
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

                            <div class=" col-3">
                                <div class="form-group">
                                    <label> بحث بحالة الأرشفه </label>
                                    <select name="is_archived_search" id="is_archived_search" class="form-control">
                                        <option value="all">بحث بالكل</option>
                                        <option value="1">مؤرشف</option>
                                        <option value="0">مفتوح</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-2 mg-t-10 mr-5">
                                <label> </label>
                                <button type="post" class="btn btn-outline-light btn-block"> <i class="fas fa-print"></i>
                                    طباعة</button>
                            </div>
                        </div>
                    </div>
                </form>

                <div class="card-body">
                    <div class="table-responsive">
                        @if (isset($data) && $data->isNotEmpty())
                            <div id="ajax_responce_serachDiv" class="table-responsive mt-3">
                                <table id="example1" class="table table-bordered table-striped table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>كود الموظف</th>
                                            <th>أسم الموظف</th>
                                            <th>قيمة السلفه</th>
                                            <th>الملاحظات</th>
                                            <th>الحالة</th>
                                            @if ($finance_cln_periods_data['is_open'] == 1)
                                                <th>العمليات</th>
                                            @endif
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
                                                <td>{{ Str::limit($info->notes, 20) }}</td>
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
                                                @if ($finance_cln_periods_data['is_open'] == 1)
                                                    <td>
                                                        {{-- Edit EditModal --}}
                                                        <button data-id="{{ $info->id }}"
                                                            data-main_salary_employees_id="{{ $info->main_salary_employees_id }}"
                                                            class="modal-effect btn load_edit_this_row btn-outline-info btn-sm"><i
                                                                class="fas fa-edit ml-1"></i></button>


                                                        {{-- Delete --}}
                                                        <a class="modal-effect btn btn-outline-danger btn-sm"
                                                            data-effect="effect-scale" data-toggle="modal"
                                                            href="#delete{{ $info->id }}">
                                                            <i class="fas fa-trash-alt ml-1"></i></a>
                                                        @include('dashboard.salaries.loans.delete')
                                                    </td>
                                                @endif

                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                                <div class="col-md-12 text-center ajax_pagination_in_search">
                                    {{ $data->links('pagination::bootstrap-5') }}
                                </div>
                            </div>
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


    <!-- Add Basic modal -->
    <div class="modal" id="modaldemo8">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-content-demo">
                <div class="modal-header">
                    <h6 class="modal-title">أضافة السلف للموظفين للشهر المالى <span class="text-danger">(
                            {{ $finance_cln_periods_data->year_and_month }} )</span> </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="addModalBody">
                    <div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <label> أسم الموظف </label>
                                <select name="employee_code_add" id="employee_code_add" class="form-control select2"
                                    style="width: 100%;">
                                    <option value="">اختر الموظف</option>
                                    @if (@isset($employees) && !@empty($employees))
                                        @foreach ($employees as $info)
                                            <option value="{{ $info->employee_code }}"
                                                data-sa="{{ $info->EmployeeData['salary'] }}"
                                                data-dp="{{ $info->EmployeeData['day_price'] }}">
                                                {{ $info->EmployeeData['name'] }}
                                                ({{ $info->employee_code }})
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
                                @error('employee_code_add')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group related_employee_add">
                                    <label> راتب الموظف الشهرى</label>
                                    <input type="text" name="salary_add" id="salary_add" value="0"
                                        class="form-control" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group related_employee_add">
                                    <label> أجر اليوم الواحد</label>
                                    <input type="text" name="day_price_add" id="day_price_add" value="0"
                                        class="form-control" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>قيمة السلفه</label>
                                <input autofocus type="text" name="total_add" id="total_add"
                                    oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                                    value="">
                                @error('total')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>ملاحظات</label>
                                <textarea class="form-control" name="notes_add" id="notes_add" placeholder="أكتب ملاحظة" rows="3"></textarea>
                                @error('notes')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="do_add_now" class="btn ripple btn-primary"type="submit" name="submit">تأكيد
                            البيانات</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Add Basic modal -->




    <!-- Edit Basic modal -->
    <div class="modal fade edit" id="EditModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-content-demo">
                <div class="modal-header">
                    <h6 class="modal-title">تعديل السلف الموظفين للشهر المالى <span class="text-danger">(
                            {{ $finance_cln_periods_data->year_and_month }} )</span> </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="EditModalBody">



                </div>
            </div>
        </div>
    </div>
    <!-- Edit Basic modal -->
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
    <!--Internal  Datatable js -->
    {{-- <script src="{{ URL::asset('dashboard/assets/js/table-data.js') }}"></script> --}}

    <script>
        $(document).ready(function() {
            // Initialize Select2 Elements
            $('.select2').select2({
                theme: 'bootstrap4'
            });

            // عرض المرتب و سعر اليوم الواحد عند اختيار الموظف
            $(document).on('change', '#employee_code_add', function(e) {
                if ($(this).val() === "") {
                    $(".related_employee_add").hide();
                    $("#salary_add").val(0);
                    $("#day_price_add").val(0);
                } else {
                    var salary = $("#employee_code_add option:selected").data("sa");
                    var day_price = $("#employee_code_add option:selected").data("dp");
                    $("#salary_add").val(salary * 1);
                    $("#day_price_add").val(day_price * 1);
                    $(".related_employee_add").show();
                }
            });


            // تعديل عرض المرتب و سعر اليوم الواحد عند اختيار الموظف
            $(document).on('change', '#employee_code_edit', function(e) {
                if ($(this).val() === "") {
                    $(".related_employee_edit").hide();
                    $("#salary_edit").val(0);
                    $("#day_price_edit").val(0);
                } else {
                    var salary = $("#employee_code_edit option:selected").data("sa");
                    var day_price = $("#employee_code_edit option:selected").data("dp");
                    $("#salary_edit").val(salary * 1);
                    $("#day_price_edit").val(day_price * 1);
                    $(".related_employee_edit").show();
                }
            });




            // عرض سعر اليوم الواحد
            $(document).on('input', '#value_add', function(e) {
                var value_add = $(this).val();
                if (value_add === "") {
                    value_add = 0;
                }
                var day_price_add = $("#day_price_add").val();
                $("#total_add").val(value_add * day_price_add * 1);
            });


            // تعديل عرض سعر اليوم الواحد
            $(document).on('input', '#value_edit', function(e) {
                var value_edit = $(this).val();
                if (value_edit === "") {
                    value_edit = 0;
                }
                var day_price_edit = $("#day_price_edit").val();
                $("#total_edit").val(value_edit * day_price_edit * 1);
            });


            // Validation and AJAX submission
            $(document).on('click', '#do_add_now', function(e) {
                e.preventDefault();

                var employee_code_add = $("#employee_code_add").val();
                if (employee_code_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك اختر الموظف',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#employee_code_add").focus();
                    return false;
                }

                var value_add = $("#value_add").val();
                if (value_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك ادخل عدد ايام السلف',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#value_add").focus();
                    return false;
                }

                var total_add = $("#total_add").val();
                if (total_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك ادخل اجمالي السلف',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#total_add").focus();
                    return false;
                }

                var notes_add = $("#notes_add").val();
                var day_price = $("#day_price_add").val();
                var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
                // عمل فحص قبل التخزين
                $.ajax({
                    url: '{{ route('dashboard.loans.checkExsistsBefor') }}',
                    type: 'post',
                    dataType: 'json',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        employee_code: employee_code_add,
                        the_finance_cln_periods_id: the_finance_cln_periods_id
                    },
                    success: function(data) {
                        if (data == 'exsists_befor') {
                            $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                            Swal.fire({
                                title: 'تحذير',
                                text: 'يوجد سجل السلف سابق مسجل للموظف هل تريد الاستمرار؟',
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonText: 'نعم',
                                cancelButtonText: 'لا',
                                customClass: {
                                    container: 'swal2-override'
                                }
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    submitSanction();
                                } else {
                                    $('#modaldemo8').modal(
                                        'show'); // إظهار الـ modal مرة أخرى
                                }
                            });
                        } else {
                            submitSanction();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText); // عرض رسالة الخطأ للمراجعة
                        Swal.fire({
                            icon: 'error',
                            title: 'خطأ',
                            text: 'عفوا لقد حدث خطأ في التحقق من السلف السابقة',
                            customClass: {
                                container: 'swal2-override'
                            }
                        }).then(() => {
                            $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                        });
                    }
                });
            });

            // تخزين البيانات
            function submitSanction() {
                var employee_code_add = $("#employee_code_add").val();
                var value_add = $("#value_add").val();
                var total_add = $("#total_add").val();
                var notes_add = $("#notes_add").val();
                var day_price = $("#day_price_add").val();
                var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();

                $('#modaldemo8').modal('hide'); // إخفاء الـ modal قبل بدء طلب AJAX

                $.ajax({
                    url: '{{ route('dashboard.loans.store') }}',
                    type: 'post',
                    dataType: 'html',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        employee_code: employee_code_add,
                        finance_cln_periods_id: the_finance_cln_periods_id,
                        value: value_add,
                        total: total_add,
                        notes: notes_add,
                        day_price: day_price,
                    },
                    success: function(data) {
                        console.log(data); // عرض الاستجابة للمراجعة
                        Swal.fire({
                            icon: 'success',
                            title: 'عملية ناجحه',
                            text: 'تم حفظ السلفة بنجاح',
                            customClass: {
                                container: 'swal2-override'
                            }
                        }).then(() => {
                            setTimeout(function() {
                                location.reload();
                            }, 1000);
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText); // عرض رسالة الخطأ للمراجعة
                        Swal.fire({
                            icon: 'error',
                            title: 'خطأ',
                            text: 'عفوا لقد حدث خطأ',
                            customClass: {
                                container: 'swal2-override'
                            }
                        }).then(() => {
                            $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                        });
                    }
                });
            }
        });
    </script>

    <script>
        // بحث عن طريق Ajax
        function ajax_search() {
            var employee_code = $("#employee_code_search").val();
            var is_archived = $("#is_archived_search").val();
            var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();

            jQuery.ajax({
                url: '{{ route('dashboard.loans.ajax-search') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
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
        $('#employee_code_search, #is_archived_search').change(function() {
            ajax_search();
        });
    </script>


    {{-- Edit --}}

    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '.load_edit_this_row', function(e) {
            var id = $(this).data("id");
            var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
            var main_salary_employees_id = $(this).data("main_salary_employees_id");

            jQuery.ajax({
                url: '{{ route('dashboard.loans.load_edit_row') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                    the_finance_cln_periods_id: the_finance_cln_periods_id,
                    main_salary_employees_id: main_salary_employees_id
                },
                success: function(data) {
                    $("#EditModalBody").html(data);
                    $("#EditModal").modal("show");
                    $('.select2').select2();
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            });
        });

        // تنفيذ عملية التعديل بعد التحقق
        $(document).on('click', '#do_edit_now', function(e) {
            e.preventDefault();

            // تحقق من الحقول المطلوبة
            var employee_code_edit = $("#employee_code_edit").val();
            $('#EditModal').modal('hide'); // إخفاء الـ modal

            if (employee_code_edit === "") {
                return showWarning('من فضلك اختر الموظف', '#employee_code_edit');
            }
            $('#EditModal').modal('show'); // إظهار الـ modal مرة أخرى


            var value_edit = $("#value_edit").val();
            $('#EditModal').modal('hide'); // إخفاء الـ modal

            if (value_edit === "") {
                return showWarning('من فضلك ادخل قيمة السلفة للموظف', '#value_edit');
            }
            $('#EditModal').modal('show'); // إظهار الـ modal مرة أخرى


            var total_edit = $("#total_edit").val();
            $('#EditModal').modal('hide'); // إخفاء الـ modal

            if (total_edit === "") {
                return showWarning('من فضلك ادخل اجمالي السلف', '#total_edit');
            }
            $('#EditModal').modal('show'); // إظهار الـ modal مرة أخرى

            // إذا كانت الحقول كلها مملوءة، استمر بالتعديل
            var id = $(this).data("id");
            var the_finance_cln_periods_id = $("#the_finance_cln_periods_id").val();
            var main_salary_employees_id = $(this).data("main_salary_employees_id");
            var notes_edit = $("#notes_edit").val();
            var day_price = $("#day_price_edit").val();

            jQuery.ajax({
                url: '{{ route('dashboard.loans.do_edit_row') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code_edit,
                    the_finance_cln_periods_id: the_finance_cln_periods_id,
                    main_salary_employees_id: main_salary_employees_id,
                    id: id,
                    value: value_edit,
                    total: total_edit,
                    notes: notes_edit,
                    day_price: day_price
                },
                success: function(data) {
                    $('#EditModal').modal('hide');
                    ajax_search();

                    Swal.fire({
                        icon: 'success',
                        title: 'عملية ناجحة',
                        text: 'تم تعديل السلفة بنجاح',
                        customClass: {
                            container: 'swal2-override'
                        }
                    });

                    // إعادة تحميل الصفحة بعد ثانية واحدة
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                    Swal.fire({
                        icon: 'error',
                        title: 'خطأ',
                        text: 'عفوا لقد حدث خطأ',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then(() => {
                        $('#EditModal').modal('show');
                    });
                }
            });
        });

        // دالة لإظهار رسالة التحذير وإعادة التركيز على الحقل الفارغ
        function showWarning(message, selector) {
            $('#EditModal').modal('hide'); // إخفاء الـ modal
            Swal.fire({
                icon: 'warning',
                title: 'تحذير',
                text: message,
                customClass: {
                    container: 'swal2-override'
                }
            }).then((result) => {
                $('#EditModal').modal('show'); // إظهار الـ modal مرة أخرى
            });
            $(selector).focus();
            return false;
        }
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
