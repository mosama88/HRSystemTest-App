@extends('dashboard.layouts.master')
@section('title', 'الضبط العام')
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
@endsection



@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">تعديل الضبط العام</h5><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;" href="{{ route('dashboard.generalSettings.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> الضبط العام
                    </a></span>
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
        @if (@isset($data) && !@empty($data))
            <div class="col-xl-12">
                <div class="card mg-b-20">
                    <div class="card-header pb-0">
                        <div class="d-flex justify-content-between">
                            <h4 class="card-title mg-b-0">تعديل جدول الضبط العام</h4>
                            <i class="mdi mdi-dots-horizontal text-gray"></i>
                        </div>
                        {{-- <p class="tx-12 tx-gray-500 mb-2">Example of Valex Bordered Table.. <a href="">Learn more</a></p> --}}
                    </div>
                    <div class="card-body pt-0">
                        @if ($errors->any())
                            @foreach ($errors->all() as $error)
                                <div class="alert alert-danger text-center">
                                    {{ $error }}
                                </div>
                            @endforeach
                        @endif
                        <form action="{{ route('dashboard.generalSettings.update', $data->id) }}" method="POST"
                            enctype="multipart/form-data">
                            @csrf
                            @method('PUT')
                            <div class="my-4">
                                <div class="form-group">
                                    <label>اسم الشركة</label>
                                    <input type="text" name="company_name" id="company_name" class="form-control"
                                        value="{{ old('company_name', $data['company_name']) }}">
                                    @error('company_name')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>هاتف الشركة</label>
                                    <input type="text" name="phons" id="phons" class="form-control"
                                        value="{{ old('phons', $data['phons']) }}" placeholder="ادخل اسم الشركة">
                                    @error('phons')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> عنوان الشركة </label>
                                    <input type="text" name="address" id="address" class="form-control"
                                        value="{{ old('address', $data['address']) }}" placeholder="ادخل عنوان الشركة">
                                    @error('address')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label>بريد الشركة </label>
                                    <input type="text" name="email" id="email" class="form-control"
                                        value="{{ old('email', $data['email']) }}" placeholder="ادخل بريد الشركة">
                                    @error('email')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label>الحد الأقصى لاحتساب عدد ساعات عمل اضافية عند انصراف الموظف واحتساب بصمة الانصراف
                                        و الاستحتسب على انها بصمة حضور شفت جديد</label>
                                    <input type="text" name="max_hours_take_fp_as_addtional"
                                        id="max_hours_take_fp_as_addtional" class="form-control"
                                        value="{{ old('max_hours_take_fp_as_addtional', $data['max_hours_take_fp_as_addtional']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('max_hours_take_fp_as_addtional')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>


                                <div class="form-group">
                                    <label>بعد كام دقيقة نحسب تاخير حضور </label>
                                    <input type="text" name="after_minute_calculate_delay"
                                        id="after_minute_calculate_delay" class="form-control"
                                        value="{{ old('after_minute_calculate_delay', $data['after_minute_calculate_delay']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_minute_calculate_delay')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label>بعد كام دقيقة نحسب انصراف مبكر </label>
                                    <input type="text" name="after_minute_calculate_early_departure"
                                        id="after_minute_calculate_early_departure" class="form-control"
                                        value="{{ old('after_minute_calculate_early_departure', $data['after_minute_calculate_early_departure']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_minute_calculate_early_departure')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label>بعد كام مره تأخير او إنصراف مبكر نخصم ربع يوم</label>
                                    <input type="text" name="after_minute_quarterday" id="after_minute_quarterday"
                                        class="form-control"
                                        value="{{ old('after_minute_quarterday', $data['after_minute_quarterday']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_minute_quarterday')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> بعد كام مرة تأخير او أنصراف مبكر نخصم نص يوم </label>
                                    <input type="text" name="after_time_half_daycut" id="after_time_half_daycut"
                                        class="form-control"
                                        value="{{ old('after_time_half_daycut', $data['after_time_half_daycut']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_time_half_daycut')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>أقل من كام دقيقة فرق بين البصمة الأولى والثانية يتم إهمال البصمة</label>
                                    <input type="text" name="less_than_minute_neglecting_fp"
                                        id="less_than_minute_neglecting_fp" class="form-control"
                                        value="{{ old('less_than_minute_neglecting_fp', $data['less_than_minute_neglecting_fp']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('less_than_minute_neglecting_fp')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> نخصم بعد كام مره تاخير او أنصراف مبكر يوم كامل </label>
                                    <input type="text" name="after_time_allday_daycut" id="after_time_allday_daycut"
                                        class="form-control"
                                        value="{{ old('after_time_allday_daycut', $data['after_time_allday_daycut']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_time_allday_daycut')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> رصيد اجازات الموظف الشهري </label>
                                    <input type="text" name="monthly_vacation_balance" id="monthly_vacation_balance"
                                        class="form-control"
                                        value="{{ old('monthly_vacation_balance', $data['monthly_vacation_balance']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                                    @error('monthly_vacation_balance')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>


                                <div class="form-group">
                                    <label> بعد كام يوم ينزل للموظف رصيد اجازات </label>
                                    <input type="text" name="after_days_begin_vacation" id="after_days_begin_vacation"
                                        class="form-control"
                                        value="{{ old('after_days_begin_vacation', $data['after_days_begin_vacation']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('after_days_begin_vacation')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> الرصيد الاولي المرحل عند تفعيل الاجازات للموظف مثل نزول عشرة ايام ونص بعد
                                        سته
                                        شهور للموظف </label>
                                    <input type="text" name="first_balance_begin_vacation"
                                        id="first_balance_begin_vacation" class="form-control"
                                        value="{{ old('first_balance_begin_vacation', $data['first_balance_begin_vacation']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                                    @error('first_balance_begin_vacation')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> الرصيد الاولي المرحل عند تفعيل الاجازات للموظف مثل نزول عشرة ايام ونص بعد
                                        سته
                                        شهور للموظف </label>
                                    <input type="text" name="sanctions_value_first_absence"
                                        id="sanctions_value_first_absence" class="form-control"
                                        value="{{ old('sanctions_value_first_absence', $data['sanctions_value_first_absence']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('sanctions_value_first_absence')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> قيمة خصم الايام بعد ثاني مرة غياب بدون اذن </label>
                                    <input type="text" name="sanctions_value_second_absence"
                                        id="sanctions_value_second_absence" class="form-control"
                                        value="{{ old('sanctions_value_second_absence', $data['sanctions_value_second_absence']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('sanctions_value_second_absence')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div class="form-group">
                                    <label> قيمة خصم الايام بعد ثالث مرة غياب بدون اذن </label>
                                    <input type="text" name="sanctions_value_thaird_absence"
                                        id="sanctions_value_thaird_absence" class="form-control"
                                        value="{{ old('sanctions_value_thaird_absence', $data['sanctions_value_thaird_absence']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('sanctions_value_thaird_absence')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>


                                <div class="form-group">
                                    <label> قيمة خصم الايام بعد رابع مرة غياب بدون اذن </label>
                                    <input type="text" name="sanctions_value_forth_absence"
                                        id="sanctions_value_forth_absence" class="form-control"
                                        value="{{ old('sanctions_value_forth_absence', $data['sanctions_value_forth_absence']) }}"
                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                                    @error('sanctions_value_forth_absence')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label> شعار الشركة</label>
                                    <div class="col-sm-12 col-md-12">
                                        <input type="file" name="image" class="dropify" data-height="200" />
                                    </div>
                                    @error('image')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>


                                <div class="form-group">
                                    <label> صورة الشركة</label>
                                    <div class="col-sm-12 col-md-12">
                                        <input type="file" name="photo_cover" class="dropify" data-height="200" />
                                    </div>
                                    @error('photo_cover')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>



                            </div>
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-primary-gradient col-4">تحديث البيانات</button>
                            </div>
                        </form>
                    </div>
                @else
                    <p class="bg-danger text-center"> عفوا لاتوجد بيانات لعرضها</p>
        @endif
    </div>
    <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    <!-- main-content closed -->
    </div>
    <!-- main-content closed --> </div>
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
@endsection
