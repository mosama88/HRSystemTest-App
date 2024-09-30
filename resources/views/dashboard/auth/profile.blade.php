@extends('dashboard.layouts.master')
@section('title', 'صفحتى')
@section('css')
    <!---Internal  Prism css-->
    <link href="{{ URL::asset('dashboard/assets/plugins/prism/prism.css') }}" rel="stylesheet">
    <!--- Custom-scroll -->
    <link href="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.css') }}" rel="stylesheet">
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">صفحتى</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/
                    البيانات الشخصية</span>
            </div>
        </div>


    </div>
    <!-- breadcrumb -->
@endsection
@section('content')
    <div class="col-lg-12 col-md-12">
        @if (session('success') != null)
            <div class="alert alert-success text-center">
                {{ session('success') }}
            </div>
        @endif

        <!-- row -->
        <div class="row">
            <div class="card custom-card col-10 mx-auto" id="tab">
                <div class="card-body">
                    <div>
                        <h6 class="card-title mb-1">تحديث البيانات الشخصية</h6>
                        <p class="text-muted card-sub-title">تحديث البيانات الشخصية و كلمة المرور أو حذف الحساب </p>
                    </div>
                    <div class="text-wrap">
                        <div class="example">
                            <div class="border">
                                <div class="bg-gray-100 nav-bg">
                                    <nav class="nav nav-tabs">
                                        <a class="nav-link active" data-toggle="tab" href="#tabCont1">بياناتى</a>
                                        <a class="nav-link" data-toggle="tab" href="#tabCont2">كلمة المرور</a>
                                        <a class="nav-link" data-toggle="tab" href="#tabCont3">حذف الحساب</a>
                                    </nav>
                                </div>
                                <div class="card-body tab-content">
                                    <div class="tab-pane active show" id="tabCont1">
                                        <div id="successMessage" class="alert alert-success mt-3" style="display: none;">
                                            {{ __('تم تحديث الملف الشخصي بنجاح') }}
                                        </div>
                                        <form id="profileForm" method="post"
                                            action="{{ route('dashboard.profile.update') }}" class="mt-6 space-y-6">
                                            @csrf
                                            @method('patch')
                                            <div class="row">
                                                {{-- Name Input --}}
                                                <div class="col-8">
                                                    <div class="control-group form-group mb-3">
                                                        <label for="name">الأسم</label>
                                                        <input type="text" id="name" name="name"
                                                            value="{{ $user->name }}" class="form-control"
                                                            placeholder="الأسم" autofocus autocomplete="name">
                                                        <span class="text-danger" id="nameError"></span>
                                                        <!-- مساحة لعرض الأخطاء -->
                                                    </div>
                                                </div>

                                                {{-- UserName Input --}}
                                                <div class="col-8">
                                                    <div class="control-group form-group mb-3">
                                                        <label for="username">أسم المستخدم</label>
                                                        <input type="text" id="username" name="username"
                                                            value="{{ $user->username }}" class="form-control"
                                                            placeholder="أسم المستخدم" required autofocus
                                                            autocomplete="username">
                                                        <span class="text-danger" id="usernameError"></span>
                                                        <!-- مساحة لعرض الأخطاء -->
                                                    </div>

                                                    {{-- Email Input --}}
                                                    <div class="control-group form-group mb-3">
                                                        <label for="email">البريد الالكترونى</label>
                                                        <input type="email" id="email" name="email"
                                                            value="{{ $user->email }}" class="form-control"
                                                            placeholder="البريد الالكترونى">
                                                        <span class="text-danger" id="emailError"></span>
                                                        <!-- مساحة لعرض الأخطاء -->
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row m-auto" dir="ltr">
                                                <button class="btn ripple btn-dark" style="width: 100px" type="submit"
                                                    name="submit">{{ __('حفظ') }}</button>
                                            </div>

                                            <div id="successMessage" class="alert alert-success mt-3"
                                                style="display: none;">
                                                {{ __('تم تحديث الملف الشخصي بنجاح') }}
                                            </div>
                                        </form>
                                    </div>
                                    <div class="tab-pane" id="tabCont2">
                                        <form method="post" action="{{ route('password.update') }}"
                                            class="mt-6 space-y-6">
                                            @csrf
                                            @method('put')

                                            @if (session('status') === 'password-updated')
                                                <p x-data="{ show: true }" x-show="show" x-transition
                                                    x-init="setTimeout(() => show = false, 2000)"
                                                    class="text-sm text-gray-600 dark:text-gray-400">
                                                    {{ __('Saved.') }}</p>
                                            @endif

                                            {{-- Old Password Input --}}
                                            <div class="col-8">
                                                <div class="control-group form-group mb-3">
                                                    <label for="current_password">كلمة المرور الحالية</label>
                                                    <input id="update_password_current_password" type="password"
                                                        name="current_password" class="form-control"
                                                        placeholder="كلمة المرور الحالية" autofocus>
                                                    @error('current_password')
                                                        <div class="alert alert-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>

                                                {{-- New Password Input --}}
                                                <div class="control-group form-group mb-3">
                                                    <label for="password">كلمة المرور الجديدة</label>
                                                    <input id="update_password_password" type="password" name="password"
                                                        class="form-control" placeholder="كلمة المرور الجديدة" autofocus>
                                                    @error('password')
                                                        <div class="alert alert-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>

                                                {{-- Confirm Password Input --}}
                                                <div class="control-group form-group mb-3">
                                                    <label for="password_confirmation">تأكيد كلمة المرور</label>
                                                    <input id="update_password_password_confirmation" type="password"
                                                        name="password_confirmation" class="form-control"
                                                        placeholder="تأكيد كلمة المرور" autofocus>
                                                    @error('password_confirmation')
                                                        <div class="alert alert-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                            </div>

                                            <div class="row m-auto" dir="ltr">
                                                <button class="btn ripple btn-dark" style="width: 100px" type="submit"
                                                    name="submit">{{ __('حفظ') }}</button>
                                            </div>


                                        </form>

                                    </div>
                                    <div class="tab-pane" id="tabCont3">
                                        <div class="col-sm-12 col-md-3 my-4 mx-auto">
                                            <a class="modal-effect btn btn-danger btn-block" data-effect="effect-scale"
                                                data-toggle="modal" href="#modaldemo8">
                                                <i class="fas fa-user-times ml-2"></i>
                                                حذف الحساب
                                            </a>
                                        </div>
                                        @include('dashboard.auth.delete')
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- row closed -->
    </div>
    <!-- Container closed -->
    </div>
    </div>
    </div>
    <!-- main-content closed -->
@endsection
@section('js')
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!--Internal  Datepicker js -->
    <script src="{{ URL::asset('dashboard/assets/plugins/jquery-ui/ui/widgets/datepicker.js') }}"></script>
    <!-- Internal Select2 js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/select2/js/select2.min.js') }}"></script>
    <!-- Internal Jquery.mCustomScrollbar js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/custom-scroll/jquery.mCustomScrollbar.concat.min.js') }}">
    </script>
    <!--Internal  Clipboard js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.min.js') }}"></script>
    <script src="{{ URL::asset('dashboard/assets/plugins/clipboard/clipboard.js') }}"></script>
    <!-- Internal Prism js-->
    <script src="{{ URL::asset('dashboard/assets/plugins/prism/prism.js') }}"></script>


    <script>
        $(document).ready(function() {
            $('#profileForm').on('submit', function(event) {
                event.preventDefault();

                // مسح الرسائل السابقة
                $('#nameError').text('');
                $('#usernameError').text('');
                $('#emailError').text('');
                $('#successMessage').hide(); // إخفاء رسالة النجاح في حال كانت ظاهرة

                // إرسال البيانات عبر AJAX
                $.ajax({
                    url: $(this).attr('action'),
                    method: 'POST',
                    data: $(this).serialize(),
                    success: function(response) {
                        // في حال النجاح
                        if (response.status === 'success') {
                            // إظهار رسالة النجاح
                            $('#successMessage').show();

                            // إعادة تحميل الصفحة بعد ثانية واحدة (1000ms)
                            setTimeout(function() {
                                location.reload();
                            }, 1000);
                        }
                    },
                    error: function(xhr) {
                        // التعامل مع الأخطاء
                        let errors = xhr.responseJSON.errors;
                        if (errors.name) {
                            $('#nameError').text(errors.name[0]);
                        }
                        if (errors.username) {
                            $('#usernameError').text(errors.username[0]);
                        }
                        if (errors.email) {
                            $('#emailError').text(errors.email[0]);
                        }
                    }
                });
            });
        });
    </script>
@endsection
