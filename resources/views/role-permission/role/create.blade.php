@extends('dashboard.layouts.master')
@section('title', 'أضافة صلاحيات`')
@section('css')

    <!-- Internal Select2 css -->
    <link href="{{URL::asset('dashboard/assets/plugins/select2/css/select2.min.css')}}" rel="stylesheet">
    <!--Internal  Datetimepicker-slider css -->
    <link href="{{URL::asset('dashboard/assets/plugins/amazeui-datetimepicker/css/amazeui.datetimepicker.css')}}" rel="stylesheet">
    <link href="{{URL::asset('dashboard/assets/plugins/jquery-simple-datetimepicker/jquery.simple-dtpicker.css')}}" rel="stylesheet">
    <link href="{{URL::asset('dashboard/assets/plugins/pickerjs/picker.min.css')}}" rel="stylesheet">
    <!-- Internal Spectrum-colorpicker css -->
    <link href="{{URL::asset('dashboard/assets/plugins/spectrum-colorpicker/spectrum.css')}}" rel="stylesheet">
    <!---Internal Fileupload css-->
    <link href="{{URL::asset('dashboard/assets/plugins/fileuploads/css/fileupload.css')}}" rel="stylesheet" type="text/css"/>
    <!---Internal Fancy uploader css-->
    <link href="{{URL::asset('dashboard/assets/plugins/fancyuploder/fancy_fileupload.css')}}" rel="stylesheet" />
    <!--Internal Sumoselect css-->
    <link rel="stylesheet" href="{{URL::asset('dashboard/assets/plugins/sumoselect/sumoselect-rtl.css')}}">
    <!--Internal  TelephoneInput css-->
    <link rel="stylesheet" href="{{URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput-rtl.css')}}">
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">الصلاحيات</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ أضافة صلاحيات</span>
            </div>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12">

                @if ($errors->any())
                    <ul class="alert alert-warning">
                        @foreach ($errors->all() as $error)
                            <li>{{$error}}</li>
                        @endforeach
                    </ul>
                @endif

                <div class="card">
                    <div class="card-header">
                        <h4>إنشاء صلاحية
                        </h4>
                    </div>
                    <div class="card-body">
                        <form action="{{ url('roles') }}" method="POST">
                            @csrf

                            <div class="mb-3">
                                <label for="">أسم الصلاحية</label>
                                <input type="text" name="name" class="form-control" />
                            </div>
                            {{-- Submit --}}
                            <div class="row row-xs wd-xl-80p">
                                <div class="col-sm-6 col-md-3 mg-t-10 mg-md-t-0"><button type="submit"
                                                                                         class="btn btn-success btn-with-icon btn-block"><i class="typcn typcn-edit"></i> تأكيد
                                        البيانات</button>
                                </div>
                                <div class="col-sm-6 col-md-3 mg-t-10 mg-md-t-0"><a
                                        href="{{ url('roles') }}" type="submit"
                                        class="btn btn-info btn-with-icon btn-block"><i
                                            class="typcn typcn-arrow-back-outline"></i> رجوع</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    @endsection

    @section('js')
        <!--Internal  Datepicker js -->
        <script src="{{URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js')}}"></script>
        <!--Internal  jquery.maskedinput js -->
        <script src="{{URL::asset('dashboard/assets/plugins/jquery.maskedinput/jquery.maskedinput.js')}}"></script>
        <!--Internal  spectrum-colorpicker js -->
        <script src="{{URL::asset('dashboard/assets/plugins/spectrum-colorpicker/spectrum.js')}}"></script>
        <!-- Internal Select2.min js -->
        <script src="{{URL::asset('dashboard/assets/plugins/select2/js/select2.min.js')}}"></script>
        <!--Internal Ion.rangeSlider.min js -->
        <script src="{{URL::asset('dashboard/assets/plugins/ion-rangeslider/js/ion.rangeSlider.min.js')}}"></script>
        <!--Internal  jquery-simple-datetimepicker js -->
        <script src="{{URL::asset('dashboard/assets/plugins/amazeui-datetimepicker/js/amazeui.datetimepicker.min.js')}}"></script>
        <!-- Ionicons js -->
        <script src="{{URL::asset('dashboard/assets/plugins/jquery-simple-datetimepicker/jquery.simple-dtpicker.js')}}"></script>
        <!--Internal  pickerjs js -->
        <script src="{{URL::asset('dashboard/assets/plugins/pickerjs/picker.min.js')}}"></script>
        <!-- Internal form-elements js -->
        <script src="{{URL::asset('dashboard/assets/js/form-elements.js')}}"></script>

        <!--Internal Fileuploads js-->
        <script src="{{URL::asset('dashboard/assets/plugins/fileuploads/js/fileupload.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/fileuploads/js/file-upload.js')}}"></script>
        <!--Internal Fancy uploader js-->
        <script src="{{URL::asset('dashboard/assets/plugins/fancyuploder/jquery.ui.widget.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fileupload.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/fancyuploder/jquery.iframe-transport.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fancy-fileupload.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/fancyuploder/fancy-uploader.js')}}"></script>
        <!--Internal  Form-elements js-->
        <script src="{{URL::asset('dashboard/assets/js/advanced-form-elements.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/js/select2.js')}}"></script>
        <!--Internal Sumoselect js-->
        <script src="{{URL::asset('dashboard/assets/plugins/sumoselect/jquery.sumoselect.js')}}"></script>
        <!-- Internal TelephoneInput js-->
        <script src="{{URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput.js')}}"></script>
        <script src="{{URL::asset('dashboard/assets/plugins/telephoneinput/inttelephoneinput.js')}}"></script>

        <script src="{{ asset('dashboard/assets/js/projects/add-users.js') }}"></script>
@endsection
