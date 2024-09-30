@extends('dashboard.layouts.master')
@section('mainSalaryEmployees', 'active')
@section('title', 'عرض تفاصيل مرتب الموظف ')
@section('css')

    <style>
        @media print {
            #print_Button {
                display: none;
            }
        }

        /* .my-2.mx-1 {
                                                                                                                    display: none;
                                                                                                                } */
    </style>

    <!-- Internal Data table css -->

    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Owl Carousel css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/owl-carousel/owl.carousel.css') }}" rel="stylesheet">
    <!---Internal  Multislider css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/multislider/multislider.css') }}" rel="stylesheet">
    <!--- Select2 css -->
    <link href="{{ URL::asset('dashboard/assets/css/sweetalert2.min.css') }}" rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/css/tableDetailsMainSalary.css') }}" rel="stylesheet">

@endsection
@section('page-header')
    @include('dashboard.messages_alert')
    <?php
    
    use Carbon\Carbon;
    
    $currentDate = Carbon::now()->format('d-m-Y');
    ?>

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات راتب الموظف المفصله
                </h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.mainSalaryEmployees.show', $finance_cln_periods_data->id) }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول بيانات رواتب الموظفين
                    </a>
                </span>
            </div>
        </div>
        <div class="d-flex my-xl-auto right-content">

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


                            بيانات راتب <span class="text-danger">{{ $mainSalaryEmployee_data->employee->name }}</span>
                            المفصله للشهر المالى (<span
                                class="text-danger">{{ $finance_cln_periods_data['month']->name }}</span> لسنه
                            {{ $finance_cln_periods_data['finance_yr'] }})
                        </h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>

                    <a href="{{ route('dashboard.mainSalaryEmployees.printSalary', $mainSalaryEmployee_data['id']) }}"
                        class="btn btn-danger float-left mt-3 mr-2">
                        <i class="mdi mdi-printer ml-1"></i>طباعة مفرادات المرتب
                    </a>
                </div>


                <div class="card-body" id="print">
                    <div class="row my-2 mx-1">
                        @if ($finance_cln_periods_data['is_open'] == 1 && $mainSalaryEmployee_data['is_archived'] == 0)
                            @if ($mainSalaryEmployee_data['is_stopped'] == 'unstopped')
                                <a href="#doStopSalary{{ $mainSalaryEmployee_data->id }}"
                                    class="btn ripple btn-sm btn-dark p-2 ml-2" data-effect="effect-scale"
                                    data-toggle="modal">
                                    <i class="fa fa-stop"></i> إيقاف المرتب مؤقتآ
                                </a>

                                <a href="#doDeleteSalaryInternal{{ $mainSalaryEmployee_data->id }}"
                                    class="btn ripple btn-sm btn-danger p-2 ml-2" data-effect="effect-scale"
                                    data-toggle="modal">
                                    <i class="fas fa-trash-alt ml-1"></i> حذف المرتب
                                </a>


                                <button data-id="{{ $mainSalaryEmployee_data->id }}"
                                    class="modal-effect btn loadArchiveSalaryEdit btn ripple btn-sm btn-info btn-sm"> <i
                                        class="fas fa-archive"></i> أرشفة المرتب
                                </button>
                            @else
                                <a data-effect="effect-scale" data-toggle="modal"
                                    href="#doUnlockSalary{{ $mainSalaryEmployee_data['id'] }}" type="button"
                                    class="btn btn-primary mt-1 mb-1">ملحوظه: هذا المرتب موقوف حاليآ <span
                                        class="badge text-whie badge-light badge-pill">إلغاء إيقاف المرتب</span></a>
                            @endif
                        @endif
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
                                <td>{{ $mainSalaryEmployee_data->fixed_allowances }}</td>
                            </tr>
                            <tr>
                                <td>بدلات متغيرة</td>
                                <td>{{ $mainSalaryEmployee_data->changeable_allowance }}</td>
                            </tr>
                            <tr>
                                <td>إضافي أيام</td>
                                <td>عدد ({{ $mainSalaryEmployee_data->additional_days_counter * 1 }}) يوم
                                    {{ $mainSalaryEmployee_data->additional_days_total }} جنية</td>
                            </tr>
                            <tr>
                                <td>مكافآت مالية</td>
                                <td>{{ $mainSalaryEmployee_data->total_rewards_salary }}</td>
                            </tr>
                            <tr>
                                <td>إجمالي الاستحقاقات</td>
                                <td>{{ $mainSalaryEmployee_data->total_benefits }}</td>
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
                            مبلغ مستحق للموظف بقيمة <span
                                class="text-danger">{{ $mainSalaryEmployee_data->net_salary * 1 }}</span> جنية
                        @elseif($mainSalaryEmployee_data->net_salary < 0)
                            مبلغ مستحق على الموظف بقيمة <span
                                class="text-danger">{{ $mainSalaryEmployee_data->net_salary * 1 * -1 }} </span> جنية
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
            </div>

            <!-- row closed -->
        </div>
        <!-- Container closed -->
    </div>
    </div>
    </div>


    <!-- Start Modal doStopSalary effects-->
    <div class="modal" id="doStopSalary{{ $mainSalaryEmployee_data->id }}">

        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content tx-size-sm">
                <div class="modal-body tx-center pd-y-20 pd-x-20">
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>

                    <!--Page Widget Error-->
                    <div class="card bd-0 mg-b-20">
                        <div class="card-body text-danger">
                            <div class="main-error-wrapper">
                                <i class="si si-danger mg-b-20 tx-50"></i>
                                <h3 class="mg-b-20">تحذير</h3>
                                <h2 class="text-dark">هل تريد وقف مرتب الموظف الأن</h2>
                            </div>

                            <table class="table table-bordered border-danger">
                                <thead>
                                    <tr>
                                        <th scope="col">كود الموظف</th>
                                        <th scope="col">أسم الموظف</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">{{ $mainSalaryEmployee_data->employee->employee_code }}</th>
                                        <td>{{ $mainSalaryEmployee_data->employee->name }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <!--Page Widget Error-->

                    <form action="{{ route('dashboard.mainSalaryEmployees.doStopSalary', $mainSalaryEmployee_data->id) }}"
                        method="POST">
                        {{ csrf_field() }}
                        @method('PUT')
                        <div class="modal-body">
                            <input type="hidden" name="id" value="{{ $mainSalaryEmployee_data->id }}">
                        </div>
                        <div class="modal-footer mx-auto">
                            <button type="submit" class="btn btn-outline-danger">نعم</button>
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">لا</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal effects-->


    <!-- Start Modal doUnlockSalary effects-->
    <div class="modal" id="doUnlockSalary{{ $mainSalaryEmployee_data->id }}">

        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content tx-size-sm">
                <div class="modal-body tx-center pd-y-20 pd-x-20">
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>

                    <!--Page Widget Error-->
                    <div class="card bd-0 mg-b-20">
                        <div class="card-body text-primary">
                            <div class="main-error-wrapper">
                                <i class="si si-primary mg-b-20 tx-50"></i>
                                <h3 class="mg-b-20">تحذير</h3>
                                <h2 class="text-dark">هل تريد إلغاء إيقاف المرتب الأن</h2>
                            </div>

                            <table class="table table-bordered border-primary">
                                <thead>
                                    <tr>
                                        <th scope="col">كود الموظف</th>
                                        <th scope="col">أسم الموظف</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">{{ $mainSalaryEmployee_data->employee->employee_code }}</th>
                                        <td>{{ $mainSalaryEmployee_data->employee->name }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <!--Page Widget Error-->

                    <form
                        action="{{ route('dashboard.mainSalaryEmployees.doUnlockSalary', $mainSalaryEmployee_data->id) }}"
                        method="POST">
                        {{ csrf_field() }}
                        @method('PUT')
                        <div class="modal-body">
                            <input type="hidden" name="id" value="{{ $mainSalaryEmployee_data->id }}">
                        </div>
                        <div class="modal-footer mx-auto">
                            <button type="submit" class="btn btn-outline-primary">نعم</button>
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">لا</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal effects-->

    <!-- Start Modal doDeleteSalaryInternal effects-->
    <div class="modal" id="doDeleteSalaryInternal{{ $mainSalaryEmployee_data->id }}">

        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content tx-size-sm">
                <div class="modal-body tx-center pd-y-20 pd-x-20">
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>

                    <!--Page Widget Error-->
                    <div class="card bd-0 mg-b-20">
                        <div class="card-body text-danger">
                            <div class="main-error-wrapper">
                                <i class="si si-danger mg-b-20 tx-50"></i>
                                <h3 class="mg-b-20">تحذير</h3>
                                <h2 class="text-dark">هل تريد حذف مرتب الموظف الأن</h2>
                            </div>

                            <table class="table table-bordered border-danger">
                                <thead>
                                    <tr>
                                        <th scope="col">كود الموظف</th>
                                        <th scope="col">أسم الموظف</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">{{ $mainSalaryEmployee_data->employee->employee_code }}</th>
                                        <td>{{ $mainSalaryEmployee_data->employee->name }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <!--Page Widget Error-->

                    <form
                        action="{{ route('dashboard.mainSalaryEmployees.doDeleteSalaryInternal', $mainSalaryEmployee_data->id) }}"
                        method="POST">
                        {{ csrf_field() }}
                        @method('PUT')
                        <div class="modal-body">
                            <input type="hidden" name="id" value="{{ $mainSalaryEmployee_data->id }}">
                        </div>
                        <div class="modal-footer mx-auto">
                            <button type="submit" class="btn btn-outline-danger">نعم</button>
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">لا</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal effects-->




    <!-- Edit Basic modal -->
    <div class="modal loadArchiveSalarystatic" id="loadArchiveSalary">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-content-demo">
                <div class="modal-header">
                    <h6 class="modal-title">أرشفة راتب
                        <strong class="text-danger">{{ $mainSalaryEmployee_data->employee->name }}</strong>
                        <span class="text-danger">(
                            {{ $finance_cln_periods_data->year_and_month }} )</span>
                    </h6>
                    <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="loadArchiveSalaryBody">
                    <!-- The content loaded dynamically via AJAX will appear here -->
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Basic modal -->










@endsection
@section('js')
    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!--Internal  jquery.maskedinput js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery.maskedinput/jquery.maskedinput.js') }}"></script>
    <!--Internal  spectrum-colorpicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/spectrum-colorpicker/spectrum.js') }}"></script>
    <!-- Internal Select2.min js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!--Internal Ion.rangeSlider.min js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/ion-rangeslider/js/ion.rangeSlider.min.js') }}"></script>
    <!--Internal  jquery-simple-datetimepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/amazeui-datetimepicker/js/amazeui.datetimepicker.min.js') }}">
    </script>
    <!-- Ionicons js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-simple-datetimepicker/jquery.simple-dtpicker.js') }}">
    </script>
    <!--Internal  pickerjs js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/pickerjs/picker.min.js') }}"></script>
    <!-- Internal form-elements js -->
    <script src="{{ URL::asset('dashboard/assets/js/form-elements.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/modal.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/sweetalert2.min.js') }}"></script>
    <!-- Internal Data tables -->
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.dataTables.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.responsive.min.js') }}"></script>

    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/dataTables.buttons.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.bootstrap4.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/jszip.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/pdfmake.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/vfs_fonts.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.html5.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.print.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/buttons.colVis.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/datatable/js/responsive.bootstrap4.min.js') }}"></script>

    <script>
        $(document).on('click', '.loadArchiveSalaryEdit', function(e) {
            var id = $(this).data("id");

            $.ajax({
                url: '{{ route('dashboard.mainSalaryEmployees.loadArchiveSalary') }}',
                type: 'post',
                dataType: 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    id: id
                },
                success: function(data) {
                    $("#loadArchiveSalaryBody").html(data);
                    $("#loadArchiveSalary").modal("show");
                    $('.select2').select2();
                },
                error: function(xhr) {
                    if (xhr.status === 404) {
                        // عرض الرسالة المستلمة من السيرفر
                        var errorMessage = JSON.parse(xhr.responseText).message;
                        $("#loadArchiveSalaryBody").html('<p class="text-center text-danger">' +
                            errorMessage + '</p>');
                        $("#loadArchiveSalary").modal("show");
                    } else {
                        alert("عفوا لقد حدث خطأ ");
                    }

                }
            });
        });
    </script>

    <script>
        $('.loadArchiveSalarystatic').modal({
            backdrop: 'static',
            keyboard: false,
            show: false // عدم فتح المودال تلقائيًا
        });
    </script>

    <script>
        function printDiv() {
            var printContents = document.getElementById('print').innerHTML;
            var originalContents = document.body.innerHTML;

            // Create a temporary container
            var tempContainer = document.createElement('div');
            tempContainer.innerHTML = printContents;
            document.body.innerHTML = tempContainer.innerHTML;

            // Print and restore original content
            window.print();
            document.body.innerHTML = originalContents;

            // Optional: If you still want to reload the page
            // location.reload();
        }
    </script>

@endsection
