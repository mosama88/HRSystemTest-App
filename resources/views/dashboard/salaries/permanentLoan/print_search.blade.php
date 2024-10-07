@extends('dashboard.layouts.master')
@section('title','طباعة السلف المستديمة')
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
    <div class="breadcrumb-header justify-content-between" id="breadcrumb-header">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">طباعه </h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    طباعة السلف المستديمة</span>
            </div>
        </div>

    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    <div class="row row-sm">
        <div class="col-md-12 col-xl-12">
            <div class=" main-content-body-invoice" id="print">
                <div class="card card-invoice">
                    <div class="card-body">
                        <div class="invoice-header">
                            <h1 class="invoice-title">السلف المستديمة للموظفين</h1>


                            <div class="billed-from">


                                @if ($systemData['image'])
                                    <img class="main-img-user avatar-xxl d-none d-sm-block mb-3" alt="200x200"
                                        src="{{ asset('dashboard/assets/uploads/admin_setting/' . $systemData['image']) }}"
                                        data-holder-rendered="true">
                                @else
                                    <img class="main-img-user avatar-xxl d-none d-sm-block" alt="200x200"
                                        src="{{ asset('dashboard/assets/img/default-logo.png') }}"
                                        data-holder-rendered="true">
                                @endif


                                <h6>{{ $systemData->company_name }}</h6>
                                <p>{{ $systemData->address }}<br>
                                    {{ $systemData->email }}</p>
                            </div><!-- billed-from -->
                        </div><!-- invoice-header -->
                        <div class="row mg-t-20">
                            <div class="col-md">
                                <label class="tx-gray-600">طبع بواسطة</label>
                                <div class="billed-to">
                                    <h6> {{ auth()->user()->name }} </h6>
                                    <label class="tx-gray-600">تاريخ الطباعه</label>

                                    <h6> @php echo date('Y-m-d'); @endphp </h6>
                                </div>
                            </div>
                            <div class="col-md">
                                <label class="tx-gray-600">تفاصيل السلف</label>
                                <p class="invoice-info-row"><span>اجمالى السلف بالجنية</span>
                                    <span> {{ $other['total_sum'] * 1 }} جنية </span>
                                </p>

                                <p class="invoice-info-row">
                                </p>

                            </div>
                        </div>
                        <div class="table-responsive mg-t-40">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th style="width: 5%">#</th>
                                        <th style="width: 5%">كود الموظف</th>
                                        <th style="width: 20%">أسم الموظف</th>
                                        <th style="width: 10%">قيمة السلفة</th>
                                        <th style="width: 10%">عدد شهور الأقساط</th>
                                        <th style="width: 10%">قيمة القسط</th>
                                        <th style="width: 10%">هل صرفت</th>
                                        <th style="width: 10%">هل الأقساط أنتهت</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $i = 0; ?>
                                    @foreach ($data as $info)
                                        <?php $i++; ?>
                                        <tr>
                                            <td>{{ $i }}</td>
                                            <td class="text-right">{{ $info->employee_code }}</td>
                                            <td class="text-right">{{ $info->name }}</td>
                                            <td class="text-right">{{ $info->total * 1 }} جنية</td>
                                            <td class="text-right">{{ $info->month_number_installment }} شهرآ</td>
                                            <td class="text-right">{{ $info->month_installment_value }} جنية
                                            </td>
                                            <td class="text-right">
                                                @if ($info->has_disbursed_done == 1)
                                                    <span class="badge badge-primary">نعم</span>
                                                @else
                                                    <span class="badge badge-danger">لا</span>
                                                @endif
                                            </td>
                                            <td>
                                                @if ($info->is_archived == 1)
                                                    <span class="badge badge-primary">نعم</span>
                                                @else
                                                    <span class="badge badge-danger">لا</span>
                                                @endif
                                            </td>
                                        <tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <hr class="mg-b-40">
                        <a href="#" class="btn btn-danger float-left mt-3 mr-2" id="print_Button"
                            onclick="printDiv()">
                            <i class="mdi mdi-printer ml-1"></i>طباعة
                        </a>
                    </div>
                </div>
            </div>
        </div><!-- COL-END -->
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
