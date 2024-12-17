@extends('dashboard.layouts.master')
@section('title', 'أدخال بيانات موظف جديد')
@section('css')
    <!---Internal  Prism css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/prism/prism.css') }}" rel="stylesheet">
    <!---Internal Input tags css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/inputtags/inputtags.css') }}" rel="stylesheet">
    <!--- Custom-scroll -->
    <link href="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.css') }}" rel="stylesheet">
    <!--- Internal Select2 css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!---Internal Fileupload css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/fileuploads/css/fileupload.css') }}" rel="stylesheet"
        type="text/css" />
    <!---Internal Fancy uploader css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/fancyuploder/fancy_fileupload.css') }}" rel="stylesheet" />
    <!--Internal Sumoselect css-->
    <link rel="stylesheet" href="{{ URL::asset('dashboard/assets/plugins/sumoselect/sumoselect-rtl.css') }}">
    <!--Internal  TelephoneInput css-->
    <link rel="stylesheet" href="{{ URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput-rtl.css') }}">


    <!-- رابط CSS لمكتبة Flatpickr -->
    <link href="{{ URL::asset('dashboard/assets/js/projects/flatpickr.min.css') }}" rel="stylesheet">


    <style>
        .flatpickr-month {
            height: 50px !important;
        }
    </style>

@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h5 class="content-title mb-0 my-auto">إدخال بيانات موظف جديد</h5><span
                    class="text-muted mt-1 tx-13 mr-2 mb-0">/ <a style="font-weight:bold;color:#117ea1;"
                        href="{{ route('dashboard.employees.index') }}">
                        <i class="fas fa-arrow-circle-left fa-lg ml-1"></i> جدول بيانات الموظفين
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
        <div class="col-xl-12">
            <!-- div -->
            <div class="card custom-card" id="tab">
                <div class="card-body">
                    <div>
                        <h6 class="card-title mb-1">Simple Tab Navigation</h6>
                        <p class="text-muted card-sub-title">Below is a tab navigation that have only few links.</p>
                    </div>
                    <div class="text-wrap">
                        <div class="example">
                            <div class="border">
                               


                                @livewire('dashboard.affairs_employees.employees.employees-create')

                            </div>
                        </div>
                        <!-- Prism Precode -->

                        <!-- End Prism Precode -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    </div>




    <!-- main-content closed -->
@endsection
@section('js')
    <!-- رابط JavaScript لمكتبة Flatpickr -->
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/flatpickr-ar.js') }}"></script>


    <!--Internal Fileuploads js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/fileuploads/js/fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fileuploads/js/file-upload.js') }}"></script>
    <!--Internal Fancy uploader js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.ui.widget.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.iframe-transport.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/jquery.fancy-fileupload.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/fancyuploder/fancy-uploader.js') }}"></script>
    <!--Internal  Form-elements js-->
    <script src="{{ URL::asset('dashboard/assets/js/advanced-form-elements.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/select2.js') }}"></script>
    <!--Internal Sumoselect js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/sumoselect/jquery.sumoselect.js') }}"></script>
    <!-- Internal TelephoneInput js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/telephoneinput/telephoneinput.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/telephoneinput/inttelephoneinput.js') }}"></script>
    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!-- Internal Jquery.mCustomScrollbar js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.concat.min.js') }}">
    </script>
    <!-- Internal Input tags js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/inputtags/inputtags.js') }}"></script>
    <!--- Tabs JS-->
    <script src="{{ URL::asset('dashboard/assets/plugins/tabs/jquery.multipurpose_tabcontent.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/tabs.js') }}"></script>
    <!--Internal  Clipboard js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.js') }}"></script>
    <!-- Internal Prism js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/prism/prism.js') }}"></script>
    {{-- Show And Hide Inputs --}}
    <script src="{{ URL::asset('dashboard/assets/js/projects/employees.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/js/projects/add-employee.js') }}"></script>


    <script>
        // To Get Citeis When Change Governorates

        $(document).on('change', '#governorate_id', function(e) {
            getcities();
        });

        function getcities() {
            var governorate_id = $("#governorate_id").val();
            jQuery.ajax({
                url: '{{ route('dashboard.employees.getcities') }}',
                type: 'post',
                'dataType': 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    governorate_id: governorate_id
                },
                success: function(data) {
                    $("#centers_div").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }

            });
        }

        //###############################################################

        // To Get Governorates When Change Country
        $(document).on('change', '#country_id', function(e) {
            get_governorates();
        });

        function get_governorates() {
            var country_id = $("#country_id").val();
            jQuery.ajax({
                url: '{{ route('dashboard.employees.get_governorates') }}',
                type: 'post',
                'dataType': 'html',
                cache: false,
                data: {
                    "_token": '{{ csrf_token() }}',
                    country_id: country_id
                },
                success: function(data) {
                    $("#governorates_Div").html(data);
                },
                error: function() {
                    alert("عفوا لقد حدث خطأ ");
                }

            });
        }
    </script>


    <script>
        $(document).ready(function() {
            $('.dropify').dropify();
        });
    </script>


    <script>
        flatpickr('#birth_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#end_national_id', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });


        flatpickr('#military_date_from', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#military_date_to', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#military_exemption_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#work_start_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });

        flatpickr('#pasport_exp_date', {
            dateFormat: 'Y-m-d',
            locale: "ar",
        });
    </script>




    <!-- JavaScript -->
    <script>
        // تخزين الـ tab النشط في localStorage عند تغييره
        document.querySelectorAll('.nav-link').forEach(function(tab) {
            tab.addEventListener('click', function() {
                localStorage.setItem('activeTab', this.getAttribute('href'));
            });
        });

        // استرجاع الـ tab النشط عند إعادة تحميل الصفحة
        document.addEventListener('DOMContentLoaded', function() {
            let activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                document.querySelector(`a[href="${activeTab}"]`).classList.add('active');
                document.querySelector(activeTab).classList.add('active');
            } else {
                document.querySelector('.nav-link').classList.add('active');
                document.querySelector('.tab-pane').classList.add('active');
            }
        });
    </script>

    <script>
        function calculateDayPrice() {
            const salaryInput = document.getElementById('salary').value;
            const dayPriceInput = document.getElementById('day_price');
            const daysInMonth = 30; // يمكنك تغيير هذا الرقم إذا كان لديك عدد مختلف للأيام

            if (salaryInput) {
                const salary = parseFloat(salaryInput);
                const dayPrice = salary / daysInMonth;
                dayPriceInput.value = dayPrice.toFixed(2); // تقليل القيمة إلى منزلتين عشريتين
            } else {
                dayPriceInput.value = '';
            }
        }
    </script>





    <script>
        // Function to calculate vacation days
        function calculateVacationDays() {
            // Get the input values
            let birthDate = new Date(document.getElementById('birth_date').value);
            let hiringDate = new Date(document.getElementById('work_start_date').value);
            let additionalServiceYears = parseInt(document.getElementById('add_service').value || 0);


            // Get the current date
            let currentDate = new Date();

            // Calculate years of service
            let yearsOfService = currentDate.getFullYear() - hiringDate.getFullYear() + additionalServiceYears;

            // Calculate vacation days
            let vacationDays = 21; // Default value
            if (yearsOfService >= 10) {
                vacationDays = 30;
            }
            if (currentDate.getFullYear() - birthDate.getFullYear() >= 50) {
                vacationDays = 45;
            }

            // Set the vacation days in the input field
            document.getElementById('num_vacation_days').value = vacationDays;
        }

        // Attach event listeners to update vacation days on input change
        document.getElementById('birth_date').addEventListener('change', calculateVacationDays);
        document.getElementById('work_start_date').addEventListener('change', calculateVacationDays);
        document.getElementById('add_service').addEventListener('input', calculateVacationDays);
    </script>

    <script>
        document.getElementById('work_start_date').addEventListener('input', calculateYearsOfService);
        document.getElementById('add_service').addEventListener('input', calculateYearsOfService);

        function calculateYearsOfService() {
            let hiringDate = new Date(document.getElementById('work_start_date').value);
            let addService = parseInt(document.getElementById('add_service').value) || 0;
            let currentDate = new Date();

            // حساب عدد السنوات بين تاريخ التعيين والتاريخ الحالي
            let yearsOfService = currentDate.getFullYear() - hiringDate.getFullYear();

            // إضافة عدد سنوات الخدمة الإضافية
            yearsOfService += addService;

            // تحديث حقل عدد سنوات الخدمة
            document.getElementById('years_service').value = yearsOfService;
        }
    </script>


@endsection
