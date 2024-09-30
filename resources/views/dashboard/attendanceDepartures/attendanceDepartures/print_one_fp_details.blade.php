@extends('dashboard.layouts.master')
@section('title', 'طباعه الحضور والإنصراف')
@section('css')
    <style>
        @media print {
            #print_Button {
                display: none;
            }
        }
    </style>
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">

                <h5 class="content-title mb-0 my-auto">طباعه مفصلة للحضور والإنصراف
                    {{ $finance_cln_periods_data->month->name }}</h5><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.attendanceDepartures.showAttendanceDetails', ['employee_code' => $other['employee_data'], 'finance_cln_periods_id' => $finance_cln_periods_data['id']]) }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i>قائمة الموظفين جهاز البصمة
                    </a>
                </span>
            </div>
        </div>
        <div class="d-flex my-xl-auto right-content">
            <a href="#" class="btn btn-danger float-left mt-3 mr-2" id="print_Button" onclick="printDiv()">
                <i class="mdi mdi-printer ml-1"></i>طباعة
            </a>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row" id="print">

        <div class="col-xl-12">
            <div class="card mg-b-20">
                <div class="card-header pb-0 m-auto">
                    <div class="d-flex justify-content-between">
                        <h4>طباعة الحضور والإنصراف عن فتره
                            <span class="text-danger">{{ $finance_cln_periods_data->start_date_fp }}</span> إلى
                            <span class="text-danger">{{ $finance_cln_periods_data->end_date_fp }}</span>
                        </h4>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive mb-4">
                        @if (isset($other['data']) && $other['data']->isNotEmpty())
                            <table class="table table-bordered mg-b-0 text-md-nowrap">
                                <thead style="background-color: #D8D9DA">
                                    <tr>
                                        <th>كود بصمة الموظف</th>
                                        <th>كود الموظف</th>
                                        <th>أسم الموظف</th>
                                        <th>الفرع</th>
                                        <th>أسم الوظيفه</th>
                                        <th>الحالة الوظيفية</th>
                                        <th>عدد ساعات العمل</th>
                                        <th>تاريخ التعيين</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">{{ $other['employee_data']['fp_code'] }}</th>
                                        <th>{{ $other['employee_data']['employee_code'] }}</th>
                                        <td>{{ $other['employee_data']['name'] }}</td>
                                        <td>{{ $other['employee_data']->branch->name }}</td>
                                        <td>{{ $other['employee_data']->jobCategories->name }}</td>
                                        <td>
                                            @if ($other['employee_data']['functional_status'] == 'Employee')
                                                موظف
                                            @else
                                                لا يعمل
                                            @endif
                                        </td>
                                        <td>{{ $other['employee_data']['daily_work_hour'] }}</td>
                                        <td>{{ $other['employee_data']['work_start_date'] }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        @else
                            <div class="alert alert-warning" role="alert" dir="rtl">
                                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                                    لعرضها!</span>
                            </div>
                        @endif

                    </div>




                    <div class="table-responsive">
                        <table class="table table-bordered mg-b-0 text-md-nowrap">
                            <thead style="background-color: #D8D9DA">
                                <tr>
                                    <th>التاريخ</th>
                                    <th>الحضور</th>
                                    <th>الأنصراف</th>
                                    <th>البصمات</th>
                                    <th>المتغيرات</th>
                                    <th>حضور متأخر</th>
                                    <th>إنصراف مبكر</th>
                                    <th>أذون ساعات</th>
                                    <th>ساعات عمل</th>
                                    <th>غياب ساعات</th>
                                    <th>اضافى ساعات</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($other['data'] as $info)
                                    <tr @if ($info->date_time_in == null && $info->date_time_out == null) style="background-color:#D8D9DA;" @endif>
                                        <th scope="row" class="text-center">
                                            {{ $info->week_day_name_ar }}
                                            {{ $info->the_day_date }}
                                        </th>
                                        <td class="text-center">
                                            @if ($info->date_time_in != null)
                                                @php echo date("H:i", strtotime($info->date_time_in)) @endphp
                                            @endif
                                        </td>
                                        <td class="text-center">
                                            @if ($info->date_time_out != null)
                                                @php echo date("H:i", strtotime($info->date_time_out)) @endphp
                                            @endif
                                        </td>
                                        <td>{{ $info->attendance_departure_actions_counter }} </td>
                                        <td>{{ $info->variables }} </td>
                                        <td>{{ $info->attendance_delay * 1 }}</td>
                                        <td>{{ $info->early_departure * 1 }}</td>
                                        <td>{{ $info->permission_hours }}</td>
                                        <td>{{ $info->total_hours * 1 }}</td>
                                        <td>{{ $info->absence_hours * 1 }}</td>
                                        <td>{{ $info->additional_hours * 1 }}</td>
                                    </tr>
                                @endforeach
                                <tr class="totaly" style="background-color: #8590af;color: #1f1e1e;">
                                    <td class="text-center" style="background-color:#dde2ef;color:#4a4a4a" colspan="5">
                                        <h4 style="font-weight: bold">الأجمالى</h4>

                                    </td>
                                    <td class="text-center">{{ $other['total_attendance_delay'] * 1 }} دقيقه</td>
                                    <td class="text-center">{{ $other['total_early_departure'] * 1 }} دقيقه</td>
                                    <td class="text-center">{{ $other['total_permission_hours'] * 1 }} يوم</td>
                                    <td class="text-center">{{ $other['total_hours_total'] * 1 }} ساعه</td>
                                    <td class="text-center">{{ $other['total_absence_hours'] * 1 }} ساعه</td>
                                    <td class="text-center">{{ $other['total_additional_hours'] * 1 }} ساعه</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>


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
    <!--Internal  Chart.bundle js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/chart.js/Chart.bundle.min.js') }}"></script>

    <script type="text/javascript">
        function printDiv() {
            var printContents = document.getElementById('print').innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
            location.reload();
        }
    </script>
@endsection
