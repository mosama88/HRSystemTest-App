@extends('dashboard.layouts.master')
@section('title', 'بيانات الأجازات المرحله')
<style>
    .table-container {
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .table-responsive {
        border-radius: 8px;
        overflow: hidden;
    }

    .table-bordered {
        border: none;
        /* Remove default border */
        background-color: #ffffff;
    }

    .table-bordered td {
        padding: 15px;
        font-size: 16px;
    }

    .table-bordered .back {
        background-color: #3d7fc5;
        color: white;
        font-weight: bold;
        text-align: center;
        border: none;
    }

    .table-bordered td:nth-child(2) {
        background-color: #88a9ff;
        color: #000000;
        text-align: right;
        font-weight: 500;
    }

    .table-bordered tr {
        border-bottom: 2px solid #dee2e6;
    }

    .table-bordered tr:last-child {
        border-bottom: none;
        /* Remove last border */
    }

    .table-bordered td:hover {
        background-color: #f1f1f1;
        color: black;
        transition: background-color 0.3s ease;
    }
</style>
@section('css')
    <!--- Internal Select2 css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Fileupload css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/fileuploads/css/fileupload.css') }}" rel="stylesheet"
        type="text/css" />
    <!---Internal Fancy uploader css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/fancyuploder/fancy_fileupload.css') }}" rel="stylesheet" />
    <!--Internal Sumoselect css-->
    <link rel="stylesheet" href="{{ URL::asset('dashboard/assets/plugins/sumoselect/sumoselect-rtl.css') }}">
    <!--Internal  TelephoneInput css-->
    <link rel="stylesheet" href="{{ URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput-rtl.css') }}">


    <style>
        .flatpickr-month {
            height: 50px !important;
        }
    </style>

    @php
        use Carbon\Carbon;
    @endphp
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">عرض الرصيد السنوى للموظف </h5><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/ <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.vacationsBalance.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول رصيد الأجازات
                    </a></span>
            </div>
        </div>
        <div class="d-flex my-xl-auto right-content">


        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row">
        <div class="col-xl-12">
            <!-- div -->
            <div class="card mg-b-20" id="tabs-style2">
                <div class="card-body">
                    @include('dashboard.messages_alert')


                    @if ($errors->any())
                        @foreach ($errors->all() as $error)
                            <div class="alert alert-danger text-center">
                                {{ $error }}
                            </div>
                        @endforeach
                    @endif
                    <div class="main-content-label mg-b-5">
                        {{--  --}}
                        <a target="_blank" href="{{ route('dashboard.employees.edit', $data->id) }}" class="btn btn-info ">
                            <i class="fas fa-edit ml-1"></i> تعديل</a>

                        <a target="_blank" href="{{ route('dashboard.employees.show', $data->id) }}"
                            class="btn btn-secondary">
                            <i class="fas fa-eye ml-1"></i> عرض</a>
                    </div>
                    <p class="mg-b-20"></p>
                    <div class="text-wrap">
                        <div class="example">
                            <div class="panel panel-primary tabs-style-2">
                                <div class=" tab-menu-heading">
                                    <div class="tabs-menu1">
                                        <!-- Tabs -->
                                        <ul class="nav panel-tabs main-nav-line">
                                            <li><a href="#tab4" class="nav-link" data-toggle="tab">بيانات
                                                    شخصية</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="panel-body tabs-menu-body main-content-body-right border">
                                    <div class="tab-content">
                                        {{-- بيانات شخصية --}}
                                        <div class="tab-pane" id="tab4">



                                            <div class="table-container">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered mg-b-0 text-md-nowrap">
                                                        <tr>
                                                            <td class="wd-300 back">كود الموظف</td>
                                                            <td>{{ $data['employee_code'] }}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">كود بصمة الموظف</td>
                                                            <td>{{ $data['fp_code'] }}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">اسم الموظف</td>
                                                            <td>{{ $data['name'] }}</td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ التعيين</td>
                                                            <td>{{ $data['work_start_date'] }}</td>
                                                        </tr>


                                                        <tr>
                                                            <td class="wd-300 back">الفرع التابع له الموظف</td>
                                                            <td>{{ $data->branch->name }} </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back"> الادارة التابع لها الموظف</td>
                                                            <td>{{ $data->department->name }}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">الحالة الوظيفية</td>
                                                            <td>
                                                                @if ($data['functional_status'] == 'Employee')
                                                                    موظف
                                                                @else
                                                                    لا يعمل
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">وظيفة الموظف</td>
                                                            <td>{{ $data->jobCategories->name }} </td>
                                                        </tr>


                                                    </table>
                                                </div>
                                            </div>


                                            {{-- End Row --}}
                                        </div>
                                        {{-- End tab --}}
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Container closed -->
        </div>
        <!-- main-content closed -->
    </div>
    <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    </div>
    </div>



























    <!-- Edit Basic modal -->
    <div class="modal fade" id="salaryArchivedModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-content-demo">
                <div class="modal-header">
                    <h6 class="modal-title">عرض الراتب المؤرشف</h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="showSalaryArchivedBody">
                    <!-- المحتوى المؤرشف هنا -->
                </div>
            </div>
        </div>
    </div>
    <!-- Edit Basic modal -->





    <!-- Scroll modal -->
    <div class="modal" id="modaleditAllowance">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-content-demo">
                <div class="modal-header">
                    <h6 class="modal-title">تعديل البدل ثابت جديد</h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modaleditAllowanceBody">




                </div>
            </div>
        </div>
    </div>
    <!--End Scroll modal -->






    <!-- main-content closed -->
@endsection
@section('js')

    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!--Internal Fileuploads js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/fileuploads/js/fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fileuploads/js/file-upload.js') }}"></script>
    <!--Internal Fancy uploader js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.ui.widget.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.iframe-transport.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fancy-fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/fancy-uploader.js') }}"></script>
    <!--Internal  Form-elements js-->
    <script src="{{ URL::asset('dashboard/assets/js/advanced-form-elements.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/select2.js') }}"></script>
    <!--Internal Sumoselect js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/sumoselect/jquery.sumoselect.js') }}"></script>
    <!-- Internal TelephoneInput js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/telephoneinput/inttelephoneinput.js') }}"></script>
    <!-- Internal Modal js-->
    <script src="{{ URL::asset('dashboard/assets/js/modal.js') }}"></script>

    <!-- JavaScript -->
    <script>
        // تخزين الـ tab النشط في localStorage عند تغييره
        document.querySelectorAll('.nav-link').forEach(function(tab) {
            tab.addEventListener('click', function() {
                localStorage.setItem('activeTab', this.getAttribute('href'));
            });
        });

        // استرجاع الـ tab النشط عند إعادة تحميل الصفحة
        document.addEventListener('DOMContentLoaded', function() {
            let activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                document.querySelector(`a[href="${activeTab}"]`).classList.add('active');
                document.querySelector(activeTab).classList.add('active');
            } else {
                document.querySelector('.nav-link').classList.add('active');
                document.querySelector('.tab-pane').classList.add('active');
            }
        });
    </script>

    <script>
        $('#modaldemo8').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
        $('#modaleditAllowance').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.DeleteAllownce').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>

    <script>
        $(document).on('click', '#do_add_allowance', function(e) {

            var allowance_id = $("#allowance_id").val();
            if (allowance_id === "") {
                $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                Swal.fire({
                    icon: 'warning',
                    title: 'تحذير',
                    text: 'من فضلك أختر البدل الثابت',
                    customClass: {
                        container: 'swal2-override'
                    }
                }).then((result) => {
                    $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                });
                $("#allowance_id").focus();
                return false;
            }

            var allowance_value = $("#allowance_value").val();
            if (allowance_value === "" || allowance_value == 0) {
                $('#modaldemo8').modal('hide'); // إخفاء الـ modal
                Swal.fire({
                    icon: 'warning',
                    title: 'تحذير',
                    text: 'من فضلك أدخل قيمة البدل الثابت',
                    customClass: {
                        container: 'swal2-override'
                    }
                }).then((result) => {
                    $('#modaldemo8').modal('show'); // إظهار الـ modal مرة أخرى
                });
                $("#allowance_value").focus();
                return false;
            }

        });
    </script>


    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '.load_edit_this_allowances', function(e) {
            var id = $(this).data("id");
            jQuery.ajax({
                url: '{{ route('dashboard.employees.load_edit_allowances') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,

                },
                success: function(data) {
                    $("#modaleditAllowanceBody").html(data);
                    $("#modaleditAllowance").modal("show");
                    $('.select2').select2();
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            });
        });
    </script>


    <script>
        $(document).on('click', '#do_edit_allowance', function(e) {


            var value_edit = $("#value_edit").val();
            if (value_edit === "" || value_edit == 0) {
                $('#modaleditAllowance').modal('hide'); // إخفاء الـ modal
                Swal.fire({
                    icon: 'warning',
                    title: 'تحذير',
                    text: 'من فضلك أدخل قيمة البدل الثابت',
                    customClass: {
                        container: 'swal2-override'
                    }
                }).then((result) => {
                    $('#modaleditAllowance').modal('show'); // إظهار الـ modal مرة أخرى
                });
                $("#value_edit").focus();
                return false;
            }

        });
    </script>


    <script>
        // تحميل بيانات السطر للتعديل
        $(document).on('click', '.showSalaryArchived', function(e) {
            var id = $(this).data("id");
            jQuery.ajax({
                url: '{{ route('dashboard.employees.showSalaryArchived') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id,
                },
                success: function(data) {
                    $("#showSalaryArchivedBody").html(data);
                    $("#showSalaryArchived").modal("show");
                    $('.select2').select2();
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }
            });
        });
    </script>

@endsection
