@extends('dashboard.layouts.master')
@section('title', 'الدرجات الوظيفية')
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
                <h4 class="content-title mb-0 my-auto">الدرجات الوظيفية</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول
                    الدرجات الوظيفية</span>
            </div>
        </div>
        @can('اضافة الدرجات الوظيفية')
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                            data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة درجة وظيفية
                            جديده</a>

                        @include('dashboard.settings.jobGrades.create')
                    </div>
                </div>
            </div>
        @endcan

    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
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
    <!-- row -->
    <div class="row">
        <!--div-->
        <div class="col-xl-12">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="d-flex justify-content-between">
                        <h4 class="card-title mg-b-0">جدول الدرجات الوظيفية</h4>
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
                                        <th>#</th>
                                        <th class="wd-15p border-bottom-0">كود الدرجه</th>
                                        <th class="wd-15p border-bottom-0">أسم الدرجه</th>
                                        <th class="wd-20p border-bottom-0">الحد الادنى للمرتب</th>
                                        <th class="wd-20p border-bottom-0">الحد الأقصى للمرتب</th>
                                        <th class="wd-15p border-bottom-0">ملاحظات</th>
                                        <th class="wd-10p border-bottom-0">الأضافة بواسطة</th>
                                        <th class="wd-25p border-bottom-0">التحديث بواسطة</th>
                                        <th class="wd-25p border-bottom-0">العمليات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $i = 0; ?>
                                    @foreach ($data as $info)
                                        <?php $i++; ?>

                                        <tr>
                                            <td>{{ $i }}</td>
                                            <td>{{ $info->job_grades_code }}</td>
                                            <td>{{ $info->name }}</td>
                                            <td>{{ $info->min_salary }}</td>
                                            <td>{{ $info->max_salary }}</td>
                                            <td>{{ Str::limit($info->notes, 50) }}</td>
                                            <td>{{ $info->createdBy->name }}</td>
                                            <td>
                                                @if (!@empty($info->updatedBy))
                                                    {{ $info->updatedBy->name }}
                                                @else
                                                    <span class="text">لا يوجد</span>
                                                @endif
                                            </td>
                                            <td>
                                                @can('تعديل الدرجات الوظيفية')
                                                    {{-- Edit --}}
                                                    <a class="modal-effect btn btn-outline-info btn-sm"
                                                        data-effect="effect-scale" data-toggle="modal"
                                                        href="#edit{{ $info->id }}"><i
                                                            class="fas fa-edit ml-1"></i>تعديل</a>
                                                @endcan
                                                @can('حذف الدرجات الوظيفية')
                                                    @if ($info->counterUsed == 0)
                                                        {{-- Delete --}}
                                                        <a class="modal-effect btn btn-outline-danger btn-sm"
                                                            data-effect="effect-scale" data-toggle="modal"
                                                            href="#delete{{ $info->id }}">
                                                            <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                                    @endif
                                                @endcan


                                            </td>
                                            @include('dashboard.settings.jobGrades.edit')
                                            @include('dashboard.settings.jobGrades.delete')
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
                    // إظهار الأخطاء في النموذج
                    if (xhr.status === 422) {
                        var errors = xhr.responseJSON.errors;
                        if (errors.name) {
                            $('#nameError').text(errors.name[0]);
                        } else {
                            $('#nameError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.min_salary) {
                            $('#min_salaryError').text(errors.min_salary[0]);
                        } else {
                            $('#min_salaryError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.max_salary) {
                            $('#max_salaryError').text(errors.max_salary[0]);
                        } else {
                            $('#max_salaryError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.notes) {
                            $('#notesError').text(errors.notes[0]);
                        } else {
                            $('#notesError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.active) {
                            $('#activeError').text(errors.active[0]);
                        } else {
                            $('#activeError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
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
