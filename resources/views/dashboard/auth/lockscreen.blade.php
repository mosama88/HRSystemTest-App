<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>برنامج الموظفين | قفل الشاشه</title>
    <link rel="icon" href="{{ asset('dashboard') }}/assets/img/brand/favicon.png" type="image/x-icon" />
    <link href="{{ asset('dashboard') }}/assets/css/icons.css" rel="stylesheet">
    <link href="{{ asset('dashboard') }}/assets/plugins/sidebar/sidebar.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('dashboard') }}/assets/css-rtl/sidemenu.css">
    <link href="{{ asset('dashboard') }}/assets/plugins/mscrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" />
    <link href="{{ asset('dashboard') }}/assets/css-rtl/style.css" rel="stylesheet">
    <link href="{{ asset('dashboard') }}/assets/css-rtl/skin-modes.css" rel="stylesheet">
    <link href="{{ asset('dashboard') }}/assets/css/style-dark.css" rel="stylesheet">
    <link href="{{ asset('dashboard') }}/assets/css/animate.css" rel="stylesheet">
    <style>
        .form-group input {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 16px;
        }

        .btn {
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>

<body class="main-body app sidebar-mini">
    <div id="global-loader">
        <img src="{{ asset('dashboard') }}/assets/img/loader.svg" class="loader-img" alt="Loader">
    </div>
    <div class="page">
        <div class="container-fluid">
            <div class="row no-gutter">

                <div class="col-md-6 col-lg-6 col-xl-5 bg-white">
                    <div class="login d-flex align-items-center py-2">
                        <div class="container p-0">
                            <div class="row">
                                <div class="col-md-10 col-lg-10 col-xl-9 mx-auto">
                                    <div class="mb-5 d-flex"> <a href="#"><img
                                                src="{{ asset('dashboard') }}/assets/img/media/logo-Administrative-Prosecution.png"
                                                class="sign-favicon ht-40" alt="logo"></a>
                                        <h1 class="main-logo1 mr-1 my-auto tx-28">هيئة<span> النيابه</span>
                                            الأدارية</h1>
                                    </div>
                                    <div class="main-card-signin d-md-flex bg-white">
                                        <div class="p-4 wd-100p">
                                            <div class="main-signin-header">
                                                <div class="avatar avatar-xxl avatar-xxl mx-auto text-center mb-2">
                                                    <img alt=""
                                                        class="avatar avatar-xxl rounded-circle mt-2 mb-2"
                                                        src="{{ asset('dashboard') }}/assets/img/login-user.png">
                                                </div>
                                                <div class="mx-auto text-center mt-4 mg-b-20">
                                                    <h5 class="mg-b-10 tx-16">{{ Auth::user()->name }}</h5>
                                                    <p class="tx-13 text-muted">أدخل كلمة المرور الخاصة بك لعرض شاشتك
                                                    </p>
                                                </div>
                                                <form action="{{ route('dashboard.unlock') }}" method="POST">
                                                    @csrf
                                                    <div class="form-group">
                                                        <input name="password" class="form-control"
                                                            placeholder="Enter your password" type="password"
                                                            value="">
                                                        <div class="error-message" id="error-message">الرجاء إدخال كلمة
                                                            المرور.</div>

                                                    </div>
                                                    <button class="btn btn-main-primary btn-block">الغاء القفل <i
                                                            class="fas fa-lock-open"></i></button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6 col-xl-7 d-none d-md-flex " style="background-color:#2C2930">
                    <div class="row wd-100p mx-auto text-center">
                        <div class="col-md-12 col-lg-12 col-xl-12 my-auto mx-auto wd-100p">
                            <img src="{{ asset('dashboard/assets/img/media/Administrative-Prosecution.png') }}"
                                class="my-auto ht-xl-80p wd-md-100p wd-xl-80p mx-auto" alt="logo"
                                style="border-radius: 10px;">
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script src="{{ asset('dashboard') }}/assets/plugins/jquery/jquery.min.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/ionicons/ionicons.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/moment/moment.js"></script>
    <script src="{{ asset('dashboard') }}/assets/js/eva-icons.min.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/rating/jquery.rating-stars.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/rating/jquery.barrating.js"></script>
    <script src="{{ asset('dashboard') }}/assets/plugins/jquery-sparkline/jquery.sparkline.min.js"></script>
    <script src="{{ asset('dashboard') }}/assets/js/custom.js"></script>
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const passwordInput = document.querySelector('input[name="password"]');
            const errorMessage = document.getElementById('error-message');
            if (!passwordInput.value) {
                e.preventDefault();
                errorMessage.style.display = 'block';
            }
        });
    </script>
</body>

</html>
