@extends('dashboard.layouts.master')
@section('title', 'مؤهل الموظفين')
@section('css')
@endsection
@section('page-header')
    @include('dashboard.messages_alert')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">مؤهل الموظفين</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    جدول
                    مؤهل الموظفين</span>
            </div>
        </div>

        @can('اضافة المؤهل')
            <div class="d-flex my-xl-auto right-content">
                <div class="mb-3 mb-xl-0">
                    <div class="btn-group dropdown">
                        <a class="modal-effect btn btn-outline-primary btn-block" data-effect="effect-super-scaled"
                            data-toggle="modal" href="#createModal"> <i class="fas fa-plus-circle"></i> أضافة مؤهل جديد</a>

                        @livewire('dashboard.settings.qualifications.qualifications-create')
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
                        <h4 class="card-title mg-b-0">جدول مؤهل الموظفين</h4>
                        <i class="mdi mdi-dots-horizontal text-gray"></i>
                    </div>
                    <p class="tx-12 tx-gray-500 mb-2">

                    </p>
                </div>
                <div class="card-body">

                    @livewire('dashboard.settings.qualifications.qualifications-table')
                    @livewire('dashboard.settings.qualifications.qualifications-update')
                </div><!-- bd -->
            </div><!-- bd -->
            @livewire('dashboard.settings.qualifications.qualifications-delete')
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
            $("#createModal").modal("toggle");
        });

        window.addEventListener('updateModalToggle', event => {
            $("#updateModal").modal("toggle");
        });

        window.addEventListener('deleteModalToggle', event => {
            $("#deleteModal").modal("toggle");
        });
    </script>
@endsection
