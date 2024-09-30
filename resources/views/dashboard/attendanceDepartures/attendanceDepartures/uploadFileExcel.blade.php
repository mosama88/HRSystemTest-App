@extends('dashboard.layouts.master')
@section('sanctions', 'active')
@section('title', 'عرض جهاز البصمة')
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
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/css/sweetalert2.min.css') }}" rel="stylesheet">
    <style>
        .under-line {
            line-height: 40px;
            /* المسافة بين النص والخط السفلي */
        }
    </style>
@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات جهاز البصمة للشهر
                    المالى {{ $finance_cln_periods_data->month->name }}</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.attendanceDepartures.show', $finance_cln_periods_data['id']) }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> بيانات بصمة الموظفين بالشهر المالى
                    </a>
                </span>
            </div>
        </div>

            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
              
                </div>
            </div>

    </div>
    </div>

    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row">


        <div class="col-lg-10 col-md-12 mx-auto">
            <div class="card p-5">
                <div class="card-body">
                    <div>
                        <h5 class="mb-4 text-right under-line">
                            إرفاق بصمات الموظفين لشهر
                            <strong class="text-danger">( {{ $finance_cln_periods_data->month->name }} )</strong>
                            <span class="d-inline-block">
                                من الفترة
                                <span class="text-danger">( {{ $finance_cln_periods_data['start_date_fp'] }} )</span>
                                إلى
                                <span class="text-danger">( {{ $finance_cln_periods_data['end_date_fp'] }} )</span>
                            </span>

                        </h5>

                        </h6>
                        <h6 class="card-title mb-2">
                            أختر ملف البصمه
                            <span class="text-danger">
                                ( ملاحظة : سيتم إهمال اى بصمة خارج نطاق فترة الشهر المالى )
                            </span>
                        </h6>
                        <p class="text-muted card-sub-title mx-5">


                        </p>
                    </div>


                    <form id="uploadForm"
                        action="{{ route('dashboard.attendanceDepartures.DoUploadFileExcel', $finance_cln_periods_data['id']) }}"
                        method="POST" enctype="multipart/form-data">

                        @csrf

                        <div class="col-sm-12 col-md-12 mb-5">
                            <input type="file" name="excel_file" id="excel_file" class="dropify" data-height="200"
                                accept=".xls,.xlsx" />
                            <div id="excel_file_error" class="alert alert-danger mt-1" style="display:none;"></div>

                        </div>
                        <div class="col-sm-12 col-md-12 text-center">
                            <button class="btn ripple btn-primary" type="submit"> <i class="fas fa-file-upload"></i> أرفق
                                ملف البصمة</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>




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

    <script src="{{ URL::asset('dashboard/assets/js/projects/sweetalert2.min.js') }}"></script>


    <script>
        $(document).ready(function() {
            $('#uploadForm').on('submit', function(e) {
                e.preventDefault();
                let formData = new FormData(this);

                $.ajax({
                    url: $(this).attr('action'),
                    method: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                        // Show success alert with SweetAlert
                        Swal.fire({
                            icon: 'success',
                            title: 'تم رفع الملف بنجاح!',
                            text: 'تم حفظ البيانات بنجاح.',
                            timerProgressBar: true,
                            showConfirmButton: false,
                            timer: 1500
                        }).then(function() {
                            // Redirect to the 'dashboard.attendanceDepartures.show' route after success
                            window.location.href =
                                '{{ route('dashboard.attendanceDepartures.show', $finance_cln_periods_data['id']) }}';
                        });
                    },
                    error: function(xhr) {
                        // Clear previous errors
                        $('#excel_file_error').hide().empty();

                        // Handle validation errors
                        let errors = xhr.responseJSON.errors;
                        if (errors.excel_file) {
                            $('#excel_file_error').text(errors.excel_file[0]).show();
                        }
                    }
                });
            });
        });
    </script>


@endsection
