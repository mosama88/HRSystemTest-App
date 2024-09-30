@extends('dashboard.layouts.master')
@section('css')
    <style>
        @media print {
            #print_Button {
                display: none;
            }
        }
    </style>
    <link href="{{ URL::asset('dashboard/assets/css/tableDetailsMainSalary.css') }}" rel="stylesheet">
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between" id="breadcrumb-header">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">طباعه </h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.mainSalaryEmployees.show', $finance_cln_periods_data->id) }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول بيانات رواتب الموظفين
                    </a></span>
            </div>
        </div>

    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <?php
    
    use Carbon\Carbon;
    
    $currentDate = Carbon::now()->format('d-m-Y');
    ?>
    <a href="#" class="btn btn-danger float-left ml-4 mt-3 mr-2" id="print_Button" onclick="printDiv()">
        <i class="mdi mdi-printer ml-1"></i>طباعة
    </a>

    <div class="billed-from" id="print">

        <div class="card-body">
            <div class="my-3">


                @if ($systemData['image'])
                    <img class="main-img-user avatar-xxl d-none d-sm-block mb-3" alt="200x200"
                        src="{{ asset('dashboard/assets/uploads/admin_setting/' . $systemData['image']) }}"
                        data-holder-rendered="true">
                @else
                    <img class="main-img-user avatar-xxl d-none d-sm-block" alt="200x200"
                        src="{{ asset('dashboard/assets/img/default-logo.png') }}" data-holder-rendered="true">
                @endif


                <h6>{{ $systemData->company_name }}</h6>
                <p>{{ $systemData->address }}<br>
                    {{ $systemData->email }}</p>

            </div>
            <!-- Employee Information Section -->
            <table class="employee-info">
                <tr>
                    <th>اسم الموظف</th>
                    <td>{{ $mainSalaryEmployee_data->employee->name }}
                        ({{ $mainSalaryEmployee_data->employee->employee_code }})</td>
                </tr>
                <tr>
                    <th>الوظيفة</th>
                    <td>{{ $mainSalaryEmployee_data->job->name }}</td>
                </tr>
                <tr>
                    <td colspan="2" class="highlight">
                        @if ($mainSalaryEmployee_data['last_salary_remain_balance'] < 0)
                            ملحوظة الرصيد المرحل من الشهر السابق
                            <strong class="text-danger">
                                ( {{ $mainSalaryEmployee_data['last_salary_remain_balance'] }} )
                            </strong>
                        @else
                            ملحوظة الرصيد المرحل من الشهر السابق
                            <strong class="text-danger">
                                ( 0 )
                            </strong>
                        @endif
                        @if ($mainSalaryEmployee_data['is_stopped'] == 'stopped')
                            (هذا المرتب موقوف)
                        @endif
                    </td>

                </tr>
            </table>

            <!-- Entitlements Section -->
            <table class="entitlements-table">
                <thead>
                    <tr>
                        <td class="category-header"></td>
                        <th colspan="4">أولاً: الاستحقاقات</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="15" class="category-header vertical-text">الاستحقاقات</td>
                        <td>الراتب الأساسي</td>
                        <td>{{ $mainSalaryEmployee_data->employee->salary * 1 }}</td>
                    </tr>
                    <tr>
                        <td>حافز ثابت</td>
                        <td>{{ $mainSalaryEmployee_data->employee->motivation * 1 }}</td>
                    </tr>
                    <tr>
                        <td>بدلات ثابتة</td>
                        <td>{{ $mainSalaryEmployee_data->fixed_allowances * 1 }}</td>
                    </tr>
                    <tr>
                        <td>بدلات متغيرة</td>
                        <td>{{ $mainSalaryEmployee_data->changeable_allowance * 1 }}</td>
                    </tr>
                    <tr>
                        <td>إضافي أيام</td>
                        <td>عدد ({{ $mainSalaryEmployee_data->additional_days_counter * 1 }}) يوم
                            {{ $mainSalaryEmployee_data->additional_days_total * 1 }} جنية</td>
                    </tr>
                    <tr>
                        <td>مكافآت مالية</td>
                        <td>{{ $mainSalaryEmployee_data->total_rewards_salary * 1 }}</td>
                    </tr>
                    <tr>
                        <td>إجمالي الاستحقاقات</td>
                        <td>{{ $mainSalaryEmployee_data->total_benefits * 1 }}</td>
                    </tr>
                </tbody>
            </table>



            <!-- Deductions Section -->
            <table class="entitlements-table">
                <thead>
                    <tr>
                        <td class="category-header"></td>
                        <th colspan="4">ثانياً: الاستقطاعات</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Absence Row -->
                    <tr>
                        <td rowspan="15" class="category-header vertical-text">الاستقطاعات</td>
                        <td rowspan="2" class="category-header">الغياب</td>
                        <td colspan="2">عدد أيام الغياب</td>
                        <td>{{ $mainSalaryEmployee_data->absence_days_counter * 1 }} </td>
                    </tr>


                    <tr>
                        <td colspan="2">قيمة الغياب</td>
                        <td>{{ $mainSalaryEmployee_data->absence_days_total * 1 }}</td>
                    </tr>

                    <!-- Penalties Row -->
                    <tr>
                        <td rowspan="2" class="category-header">الجزاءات</td>
                        <td colspan="2">عدد أيام الجزاء</td>
                        <td>{{ $mainSalaryEmployee_data->sanctions_days_counter * 1 }} </td>
                    </tr>
                    <tr>
                        <td colspan="2">قيمة الجزاء</td>
                        <td>{{ $mainSalaryEmployee_data->sanctions_days_total * 1 }}</td>
                    </tr>


                    <!-- Loans Row -->
                    <tr>
                        <td rowspan="2" class="category-header">السلف</td>
                        <td colspan="2">سلف شهرية</td>
                        <td>{{ $mainSalaryEmployee_data->monthly_loan * 1 }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">سلف مستديمة</td>
                        <td>{{ $mainSalaryEmployee_data->permanent_loan * 1 }}</td>
                    </tr>

                    <!-- Deductions Row -->
                    <tr>
                        <td rowspan="4" class="category-header">الخصومات</td>
                        <td colspan="2">خصومات</td>
                        <td>{{ $mainSalaryEmployee_data->discount * 1 }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">تأمين اجتماعي</td>
                        <td>{{ $mainSalaryEmployee_data->medical_social_monthly * 1 }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">تأمين طبى</td>
                        <td>{{ $mainSalaryEmployee_data->medical_insurance_monthly * 1 }}</td>
                    </tr>

                    <!-- Total Deductions Row -->
                    <tr>
                        <td class="highlight-total" colspan="2">إجمالي الاستقطاعات</td>
                        <td class="highlight-total">{{ $mainSalaryEmployee_data->total_deductions * 1 }} جنيه</td>
                    </tr>
                </tbody>
            </table>

            <!-- Net Salary Section -->
            <div class="net-salary">
                @if ($mainSalaryEmployee_data->net_salary > 0)
                    مبلغ مستحق للموظف بقيمة <span class="text-danger">{{ $mainSalaryEmployee_data->net_salary * 1 }}</span>
                    جنية
                @elseif($mainSalaryEmployee_data->net_salary < 0)
                    مبلغ مستحق على الموظف بقيمة <span
                        class="text-danger">{{ $mainSalaryEmployee_data->net_salary * 1 * -1 }}
                    </span> جنية
                @else
                    لا يوجد له و لا علية
                @endif
                @if ($mainSalaryEmployee_data['is_archived'] == 1)
                    <strong class="float-left">
                        تم أرشفة المرتب بواسطة
                        <span class="text-danger">({{ $mainSalaryEmployee_data->updatedByAdmin->name }})
                            ({{ $mainSalaryEmployee_data->archived_date }})</span>
                    </strong>
                @endif
            </div>



            <div class="note">
                <span> <?php echo $currentDate; ?>
                </span>
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
