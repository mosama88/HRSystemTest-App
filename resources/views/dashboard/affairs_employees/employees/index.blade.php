@extends('dashboard.layouts.master')
@section('title', 'بيانات الموظفين')
@section('css')

@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">بيانات الموظفين</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول
                    بيانات الموظفين</span>
            </div>
        </div>
        <div class="d-flex my-xl-auto right-content">
            <div class="mb-3 mb-xl-0">
                <div class="btn-group dropdown">
                    <a class="btn btn-outline-primary btn-block" href="{{ route('dashboard.employees.create') }}"> <i
                            class="fas fa-plus-circle"></i> أضافة موظف جديد</a>
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
                        <h4 class="card-title mg-b-0">جدول شئون الموظفين</h4>
                        <a class="my-2 mx-2 btn btn-success" href="{{ url('employees/excel/export-excel') }}"> <i
                                class="fas fa-file-excel fa-lg ml-2 "></i> سحب اكسيل شيت</a>
                    </div>
                </div>
                <div class="card-body">
                    {{-- Search --}}
                    <div id="alertMessage" class="alert alert-danger mb-0 show d-none" role="alert">
                        <span class="alert-inner--icon"><i class="fe fe-slash"></i></span>
                        <span class="alert-inner--text"><strong>Danger!</strong> قم بتغيير بعض الأمور وحاول إرسال
                            الطلب مرة أخرى.!</span>
                    </div>

                    @livewire('dashboard.affairs_employees.employees.employees-table')

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


@endsection
