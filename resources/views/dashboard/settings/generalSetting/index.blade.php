@extends('dashboard.layouts.master')
@section('title', 'الضبط العام')
@section('css')
<style>
    .table-responsive {
    margin: 20px 0;
    padding: 15px;
    background-color: #f7f9fc;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    font-size: 1rem;
    color: #333;
}

.table td, 
.table th {
    padding: 15px;
    text-align: right;
    vertical-align: middle;
    border: 1px solid #dee2e6;
}

.table th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

.table tr:nth-child(even) {
    background-color: #f2f2f2;
}

.table tr:hover {
    background-color: #e9ecef;
    transition: background-color 0.3s;
}

h6 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: bold;
    color: #333;
}

.badge {
    padding: 5px 10px;
    font-size: 0.9rem;
    border-radius: 5px;
}

.badge-primary {
    background-color: #007bff;
    color: white;
}

.badge-danger {
    background-color: #dc3545;
    color: white;
}

.badge-success {
    background-color: #28a745;
    color: white;
}

.img-thumbnail {
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.btn-info-gradient {
    background: linear-gradient(45deg, #007bff, #00c3ff);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    transition: background 0.3s;
}

.btn-info-gradient:hover {
    background: linear-gradient(45deg, #0056b3, #00aaff);
}

</style>
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">الضبط العام</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول الضبط العام</span>
            </div>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row">
        @include('dashboard.messages_alert')


        @if (@isset($data) && !@empty($data))
            <div class="col-xl-12">
                <div class="card mg-b-20">
                    <div class="card-header pb-0">
                        <div class="d-flex justify-content-between">
                            <h4 class="card-title mg-b-0">جدول الضبط العام</h4>
                            <i class="mdi mdi-dots-horizontal text-gray"></i>
                        </div>
                        {{-- <p class="tx-12 tx-gray-500 mb-2">Example of Valex Bordered Table.. <a href="">Learn more</a></p> --}}
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered mg-b-0 text-md-nowrap">
                                <tr>
                                    <td class="wd-500">اسم الشركة</td>
                                    <td> {{ $data['company_name'] }}</td>
                                </tr>
                                <tr>
                                    <td class="wd-500"> حالة التفعيل</td>
                                    <td>
                                        @if ($data['system_status'] == 1)
                                            مفعل
                                        @else
                                            معطل
                                        @endif
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">هاتف الشركة</td>
                                    <td> {{ $data['phons'] }}</td>
                                </tr>
                                <tr>
                                    <td class="wd-500">عنوان الشركة</td>
                                    <td> {{ $data['address'] }}</td>
                                </tr>
                                <tr>
                                    <td class="wd-500">بريد الشركة</td>
                                    <td> {{ $data['email'] }}</td>
                                </tr>

                                <tr>
                                    <td class="wd-500"> الحد الأقصى لاحتساب عدد ساعات عمل اضافية عند انصراف الموظف واحتساب
                                        بصمة الانصراف و الاستحتسب على انها بصمة حضور شفت جديد</td>
                                    <td>

                                        <h6>{{ $data['max_hours_take_fp_as_addtional'] * 1 }}
                                            <span class="badge badge-primary">
                                                @if ($data['max_hours_take_fp_as_addtional'] <= 10)
                                                    ساعات
                                                @else
                                                    ساعه
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="wd-500"> بعد كام دقيقة نحسب تاخير حضور </td>
                                    <td>
                                        <h6>{{ $data['after_minute_calculate_delay'] * 1 }}
                                            <span class="badge badge-danger">
                                                @if ($data['after_minute_calculate_delay'] <= 10)
                                                    دقائق
                                                @else
                                                    دقيقة
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500"> بعد كام دقيقة نحسب انصراف مبكر </td>
                                    <td>
                                        <h6>{{ $data['after_minute_calculate_early_departure'] * 1 }}
                                            <span class="badge badge-danger">
                                                @if ($data['after_minute_calculate_early_departure'] <= 10)
                                                    دقائق
                                                @else
                                                    دقيقة
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500"> بعد كام مره تأخير او إنصراف مبكر نخصم ربع يوم
                                    </td>
                                    <td>
                                        <h6>{{ $data['after_minute_quarterday'] * 1 }}
                                            <span class="badge badge-danger">
                                                @if ($data['after_minute_quarterday'] <= 10)
                                                    دقائق
                                                @else
                                                    دقيقة
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500"> بعد كام مرة تأخير او أنصراف مبكر نخصم نص يوم </td>
                                    <td>
                                        <h6>{{ $data['after_time_half_daycut'] * 1 }}
                                            <span class="badge badge-primary">
                                                @if ($data['after_time_half_daycut'] <= 10)
                                                    ساعات
                                                @else
                                                    ساعه
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">نخصم بعد كام مره تاخير او أنصراف مبكر يوم كامل </td>
                                    <td>
                                        <h6>{{ $data['after_time_allday_daycut'] * 1 }}
                                            <span class="badge badge-primary">
                                                @if ($data['after_time_allday_daycut'] <= 10)
                                                    مرات
                                                @else
                                                    مره
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">أقل من كام دقيقة فرق بين البصمة الأولى والثانية يتم إهمال
                                        البصمة
                                    </td>
                                    <td>
                                        <h6>{{ $data['less_than_minute_neglecting_fp'] * 1 }}
                                            <span class="badge badge-danger">
                                                @if ($data['less_than_minute_neglecting_fp'] <= 10)
                                                    دقائق
                                                @else
                                                    دقيقة
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">رصيد اجازات الموظف الشهري </td>
                                    <td>
                                        <h6>{{ $data['monthly_vacation_balance'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['monthly_vacation_balance'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">بعد كام يوم ينزل للموظف رصيد اجازات </td>
                                    <td>
                                        <h6>{{ $data['after_days_begin_vacation'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['after_days_begin_vacation'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">الرصيد الاولي المرحل عند تفعيل الاجازات للموظف مثل نزول عشرة ايام
                                        ونص بعد سته شهور للموظف </td>
                                    <td>
                                        <h6>{{ $data['first_balance_begin_vacation'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['first_balance_begin_vacation'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">قيمة خصم الايام بعد اول مرة غياب بدون اذن </td>
                                    <td>
                                        <h6>{{ $data['sanctions_value_first_absence'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['sanctions_value_first_absence'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">قيمة خصم الايام بعد ثاني مرة غياب بدون اذن </td>
                                    <td>
                                        <h6>{{ $data['sanctions_value_second_absence'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['sanctions_value_second_absence'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">قيمة خصم الايام بعد ثالث مرة غياب بدون اذن </td>
                                    <td>
                                        <h6>{{ $data['sanctions_value_thaird_absence'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['sanctions_value_thaird_absence'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">قيمة خصم الايام بعد رابع مرة غياب بدون اذن </td>
                                    <td>
                                        <h6>{{ $data['sanctions_value_forth_absence'] * 1 }}
                                            <span class="badge badge-success">
                                                @if ($data['sanctions_value_forth_absence'] <= 10)
                                                    أيام
                                                @else
                                                    يوم
                                                @endif
                                            </span>
                                        </h6>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wd-500">شعار الشركة</td>
                                    <td>
                                        @if ($data['image'])
                                            <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
                                                style="width: 100px; height:100"
                                                src="{{ asset('dashboard/assets/uploads/admin_setting/' . $data['image']) }}"
                                                data-holder-rendered="true">
                                        @else
                                            <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
                                                style="width: 100px; height:100"
                                                src="{{ asset('dashboard/assets/img/default-logo.png') }}"
                                                data-holder-rendered="true">
                                        @endif
                                    </td>
                                </tr>
                                <tr>
                                    @can('تعديل الضبط العام')
                                        <td colspan="2" class="text-center">
                                            <a href="{{ route('dashboard.generalSettings.edit', $data->id) }}"
                                                class="btn btn-info-gradient col-4">تعديل</a>
                                        </td>
                                    @endcan
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        @else
            <div class="alert alert-warning" role="alert" dir="rtl">
                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
            </div>
        @endif
    </div>
    <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    <!-- main-content closed -->
@endsection
@section('js')
@endsection
