@extends('dashboard.layouts.master')
@section('title', 'صفحتى')
@section('css')
    <!-- Internal Data table css -->
    <link href="{{ asset('dashboard') }}/assets/plugins/datatable/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
    <link href="{{ asset('dashboard') }}/assets/plugins/datatable/css/buttons.bootstrap4.min.css" rel="stylesheet">
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">صفحتى الشخصية</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ تعديل صفحتى الشخصية</span>
            </div>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection
@section('content')

    <div class="row row-sm">

        @if ($errors->any())
        @foreach ($errors->all() as $error)
            <div class="alert alert-danger text-center">
                {{ $error }}
            </div>
        @endforeach
    @endif


        <div class="col-lg-12 col-md-12">
            @if(session('success')!=null)
                <div class="alert alert-success text-center">
                    {{session('success')}}
                </div>
            @endif
            <div class="card">
                <div class="card-body">
                    <div class="main-content-label mg-b-5">
                        تعديل بياناتى الشخصية
                    </div>

                    <p class="mg-b-20"></p>
                    <div id="wizard3">
                        <h3 class="mb-3">بياناتى</h3>
                        <section>
                            <form method="post" action="{{ route('dashboard.profile.update') }}" class="mt-6 space-y-6">
                                @csrf
                                @method('patch')
                                {{-- Name Input --}}
                                <div class="col-12">
                                    <div class="control-group form-group">
                                        <label for="exampleInputEmail1">الأسم</label>
                                        <input type="text" name="name" value="{{ $user->name }}"
                                            class="form-control" placeholder="الأسم" required autofocus autocomplete="name">
                                        @error('name')
                                            <div class="alert alert-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    {{-- Email Input --}}
                                    <div class="control-group form-group">
                                        <label for="exampleInputEmail1">البريد الالكترونى</label>
                                        <input type="email" name="email" value="{{ $user->email }}"
                                            class="form-control" placeholder="البريد الالكترونى">
                                        @error('email')
                                            <div class="alert alert-danger">{{ $message }}</div>
                                        @enderror
                                    </div>

                                    @if ($user instanceof \Illuminate\Contracts\Auth\MustVerifyEmail && !$user->hasVerifiedEmail())
                                        <div>
                                            <p class="text-sm mt-2 text-gray-800 dark:text-gray-200">
                                                {{ __('Your email address is unverified.') }}

                                                <button form="send-verification"
                                                    class="underline text-sm text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 dark:focus:ring-offset-gray-800">
                                                    {{ __('Click here to re-send the verification email.') }}
                                                </button>
                                            </p>

                                            @if (session('status') === 'verification-link-sent')
                                                <p class="mt-2 font-medium text-sm text-green-600 dark:text-green-400">
                                                    {{ __('A new verification link has been sent to your email address.') }}
                                                </p>
                                            @endif
                                        </div>
                                    @endif
                                    <x-primary-button>{{ __('حفظ') }}</x-primary-button>

                                    @if (session('status') === 'profile-updated')
                                        <p x-data="{ show: true }" x-show="show" x-transition x-init="setTimeout(() => show = false, 2000)"
                                            class="text-sm text-gray-600 dark:text-gray-400">{{ __('Saved.') }}</p>
                                    @endif

                            </form>
                        </section>
                        <h3 class="mb-3">كلمة المرور</h3>
                        <section>
                            <form method="post" action="{{ route('password.update') }}" class="mt-6 space-y-6">
                                @csrf
                                @method('put')



                                {{-- Old Password Input --}}
                                <div class="col-12">
                                    <div class="control-group form-group">
                                        <label for="current_password">كلمة المرور الحالية</label>
                                        <input id="update_password_current_password" type="password" name="current_password"
                                            class="form-control" placeholder="كلمة المرور الحالية" autofocus>
                                        @error('current_password')
                                            <div class="alert alert-danger">{{ $message }}</div>
                                        @enderror
                                    </div>

                                    {{-- New Password Input --}}
                                    <div class="control-group form-group">
                                        <label for="password">كلمة المرور الجديدة</label>
                                        <input id="update_password_password" type="password" name="password"
                                            class="form-control" placeholder="كلمة المرور الجديدة" autofocus>
                                        @error('password')
                                            <div class="alert alert-danger">{{ $message }}</div>
                                        @enderror
                                    </div>

                                    {{-- Confirm Password Input --}}
                                    <div class="control-group form-group">
                                        <label for="password_confirmation">تأكيد كلمة المرور</label>
                                        <input id="update_password_password_confirmation" type="password"
                                            name="password_confirmation" class="form-control"
                                            placeholder="تأكيد كلمة المرور" autofocus>
                                        @error('password_confirmation')
                                            <div class="alert alert-danger">{{ $message }}</div>
                                        @enderror
                                    </div>

                                    <x-primary-button>{{ __('حفظ') }}</x-primary-button>

                                    @if (session('status') === 'password-updated')
                                        <p x-data="{ show: true }" x-show="show" x-transition x-init="setTimeout(() => show = false, 2000)"
                                            class="text-sm text-gray-600 dark:text-gray-400">{{ __('Saved.') }}</p>
                                    @endif
                                </div>
                            </form>
                        </section>

                        <h3>حذف الحساب</h3>
                        <section>
                            <div class="col-sm-12 col-md-6 my-4 mx-auto">
                                <a class="modal-effect btn btn-danger btn-block" data-effect="effect-scale"
                                    data-toggle="modal" href="#modaldemo8">
                                    <i class="fas fa-user-times ml-2"></i>
                                    حذف الحساب
                                </a>
                            </div>
                            @include('dashboard.auth.delete')
                        </section>

                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    <!-- Back-to-top -->
    <a href="#top" id="back-to-top"><i class="las la-angle-double-up"></i></a>
@endsection
@section('js')
    <!--Internal  Select2 js -->
    <script src="{{ asset('dashboard') }}/assets/plugins/select2/js/select2.min.js"></script>

    <!-- Internal Jquery.steps js -->
    <script src="{{ asset('dashboard') }}/assets/plugins/jquery-steps/jquery.steps.min.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/parsleyjs/parsley.min.js"></script>

    <!-- Sticky js -->
    <script src="{{ asset('dashboard') }}/assets/js/sticky.js"></script>

    <!--Internal  Form-wizard js -->
    <script src="{{ asset('dashboard') }}/assets/js/form-wizard.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.2.1/dist/cdn.min.js" defer></script>



@endsection
