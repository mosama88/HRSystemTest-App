@extends('dashboard.layouts.master')
@section('title', 'الفروع')
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
                <h4 class="content-title mb-0 my-auto">الفروع</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ جدول
                    الفروع</span>
            </div>
        </div>
        @can('اضافة الفروع')
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                            data-toggle="modal" href="#modaldemo8"> <i class="fas fa-plus-circle"></i> أضافة فرع جديده</a>

                        @include('dashboard.settings.branches.create')
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
                        <h4 class="card-title mg-b-0">جدول الفروع</h4>
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
                                        <th class="wd-15p border-bottom-0">الأسم</th>
                                        <th class="wd-20p border-bottom-0">العنوان</th>
                                        <th class="wd-15p border-bottom-0">الهاتف</th>
                                        <th class="wd-15p border-bottom-0">البريد الالكتورنى</th>
                                        <th class="wd-10p border-bottom-0">التفعيل</th>
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
                                            <td>{{ $info->name }}</td>
                                            <td>{{ Str::limit($info->address, 30) }}</td>
                                            <td>{{ $info->phones }}</td>
                                            <td>{{ $info->email }}</td>
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
                                                @can('تعديل الفروع')
                                                    {{-- Edit --}}
                                                    <a class="modal-effect btn btn-outline-info btn-sm"
                                                        data-effect="effect-scale" data-toggle="modal"
                                                        href="#edit{{ $info->id }}"><i
                                                            class="fas fa-edit ml-1"></i>تعديل</a>
                                                @endcan
                                                @can('حذف الفروع')
                                                    @if ($info->counterUsed == 0)
                                                        {{-- Delete --}}
                                                        <a class="modal-effect btn btn-outline-danger btn-sm"
                                                            data-effect="effect-scale" data-toggle="modal"
                                                            href="#delete{{ $info->id }}">
                                                            <i class="fas fa-trash-alt ml-1"></i>حذف</a>
                                                    @endif
                                                @endcan


                                            </td>
                                            @include('dashboard.settings.branches.edit')
                                            @include('dashboard.settings.branches.delete')
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

                        if (errors.address) {
                            $('#addressError').text(errors.address[0]);
                        } else {
                            $('#addressError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.phones) {
                            $('#phonesError').text(errors.phones[0]);
                        } else {
                            $('#phonesError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
                        }

                        if (errors.email) {
                            $('#emailError').text(errors.email[0]);
                        } else {
                            $('#emailError').text(''); // إخفاء الرسالة إذا لم يكن هناك خطأ
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
