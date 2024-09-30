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
                <h4 class="content-title mb-0 my-auto">السنوات المالية</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول السنوات المالية </span>
            </div>
        </div>
        @can('اضافة السنوات المالية')
        <div class="d-flex my-xl-auto right-content">
            <div class="mb-3 mb-xl-0">
                <div class="btn-group dropdown">
                    <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                        data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة سنه مالية جديده</a>
                    @include('dashboard.settings.financeCalendars.create')
                </div>
            </div>
        </div>
        @endcan
        
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
                        <h4 class="card-title mg-b-0">جدول السنوات</h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>
                    <p class="tx-12 tx-gray-500 mb-2">

                    </p>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        @if (@isset($data) && !@empty($data))
                            <table class="table text-md-nowrap" id="example2">
                                <thead>
                                    <tr>
                                        <th>كود السنه</th>
                                        <th>وصف السنه</th>
                                        <th>بداية السنه</th>
                                        <th>نهاية السنه</th>
                                        <th>الأضافة بواسطة</th>
                                        <th>التحديث بواسطة</th>
                                        <th>العمليات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data as $info)
                                        <tr>
                                            <td>{{ $info->finance_yr }}</td>
                                            <td>{{ $info->finance_yr_desc }}</td>
                                            <td>{{ $info->start_date }}</td>
                                            <td>{{ $info->end_date }}</td>
                                            <td>{{ $info->createdByAdmin->username }}</td>
                                            <td>
                                                @if ($info->updated_by == 1)
                                                    {{ $info->updatedByAdmin->name }}
                                                @else
                                                    <span class="text">لا يوجد</span>
                                                @endif
                                            </td>
                                            <td>
                                                @if ($info->is_open == 0)
                                                @can('فتح السنوات المالية')
                                                    {{-- Open --}}
                                                    <a class="btn ripple btn-outline-success btn-sm"
                                                        href="{{ route('dashboard.financeCalendars.open', $info->id) }}"><i
                                                            class="fas fa-lock-open ml-1"></i>فتح السنه المالية</a>
                                                @endcan
                                                @can('تعديل السنوات المالية')
                                                    {{-- Edit --}}
                                                    <a class="modal-effect btn btn-outline-info btn-sm"
                                                        data-effect="effect-scale" data-toggle="modal"
                                                        href="#edit{{ $info->id }}"><i
                                                            class="fas fa-edit ml-1"></i>تعديل</a>
                                                @endcan
                                                @can('حذف السنوات المالية')
                                                    {{-- Delete --}}
                                                    <a class="modal-effect btn btn-outline-danger btn-sm"
                                                        data-effect="effect-scale" data-toggle="modal"
                                                        href="#delete{{ $info->id }}">
                                                        <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                                @endcan   
                                                @elseif($info->is_open == 1)
                                                    سنه مالية مفتوحه
                                                @elseif($info->is_open == 2)
                                                    سنه مالية مؤرشفه
                                                @endif
                                                @can('عرض شهور السنه السنوات مالية')
                                                    {{-- show --}}
                                                <a class="btn ripple btn-outline-primary btn-sm"
                                                href="{{ route('dashboard.financeCalendars.show', $info->id) }}"><i
                                                    class="fas fa-eye ml-1"></i>شهور السنه</a>
                                                @endcan
                                                @can('غلق السنوات المالية')
                                                @if ($info->is_open == 1)
                                                {{-- Close --}}
                                                <a class="btn ripple btn-outline-danger btn-sm"
                                                    href="{{ route('dashboard.financeCalendars.close', $info->id) }}"><i
                                                        class="fas fa-lock ml-1"></i>غلق السنه المالية</a>
                                            @endif
                                                @endcan
                                            </td>
                                            @include('dashboard.settings.financeCalendars.edit')
                                            @include('dashboard.settings.financeCalendars.delete')
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        @else
                            <div class="alert alert-warning" role="alert" dir="rtl">
                                <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                                <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات لعرضها!</span>
                            </div>
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


    <script>
        $('#ajaxForm').on('submit', function(e) {
            e.preventDefault();

            var formData = $(this).serialize();

            $.ajax({
                url: $(this).attr('action'),
                method: $(this).attr('method'),
                data: formData,
                success: function(response) {
                    // إخفاء الـ modal فقط عند نجاح العملية
                    $('#modaldemo8').modal('hide');

                    Swal.fire({
                        icon: 'success',
                        title: 'تم حفظ البيانات',
                        text: 'تم حفظ البيانات بنجاح.',
                        timer: 1000, // وقت العرض بالمللي ثانية
                        timerProgressBar: true,
                        didClose: () => {
                            location.reload(); // إعادة تحميل الصفحة بعد انتهاء العرض
                        }
                    });
                },
                error: function(xhr) {
                    // إخفاء الأخطاء السابقة
                    $('#finance_yrError').text('');
                    $('#finance_yr_descError').text('');
                    $('#start_dateError').text('');
                    $('#end_dateError').text('');

                    if (xhr.status === 422) {
                        var errors = xhr.responseJSON.errors;
                        if (errors.finance_yr) {
                            $('#finance_yrError').text(errors.finance_yr[0]);
                        }
                        if (errors.finance_yr_desc) {
                            $('#finance_yr_descError').text(errors.finance_yr_desc[0]);
                        }
                        if (errors.start_date) {
                            $('#start_dateError').text(errors.start_date[0]);
                        }
                        if (errors.end_date) {
                            $('#end_dateError').text(errors.end_date[0]);
                        }
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'حدث خطأ',
                            text: 'عفوا حدث خطأ ما. الرجاء المحاولة مرة أخرى.'
                        });
                    }
                }
            });
        });
    </script>


    <script>
        $('#modaldemo8').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.edit').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });

        $('.delete').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>

@endsection
