@extends('dashboard.layouts.master')
@section('title', 'السنوات المالية')
@section('css')
    <!-- Internal Data table css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/buttons.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/jquery.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">

@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">
                    @if ($finance_cln_periods->isNotEmpty())
                        جدول السنوات المالية لسنة {{ $finance_cln_periods->first()->finance_yr }}
                    @else
                        لا توجد سنوات مالية
                    @endif
                </h5><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;" href="{{ route('dashboard.financeCalendars.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول السنوات المالية
                    </a>
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
                            @if ($finance_cln_periods->isNotEmpty())
                                جدول السنوات المالية لسنة {{ $finance_cln_periods->first()->finance_yr }}
                            @else
                                لا توجد سنوات مالية
                            @endif
                        </h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>
                    <p class="tx-12 tx-gray-500 mb-2">

                    </p>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        @if ($finance_cln_periods->isNotEmpty())
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>اسم الشهر عربي</th>
                                            <th>اسم الشهر إنجليزي</th>
                                            <th>سنة</th>
                                            <th>تاريخ البداية</th>
                                            <th>تاريخ النهاية</th>
                                            <th>عدد الأيام</th>
                                            <th>حالة الشهر</th>
                                            <th>الإضافة بواسطة</th>
                                            <th>التحديث بواسطة</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($finance_cln_periods as $info)
                                            <tr>
                                                <td>{{ $info->month->name ?? 'غير محدد' }}</td>
                                                <td>{{ $info->month->name_en ?? 'غير محدد' }}</td>
                                                <td>{{ $info->finance_yr ?? 'غير محدد' }}</td>
                                                <td>{{ $info->start_date_m ?? 'غير محدد' }}</td>
                                                <td>{{ $info->end_date_m ?? 'غير محدد' }}</td>
                                                <td>{{ $info->number_of_days ?? 'غير محدد' }}</td>
                                                <td>
                                                    @if ($info->is_open == 0)
                                                        <a class="badge badge-warning" href="#">معلق</a>
                                                    @elseif ($info->is_open == 1)
                                                        <a class="badge badge-success" href="#">مفتوح</a>
                                                    @else
                                                        <a class="badge badge-danger" href="#">مؤرشف</a>
                                                    @endif
                                                    @if ($info['is_open'] != 2)
                                                        {{-- Edit --}}
                                                        {{-- <a class="modal-effect btn btn-outline-info btn-sm mx-2"
                                                            data-effect="effect-scale" data-toggle="modal"
                                                            href="#editIsOpen{{ $info->id }}"><i
                                                                class="fas fa-edit ml-1"></i></a> --}}
                                                    @endif
                                                </td>
                                                <td>{{ $info->createdByAdmin->username ?? 'غير معروف' }}</td>
                                                <td>
                                                    @if ($info->updated_by > 0 && $info->updatedByAdmin)
                                                        {{ $info->updatedByAdmin->name }}
                                                    @else
                                                        <span class="text">لا يوجد</span>
                                                    @endif
                                                </td>

                                            </tr>
                                            {{-- @include('dashboard.settings.financeCalendars.editISOpen') --}}
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        @else
                            <p class="bg-danger text-center text-white p-2">عفواً، لا توجد بيانات لعرضها.</p>
                        @endif


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
    <!-- Internal Modal js-->
    <script src="{{ URL::asset('dashboard/assets/js/modal.js') }}"></script>
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


@endsection
