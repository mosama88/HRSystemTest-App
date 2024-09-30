@extends('dashboard.layouts.master2')
@section('title', 'صفحة الدخول')
@section('css')
    <!-- Sidemenu-respoansive-tabs css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/sidemenu-responsive-tabs/css/sidemenu-responsive-tabs.css') }}"
        rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/select2/css/select2.min.css') }}" rel="stylesheet">
    <!--Internal  Datetimepicker-slider css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/amazeui-datetimepicker/css/amazeui.datetimepicker.css') }}"
        rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/jquery-simple-datetimepicker/jquery.simple-dtpicker.css') }}"
        rel="stylesheet">
    <link href="{{ URL::asset('dashboard/assets/plugins/pickerjs/picker.min.css') }}" rel="stylesheet">
    <!-- Internal Spectrum-colorpicker css -->
    <link href="{{ URL::asset('dashboard/assets/plugins/spectrum-colorpicker/spectrum.css') }}" rel="stylesheet">

    <style>
        .login-form {
            display: none;
        }

        .select-hide {

            margin-top: 100px;
        }
    </style>
@endsection
@section('content')
    <div class="col-12 container-fluid">
        <div class="row no-gutter">
            <!-- The content half -->
            <div class="col-md-6 col-lg-6 col-xl-5 bg-white">
                <div class="login d-flex align-items-center py-2">
                    <!-- Demo content-->
                    <div class="container p-0">
                        <div class="row">
                            <div class="col-md-10 col-lg-10 col-xl-9 mx-auto">
                                <div class="card-sigin">
                                    <div class="mb-5 d-flex"> <a href="{{ url('/' . ($page = 'index')) }}">
                                            @if ($data['image'])
                                                <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
                                                    style="width: 100px; height:100"
                                                    src="{{ asset('dashboard/assets/uploads/admin_setting/' . $data['image']) }}"
                                                    data-holder-rendered="true">
                                            @else
                                                <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
                                                    style="width: 100px; height:100"
                                                    src="{{ asset('dashboard/assets/img/default-logo.png') }}"
                                                    data-holder-rendered="true">
                                            @endif

                                        </a>
                                        <h1 class="main-logo1 ml-1 mr-0 my-auto tx-28"><span class="mr-4"
                                                style="color: #0262AC;">{{ $data['company_name'] }}</span></h1>
                                    </div>


                                    <div class="container select-hide">
                                        {{-- Select To login --}}
                                        <div class="row mb-3">
                                            <label class="form-label">حدد طريقة الدخول</label>
                                            <div class="col-sm-12">
                                                <select name="somename" class="form-control" id="selectForm"
                                                    aria-label="Default select example" onclick="console.log($(this).val())"
                                                    onchange="console.log('change is firing')" tabindex="-1">
                                                    <option disabled selected="">
                                                        افتح قائمة التحديد</option>
                                                    <option value="admin">Admin</option>
                                                    <option value="user">User</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>



                                    @if ($errors->any())
                                        @foreach ($errors->all() as $error)
                                            <div class="alert alert-danger text-center">
                                                {{ $error }}
                                            </div>
                                        @endforeach
                                    @endif

                                    {{-- Login Admin --}}
                                    <div class="login-form" id="admin">
                                        <h4 class="font-size-18 mt-5 text-center">
                                            مرحبًا بعودتك !
                                        </h4>
                                        <p class="text-muted text-center">الدخول بواسطة Admin
                                        </p>
                                        <form method="POST" action="{{ route('admin.login') }}">
                                            @csrf

                                            <!-- Email Input -->
                                            <div class="mb-3">
                                                <label class="form-label" for="username">أسم المستخدم</label>
                                                <input type="text" name="username" class="form-control" id="username"
                                                    placeholder="Enter username">
                                                <x-input-error :messages="$errors->get('username')" class="mt-2" />
                                            </div>

                                            <!-- Password Input -->
                                            <div class="mb-3">
                                                <label class="form-label" for="userpassword">كلمة المرور</label>
                                                <input type="password" name="password" class="form-control"
                                                    id="userpassword" placeholder="Enter password">
                                                <x-input-error :messages="$errors->get('password')" class="mt-2" />
                                            </div>

                                            <div class="mb-3 row">
                                                <div class="col-sm-12">
                                                    <div class="form-check">
                                                        <input type="checkbox" name="remember" class="form-check-input"
                                                            id="customControlInline">
                                                        <label class="form-check-label mx-3"
                                                            for="customControlInline">تذكرنى</label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 text-center my-2">
                                                    <button class="btn btn-primary w-md waves-effect waves-light"
                                                        type="submit">دخول</button>
                                                </div>
                                            </div>


                                        </form>
                                    </div>


                                    {{-- Login User --}}
                                    <div class="login-form" id="user">
                                        <h4 class="font-size-18 mt-5 text-center">
                                            مرحبًا بعودتك !
                                        </h4>
                                        <p class="text-muted text-center">الدخول بواسطة User.
                                        </p>

                                        <form method="POST" action="{{ route('user.login') }}">
                                            @csrf

                                            <!-- Email Input -->
                                            <div class="mb-3">
                                                <label class="form-label" for="username">أسم المستخدم</label>
                                                <input type="text" name="email" class="form-control" id="username"
                                                    placeholder="Enter username">
                                                <x-input-error :messages="$errors->get('email')" class="mt-2" />
                                            </div>

                                            <!-- Password Input -->
                                            <div class="mb-3">
                                                <label class="form-label" for="userpassword">كلمة المرور</label>
                                                <input type="password" name="password" class="form-control"
                                                    id="userpassword" placeholder="Enter password">
                                                <x-input-error :messages="$errors->get('password')" class="mt-2" />
                                            </div>

                                            <div class="mb-3 row">
                                                <div class="col-sm-12">
                                                    <div class="form-check">
                                                        <input type="checkbox" name="remember" class="form-check-input"
                                                            id="customControlInline">
                                                        <label class="form-check-label mx-3"
                                                            for="customControlInline">تذكرنى</label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 text-center my-2">
                                                    <button class="btn btn-primary w-md waves-effect waves-light"
                                                        type="submit">دخول</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>



                                </div>
                            </div>
                        </div>
                    </div><!-- End -->
                </div>
            </div><!-- End -->


            <!-- The image half -->
            <div class="col-md-6 col-lg-6 col-xl-7 d-none d-md-flex"
                style="background-color: #014051; height: 100vh; padding: 0;">
                <div class="row" style="width: 100%; height: 100%; margin: 0;">
                    <div class="col-12 my-auto" style="width: 100vw; height: 100%; padding: 0;">
                        @if ($data['photo_cover'])
                            <img style="width: 100%; height: 100%; object-fit: cover;"
                                src="{{ asset('dashboard/assets/uploads/company/photo/' . $data['photo_cover']) }}"
                                data-holder-rendered="true">
                        @else
                            <img src="{{ URL::asset('dashboard/assets/img/media/hr-system.jpg') }}"
                                style="width: 100%; height: 100%; object-fit: cover;" alt="logo">
                        @endif
                    </div>
                </div>
            </div>

            {{-- #0DB2DE --}}
        </div>
    </div>
@endsection
@section('js')
    <script>
        $('#selectForm').change(function() {
            var myID = $(this).val();
            $('.login-form').each(function() {
                myID === $(this).attr('id') ? $(this).show() : $(this).hide();
            });
        });
    </script>


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
@endsection
