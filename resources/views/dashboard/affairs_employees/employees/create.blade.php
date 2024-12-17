@extends('dashboard.layouts.master')
@section('title', 'أدخال بيانات موظف جديد')
@section('css')
    <!---Internal  Prism css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/prism/prism.css') }}" rel="stylesheet">
    <!---Internal Input tags css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/inputtags/inputtags.css') }}" rel="stylesheet">
    <!--- Custom-scroll -->
    <link href="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.css') }}" rel="stylesheet">
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


    <!-- رابط CSS لمكتبة Flatpickr -->
    <link href="{{ URL::asset('dashboard/assets/js/projects/flatpickr.min.css') }}" rel="stylesheet">


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
                <h5 class="content-title mb-0 my-auto">إدخال بيانات موظف جديد</h5><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/ <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.employees.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول بيانات الموظفين
                    </a>
                </span>
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

                    {{-- Success Message --}}
                    <div id="successMessage" class="alert alert-solid-success d-none" role="alert"
                        style="opacity: 0; position: relative; right: -100%; transition: right 0.5s ease-out, opacity 0.5s ease-out;">
                        <button aria-label="Close" class="close" data-dismiss="alert" type="button">
                            <span aria-hidden="true">&times;</span></button>
                        <strong>نجاح العملية!</strong> تم أضافة بيانات الموظف بنجاح .
                    </div>

                    @if ($errors->any())
                        @foreach ($errors->all() as $error)
                            <div class="alert alert-danger text-center">
                                {{ $error }}
                            </div>
                        @endforeach
                    @endif
                    <form action="{{ route('dashboard.employees.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        <div class="main-content-label mg-b-5">
                            إضافة موظف جديد
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
                                                <li><a href="#tab5" class="nav-link" data-toggle="tab">بيانات وظيفية</a>
                                                </li>
                                                <li><a href="#tab6" class="nav-link" data-toggle="tab">بيانات إضافية</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="panel-body tabs-menu-body main-content-body-right border">
                                        <div class="tab-content">
                                            {{-- بيانات شخصية --}}
                                            <div class="tab-pane" id="tab4">

                                                <div class="row">
                                                    {{-- FP Code Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> كود بصمة الموظف</label> <span class="tx-danger">*</span>
                                                            <input autofocus type="text" name="fp_code" id="fp_code"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control" value="{{ old('fp_code') }}">
                                                            @error('fp_code')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Name Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> اسم الموظف بالكامل</label> <span
                                                                class="tx-danger">*</span>
                                                            <input type="text" name="name" id="name"
                                                                class="form-control" value="{{ old('name') }}">
                                                            @error('name')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror

                                                        </div>
                                                    </div>

                                                    {{-- Gender Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> نوع الجنس</label> <span class="tx-danger">*</span>
                                                            <select name="gender" id="gender" class="form-control">
                                                                <option value="" selected>-- أختر النوع --</option>
                                                                <option @if (old('gender') == 'Male') selected @endif
                                                                    value="Male">ذكر</option>
                                                                <option @if (old('gender') == 'Female') selected @endif
                                                                    value="Female">انثي</option>
                                                            </select>
                                                            @error('gender')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Branch Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الفرع التابع له الموظف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="branch_id" id="branch_id"
                                                                class="form-control select2">
                                                                <option value="" selected>-- أختر الفرع --</option>
                                                                @if (@isset($other['branches']) && !@empty($other['branches']))
                                                                    @foreach ($other['branches'] as $info)
                                                                        <option
                                                                            @if (old('branch_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('branch_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Qualifications Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> المؤهل الدراسي</label>
                                                            <select name="qualification_id" id="qualification_id"
                                                                class="form-control select2">
                                                                <option value="" selected>-- أختر المؤهل --</option>
                                                                @if (@isset($other['qualifications']) && !@empty($other['qualifications']))
                                                                    @foreach ($other['qualifications'] as $info)
                                                                        <option
                                                                            @if (old('qualification_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('qualification_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Qualifications Year Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label>سنة التخرج</label>
                                                            <input type="text" name="qualification_year"
                                                                id="qualification_year" class="form-control"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                value="{{ old('qualification_year') }}">
                                                            @error('qualification_year')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Qualifications Year Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> تقدير التخرج</label>
                                                            <select name="graduation_estimate" id="graduation_estimate"
                                                                class="form-control">
                                                                <option value="" selected>-- أختر التقدير --</option>
                                                                <option @if (old('graduation_estimate') == 'Fair') selected @endif
                                                                    value="Fair">مقبول</option>
                                                                <option @if (old('graduation_estimate') == 'Good') selected @endif
                                                                    value="Good">جيد</option>
                                                                <option @if (old('graduation_estimate') == 'Very_Good') selected @endif
                                                                    value="Very_Good">جيد جدآ</option>
                                                                <option @if (old('graduation_estimate') == 'Excellent') selected @endif
                                                                    value="Excellent">أمتياز</option>

                                                            </select>
                                                            @error('graduation_estimate')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- major Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> تخصص التخرج</label>
                                                            <input type="text" name="major" id="major"
                                                                class="form-control" value="{{ old('major') }}">
                                                            @error('major')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Birth Date Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group" id="employee_birth_date_input">
                                                            <label> تاريخ الميلاد</label> <span class="tx-danger">*</span>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="birth_date" id="birth_date"
                                                                    placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('birth_date') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('birth_date')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('birth_date')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                    {{-- National ID Date Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> رقم بطاقة الهوية</label> <span
                                                                class="tx-danger">*</span>
                                                            <input type="text" name="national_id" id="national_id"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control" value="{{ old('national_id') }}">
                                                            @error('national_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- National ID Place Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> مركز اصدار بطاقة الهوية </label> <span
                                                                class="tx-danger">*</span>
                                                            <input type="text" name="national_id_place"
                                                                id="national_id_place" class="form-control"
                                                                value="{{ old('national_id_place') }}">
                                                            @error('national_id_place')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- End National ID Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> تاريخ انتهاء بطاقة الهوية</label> <span
                                                                class="tx-danger">*</span>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="end_national_id"
                                                                    id="end_national_id" placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('end_national_id') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('end_national_id')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('end_national_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                    {{-- Social Status Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الحالة الأجتماعية</label>
                                                            <select name="social_status" id="social_status"
                                                                class="form-control">
                                                                <option value="" selected>-- أختر الحالة --</option>
                                                                <option @if (old('social_status') == 'Married') selected @endif
                                                                    value="Married">متزوج</option>
                                                                <option @if (old('social_status') == 'Single') selected @endif
                                                                    value="Single">أعزب</option>
                                                                <option @if (old('social_status') == 'Widowed') selected @endif
                                                                    value="Widowed">أرمل</option>
                                                                <option @if (old('social_status') == 'Divorced') selected @endif
                                                                    value="Divorced">مطلق</option>
                                                            </select>
                                                            @error('social_status')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Children Number Input --}}
                                                    <div class="col-md-4 mb-3" id="children_number_hideandshow">
                                                        <div class="form-group">
                                                            <label> عدد الأطفال</label>
                                                            <input type="text" name="children_number"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                id="children_number" class="form-control"
                                                                value="{{ old('children_number') }}">
                                                            @error('children_number')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Blood Group ID Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> فصيلة الدم</label>
                                                            <select name="blood_types_id" id="blood_types_id"
                                                                class="form-control select2 ">
                                                                <option value="" selected>-- أختر الفصية --</option>
                                                                @if (@isset($other['blood_types']) && !@empty($other['blood_types']))
                                                                    @foreach ($other['blood_types'] as $info)
                                                                        <option
                                                                            @if (old('blood_types_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('blood_types_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Nationality Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الجنسية</label> <span class="tx-danger">*</span>
                                                            <select name="nationality_id" id="nationality_id"
                                                                class="form-control select2 ">
                                                                <option value="" selected>-- أختر الجنسية --</option>
                                                                @if (@isset($other['nationalities']) && !@empty($other['nationalities']))
                                                                    @foreach ($other['nationalities'] as $info)
                                                                        <option
                                                                            @if (old('nationality_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('nationality_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Languages Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> اللغة الاساسية التي يتحدث بها</label>
                                                            <select name="language_id" id="language_id"
                                                                class="form-control select2 ">
                                                                <option value="" selected>-- أختر الوظيفه --</option>
                                                                @if (@isset($other['languages']) && !@empty($other['languages']))
                                                                    @foreach ($other['languages'] as $info)
                                                                        <option
                                                                            @if (old('language_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('language_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Religion Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الديانة</label>
                                                            <select name="religion" id="religion" class="form-control">
                                                                <option value="" selected>-- أختر الديانه --</option>
                                                                <option @if (old('religion') == 'Muslim') selected @endif
                                                                    value="Muslim">مسلم</option>
                                                                <option @if (old('religion') == 'Christian') selected @endif
                                                                    value="Christian">مسيحى</option>
                                                            </select>
                                                            @error('religion')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Email Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> البريد الالكتروني</label> <span
                                                                class="tx-danger">*</span>
                                                            <input type="text" name="email" id="email"
                                                                class="form-control" value="{{ old('email') }}">
                                                            @error('email')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Country Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label>الدولة التابع لها الموظف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="country_id" id="country_id"
                                                                class="form-control select2">
                                                                <option value="">-- اختر الدولة التابع لها الموظف --
                                                                </option>
                                                                @if (@isset($other['countires']) && !@empty($other['countires']))
                                                                    @foreach ($other['countires'] as $info)
                                                                        <option
                                                                            @if (old('country_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('country_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Governorate Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group" id="governorates_Div">
                                                            <label>المحافظة التابع لها الموظف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="governorate_id" id="governorate_id"
                                                                class="form-control select2">
                                                                <option value="">-- اختر المحافظة التابع لها الموظف
                                                                    --</option>
                                                                @if (isset($other['governorates']) && !empty($other['governorates']))
                                                                    @foreach ($other['governorates'] as $info)
                                                                        <option value="{{ $info->id }}"
                                                                            {{ old('governorate_id') == $info->id ? 'selected' : '' }}>
                                                                            {{ $info->name }}
                                                                        </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('governorate_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- City Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group" id="centers_div">
                                                            <label>المدينة/المركز</label> <span class="tx-danger">*</span>
                                                            <select name="city_id" id="city_id"
                                                                class="form-control select2">
                                                                <option value="">-- اختر المدينة التابع لها الموظف --
                                                                </option>
                                                                @if (isset($other['cities']) && !empty($other['cities']))
                                                                    @foreach ($other['cities'] as $info)
                                                                        <option value="{{ $info->id }}"
                                                                            {{ old('city_id') == $info->id ? 'selected' : '' }}>
                                                                            {{ $info->name }}
                                                                        </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('city_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Staies Address Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> عنوان الاقامة الحالي للموظف</label>
                                                            <input type="text" name="staies_address"
                                                                id="staies_address" class="form-control"
                                                                value="{{ old('staies_address') }}">
                                                            @error('staies_address')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Work Telephone Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هاتف المحمول</label> <span class="tx-danger">*</span>
                                                            <input type="text" name="mobile" id="mobile"
                                                                class="form-control" value="{{ old('mobile') }}">
                                                            @error('mobile')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Home Telephone Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هاتف المنزل</label>
                                                            <input type="text" name="home_telephone"
                                                                id="home_telephone" class="form-control"
                                                                value="{{ old('home_telephone') }}">
                                                            @error('home_telephone')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Work Telephone Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هاتف العمل</label>
                                                            <input type="text" name="work_telephone"
                                                                id="work_telephone" class="form-control"
                                                                value="{{ old('work_telephone') }}">
                                                            @error('work_telephone')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Military Input --}}
                                                    <div class="col-md-4 mb-3" id="military_hideandshow">
                                                        <div class="form-group">
                                                            <label> حالة الخدمة العسكرية</label>
                                                            <select name="military" id="military" class="form-control">
                                                                <option value="" selected>-- أختر الحالة --</option>
                                                                <option @if (old('military') == 'Exemption') selected @endif
                                                                    value="Exemption">إعفاء نهائى</option>
                                                                <option @if (old('military') == 'Exemption_Temporary') selected @endif
                                                                    value="Exemption_Temporary">إعفاء مؤقت</option>
                                                                <option @if (old('military') == 'Complete') selected @endif
                                                                    value="Complete">أدى الخدمه</option>
                                                            </select>
                                                            @error('military')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Miltary Date From Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_1"
                                                        id="military_date_from_hideandshow">
                                                        <div class="form-group">
                                                            <label> تاريخ بداية الخدمة العسكرية </label>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="military_date_from"
                                                                    id="military_date_from" placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('military_date_from') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('military_date_from')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('military_date_from')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>



                                                    {{-- Miltary Date To Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_1"
                                                        id="military_date_to_hideandshow">
                                                        <div class="form-group">
                                                            <label> تاريخ نهاية الخدمة العسكرية </label>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="military_date_to"
                                                                    id="military_date_to" placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('military_date_to') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('military_date_to')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('military_date_to')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Miltary Wepon Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_1"
                                                        id="military_wepon_hideandshow">
                                                        <div class="form-group">
                                                            <label> سلاح الخدمة العسكرية </label>
                                                            <input type="text" name="military_wepon"
                                                                id="military_wepon" class="form-control"
                                                                value="{{ old('military_wepon') }}">
                                                            @error('qualification_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Miltary Exemption Date Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_2"
                                                        id="military_exemption_date_hideandshow">
                                                        <div class="form-group">
                                                            <label> تاريخ اعفاء الخدمة العسكرية </label>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="military_exemption_date"
                                                                    id="military_exemption_date"
                                                                    placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('military_exemption_date') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('military_exemption_date')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('military_wepon')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Miltary Exemption Reason Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_2"
                                                        id="military_exemption_reason_hideandshow">
                                                        <div class="form-group">
                                                            <label> سبب اعفاء الخدمة العسكرية </label>
                                                            <input type="text" name="military_exemption_reason"
                                                                id="military_exemption_reason" class="form-control"
                                                                value="{{ old('	military_exemption_reason') }}">
                                                            @error('military_exemption_reason')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Miltary Postponement Reason Input --}}
                                                    <div class="col-md-4 mb-3 related_miltary_3"
                                                        id="military_postponement_reason_hideandshow">
                                                        <div class="form-group">
                                                            <label> سبب ومدة تأجيل الخدمة العسكرية</label>
                                                            <input type="text" name="military_postponement_reason"
                                                                id="military_postponement_reason" class="form-control"
                                                                value="{{ old('military_postponement_reason') }}">
                                                            @error('military_postponement_reason')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Driving License Input --}}
                                                    <div class="col-md-4 mb-3" id="driving_license_hideandshow">
                                                        <div class="form-group">
                                                            <label> هل يمتلك رخصة قيادة</label>
                                                            <select name="driving_license" id="driving_license"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('driving_license') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('driving_license') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('driving_license')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Driving License ID Input --}}
                                                    <div class="col-md-4 mb-3 related_does_has_Driving_License"
                                                        id="driving_License_id_hideandshow">
                                                        <div class="form-group">
                                                            <label> رقم رخصة القيادة</label>
                                                            <input type="text" name="driving_License_id"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                id="driving_License_id" class="form-control"
                                                                value="{{ old('	driving_License_id') }}">
                                                            @error('driving_License_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Driving License Type Input --}}
                                                    <div class="col-md-4 mb-3 related_does_has_Driving_License"
                                                        id="driving_license_type_hideandshow">
                                                        <div class="form-group">
                                                            <label> نوع رخصة القيادة</label>
                                                            <select name="driving_license_type" id="driving_license_type"
                                                                class="form-control select2 ">
                                                                <option value=""> -- اختر النوع --</option>
                                                                <option @if (old('driving_license_type') == 'Special') selected @endif
                                                                    value="Special">رخصة خاصة</option>
                                                                <option @if (old('driving_license_type') == 'First') selected @endif
                                                                    value="First">رخصة درجه أولى</option>
                                                                <option @if (old('driving_license_type') == 'Second') selected @endif
                                                                    value="Second">رخصة درجه ثانية</option>
                                                                <option @if (old('driving_license_type') == 'Third') selected @endif
                                                                    value="Third">رخصة درجه ثالثه</option>
                                                                <option @if (old('driving_license_type') == 'Fourth') selected @endif
                                                                    value="Fourth">رخصة درجه رابعه</option>
                                                                <option @if (old('driving_license_type') == 'Pro') selected @endif
                                                                    value="Pro">رخصة مهنية</option>
                                                                <option @if (old('driving_license_type') == 'Motorcycle') selected @endif
                                                                    value="Motorcycle">رخصة دراجه بخارية</option>
                                                            </select>
                                                            @error('driving_license_type')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Has Relatives Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل يمتلك أقارب بالعمل </label>
                                                            <select name="has_relatives" id="has_relatives"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('has_relatives') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('has_relatives') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('has_relatives')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Relatives Details Input --}}
                                                    <div class="col-md-8 Related_Relatives_detailsDiv mb-3"
                                                        id="relatives_details_hideandshow">
                                                        <div class="form-group">
                                                            <label> تفاصيل الاقارب</label>
                                                            <textarea type="text" name="relatives_details" id="relatives_details" class="form-control">{{ old('relatives_details') }}</textarea>
                                                            @error('relatives_details')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Disabilities Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل يمتلك اعاقة / عمليات سابقة </label>
                                                            <select name="disabilities" id="disabilities"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('disabilities') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('disabilities') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('disabilities')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Disabilities Type Input --}}
                                                    <div class="col-md-12 mb-3 Related_is_Disabilities_processesDiv"
                                                        id="disabilities_type_hideandshow">
                                                        <div class="form-group">
                                                            <label> تفاصيل الاعاقة / عمليات سابقة</label>
                                                            <textarea type="text" name="disabilities_type" id="disabilities_type" class="form-control">{{ old('disabilities_type') }}</textarea>
                                                            @error('disabilities_type')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Notes Type Input --}}
                                                    <div class="col-md-12 mb-3">
                                                        <div class="form-group">
                                                            <label> ملاحظات علي الموظف </label>
                                                            <textarea type="text" name="notes" id="notes" class="form-control">{{ old('notes') }}</textarea>
                                                            @error('notes')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>
                                                </div>
                                                {{-- End Row --}}
                                            </div>
                                            {{-- End tab --}}

                                            {{-- بيانات وظيفية  --}}
                                            <div class="tab-pane" id="tab5">

                                                <div class="row">

                                                    {{-- Work Start Date Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group" id="employee_hiring_date_input">
                                                            <label> تاريخ التعيين</label> <span class="tx-danger">*</span>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="work_start_date"
                                                                    id="work_start_date" placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('work_start_date') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('work_start_date')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('work_start_date')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Functional Status Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label>الحالة الوظيفية</label> <span class="tx-danger">*</span>
                                                            <select name="functional_status" id="functional_status"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('functional_status') == 'Employee') selected @endif
                                                                    value="Employee">موظف</option>
                                                                <option @if (old('functional_status') == 'Unemployed') selected @endif
                                                                    value="Unemployed">لا يعمل</option>
                                                            </select>
                                                            @error('functional_status')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                    {{-- job_grade_id Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الدرجه الوظيفية</label>
                                                            <span class="tx-danger">*</span>
                                                            <select name="job_grade_id" id="job_grade_id"
                                                                class="form-control select2 ">
                                                                <option value="">اختر الادارة</option>
                                                                @if (@isset($other['job_grades']) && !@empty($other['job_grades']))
                                                                    @foreach ($other['job_grades'] as $info)
                                                                        <option
                                                                            @if (old('job_grade_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }}
                                                                            ({{ $info->min_salary * 1 }} -
                                                                            {{ $info->max_salary * 1 }})
                                                                        </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('job_grade_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                    {{-- Department Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> الادارة التابع لها الموظف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="department_id" id="department_id"
                                                                class="form-control select2 ">
                                                                <option value="">اختر الادارة</option>
                                                                @if (@isset($other['departements']) && !@empty($other['departements']))
                                                                    @foreach ($other['departements'] as $info)
                                                                        <option
                                                                            @if (old('department_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('department_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Jobs Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> وظيفة الموظف</label> <span class="tx-danger">*</span>
                                                            <select name="job_categories_id" id="job_categories_id"
                                                                class="form-control select2">
                                                                <option value="">-- اختر الوظيفة --</option>
                                                                @if (@isset($other['jobs']) && !@empty($other['jobs']))
                                                                    @foreach ($other['jobs'] as $info)
                                                                        <option
                                                                            @if (old('job_categories_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">
                                                                            {{ $info->name }} </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('job_categories_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Has Attendance Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له بصمة حضور وانصراف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="has_attendance" id="has_attendance"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('has_attendance') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('has_attendance') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('has_attendance')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Has Fixed Shift Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له شفت ثابت</label> <span class="tx-danger">*</span>
                                                            <select name="has_fixed_shift" id="has_fixed_shift"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('has_fixed_shift') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('has_fixed_shift') == 'No') selected @endif
                                                                    value="No">لا</option>

                                                            </select>
                                                            @error('has_fixed_shift')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                    {{-- shift Types_id Input --}}
                                                    <div class="col-md-7 mb-3" id="relatedfixced_shift_hideandshow">
                                                        <div class="form-group">
                                                            <label>أنواع الشفتات</label>
                                                            <select name="shift_types_id" id="shift_types_id"
                                                                class="form-control">
                                                                <option selected value=""> -- اختر نوع الشفت --
                                                                </option>
                                                                @if (@isset($other['shifts_types']) && !@empty($other['shifts_types']))
                                                                    @foreach ($other['shifts_types'] as $info)
                                                                        <option
                                                                            @if (old('shift_types_id') == $info->id) selected="selected" @endif
                                                                            value="{{ $info->id }}">

                                                                            @if ($info->type == 1)
                                                                                صباحى
                                                                            @elseif ($info->type == 2)
                                                                                مسائى
                                                                            @else
                                                                                يوم كامل
                                                                            @endif
                                                                            من
                                                                            {{ \Carbon\Carbon::parse($info->from_time)->format('g:i') }}
                                                                            {{ \Carbon\Carbon::parse($info->from_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                                                                            إلى
                                                                            {{ \Carbon\Carbon::parse($info->to_time)->format('g:i') }}
                                                                            {{ \Carbon\Carbon::parse($info->to_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}

                                                                            عدد ساعات
                                                                            @php
                                                                                $to_time = Carbon::parse(
                                                                                    $info['to_time'],
                                                                                );
                                                                                $from_time = Carbon::parse(
                                                                                    $info['from_time'],
                                                                                );
                                                                                $diff_in_minutes = $to_time->diffInMinutes(
                                                                                    $from_time,
                                                                                );
                                                                                $hours = floor($diff_in_minutes / 60);
                                                                                $minutes = $diff_in_minutes % 60;
                                                                            @endphp
                                                                            {{ $hours }} ساعة و
                                                                            {{ $minutes }} دقيقة
                                                                        </option>
                                                                    @endforeach
                                                                @endif
                                                            </select>
                                                            @error('shift_types_id')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Daily Work Hour Input --}}
                                                    <div class="col-md-4 mb-3" id="daily_work_hourDiv_hideandshow">
                                                        <div class="form-group">
                                                            <label> عدد ساعات العمل اليومي</label>
                                                            <input type="text" name="daily_work_hour"
                                                                id="daily_work_hour"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control"
                                                                value="{{ old('daily_work_hour') }}">
                                                            @error('daily_work_hour')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>





                                                    {{-- Add Service Input --}}
                                                    <div class="form-group mb-3 col-4" id="employee_add_service_input">
                                                        <label for="employee_add_service">أضافة سنوات الخدمه</label>
                                                        <input type="text" name="add_service"
                                                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                            id="add_service" class="form-control"
                                                            value="{{ old('add_service') }}">
                                                        @error('add_service')
                                                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                                                <span class="alert-inner--icon"><i
                                                                        class="fe fe-slash"></i></span>
                                                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                                                    {{ $message }}</span>
                                                            </div>
                                                        @enderror
                                                    </div>

                                                    {{-- Years Service Input --}}
                                                    <div class="form-group mb-3 col-4" id="employee_years_service_input">
                                                        <label for="employee_years_service">عدد سنوات الخدمه</label> <span
                                                            class="tx-danger">*</span>
                                                        <input type="text" name="years_service" readonly
                                                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                            id="years_service" class="form-control"
                                                            value="{{ old('years_service') }}">
                                                        @error('years_service')
                                                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                                                <span class="alert-inner--icon"><i
                                                                        class="fe fe-slash"></i></span>
                                                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                                                    {{ $message }}</span>
                                                            </div>
                                                        @enderror
                                                    </div>

                                                    {{-- Num Vacation Days Input --}}
                                                    <div class="form-group mb-3 col-4"
                                                        id="employee_num_vacation_days_input">
                                                        <label for="employee_num_vacation_days">رصيد الأجازات</label>
                                                        <input type="text" name="num_vacation_days"
                                                            id="num_vacation_days" class="form-control"
                                                            value="{{ old('num_vacation_days') }}" readonly>
                                                        @error('num_vacation_days')
                                                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                                                <span class="alert-inner--icon"><i
                                                                        class="fe fe-slash"></i></span>
                                                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                                                    {{ $message }}</span>
                                                            </div>
                                                        @enderror
                                                    </div>


                                                    {{-- salary Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> راتب الموظف الشهري</label> <span
                                                                class="tx-danger">*</span>
                                                            <input type="text" name="salary" id="salary"
                                                                oninput="calculateDayPrice(); this.value=this.value.replace(/[^0-9]/g,'');"
                                                                class="form-control" value="{{ old('salary') }}">
                                                            @error('salary')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror

                                                        </div>
                                                    </div>


                                                    {{-- Day Price Input --}}
                                                    <input type="hidden" name="day_price" id="day_price"
                                                        oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                                        class="form-control" value="{{ old('day_price') }}">





                                                    {{-- Motivation Type Input --}}
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label> هل له حافز </label> <span class="tx-danger">*</span>
                                                            <select name="motivation_type" id="motivation_type"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('motivation_type') == 'Fixed') selected @endif
                                                                    value="Fixed">ثابت</option>
                                                                <option @if (old('motivation_type') == 'Changeable') selected @endif
                                                                    value="Changeable">متغير</option>
                                                                <option @if (old('motivation_type') == 'None') selected @endif
                                                                    value="None">لا يوجد</option>
                                                            </select>
                                                            @error('motivation_type')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Motivation Input --}}
                                                    <div class="col-md-4 mb-3" id="MotivationDIV_hideandshow">
                                                        <div class="form-group">
                                                            <label> قيمة الحافز الشهري الثابت</label>
                                                            <input type="text" name="motivation" id="motivation"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control" value="{{ old('motivation') }}">
                                                            @error('motivation')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Is Social Insurance Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له تأمين اجتماعي </label>
                                                            <select name="social_insurance" id="social_insurance"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('social_insurance') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('social_insurance') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('social_insurance')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Social Insurance Cut Monthely Input --}}
                                                    <div class="col-md-4 mb-3"
                                                        id="social_insurance_cut_monthelyDIV_hideandshow">
                                                        <div class="form-group">
                                                            <label> قيمة التأمين الاجتماعي المستقطع شهرياً</label>
                                                            <input type="text" name="social_insurance_cut_monthely"
                                                                id="social_insurance_cut_monthely"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control"
                                                                value="{{ old('social_insurance_cut_monthely') }}">
                                                            @error('social_insurance_cut_monthely')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Social Insurance Number Input --}}
                                                    <div class="col-md-4 mb-3"
                                                        id="social_insurance_numberDIV_hideandshow">
                                                        <div class="form-group">
                                                            <label> رقم التامين الاجتماعي للموظف</label>
                                                            <input type="text" name="social_insurance_number"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                id="social_insurance_number" class="form-control"
                                                                value="{{ old('social_insurance_number') }}">
                                                            @error('social_insurance_number')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Medical Insurance Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له تأمين طبي </label>
                                                            <select name="medical_insurance" id="medical_insurance"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('medical_insurance') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('medical_insurance') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('medical_insurance')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Medical Insurance Cut Monthely Input --}}
                                                    <div class="col-md-4 mb-3 relatedismedicalinsurance"
                                                        id="medicalinsurancecutmonthelyDIV_hideandshow">
                                                        <div class="form-group">
                                                            <label> قيمة التأمين الطبي المستقطع شهرياً</label>
                                                            <input type="text" name="medical_insurance_cut_monthely"
                                                                id="medical_insurance_cut_monthely"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                class="form-control"
                                                                value="{{ old('medical_insurance_cut_monthely') }}">
                                                            @error('medical_insurance_cut_monthely')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Medical Insurance Number Input --}}
                                                    <div class="col-md-4 mb-3 relatedismedicalinsurance"
                                                        id="medicalinsuranceNumberDIV_hideandshow">
                                                        <div class="form-group">
                                                            <label> رقم التامين الطبي للموظف</label>
                                                            <input type="text" name="medical_insurance_number"
                                                                id="medical_insurance_number" class="form-control"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                value="{{ old('medical_insurance_number') }}">
                                                            @error('medical_insurance_number')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Type Salary Receipt Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> نوع صرف راتب الموظف</label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="Type_salary_receipt" id="Type_salary_receipt"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('Type_salary_receipt') == 'Cach') selected @endif
                                                                    value="Cach">كاش</option>
                                                                <option @if (old('Type_salary_receipt') == 'Visa') selected @endif
                                                                    value="Visa">فيزا</option>
                                                            </select>
                                                            @error('Type_salary_receipt')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Active Vacation Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له رصيد اجازات سنوي</label>
                                                            <select name="active_vacation" id="active_vacation"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('active_vacation') == 'Yes') selected @endif
                                                                    value="Yes">نعم</option>
                                                                <option @if (old('active_vacation') == 'No') selected @endif
                                                                    value="No">لا</option>
                                                            </select>
                                                            @error('active_vacation')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Urgent Person Details Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> شخص يمكن الرجوع اليه للضرورة </label>
                                                            <input type="text" name="urgent_person_details"
                                                                id="urgent_person_details" class="form-control"
                                                                value="{{ old('urgent_person_details') }}">
                                                            @error('urgent_person_details')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Fixed Allowances Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> هل له بدلات ثابتة </label> <span
                                                                class="tx-danger">*</span>
                                                            <select name="fixed_allowances" id="fixed_allowances"
                                                                class="form-control">
                                                                <option value=""> -- اختر الحالة --</option>
                                                                <option @if (old('fixed_allowances') == '1') selected @endif
                                                                    value="1">نعم</option>
                                                                <option @if (old('fixed_allowances') == '0') selected @endif
                                                                    value="0">لا</option>
                                                            </select>
                                                            @error('fixed_allowances')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>
                                                </div>
                                                {{-- End Row --}}
                                            </div>
                                            {{-- End tab5 --}}

                                            <div class="tab-pane" id="tab6">
                                                {{-- بيانات إضافية --}}
                                                <div class="row">
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">

                                                            {{-- Name Sponsor Input --}}
                                                            <label> اسم الكفيل </label>
                                                            <input type="text" name="name_sponsor" id="name_sponsor"
                                                                class="form-control" value="{{ old('name_sponsor') }}">
                                                            @error('name_sponsor')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Pasport Identity Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> رقم الباسبور ان وجد </label>
                                                            <input type="text" name="pasport_identity"
                                                                id="pasport_identity" class="form-control"
                                                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                                                value="{{ old('pasport_identity') }}">
                                                            @error('pasport_identity')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Pasport Place Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label>جهة اصدار الباسبور </label>
                                                            <input type="text" name="pasport_from_place"
                                                                id="pasport_from_place" class="form-control"
                                                                value="{{ old('pasport_from_place') }}">
                                                            @error('pasport_from_place')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>

                                                    {{-- Pasport Exp Date Input --}}
                                                    <div class="col-md-4 mb-3">
                                                        <div class="form-group">
                                                            <label> تاريخ انتهاء الباسبور </label>
                                                            <!-- حقل إدخال التاريخ -->
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i
                                                                            class="fa fa-calendar-alt"></i></span>
                                                                </div>
                                                                <input type="text" name="pasport_exp_date"
                                                                    id="pasport_exp_date" placeholder="يوم / شهر / سنه"
                                                                    class="form-control flatpickr bg-transparent"
                                                                    value="{{ old('pasport_exp_date') }}">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="wd-80 btn btn-dark"
                                                                        onclick="document.getElementById('pasport_exp_date')._flatpickr.clear()"><i
                                                                            class="fa fa-times"></i> محو</button>
                                                                </div>
                                                            </div>
                                                            @error('pasport_exp_date')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>




                                                    {{-- Photo Input --}}
                                                    <div class="col-md-12 mb-3">
                                                        <label> الصورة الشخصية للموظف</label>
                                                        <input type="file" name="photo" id="photo"
                                                            value="{{ old('photo') }}" class="dropify"
                                                            data-height="150" />
                                                        @error('photo')
                                                            <div class="alert alert-danger">{{ $message }}</div>
                                                        @enderror
                                                    </div>

                                                    {{-- CV Input --}}
                                                    <div class="col-md-12 mb-3">
                                                        <div class="">
                                                            <label> السيرة الذاتية للموظف</label>
                                                            <input type="file" name="cv" id="cv"
                                                                value="{{ old('cv') }}" class="dropify"
                                                                data-height="150" />
                                                            @error('cv')
                                                                <div class="alert alert-danger">{{ $message }}</div>
                                                            @enderror
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row col-6 mx-auto">
                                        <div class="col-md-6 mx-auto mt-3 mb-3">
                                            <div class="form-group">
                                                <button class="btn ripple btn-primary btn-block" type="submit">تأكيد
                                                    البيانات</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                    </form>
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


    <!-- main-content closed -->
@endsection
@section('js')
    <!-- رابط JavaScript لمكتبة Flatpickr -->
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr-ar.js') }}"></script>


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
    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!-- Internal Jquery.mCustomScrollbar js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.concat.min.js') }}">
    </script>
    <!-- Internal Input tags js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/inputtags/inputtags.js') }}"></script>
    <!--- Tabs JS-->
    <script src="{{ URL::asset('dashboard/assets/plugins/tabs/jquery.multipurpose_tabcontent.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/tabs.js') }}"></script>
    <!--Internal  Clipboard js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.js') }}"></script>
    <!-- Internal Prism js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/prism/prism.js') }}"></script>
    {{-- Show And Hide Inputs --}}
    <script src="{{ URL::asset('dashboard/assets/js/projects/employees.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/add-employee.js') }}"></script>


    <script>
        // To Get Citeis When Change Governorates

        $(document).on('change', '#governorate_id', function(e) {
            getcities();
        });

        function getcities() {
            var governorate_id = $("#governorate_id").val();
            jQuery.ajax({
                url: '{{ route('dashboard.employees.getcities') }}',
                type: 'post',
                'dataType': 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    governorate_id: governorate_id
                },
                success: function(data) {
                    $("#centers_div").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }

            });
        }

        //###############################################################

        // To Get Governorates When Change Country
        $(document).on('change', '#country_id', function(e) {
            get_governorates();
        });

        function get_governorates() {
            var country_id = $("#country_id").val();
            jQuery.ajax({
                url: '{{ route('dashboard.employees.get_governorates') }}',
                type: 'post',
                'dataType': 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    country_id: country_id
                },
                success: function(data) {
                    $("#governorates_Div").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }

            });
        }
    </script>


    <script>
        $(document).ready(function() {
            $('.dropify').dropify();
        });
    </script>


    <script>
        flatpickr('#birth_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#end_national_id', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });


        flatpickr('#military_date_from', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#military_date_to', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#military_exemption_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#work_start_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#pasport_exp_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });
    </script>




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
        function calculateDayPrice() {
            const salaryInput = document.getElementById('salary').value;
            const dayPriceInput = document.getElementById('day_price');
            const daysInMonth = 30; // يمكنك تغيير هذا الرقم إذا كان لديك عدد مختلف للأيام

            if (salaryInput) {
                const salary = parseFloat(salaryInput);
                const dayPrice = salary / daysInMonth;
                dayPriceInput.value = dayPrice.toFixed(2); // تقليل القيمة إلى منزلتين عشريتين
            } else {
                dayPriceInput.value = '';
            }
        }
    </script>





    <script>
        // Function to calculate vacation days
        function calculateVacationDays() {
            // Get the input values
            let birthDate = new Date(document.getElementById('birth_date').value);
            let hiringDate = new Date(document.getElementById('work_start_date').value);
            let additionalServiceYears = parseInt(document.getElementById('add_service').value || 0);


            // Get the current date
            let currentDate = new Date();

            // Calculate years of service
            let yearsOfService = currentDate.getFullYear() - hiringDate.getFullYear() + additionalServiceYears;

            // Calculate vacation days
            let vacationDays = 21; // Default value
            if (yearsOfService >= 10) {
                vacationDays = 30;
            }
            if (currentDate.getFullYear() - birthDate.getFullYear() >= 50) {
                vacationDays = 45;
            }

            // Set the vacation days in the input field
            document.getElementById('num_vacation_days').value = vacationDays;
        }

        // Attach event listeners to update vacation days on input change
        document.getElementById('birth_date').addEventListener('change', calculateVacationDays);
        document.getElementById('work_start_date').addEventListener('change', calculateVacationDays);
        document.getElementById('add_service').addEventListener('input', calculateVacationDays);
    </script>

    <script>
        document.getElementById('work_start_date').addEventListener('input', calculateYearsOfService);
        document.getElementById('add_service').addEventListener('input', calculateYearsOfService);

        function calculateYearsOfService() {
            let hiringDate = new Date(document.getElementById('work_start_date').value);
            let addService = parseInt(document.getElementById('add_service').value) || 0;
            let currentDate = new Date();

            // حساب عدد السنوات بين تاريخ التعيين والتاريخ الحالي
            let yearsOfService = currentDate.getFullYear() - hiringDate.getFullYear();

            // إضافة عدد سنوات الخدمة الإضافية
            yearsOfService += addService;

            // تحديث حقل عدد سنوات الخدمة
            document.getElementById('years_service').value = yearsOfService;
        }
    </script>


@endsection
