@extends('dashboard.layouts.master')
@section('title', 'أنواع الشفتات')
@section('css')
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

                <div class="card-body">

                    @livewire('dashboard.settings.shiftsTypes.shifts-types-table')

                    @livewire('dashboard.settings.shiftsTypes.branch-update')
                    @livewire('dashboard.settings.shiftsTypes.branch-delete')



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

    <script>
        //to open and close modal
        // if Open will be close
        // if Close will be open
        window.addEventListener('createModalToggle', event => {
            $("#createShiftsTypesModal").modal("toggle");
        });

        window.addEventListener('updateModalToggle', event => {
            $("#updatedShiftsTypesModal").modal("toggle");
        });

        window.addEventListener('deleteModalToggle', event => {
            $("#deleteShiftsTypesModal").modal("toggle");
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


@endsection
