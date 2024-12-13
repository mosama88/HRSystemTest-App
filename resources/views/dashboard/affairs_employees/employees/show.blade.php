@extends('dashboard.layouts.master')
@section('title', 'عرض بيانات الموظف')
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
                <h5 class="content-title mb-0 my-auto">عرض بيانات الموظف </h5><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/ <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.employees.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول بيانات الموظفين
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
                        <a href="{{ route('dashboard.employees.edit', $data->id) }}" class="btn btn-info ">
                            <i class="fas fa-edit ml-1"></i> تعديل</a>
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
                                            <li><a href="#tab7" class="nav-link" data-toggle="tab">مستندات الموظف</a>
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
                                                            <td class="wd-300 back"> نوع الجنس</td>
                                                            <td>
                                                                @if ($data['gender'] == 'Male')
                                                                    ذكر
                                                                @else
                                                                    أنثى
                                                                @endif
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">الفرع التابع له الموظف</td>
                                                            <td>{{ $data->branch->name }} </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">المؤهل الدراسي</td>
                                                            <td>{{ $data->qualification->name }} </td>

                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">سنة التخرج</td>
                                                            <td>{{ $data->qualification_year }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تقدير التخرج</td>
                                                            <td>
                                                                @if ($data['graduation_estimate'] == 'Fair')
                                                                    مقبول
                                                                @elseif($data['graduation_estimate'] == 'Good')
                                                                    جيد
                                                                @elseif($data['graduation_estimate'] == 'Very_Good')
                                                                    جيد جدآ
                                                                @elseif($data['graduation_estimate'] == 'Excellent')
                                                                    أمتياز
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تخصص التخرج</td>
                                                            <td>{{ $data->major }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ الميلاد</td>
                                                            <td>{{ $data->birth_date }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رقم بطاقة الهوية</td>
                                                            <td>{{ $data->national_id }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">مركز اصدار بطاقة الهوية</td>
                                                            <td>{{ $data->national_id_place }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ انتهاء بطاقة الهوية</td>
                                                            <td>{{ $data->end_national_id }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">الحالة الأجتماعية</td>
                                                            <td>
                                                                @if ($data['social_status'] == 'Married')
                                                                    متزوج
                                                                @elseif($data['social_status'] == 'Single')
                                                                    أعزب
                                                                @elseif($data['social_status'] == 'Widowed')
                                                                    أرمل
                                                                @elseif($data['social_status'] == 'Divorced')
                                                                    مطلق
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">عدد الأطفال</td>
                                                            <td>
                                                                @if ($data->children_number > 0)
                                                                    لدية {{ $data->children_number }} أطفال
                                                                @else
                                                                    ليس لدية أطفال
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">فصيلة الدم</td>
                                                            <td>{{ $data->bloodTypes->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">الجنسية</td>
                                                            <td>{{ $data->nationality->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">اللغة الاساسية التي يتحدث بها</td>
                                                            <td>{{ $data->language->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">الديانة</td>
                                                            <td>
                                                                @if ($data['religion'] == 'Muslim')
                                                                    مسلم
                                                                @else
                                                                    مسيحى
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">البريد الالكتروني</td>
                                                            <td>{{ $data->email }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">الدولة</td>
                                                            <td>{{ $data->country->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">المحافظة</td>
                                                            <td>{{ $data->governorate->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">المدينة/المركز</td>
                                                            <td>{{ $data->city->name }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">عنوان الاقامة الحالي للموظف</td>
                                                            <td>{{ $data->staies_address }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هاتف المحمول</td>
                                                            <td>{{ $data->mobile }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هاتف المنزل</td>
                                                            <td>{{ $data->home_telephone }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هاتف العمل</td>
                                                            <td>{{ $data->work_telephone }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">حالة الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data['military'] == 'Exemption')
                                                                    إعفاء نهائى
                                                                @elseif($data['military'] == 'Exemption_Temporary')
                                                                    إعفاء مؤقت
                                                                @elseif($data['military'] == 'Complete')
                                                                    أدى الخدمه
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ بداية الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_date_from > 0)
                                                                    {{ $data->military_date_from }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ نهاية الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_date_to > 0)
                                                                    {{ $data->military_date_to }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">سلاح الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_wepon > 0)
                                                                    {{ $data->military_wepon }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ اعفاء الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_exemption_date > 0)
                                                                    {{ $data->military_exemption_date }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">سبب اعفاء الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_exemption_reason > 0)
                                                                    {{ $data->military_exemption_reason }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">سبب ومدة تأجيل الخدمة العسكرية</td>
                                                            <td>
                                                                @if ($data->military_postponement_reason > 0)
                                                                    {{ $data->military_postponement_reason }}
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل يمتلك رخصة قيادة</td>
                                                            <td>

                                                                @if ($data->driving_license == 'Yes')
                                                                    نعم
                                                                @else
                                                                    لا يمتلك رخصة قياده
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رقم رخصة القيادة</td>
                                                            <td>
                                                                @if ($data->driving_License_id > 0)
                                                                    {{ $data->driving_License_id }}
                                                                @else
                                                                    ليس لدية رخصه
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">نوع رخصة القيادة</td>
                                                            <td>
                                                                @if ($data['driving_license_type'] == 'Special')
                                                                    رخصة خاصة
                                                                @elseif($data['driving_license_type'] == 'First')
                                                                    رخصة درجه أولى
                                                                @elseif($data['driving_license_type'] == 'Second')
                                                                    رخصة درجه ثانية
                                                                @elseif($data['driving_license_type'] == 'Third')
                                                                    رخصة درجه ثالثه
                                                                @elseif($data['driving_license_type'] == 'Fourth')
                                                                    رخصة درجه رابعه
                                                                @elseif($data['driving_license_type'] == 'Pro')
                                                                    رخصة مهنية
                                                                @elseif($data['driving_license_type'] == 'Motorcycle')
                                                                    رخصة رخصة دراجه بخارية
                                                                @else
                                                                    ليس لدية رخصه
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل يمتلك أقارب بالعمل</td>
                                                            <td>
                                                                @if ($data->has_relatives == 'Yes')
                                                                    نعم
                                                                @else
                                                                    لا يمتلك أقارب بالعمل
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تفاصيل الاقارب</td>
                                                            <td>
                                                                @if ($data->relatives_details > 0)
                                                                    {{ $data->relatives_details }}
                                                                @else
                                                                    ليس لدية أقارب
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل يمتلك اعاقة / عمليات سابقة</td>
                                                            <td>
                                                                @if ($data->disabilities == 'Yes')
                                                                    نعم
                                                                @else
                                                                    ليس لدية إعاقة
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تفاصيل الاعاقة / عمليات سابقة</td>
                                                            <td>
                                                                @if ($data->disabilities_type > 0)
                                                                    {{ $data->disabilities_type }}
                                                                @else
                                                                    لا يوجد تفاصيل
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">ملاحظات علي الموظف</td>
                                                            <td>
                                                                @if ($data->notes > 0)
                                                                    {{ $data->notes }}
                                                                @else
                                                                    لا توجد ملاحظات
                                                                @endif
                                                            </td>
                                                        </tr>


                                                    </table>
                                                </div>
                                            </div>


                                            {{-- End Row --}}
                                        </div>
                                        {{-- End tab --}}

                                        {{-- بيانات وظيفية  --}}
                                        <div class="tab-pane" id="tab5">

                                            <div class="table-container">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered mg-b-0 text-md-nowrap">
                                                        <tr>
                                                            <td class="wd-300 back">تاريخ التعيين</td>
                                                            <td>{{ $data['work_start_date'] }}</td>
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
                                                            <td class="wd-300 back">الدرجه الوظيفية</td>
                                                            <td>{{ $data->jobGrade->name }}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back"> الادارة التابع لها الموظف</td>
                                                            <td>{{ $data->department->name }}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">وظيفة الموظف</td>
                                                            <td>{{ $data->jobCategories->name }} </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">هل له بصمة حضور وانصراف</td>
                                                            <td>
                                                                @if ($data->has_attendance == 'Yes')
                                                                    نعم
                                                                @else
                                                                    ليس لدية بصمة
                                                                @endif
                                                            </td>


                                                        </tr>
                                                        <tr>
                                                            <td class="wd-300 back">هل له شفت ثابت</td>
                                                            <td>
                                                                @if ($data->has_fixed_shift == 'Yes')
                                                                    نعم
                                                                @else
                                                                    ليس له شفت ثابت
                                                                @endif
                                                            </td>
                                                        </tr>
                                                        @if ($data['has_fixed_shift'] == 'Yes')
                                                            <tr>
                                                                <td class="wd-300 back">توقيت الشفت</td>
                                                                <td>


                                                                    @if ($data->shiftTypes->type == 1)
                                                                        صباحى
                                                                    @elseif ($data->shiftTypes->type == 2)
                                                                        مسائى
                                                                    @elseif($data->shiftTypes->type == 3)
                                                                        يوم كامل
                                                                    @else
                                                                        لا يوجد له شفت ثابت
                                                                    @endif

                                                                    @php
                                                                        // تحويل from_time و to_time إلى كائنات Carbon
                                                                        $fromTime = \Carbon\Carbon::parse(
                                                                            $data->shiftTypes->from_time,
                                                                        );
                                                                        $toTime = \Carbon\Carbon::parse(
                                                                            $data->shiftTypes->to_time,
                                                                        );

                                                                        // تنسيق الوقت بنظام 12 ساعة مع AM/PM
                                                                        $formattedFromTime = $fromTime->format('g:i A'); // تنسيق 12 ساعة
                                                                        $formattedToTime = $toTime->format('g:i A');

                                                                        // تحويل AM/PM إلى النص العربي (صباحًا/مساءً)
                                                                        $formattedFromTimeArabic =
                                                                            $fromTime->format('A') == 'AM'
                                                                                ? 'صباحًا'
                                                                                : 'مساءً';
                                                                        $formattedToTimeArabic =
                                                                            $toTime->format('A') == 'AM'
                                                                                ? 'صباحًا'
                                                                                : 'مساءً';
                                                                    @endphp

                                                                    <!-- عرض التوقيت بنظام 12 ساعة مع النص العربي -->
                                                                    {{ $fromTime->format('g:i') }}
                                                                    {{ $formattedFromTimeArabic }} إلى
                                                                    {{ $toTime->format('g:i') }}
                                                                    {{ $formattedToTimeArabic }} عدد ساعات العمل
                                                                    {{ $data->shiftTypes->total_hours }} ساعة

                                                                </td>
                                                            </tr>
                                                        @endif
                                                        <tr>
                                                            <td class="wd-300 back">عدد ساعات العمل اليومي</td>
                                                            <td>{{ $data->daily_work_hour }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">أضافة سنوات الخدمه</td>
                                                            <td>
                                                                @if ($data->add_service > 0)
                                                                    {{ $data->add_service }}
                                                                @else
                                                                    لا يوجد له ضم مده
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">عدد سنوات الخدمه</td>
                                                            <td>{{ $data->years_service }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رصيد الأجازات</td>
                                                            <td>{{ $data->num_vacation_days }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">راتب الموظف الشهري</td>
                                                            <td>
                                                                {{ $data->salary }}


                                                                <button data-id="{{ $data['id'] }}" data-toggle="modal"
                                                                    data-target="#salaryArchivedModal"
                                                                    class="btn btn-primary modal-effect showSalaryArchived"><i
                                                                        class="typcn typcn-folder"></i> الراتب
                                                                    المؤرشف</button>

                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">راتب الموظف اليومى</td>
                                                            <td>
                                                                {{ $data->day_price }}
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل له حافز</td>
                                                            <td>
                                                                @if ($data->motivation_type == 'Fixed')
                                                                    ثابت
                                                                @elseif($data->motivation_type == 'Changeable')
                                                                    متغير
                                                                @else
                                                                    لا يوجد
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">قيمة الحافز الشهري الثابت</td>
                                                            <td>
                                                                @if ($data->motivation > 0)
                                                                    {{ $data->motivation }}
                                                                @else
                                                                    لا يوجد له حافز
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل له تأمين اجتماعي</td>
                                                            <td>
                                                                @if ($data->social_insurance == 'Yes')
                                                                    نعم
                                                                @else
                                                                    لا يوجد له تأمين اجتماعي
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">قيمة التأمين الاجتماعي المستقطع شهرياً
                                                            </td>
                                                            <td>
                                                                @if ($data->social_insurance_cut_monthely > 0)
                                                                    {{ $data->social_insurance_cut_monthely * 1 }}
                                                                @else
                                                                    لا يوجد له تأمين مستقطع
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رقم التامين الاجتماعي للموظف</td>
                                                            <td>
                                                                @if ($data->social_insurance_number > 0)
                                                                    {{ $data->social_insurance_number }}
                                                                @else
                                                                    لا يوجد له رقم تامين الاجتماعي
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل له تأمين طبي</td>
                                                            <td>
                                                                @if ($data->medical_insurance == 'Yes')
                                                                    نعم
                                                                @else
                                                                    لا يوجد له تأمين طبي
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">قيمة التأمين الطبي المستقطع شهرياً</td>
                                                            <td>
                                                                @if ($data->medical_insurance_cut_monthely > 0)
                                                                    {{ $data->medical_insurance_cut_monthely }}
                                                                @else
                                                                    لا يوجد له تأمين مستقطع
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رقم التامين الطبي للموظف</td>
                                                            <td>
                                                                @if ($data->medical_insurance_number > 0)
                                                                    {{ $data->medical_insurance_number }}
                                                                @else
                                                                    لا يوجد له رقم تامين طبي
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">نوع صرف راتب الموظف</td>
                                                            <td>
                                                                @if ($data->Type_salary_receipt == 'Cach')
                                                                    كاش
                                                                @else
                                                                    فيزا
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل له رصيد اجازات سنوي</td>
                                                            <td>
                                                                @if ($data->active_vacation == 'Yes')
                                                                    نعم
                                                                @else
                                                                    لا يوجد له رصيد اجازات سنوي
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">شخص يمكن الرجوع اليه للضرورة</td>
                                                            <td>{{ $data->urgent_person_details }} </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">هل له بدلات ثابتة</td>
                                                            <td>
                                                                @if ($data->fixed_allowances == 1)
                                                                    نعم
                                                                @else
                                                                    لا يوجد له بدلات ثابتة
                                                                @endif
                                                            </td>
                                                        </tr>



                                                    </table>
                                                </div>
                                            </div>



                                            <hr>
                                            @if ($data['fixed_allowances'] == 1)
                                                <div class="mb-3 mb-xl-0">
                                                    <div class="btn-group dropdown">
                                                        <a class="modal-effect btn btn-outline-primary btn-block"
                                                            data-effect="effect-super-scaled" data-toggle="modal"
                                                            href="#modaldemo8"> <i class="fas fa-plus-circle"></i>
                                                            أضافة
                                                            بدل ثابت
                                                            جديد</a>
                                                    </div>
                                                    @include('dashboard.affairs_employees.employees.fixed_allowance')
                                                </div>
                                                {{-- Fixed Allowances Table --}}
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        @if (isset($data['fixed_allowances']) &&
                                                                !empty($data['fixed_allowances']) &&
                                                                is_int($data['fixed_allowances']) &&
                                                                $data['fixed_allowances'] > 0)
                                                            <table class="table table-striped mg-b-0 text-md-nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>أسم البدل الثابت</th>
                                                                        <th>قيمة البدل</th>
                                                                        <th>ملاحظات</th>
                                                                        <th>الأضافة بواسطة</th>
                                                                        <th>التحديث بواسطة</th>
                                                                        <th>العمليات</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    @php $i = 0;@endphp
                                                                    @foreach ($data['employee_fixed_allowances'] as $info)
                                                                        @php $i++;@endphp
                                                                        <tr>
                                                                            <th scope="row">{{ $i }}
                                                                            </th>
                                                                            <td>{{ $info->allowance?->name }}</td>
                                                                            <td>{{ $info->value }}</td>
                                                                            <td>{{ $info->notes }}</td>
                                                                            <td>{{ $info->createdByAdmin ? $info->createdByAdmin->name : 'لا يوجد' }}
                                                                            </td>
                                                                            <td>
                                                                                @if ($info->updated_by > 0)
                                                                                    {{ $info->updatedByAdmin?->name }}
                                                                                @else
                                                                                    <span class="text">لا يوجد</span>
                                                                                @endif
                                                                            </td>

                                                                            <td>
                                                                                {{-- Edit --}}
                                                                                <button
                                                                                    class="modal-effect btn load_edit_this_allowances btn-outline-info btn-sm"
                                                                                    data-effect="effect-scale"
                                                                                    data-toggle="modal"
                                                                                    data-id="{{ $info->id }}"><i
                                                                                        class="fas fa-edit ml-1"></i>تعديل</button>


                                                                                {{-- Delete --}}
                                                                                <a class="modal-effect btn btn-outline-danger btn-sm"
                                                                                    data-effect="effect-scale"
                                                                                    data-toggle="modal"
                                                                                    href="#delete{{ $info->id }}">
                                                                                    <i
                                                                                        class="fas fa-trash-alt ml-1"></i>حذف</a>

                                                                            </td>
                                                                            @include('dashboard.affairs_employees.employees.delete_fixed_allowance')

                                                                        </tr>
                                                                    @endforeach
                                                                </tbody>
                                                            </table>
                                                        @else
                                                            <div class="alert alert-warning" role="alert"
                                                                dir="rtl">
                                                                <span class="alert-inner--icon"><i
                                                                        class="fe fe-info"></i></span>
                                                                <span class="alert-inner--text"><strong> عفواً
                                                                        :</strong> لا توجد مستندات لعرضها!</span>
                                                            </div>
                                                        @endif
                                                    </div><!-- bd -->
                                                </div>
                                            @endif
                                            {{-- End Row --}}
                                        </div>
                                        {{-- End tab5 --}}

                                        <div class="tab-pane" id="tab6">
                                            {{-- بيانات إضافية --}}
                                            <div class="table-container">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered mg-b-0 text-md-nowrap">
                                                        <tr>
                                                            <td class="wd-300 back">اسم الكفيل</td>
                                                            <td>

                                                                @if ($data->name_sponsor > 0)
                                                                    {{ $data->name_sponsor }}
                                                                @else
                                                                    لا يوجد له كفيل
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">رقم الباسبور ان وجد</td>
                                                            <td>

                                                                @if ($data->pasport_identity > 0)
                                                                    {{ $data->pasport_identity }}
                                                                @else
                                                                    لا يوجد له باسبور
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">جهة اصدار الباسبور</td>
                                                            <td>

                                                                @if ($data->pasport_from_place > 0)
                                                                    {{ $data->pasport_from_place }}
                                                                @else
                                                                    لا يوجد له باسبور
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">تاريخ انتهاء الباسبور</td>
                                                            <td>

                                                                @if ($data->pasport_exp_date > 0)
                                                                    {{ $data->pasport_exp_date }}
                                                                @else
                                                                    لا يوجد له باسبور
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">الصورة الشخصية للموظف</td>
                                                            <td>
                                                                @if ($data['image'])
                                                                    <img class="img-thumbnail rounded me-2 mt-2"
                                                                        alt="200x200" style="width: 300px; height:200"
                                                                        src="{{ asset('dashboard/assets/uploads/employees/photo/' . $data['image']->filename) }}"
                                                                        data-holder-rendered="true">
                                                                    <a class=" col-6 btn ripple btn-primary mt-2 btn-block"
                                                                        href="{{ asset('dashboard/assets/uploads/employees/photo/' . $data['image']->filename) }}"
                                                                        download>
                                                                        <i class="fas fa-download"></i>
                                                                        تحميل الصورة الشخصية</a>
                                                                @else
                                                                    لا يوجد صورة شخصية
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="wd-300 back">السيرة الذاتية للموظف</td>
                                                            <td>
                                                                @if ($data['image'])
                                                                    <div class="mb-3 mt-2">
                                                                        <a href="{{ asset('dashboard/assets/uploads/employees/cv/' . $data['cv']) }}"
                                                                            target="_blank">
                                                                            <a class="btn ripple btn-primary"
                                                                                href="{{ asset('dashboard/assets/uploads/employees/cv/' . $data['cv']) }}"
                                                                                download>
                                                                                <i class="fas fa-download"></i>
                                                                                تحميل السيرة الذاتية</a>
                                                                    </div>
                                                                @else
                                                                    لا يوجد سيرة ذاتية
                                                                @endif
                                                            </td>
                                                        </tr>

                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="tab-pane" id="tab7">
                                            {{-- بيانات إضافية --}}
                                            <div class="row">
                                                <div class="col-md-12 text-center mb-3">
                                                    <h5>المستندات الخاصة بـ <span
                                                            class="text-danger">{{ $data['name'] }}</span></h5>



                                                    <div class="col-lg-12 col-md-12">
                                                        <div class="card">
                                                            <div class="card-body">

                                                                <div class="row">
                                                                    <div
                                                                        class="col-md-10 col-lg-8 col-xl-6 mx-auto d-block">
                                                                        <div
                                                                            class="card card-body pd-20 pd-md-40 border shadow-none">
                                                                            <h5 class="card-title mg-b-20">أضف مستند
                                                                                جديده
                                                                            </h5>

                                                                            <form
                                                                                action="{{ route('dashboard.employees.add_files', $data['id']) }}"
                                                                                method="POST"
                                                                                enctype="multipart/form-data">
                                                                                @csrf
                                                                                <div class="form-group mb-3">
                                                                                    <label
                                                                                        class="main-content-label tx-11 tx-medium tx-gray-600">أسم
                                                                                        المستند</label>
                                                                                    <input type="text" name="desc_file"
                                                                                        id="desc_file"
                                                                                        class="form-control"
                                                                                        value="" required
                                                                                        oninvalid="setCustomValidity('من فضلك أدخل وصف هذا المرفق')"
                                                                                        onchange="try{setCustomValidity('')}catch(e){}">
                                                                                    @error('desc_file')
                                                                                        <span
                                                                                            class="text-danger">{{ $message }}</span>
                                                                                    @enderror
                                                                                </div>
                                                                                <div class="form-group mb-3">
                                                                                    <label
                                                                                        class="main-content-label tx-11 tx-medium tx-gray-600">المرفقات
                                                                                    </label>
                                                                                    <div class="pos-relative">
                                                                                        <input type="file"
                                                                                            name="file_path"
                                                                                            id="file_path" value=""
                                                                                            class="dropify"
                                                                                            data-height="100" required
                                                                                            oninvalid="setCustomValidity('من فضلك أضف المرفق')"
                                                                                            onchange="try{setCustomValidity('')}catch(e){}" />
                                                                                        @error('file_path')
                                                                                            <span
                                                                                                class="text-danger">{{ $message }}</span>
                                                                                        @enderror

                                                                                    </div>
                                                                                </div>

                                                                                <button
                                                                                    class="btn btn-main-primary btn-block">أضف</button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    {{-- Table --}}
                                                    <div class="card-body">
                                                        <div class="table-responsive">
                                                            @if (isset($other['employee_files']) && !empty($other['employee_files']) && count($other['employee_files']) > 0)
                                                                <table class="table table-striped mg-b-0 text-md-nowrap">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>#</th>
                                                                            <th>أسم الملف</th>
                                                                            <th>تحميل الملف</th>
                                                                            <th>العمليات</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        @php $i = 0;@endphp
                                                                        @foreach ($other['employee_files'] as $info)
                                                                            @php $i++;@endphp
                                                                            <tr>
                                                                                <th scope="row">{{ $i }}
                                                                                </th>
                                                                                <td>{{ $info->desc_file }}</td>

                                                                                <td> <a class="btn btn-primary"
                                                                                        href="{{ asset('dashboard/assets/uploads/employees/new/' . $info['file_path']) }}"
                                                                                        target="_blank"> <i
                                                                                            class="fas fa-download"></i>
                                                                                        تحميل </a>
                                                                                </td>
                                                                                <td>
                                                                                    {{-- Delete --}}
                                                                                    <a class="modal-effect btn btn-outline-danger btn-sm"
                                                                                        data-effect="effect-scale"
                                                                                        data-toggle="modal"
                                                                                        href="#delete{{ $info->id }}">
                                                                                        <i
                                                                                            class="fas fa-trash-alt ml-1"></i>حذف</a>
                                                                                </td>
                                                                                @include('dashboard.affairs_employees.employees.delete_file')
                                                                            </tr>
                                                                        @endforeach
                                                                    </tbody>
                                                                </table>
                                                            @else
                                                                <div class="alert alert-warning" role="alert"
                                                                    dir="rtl">
                                                                    <span class="alert-inner--icon"><i
                                                                            class="fe fe-info"></i></span>
                                                                    <span class="alert-inner--text"><strong> عفواً
                                                                            :</strong> لا توجد ملفات لعرضها!</span>
                                                                </div>
                                                            @endif
                                                        </div><!-- bd -->
                                                    </div>

                                                </div>

                                            </div>

                                        </div>
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
