@extends('dashboard.layouts.master')
@section('css')
    <style>
        @media print {
            .hidden-print {
                display: none;
            }
        }

        @media print {
            #printButton {
                display: none;
            }
        }

        .custom_td_fisrt {
            width: 30%;
            background-color: lightcyan !important;
        }

        /*    .tdheader{
                                                top: 0;
                                                position: sticky;
                                                background: yellow;
                                                color: black;
                                                }*/
        td,
        th {
            text-align: center;
            color: black;
        }

        .underPrag {
            text-decoration: underline;
            font-size: 14px;
            color: black;
            font-weight: bold;
            margin: 7px;
        }

        .maintd {
            font-size: 14px;
        }

        span {
            padding-top: 1px;
            padding-bottom: 1px;
        }

        @media print {
            @page {
                size: landscape
            }

            ;
        }

        @media print {
            .tdheader {
                height: 100px;
            }
        }
    </style>
    <link href="{{ URL::asset('dashboard/assets/css/tableDetailsMainSalary.css') }}" rel="stylesheet">
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">طباعة </h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ طباعة بحث
                    إجمالى مفصل لكل الموظفين</span>
            </div>
        </div>


    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row" id="print">

        <table dir="rtl" cellspacing="1" cellpadding="1" border="1"
            style="text-align:right;border-color: black; width: 98%; background-color: white  !important;  margin: 0 auto;  ">
            <tr>
                <td colspan="24" class="text-right maintd "
                    style="padding-right:10px !important;text-align: center !important;">
                    بحث الرواتب بالشهر المالي ({{ $finance_cln_periods_data['month']->name }} لسنة
                    {{ $finance_cln_periods_data['finance_yr'] }})
                </td>
            </tr>
            <tr style="background-color: lemonchiffon  !important">
                <td class="tdheader" rowspan="2"><span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">الرقم
                        الوظيفي</span> </td>
                <td class="tdheader" style="width: 15%;" rowspan="2"><span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        الاسم</span></td>
                <td class="tdheader" rowspan="2"><span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        الوظيفة</span></td>
                <td colspan="8" style="font-size: 14px;font-weight: bold;">الاستحقاقات</td>
                <td class="tdheader" rowspan="2"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        اجمالي الاستحقاقات </span></td>
                <td colspan="9" style="font-size: 14px;font-weight: bold;">الاستقطاعات</td>
                <td class="tdheader" rowspan="2"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        اجمالي الاستقطاعات </span></td>
                <td class="tdheader" rowspan="2"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        رصيد سابق مرحل</span></td>
                <td class="tdheader" rowspan="2"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        الراتب المستحق</span></td>
            </tr>
            <tr style="background-color: wheat  !important">
                <td class="tdheader"><span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        الراتب</span></td>
                <td class="tdheader"><span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">اجر
                        اليوم الواحد </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">مكافئات
                    </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">الحافز
                        قيمة </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">الاضافي
                        ايام </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">قيمة
                        الاضافي </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        بدلات ثابتة </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        بدلات متغيرة </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">ايام
                        الغياب </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        قيمة الغياب</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">الجزاء
                        ايام </span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        قيمة الجزاء</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        سلف شهرية</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        سلف مستديمة</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        خصومات مالية</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        تأمين طبي</span></td>
                <td class="tdheader"> <span
                        style="writing-mode: vertical-lr !important;
               -ms-writing-mode: tb-rl !important;;
               transform: rotate(180deg) !important;">
                        تأمين اجتماعي</span></td>
            </tr>
            @if (@isset($data) and !@empty($data) and count($data) > 0)
                @foreach ($data as $info)
                    <tr>
                        <td> {{ $info->employee_code }} </td>
                        <td>{{ $info->employee_name }}</td>
                        <td>{{ $info->job->name }}</td>
                        <td style="background-color: linen !important">{{ $info->salary_employee }}</td>
                        <td>{{ $info->day_price }}</td>
                        <td>{{ $info->total_rewards_salary * 1 }}</td>
                        <td>
                            @if (optional($info->employee)->motivation !== null)
                                {{ optional($info->employee)->motivation * 1 }}
                            @else
                                0
                            @endif
                        </td>
                        <td>{{ $info->additional_days_counter * 1 }}</td>
                        <td>{{ $info->additional_days_total * 1 }}</td>
                        <td>{{ $info->fixed_allowances * 1 }}</td>
                        <td>{{ $info->changeable_allowance * 1 }}</td>
                        <td style="background-color: lightcyan !important">
                            {{ $info->total_benefits * 1 }}</td>
                        <td>{{ $info->absence_days_counter * 1 }} </td>
                        <td>{{ $info->absence_days_total * 1 }} </td>
                        <td>{{ $info->sanctions_days_counter * 1 }} </td>
                        <td>{{ $info->sanctions_days_total * 1 }} </td>
                        <td>{{ $info->monthly_loan * 1 }}</td>
                        <td>{{ $info->permanent_loan * 1 }}</td>
                        <td>{{ $info->discount * 1 }}</td>
                        <td>{{ $info->medical_insurance_monthly * 1 }}</td>
                        <td>{{ $info->medical_social_monthly * 1 }}</td>
                        <td style="background-color: lightsalmon !important">{{ $info->total_deductions * 1 }}</td>
                        <td style="background-color: greenyellow !important">{{ $info->last_salary_remain_balance * 1 }}
                        </td>
                        <td style="background-color: lightgreen !important">{{ $info->net_salary * 1 }}</td>
                    </tr>
                @endforeach
                <tr style="background-color: lavender !important">
                    <td colspan="3">الاجماليات</td>
                    <td>{{ $total['salary_employee'] * 1 }}</td>
                    <td>{{ $total['day_price'] * 1 }}</td>
                    <td>{{ $total['total_rewards_salary'] * 1 }}</td>
                    <td>{{ $total['motivation'] * 1 }}</td>
                    <td>{{ $total['additional_days_counter'] * 1 }}</td>
                    <td>{{ $total['additional_days_total'] * 1 }}</td>
                    <td>{{ $total['fixed_allowances'] * 1 }}</td>
                    <td>{{ $total['changeable_allowance'] * 1 }}</td>
                    <td style="background-color: lightsalmon !important">{{ $total['total_benefits'] * 1 }}</td>
                    <td>{{ $total['absence_days_counter'] * 1 }}</td>
                    <td>{{ $total['absence_days_total'] * 1 }}</td>
                    <td>{{ $total['sanctions_days_counter'] * 1 }}</td>
                    <td>{{ $total['sanctions_days_total'] * 1 }}</td>
                    <td>{{ $total['monthly_loan'] * 1 }}</td>
                    <td>{{ $total['permanent_loan'] * 1 }}</td>
                    <td>{{ $total['discount'] * 1 }}</td>
                    <td>{{ $total['medical_insurance_monthly'] * 1 }}</td>
                    <td>{{ $total['medical_social_monthly'] * 1 }}</td>
                    <td style="background-color: lightsalmon !important">{{ $total['total_deductions'] * 1 }}</td>
                    <td style="background-color: greenyellow !important">{{ $total['last_salary_remain_balance'] * 1 }}
                    </td>
                    <td style="background-color: lightsalmon !important">{{ $total['net_salary'] * 1 }}</td>
                </tr>
        </table>
    @else
        <div class="clearfix"></div>
        <p class="" style="text-align: center; font-size: 16px;font-weight: bold; color: brown">
            عفوا لاتوجد بيانات لعرضها !!
        </p>
        @endif
        <br>
        <p
            style="
         padding: 10px 10px 0px 10px;
         bottom: 0;
         width: 100%;
         /* Height of the footer*/
         text-align: center;font-size: 16px; font-weight: bold;
         ">
            {{ $systemData['address'] }} - {{ $systemData['phones'] }} </p>
        <div class="clearfix"></div>
        <br>


    </div>
    <!-- row closed -->
    <p class="text-center">

        <a href="#" class="btn btn-danger float-left ml-4 mt-3 mr-2" id="print_Button" onclick="printDiv()">
            <i class="mdi mdi-printer ml-1"></i>طباعة
        </a>

    </p>
    </div>
    <!-- Container closed -->
    </div>
    <!-- main-content closed -->
@endsection
@section('js')
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
