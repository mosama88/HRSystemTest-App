@extends('dashboard.layouts.master')
@section('title', 'أنواع الشفتات')
@section('css')
    <!-- Internal Data table css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/buttons.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.bootstrap4.min.css') }}" rel="stylesheet" />
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/jquery.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/datatable/css/responsive.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">

@endsection
@php
    use Carbon\Carbon;
@endphp
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto"> أنواع الشفتات</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول أنواع الشفتات</span>
            </div>
        </div>

        @can('اضافة الشفتات')
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                            data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة شيفت جديد</a>
                        @include('dashboard.settings.shiftsTypes.create')
                    </div>
                </div>
            </div>
        @endcan

    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <!-- row -->
    @if ($errors->any())
        @foreach ($errors->all() as $error)
            <div class="alert alert-solid-danger mb-2 col-6" role="alert">
                <button aria-label="Close" class="close" data-dismiss="alert" type="button">
                    <span aria-hidden="true">&times;</span></button>
                <strong>عفوآ حدث خطأ ما!</strong> {{ $error }}
            </div>
            </div>
        @endforeach
    @endif
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

                <div class="card-body" id="ajax_search_shifts">
                    <div class="table-responsive">
                        @if (@isset($data) && !@empty($data) && count($data) > 0)
                            <table class="table text-md-nowrap" id="example2">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>نوع الشفت</th>
                                        <th>بداية الوقت</th>
                                        <th>نهاية الوقت</th>
                                        <th>عدد الساعات</th>
                                        <th>حالة التفعيل</th>
                                        <th>أضافة بواسطة</th>
                                        <th>تحديث بواسطة</th>
                                        <th>العمليات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $i = 0; ?>
                                    @foreach ($data as $info)
                                        <?php $i++; ?>

                                        <tr>
                                            <td>{{ $i }}</td>
                                            <td>
                                                @if ($info->type == 1)
                                                    صباحى
                                                @elseif ($info->type == 2)
                                                    مسائى
                                                @else
                                                    يوم كامل
                                                @endif
                                            </td>
                                            <td>
                                                {{ \Carbon\Carbon::parse($info->from_time)->format('g:i') }}
                                                {{ \Carbon\Carbon::parse($info->from_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                                            </td>
                                            <td>
                                                {{ \Carbon\Carbon::parse($info->to_time)->format('g:i') }}
                                                {{ \Carbon\Carbon::parse($info->to_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                                            </td>
                                            </td>
                                            @php
                                                $to_time = Carbon::parse($info['to_time']);
                                                $from_time = Carbon::parse($info['from_time']);
                                                $diff_in_minutes = $to_time->diffInMinutes($from_time);
                                                $hours = floor($diff_in_minutes / 60);
                                                $minutes = $diff_in_minutes % 60;
                                            @endphp
                                            <td>{{ $hours }} ساعة و {{ $minutes }} دقيقة</td>
                                            <td>
                                                @if ($info->active == 0)
                                                    <span class="label text-danger d-flex">
                                                        <div class="dot-label bg-danger ml-1"></div>{{ __('معطل') }}
                                                    </span>
                                                @else
                                                    <span class="label text-success d-flex">
                                                        <div class="dot-label bg-success ml-1"></div>{{ __('مفعل') }}
                                                    </span>
                                                @endif
                                            </td>
                                            <td>{{ $info->createdBy->username }}</td>
                                            <td>
                                                @if ($info->updated_by > 0)
                                                    {{ $info->updatedby->name }}
                                                @else
                                                    <span class="text">لا يوجد</span>
                                                @endif
                                            </td>
                                            <td>
                                                @can('تعديل الشفتات')
                                                    {{-- Edit --}}
                                                    <a class="modal-effect btn btn-outline-info btn-sm"
                                                        data-effect="effect-scale" data-toggle="modal"
                                                        href="#edit{{ $info->id }}"><i
                                                            class="fas fa-edit ml-1"></i>تعديل</a>
                                                @endcan
                                                @can('حذف الشفتات')
                                                    @if ($info->counterUsed == 0)
                                                        {{-- Delete --}}
                                                        <a class="modal-effect btn btn-outline-danger btn-sm"
                                                            data-effect="effect-scale" data-toggle="modal"
                                                            href="#delete{{ $info->id }}">
                                                            <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                                    @endif
                                                @endcan
                                            </td>
                                            @include('dashboard.settings.shiftsTypes.edit')
                                            @include('dashboard.settings.shiftsTypes.delete')
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
                        showConfirmButton: false, // إخفاء زر OK
                        didClose: () => {
                            location.reload(); // إعادة تحميل الصفحة بعد انتهاء العرض
                        }
                    });
                },
                error: function(xhr) {
                    // مسح رسائل الأخطاء السابقة
                    $('#typeError').text('');
                    $('#from_timeError').text('');
                    $('#to_timeError').text('');
                    $('#total_hoursError').text('');
                    $('#activeError').text('');

                    if (xhr.status === 422) {
                        var errors = xhr.responseJSON.errors;
                        if (errors.type) {
                            $('#typeError').text(errors.type[0]);
                        }
                        if (errors.from_time) {
                            $('#from_timeError').text(errors.from_time[0]);
                        }
                        if (errors.to_time) {
                            $('#to_timeError').text(errors.to_time[0]);
                        }
                        if (errors.total_hours) {
                            $('#total_hoursError').text(errors.total_hours[0]);
                        }
                        if (errors.active) {
                            $('#activeError').text(errors.active[0]);
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
        $(document).ready(function() {
            function calculateTotalHours() {
                var fromTime = $('#from_time').val();
                var toTime = $('#to_time').val();

                if (fromTime && toTime) {
                    var from = new Date('1970-01-01T' + fromTime + 'Z');
                    var to = new Date('1970-01-01T' + toTime + 'Z');

                    var diff = (to - from) / 3600000; // حساب الفرق بالساعات

                    if (diff < 0) {
                        diff += 24; // لإصلاح الفارق في حال كان الوقت ينتهي في اليوم التالي
                    }

                    $('#total_hours').val(diff.toFixed(2)); // تحديث حقل عدد الساعات
                } else {
                    $('#total_hours').val(''); // تفريغ حقل عدد الساعات إذا لم تكن القيم موجودة
                }
            }

            $('#from_time, #to_time').on('change', calculateTotalHours);
        });
    </script>




<script>
    $(document).ready(function() {
        function calculateTotalHoursUpdate() {
            var fromTime = $('#from_time_update').val();
            var toTime = $('#to_time_update').val();

            if (fromTime && toTime) {
                var from = new Date('1970-01-01T' + fromTime + 'Z');
                var to = new Date('1970-01-01T' + toTime + 'Z');

                var diff = (to - from) / 3600000; // حساب الفرق بالساعات

                if (diff < 0) {
                    diff += 24; // لإصلاح الفارق في حال كان الوقت ينتهي في اليوم التالي
                }

                $('#total_hours_update').val(diff.toFixed(2)); // تحديث حقل عدد الساعات
            } else {
                $('#total_hours_update').val(''); // تفريغ حقل عدد الساعات إذا لم تكن القيم موجودة
            }
        }

        $('#from_time_update, #to_time_update').on('change', calculateTotalHoursUpdate);
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
