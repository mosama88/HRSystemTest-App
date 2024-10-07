@extends('dashboard.layouts.master')
@section('title', 'عرض السلف المستديمة الموظفين الشهر المالى')
@section('css')
    <style>
        .modal-dialog.modal-fullscreen {
            max-width: 90%;
            margin: auto;
        }
    </style>
    <!-- Internal Data table css -->
    <!---Internal  Prism css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/prism/prism.css') }}" rel="stylesheet">
    <!--- Custom-scroll -->
    <link href="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.css') }}" rel="stylesheet">


    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!---Internal  Multislider css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/multislider/multislider.css') }}" rel="stylesheet">
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/css/sweetalert2.min.css') }}" rel="stylesheet">

    <!-- رابط CSS لمكتبة Flatpickr -->
    <link href="{{ URL::asset('dashboard/assets/js/projects/flatpickr.min.css') }}" rel="stylesheet">

    <style>
        .flatpickr-month {
            height: 50px !important;
        }
    </style>

@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">بيانات السلف المستديمة للموظفين </h5>
            </div>
        </div>


        <div class="d-flex my-xl-auto right-content">
            <div class="mb-3 mb-xl-0">
                <div class="btn-group dropdown">
                    <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                        data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة سلفة مستديمة
                        للموظفين</a>
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
                            بيانات السلف المستديمة
                        </h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>

                </div>


                <input type="hidden" value="@php echo date('Y-m-d'); @endphp" id="the_today_date">

                <form method="POST" action="{{ route('dashboard.permanentLoan.print_search') }}" target="_blank">
                    @csrf
                    <div class="col-10 mx-auto mt-4">
                        <div class="row">
                            <div class=" col-3">
                                <div class="form-group">
                                    <label> بحث بالموظفين </label>
                                    <select name="employee_code" id="employee_code_search" class="form-control select2">
                                        <option value="all">بحث بالكل</option>
                                        @if (@isset($other['employees']) && !@empty($other['employees']))
                                            @foreach ($other['employees'] as $emp)
                                                <option value="{{ $emp->employee_code }}">{{ $emp->name }} / كود الموظف
                                                    ({{ $emp->employee_code }})
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
                                    <label> بحث بحالة الصرف </label>
                                    <select name="has_disbursed_done" id="has_disbursed_done_search" class="form-control">
                                        <option value="all">بحث بالكل</option>
                                        <option value="1">تم الصرف</option>
                                        <option value="0">بإنتظار الصرف</option>
                                    </select>
                                </div>
                            </div>

                            <div class=" col-3">
                                <div class="form-group">
                                    <label> بحث بحالة الأرشفه </label>
                                    <select name="is_archived" id="is_archived_search" class="form-control">
                                        <option value="all">بحث بالكل</option>
                                        <option value="1">مؤرشف</option>
                                        <option value="0">مفتوح</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-2 mg-t-10 mr-5">
                                <label> </label>
                                <button type="post" class="btn btn-outline-light btn-block">
                                    <i class="fas fa-print"></i> طباعة</button>
                            </div>
                        </div>
                    </div>
                </form>

                <div class="card-body">
                    <div class="table-responsive">
                        @if (isset($data) && $data->isNotEmpty())
                            <div id="ajax_responce_serachDiv" class="table-responsive mt-3">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>كود الموظف</th>
                                            <th>أسم الموظف</th>
                                            <th>قيمة السلفة </th>
                                            <th>عدد شهور الأقساط</th>
                                            <th>قيمة القسط </th>
                                            <th>يبدأ سداد أول قسط فى تاريخ</th>
                                            <th>هل صرفت</th>
                                            <th>المتبقى</th>
                                            <th>المدفوع</th>
                                            <th> هل الأقساط أنتهت</th>
                                            <th>الملاحظات</th>
                                            <th>العمليات</th>
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
                                                <td>{{ $info->month_number_installment }}</td>
                                                <td>{{ $info->month_installment_value * 1 }}</td>
                                                <td>{{ $info->year_month_start_date }}</td>
                                                <td>
                                                    <div>
                                                        @if ($info->has_disbursed_done == 1)
                                                            <span class="badge badge-primary">نعم</span>
                                                        @else
                                                            <div class="d-flex align-items-center">
                                                                <span class="badge badge-danger">لا</span>
                                                                <div>


                                                                    <button
                                                                        class=" wd-100 btn btn-success btn-with-icon btn-sm mr-2"
                                                                        data-effect="effect-scale" data-toggle="modal"
                                                                        href="#disbursed_done_now{{ $info->id }}"style="height:30px"><i
                                                                            class="fas fa-check-double ml-1"></i> صرف
                                                                        الأن </a>
                                                                    </button>
                                                                </div>
                                                                @include('dashboard.salaries.permanentLoan.disbursed_done_now')

                                                            </div>
                                                        @endif
                                                    </div>
                                                </td>
                                                <td>{{ $info->installment_remain * 1 }}</td>
                                                <td>{{ $info->installment_paid * 1 }}</td>

                                                <td>
                                                    @if ($info->is_archived == 1)
                                                        <span class="badge badge-primary">نعم</span>
                                                    @else
                                                        <span class="badge badge-danger">لا</span>
                                                    @endif
                                                </td>
                                                <td>{{ Str::limit($info->notes, 20) }}</td>

                                                <td class="col-2">
                                                    <div class="dropdown">
                                                        <button aria-expanded="false" aria-haspopup="true"
                                                            class="btn ripple btn-sm btn-primary dropdown-toggle"
                                                            data-toggle="dropdown" id="dropdownMenuButton"
                                                            type="button">العمليات <i class="fas ml-1"></i></button>

                                                        <div class="dropdown-menu tx-13"
                                                            aria-labelledby="dropdownMenuButton">
                                                            <!-- Details EditModal -->
                                                            <button data-id="{{ $info->id }}"
                                                                class="dropdown-item d-flex text-primary align-items-center load_installment_details"
                                                                data-effect="effect-scale" data-toggle="modal">
                                                                <i class="fas fa-eye ml-2"></i>تفاصيل السلفه
                                                            </button>
                                                            {{-- @if ($info->has_disbursed_done == 0) --}}
                                                            <!-- Edit EditModal -->
                                                            <button data-id="{{ $info->id }}"
                                                                class="dropdown-item d-flex text-info align-items-center load_edit_this_row">
                                                                <i class="fas fa-edit ml-2"></i>تعديل
                                                            </button>
                                                            <!-- Delete -->
                                                            <button
                                                                class="dropdown-item d-flex align-items-center text-danger"
                                                                data-effect="effect-scale" data-toggle="modal"
                                                                href="#delete{{ $info->id }}">
                                                                <i class="fas fa-trash-alt ml-2"></i>حذف
                                                            </button>
                                                            {{-- @endif --}}
                                                        </div>
                                                    </div>

                                                    @include('dashboard.salaries.permanentLoan.delete')
                                                </td>

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
                    <h6 class="modal-title">أضافة سلفة مستديمة للموظفين</h6>
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
                                    @if (@isset($other['employees']) && !@empty($other['employees']))
                                        @foreach ($other['employees'] as $info)
                                            <option value="{{ $info['employee_code'] }}" data-sa="{{ $info['salary'] }}"
                                                data-dp="{{ $info['day_price'] }}">
                                                {{ $info['name'] }}
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
                                    <input type="text" name="employee_salary_add" id="employee_salary_add"
                                        value="0" class="form-control" readonly>
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
                                <label>أجمالى قيمة السلفة المستديمة</label>
                                <input autofocus type="text" name="total_add" id="total_add"
                                    oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                                    value="">
                                @error('total')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>عدد شهور الأقساط</label>
                                <input autofocus type="text" name="month_number_installment_add"
                                    id="month_number_installment_add"
                                    oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                                    value="">
                                @error('month_number_installment')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>قيمة القسط الشهرى</label>

                                <input autofocus type="text" name="month_installment_value_add"
                                    id="month_installment_value_add" readonly
                                    oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="form-control"
                                    value="0">
                                @error('month_installment_value')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>يبدأ سداد أول قسط فى تاريخ</label>
                                <!-- حقل إدخال التاريخ -->
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                    </div>
                                    <input type="text" name="year_month_start_date_add" id="year_month_start_date_add"
                                        placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent"
                                        value="{{ old('year_month_start_date_add') }}">
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-dark"
                                            onclick="document.getElementById('year_month_start_date_add')._flatpickr.clear()"><i
                                                class="fa fa-times"></i> محو</button>
                                    </div>
                                </div>
                                @error('year_month_start_date_add')
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
                    <h6 class="modal-title">تعديل السلف الموظفين للشهر المالى</h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="EditModalBody">



                </div>
            </div>
        </div>
    </div>
    <!-- Edit Basic modal -->


    <!-- Details Basic modal -->
    <div class="modal fade" id="loadInstallmentDetailsModal">
        <div class="modal-dialog modal-dialog-centered modal-fullscreen" role="document">
            <div class="modal-content text-center">
                <div class="modal-header">
                    <h6 class="modal-title">عرض تفاصيل أقساط سلفه مستديمة لـ
                        <span class="text-danger">{{ $info->emp_name }}</span>
                    </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="loadInstallmentDetailsModalBody">
                    <!-- سيتم تحميل تفاصيل الأقساط هنا -->
                </div>
            </div>
        </div>

    </div>
    </div>




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



    <!-- رابط JavaScript لمكتبة Flatpickr -->
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr-ar.js') }}"></script>


    <script>
        flatpickr('#year_month_start_date_add', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });
    </script>

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
                    $("#employee_salary_add").val(0);
                    $("#day_price_add").val(0);
                } else {
                    var salary = $("#employee_code_add option:selected").data("sa");
                    var day_price = $("#employee_code_add option:selected").data("dp");
                    $("#employee_salary_add").val(salary * 1);
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



            function recalculate_add_permanent_installment() {
                var total_add = $("#total_add").val();
                if (total_add == "") {
                    total_add = 0;
                }
                var month_number_installment_add = $("#month_number_installment_add").val();
                if (month_number_installment_add == "") {
                    month_number_installment_add = 0;
                }

                if (total_add != 0 && month_number_installment_add != 0) {
                    var month_installment_value_add = parseFloat(total_add) / parseFloat(
                        month_number_installment_add);
                    $("#month_installment_value_add").val(month_installment_value_add.toFixed(2) * 1);
                } else {
                    $("#month_installment_value_add").val(0);
                }
            }

            // Trigger the recalculation on input changes
            $(document).on('input', '#total_add', function(e) {
                recalculate_add_permanent_installment();
            });

            $(document).on('input', '#month_number_installment_add', function(e) {
                recalculate_add_permanent_installment();
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

                var total_add = $("#total_add").val();
                if (total_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك ادخل اجمالي السلف المستديمة',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#total_add").focus();
                    return false;
                }

                var month_number_installment_add = $("#month_number_installment_add").val();
                if (month_number_installment_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك أدخل عدد شهور الأقساط',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#month_number_installment_add").focus();
                    return false;
                }

                var year_month_start_date_add = $("#year_month_start_date_add").val();
                if (year_month_start_date_add === "") {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'من فضلك اختر تاريخ سداد أول قسط',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then((result) => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#year_month_start_date_add").focus();
                    return false;
                }


                // احصل على تاريخ اليوم من الحقل المخفي
                var theTodayDate = $("#the_today_date").val();
                var yearMonthStartDate = $("#year_month_start_date_add").val();

                if (yearMonthStartDate < theTodayDate) {
                    $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                    Swal.fire({
                        icon: 'warning',
                        title: 'تحذير',
                        text: 'يرجى اختيار تاريخ اليوم أو تاريخ لاحق له',
                        customClass: {
                            container: 'swal2-override'
                        }
                    }).then(() => {
                        $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                    });
                    $("#year_month_start_date_add").focus();
                    return false;
                }



                var notes_add = $("#notes_add").val();
                var day_price = $("#day_price_add").val();
                // عمل فحص قبل التخزين
                $.ajax({
                    url: '{{ route('dashboard.permanentLoan.checkExsistsBefor') }}',
                    type: 'post',
                    dataType: 'json',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        employee_code: employee_code_add,
                    },
                    success: function(data) {
                        if (data == 'exsists_befor') {
                            $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                            Swal.fire({
                                title: 'تحذير',
                                text: 'يوجد سلفه مستديمة مفتوحة للموظف هل تريد الاستمرار؟',
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
                            text: 'عفوا لقد حدث خطأ في التحقق من السلف المستديمة السابقة',
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
                var employee_salary_add = $("#employee_salary_add").val(); // تأكد من صحة هذا المتغير
                var total_add = $("#total_add").val();
                var month_number_installment_add = $("#month_number_installment_add").val();
                var month_installment_value_add = $("#month_installment_value_add").val();
                var year_month_start_date_add = $("#year_month_start_date_add").val();
                var notes_add = $("#notes_add").val();



                $('#modaldemo8').modal('hide'); // إخفاء الـ modal قبل بدء طلب AJAX

                $.ajax({
                    url: '{{ route('dashboard.permanentLoan.store') }}',
                    type: 'post',
                    dataType: 'html',
                    cache: false,
                    data: {
                        "_token": '{{ csrf_token() }}',
                        employee_code: employee_code_add,
                        employee_salary: employee_salary_add, // تأكد من اسم المتغير هنا
                        total: total_add,
                        month_number_installment: month_number_installment_add,
                        month_installment_value: month_installment_value_add,
                        year_month_start_date: year_month_start_date_add,
                        notes: notes_add,
                    },
                    success: function(data) {
                        console.log(data); // عرض الاستجابة للمراجعة
                        Swal.fire({
                            icon: 'success',
                            title: 'عملية ناجحه',
                            text: 'تم حفظ السلف المستديمة بنجاح',
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
        $(document).on('click', '.load_edit_this_row', function(e) {
            var id = $(this).data("id");

            jQuery.ajax({
                url: '{{ route('dashboard.permanentLoan.load_edit_row') }}',
                type: 'post',
                dataType: 'json',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                },
                success: function(response) {
                    if (response.error) {
                        $('#EditModal').modal('hide');

                        Swal.fire({
                            icon: 'error',
                            title: 'عفوا',
                            text: response.error,
                            customClass: {
                                container: 'swal2-override'
                            }
                        });
                    } else {
                        $("#EditModalBody").html(response.html);
                        $("#EditModal").modal("show");
                        $('.select2').select2();
                    }
                },
                error: function() {
                    $('#EditModal').modal('hide');

                    Swal.fire({
                        icon: 'error',
                        title: 'عفوا',
                        text: 'لقد حدث خطأ',
                        customClass: {
                            container: 'swal2-override'
                        }
                    });
                }
            });
        });




        // تنفيذ عملية التعديل بعد التحقق
        $(document).on('click', '#do_edit_now', function(e) {
            e.preventDefault();

            // تحقق من الحقول المطلوبة
            var employee_code_edit = $("#employee_code_edit").val();
            if (employee_code_edit === "") {
                return showWarning('من فضلك اختر الموظف', '#employee_code_edit');
            }

            var total_edit = $("#total_edit").val();
            if (total_edit === "") {
                return showWarning('من فضلك ادخل اجمالي السلف المستديمة', '#total_edit');
            }

            var month_number_installment_edit = $("#month_number_installment_edit").val();
            if (month_number_installment_edit === "") {
                return showWarning('من فضلك أدخل عدد شهور الأقساط', '#month_number_installment_edit');
            }

            var year_month_start_date_edit = $("#year_month_start_date_edit").val();
            var theTodayDate = $("#the_today_date").val();
            if (year_month_start_date_edit === "") {
                return showWarning('من فضلك اختر تاريخ سداد أول قسط', '#year_month_start_date_edit');
            } else if (year_month_start_date_edit < theTodayDate) {
                return showWarning('يرجى اختيار تاريخ اليوم أو تاريخ لاحق له', '#year_month_start_date_edit');
            }

            // إذا كانت الحقول كلها مملوءة، استمر بالتعديل
            var id = $(this).data("id");
            var notes_edit = $("#notes_edit").val();
            var employee_salary_edit = $("#employee_salary_edit").val();
            var month_installment_value_edit = $("#month_installment_value_edit").val();

            jQuery.ajax({
                url: '{{ route('dashboard.permanentLoan.do_edit_row') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                    employee_code: employee_code_edit,
                    employee_salary: employee_salary_edit,
                    total: total_edit,
                    month_number_installment: month_number_installment_edit,
                    month_installment_value: month_installment_value_edit,
                    year_month_start_date: year_month_start_date_edit,
                    notes: notes_edit,
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
                $(selector).focus(); // التركيز على الحقل الفارغ
            });
            return false;
        }
    </script>



    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '.load_installment_details', function(e) {
            var id = $(this).data("id");

            $.ajax({
                url: '{{ route('dashboard.permanentLoan.load_installment_details') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                },
                success: function(data) {
                    $("#loadInstallmentDetailsModalBody").html(data);
                    $("#loadInstallmentDetailsModal").modal("show");
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            });
        });
    </script>


    <script>
        // بحث عن طريق Ajax
        function ajax_search() {
            var employee_code = $("#employee_code_search").val();
            var is_archived = $("#is_archived_search").val();
            var has_disbursed_done = $("#has_disbursed_done_search").val();

            jQuery.ajax({
                url: '{{ route('dashboard.permanentLoan.ajax-search') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    employee_code: employee_code,
                    is_archived: is_archived,
                    has_disbursed_done: has_disbursed_done,
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
            var has_disbursed_done = $("#has_disbursed_done_search").val();


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
                    has_disbursed_done: has_disbursed_done,
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
        $('#employee_code_search,#has_disbursed_done_search, #is_archived_search').change(
            function() {
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

        $('#loadInstallmentDetailsModal').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>
    <script>
        $(document).ready(function() {
            $(document).on('click', '.doSingleCachPayNow', function(e) {
                e.preventDefault(); // منع الإجراء الافتراضي

                // إخفاء المودال الحالي قبل عرض رسالة التنبيه
                $('#loadInstallmentDetailsModal').modal('hide');

                Swal.fire({
                    title: 'هل أنت متأكد؟',
                    text: "لن تتمكن من التراجع عن هذا الإجراء!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'نعم',
                    cancelButtonText: 'لا',
                    customClass: {
                        container: 'swal2-override' // يمكنك تخصيص المظهر باستخدام CSS هنا إذا لزم الأمر
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        var id = $(this).data("id");
                        var idParent = $(this).data("idparent");

                        // طلب للتحقق من السلف المستديمة
                        jQuery.ajax({
                            url: '{{ route('dashboard.permanentLoan.doSingleCachPayNow') }}',
                            type: 'post',
                            dataType: 'json',
                            cache: false,
                            data: {
                                "_token": '{{ csrf_token() }}',
                                id: id,
                                idparent: idParent
                            },
                            success: function(data) {
                                // تحميل تفاصيل القسط
                                jQuery.ajax({
                                    url: '{{ route('dashboard.permanentLoan.load_installment_details') }}',
                                    type: 'post',
                                    dataType: 'html',
                                    cache: false,
                                    data: {
                                        "_token": '{{ csrf_token() }}',
                                        id: idParent
                                    },
                                    success: function(data) {
                                        $("#loadInstallmentDetailsModalBody")
                                            .html(data);
                                        $("#loadInstallmentDetailsModal")
                                            .modal("show");
                                    },
                                    error: function(xhr, status, error) {
                                        console.error(xhr
                                            .responseText
                                        ); // عرض رسالة الخطأ للمراجعة
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'خطأ',
                                            text: 'عفوا لقد حدث خطأ في التحقق من السلف المستديمة السابقة',
                                            customClass: {
                                                container: 'swal2-override'
                                            }
                                        }).then(() => {
                                            $('#modaldemo8').modal(
                                                'show'
                                            ); // إظهار الـ modal مرة أخرى
                                        });
                                    }
                                });
                            },
                            error: function(xhr, status, error) {
                                console.error(xhr
                                    .responseText); // عرض رسالة الخطأ للمراجعة
                                Swal.fire({
                                    icon: 'error',
                                    title: 'خطأ',
                                    text: 'عفوا لقد حدث خطأ في التحقق من السلف المستديمة السابقة',
                                    customClass: {
                                        container: 'swal2-override'
                                    }
                                }).then(() => {
                                    $('#modaldemo8').modal(
                                        'show'); // إظهار الـ modal مرة أخرى
                                });
                            }
                        });
                    } else {
                        // إلغاء الإجراء
                        return false;
                    }
                });
            });
        });
    </script>


@endsection
