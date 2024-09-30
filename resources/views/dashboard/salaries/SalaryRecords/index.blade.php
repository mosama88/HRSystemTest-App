@extends('dashboard.layouts.master')
@section('title', 'الأجور')
@section('css')
    <!-- Internal Data table css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/buttons.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/jquery.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.dataTables.min.css') }}" rel="stylesheet">


    <!---Internal Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!---Internal  Multislider css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/multislider/multislider.css') }}" rel="stylesheet">
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">


    <!---Internal  Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!--- Internal Sweet-Alert css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/sweet-alert/sweetalert.css') }}" rel="stylesheet">

@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات السجلات الرئيسية للرواتب</h4><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    قائمة الأجور
                </span>
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
        <!--div-->
        <div class="col-xl-12">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="d-flex justify-content-between">
                        <h4 class="card-title mg-b-0">
                            جدول السجلات الرئيسية للرواتب
                        </h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>
                    <p class="tx-12 tx-gray-500 mb-2">

                    </p>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        @if ($data->isNotEmpty())
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>اسم الشهر </th>
                                            <th>سنة</th>
                                            <th>تاريخ البداية</th>
                                            <th>تاريخ النهاية</th>
                                            <th>بداية البصمة</th>
                                            <th>نهاية البصمة</th>
                                            <th>عدد الأيام</th>
                                            <th>حالة الشهر</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($data as $info)
                                            <tr>
                                                <td>{{ $info->month->name ?? 'غير محدد' }}</td>
                                                <td>{{ $info->finance_yr ?? 'غير محدد' }}</td>
                                                <td>{{ $info->start_date_m ?? 'غير محدد' }}</td>
                                                <td>{{ $info->end_date_m ?? 'غير محدد' }}</td>
                                                <td>{{ $info->start_date_fp ?? 'غير محدد' }}</td>
                                                <td>{{ $info->end_date_fp ?? 'غير محدد' }}</td>
                                                <td>{{ $info->number_of_days ?? 'غير محدد' }}</td>
                                                <td>
                                                    @if ($info->is_open == 0)
                                                        <a class="badge badge-warning" href="#">معلق</a>
                                                    @elseif ($info->is_open == 1)
                                                        <a class="badge badge-success" href="#">مفتوح</a>
                                                    @else
                                                        <a class="badge badge-danger" href="#">مؤرشف</a>
                                                    @endif


                                                    @if (!@empty($info->currentYear))
                                                        @if ($info->currentYear['is_open'] == 1)
                                                            @if ($info->is_open == 0 and $info->counterOpenMonth == 0 and $info->counterPreviousWatingOpen == 0)
                                                                {{-- @if ($info['is_open'] != 2 && $info['is_open'] != 1) --}}
                                                                {{-- Edit To Open --}}
                                                                <a class="modal-effect btn btn-outline-primary btn-sm mx-2"
                                                                    data-effect="effect-scale" data-toggle="modal"
                                                                    href="#editIsOpen{{ $info->id }}"><i
                                                                        class="fas fa-edit ml-1"></i>فتح الشهر
                                                                    المالى</a>
                                                                @include('dashboard.salaries.SalaryRecords.editISOpen')
                                                            @endif

                                                            @if ($info['is_open'] == 1)
                                                                {{-- Edit To Open --}}
                                                                {{-- Delete --}}
                                                                <a class="modal-effect btn btn-outline-danger btn-sm"
                                                                    data-effect="effect-scale" data-toggle="modal"
                                                                    href="#editIsClose{{ $info->id }}">
                                                                    <i class="fas fa-folder-open"></i> أرشفة الشهر
                                                                    المالى
                                                                </a>
                                                                @include('dashboard.salaries.SalaryRecords.load_close_month')
                                                            @endif
                                                        @endif
                                                    @endif
                                                    {{-- @include('dashboard.salaries.SalaryRecords.load_open_month') --}}
                                                </td>

                                            </tr>
                                        @endforeach

                                    </tbody>
                                </table>

                            </div>
                        @else
                            <div class="alert alert-warning" role="alert" dir="rtl">
                                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
                            </div>
                        @endif
                        {{ $data->render('pagination::bootstrap-5') }}
                    </div>
                </div><!-- bd -->
            </div><!-- bd -->
        </div>
        <!--/div-->
    </div>
    <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    <!-- main-content closed -->

@endsection
@section('js')
    <!-- Internal Data tables -->
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.bootstrap4.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.buttons.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.bootstrap4.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jszip.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/pdfmake.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/vfs_fonts.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.html5.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.print.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.colVis.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.bootstrap4.min.js') }}"></script>
    <!--Internal  Datatable js -->
    <script src="{{ URL::asset('dashboard/assets/js/table-data.js') }}"></script>

    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!-- Internal Modal js-->
    <script src="{{ URL::asset('dashboard/assets/js/modal.js') }}"></script>

    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/rating/ratings.js') }}"></script>

@endsection
