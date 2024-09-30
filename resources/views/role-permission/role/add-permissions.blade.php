@extends('dashboard.layouts.master')
@section('title', 'أضافة أذونات`')
@section('css')
    <!--Internal  Font Awesome -->
    <link href="{{ URL::asset('dashboard/assets/plugins/fontawesome-free/css/all.min.css') }}" rel="stylesheet">
    <!--Internal  treeview -->
    <link href="{{ URL::asset('dashboard/assets/plugins/treeview/treeview-rtl.css') }}" rel="stylesheet" type="text/css" />
@endsection
@section('page-header')
    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">الأذونات</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ أضافة
                    أذونات</span>
            </div>
        </div>
    </div>
    <!-- breadcrumb -->
@endsection


@section('page-header')

    <!-- breadcrumb -->
    <div class="breadcrumb-header justify-content-between">
        <div class="my-auto">
            <div class="d-flex">
                <h4 class="content-title mb-0 my-auto">الأذونات</h4><span class="text-muted mt-1 tx-13 mr-2 mb-0">/ أضافة
                    أذونات</span>
            </div>
        </div>

    </div>
    <!-- breadcrumb -->
@endsection



@section('content')
    <div class="container col-12 mt-5">


        <div class="row">
            <div class="col-md-12">

                @if (session('status'))
                    <div class="alert alert-success">{{ session('status') }}</div>
                @endif

                <div class="card">
                    <div class="text-left my-4 mx-4">
                        <div>
                            <a class="btn btn-outline-primary" href="{{ url('roles') }}"> <i class="fas fa-undo"></i>
                                الرجوع الى
                                جدول الأذونات</a>

                        </div>
                    </div>

                    <div class="card-header">
                        <h4>الصلاحية : {{ $role->name }}
                        </h4>
                    </div>
                    <div class="card-body">


                        <form action="{{ url('roles/' . $role->id . '/give-permissions') }}" method="POST">
                            @csrf
                            @method('PUT')

                            <div class="mb-3 col-12">
                                @error('permission')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror

                                <label for="">الأذونات</label>

                                <div class="row">
                                    <ul id="treeview1" class="col-12">


                                        <div class="row mb-4">

                                            <div class="col-4">
                                                {{-- قائمة الأعدادات --}}
                                                <li>
                                                    <a href="#">قائمة الأعدادات</a>
                                                    <ul>

                                                        <li>
                                                            <a href="#">قائمة الأعدادات</a>
                                                            <ul>
                                                                <li>
                                                                    @foreach ($permissions->where('category', 'Settings') as $permission)
                                                                        <div class="col-md-12">
                                                                            <label>
                                                                                <input type="checkbox" name="permission[]"
                                                                                    value="{{ $permission->name }}"
                                                                                    {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                {{ $permission->name }}
                                                                            </label>
                                                                        </div>
                                                                    @endforeach
                                                                </li>
                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الضبط العام</a>
                                                            <ul>
                                                                <li>
                                                                    @foreach ($permissions->where('category', 'generalSettings') as $permission)
                                                                        <div class="col-md-12">
                                                                            <label>
                                                                                <input type="checkbox" name="permission[]"
                                                                                    value="{{ $permission->name }}"
                                                                                    {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                {{ $permission->name }}
                                                                            </label>
                                                                        </div>
                                                                    @endforeach
                                                                </li>
                                                            </ul>
                                                        </li>

                                                        <!-- السنوات المالية -->
                                                        <li>
                                                            <a href="#">السنوات المالية</a>
                                                            <ul>
                                                                <li>
                                                                    @foreach ($permissions->where('category', 'financeCalendars') as $permission)
                                                                        <div class="col-md-12">
                                                                            <label>
                                                                                <input type="checkbox" name="permission[]"
                                                                                    value="{{ $permission->name }}"
                                                                                    {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                {{ $permission->name }}
                                                                            </label>
                                                                        </div>
                                                                    @endforeach
                                                                </li>
                                                            </ul>
                                                        </li>

                                                        <!-- الفروع -->
                                                        <li>
                                                            <a href="#">الفروع</a>
                                                            <ul>
                                                                <li>
                                                                    @foreach ($permissions->where('category', 'branches') as $permission)
                                                                        <div class="col-md-12">
                                                                            <label>
                                                                                <input type="checkbox" name="permission[]"
                                                                                    value="{{ $permission->name }}"
                                                                                    {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                {{ $permission->name }}
                                                                            </label>
                                                                        </div>
                                                                    @endforeach
                                                                </li>
                                                            </ul>
                                                        </li>

                                                        <!-- الشفتات -->
                                                        <li>
                                                            <a href="#">الشفتات</a>
                                                            <ul>
                                                                <li>
                                                                    @foreach ($permissions->where('category', 'shiftsTypes') as $permission)
                                                                        <div class="col-md-12">
                                                                            <label>
                                                                                <input type="checkbox" name="permission[]"
                                                                                    value="{{ $permission->name }}"
                                                                                    {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                {{ $permission->name }}
                                                                            </label>
                                                                        </div>
                                                                    @endforeach
                                                                </li>
                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">الأدارات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'departments') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">الوظائف</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'jobsCategories') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الدرجات الوظيفية</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'jobsGrades') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">المؤهل</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'qualifications') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">العطلات الرسمية</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'holidays') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">الأستقالة</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'resignations') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الأجازات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'vacations') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>



                                                        <li>
                                                            <a href="#">البلاد</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'countries') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">المنطقه</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'cities') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">الجنسيات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'nationalities') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">فصيلة الدم</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'bloodTypes') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                    </ul>
                                                </li>
                                            </div>

                                            <div class="col-4">
                                                {{-- قائمة بيانات شئون الموظفين --}}
                                                <li>
                                                    <a href="#">قائمة بيانات شئون الموظفين</a>
                                                    <ul>

                                                        <li>
                                                            <a href="#">قائمة بيانات شئون الموظفين</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'affairsEmployees') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الموظفين</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'Employees') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>



                                                        <li>
                                                            <a href="#">الأضافى للراتب</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'additional_types') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الخصم للراتب</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'discount_types') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">البدلات للراتب</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'allowances') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </div>

                                            <div class="col-4">
                                                {{--  قائمة الأجور --}}
                                                <li>
                                                    <a href="#">قائمة الأجور</a>
                                                    <ul>

                                                        <li>
                                                            <a href="#">قائمة الأجور</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'salaries') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">السجلات الرئيسية للرواتب</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'salaryRecords') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>



                                                        <li>
                                                            <a href="#">الجزاءات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'sanctions') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الغيابات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'absences') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الأضافى</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'additionals') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>



                                                        <li>
                                                            <a href="#">الخصومات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'discounts') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">المكافئات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'rewards') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">البدلات المتغيرة</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'allowancesSalary') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">السلف الشهرية</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'loans') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">السلف المستديمة</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'permanentLoan') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="#">رواتب الموظفين</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'mainSalaryEmployees') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                    </ul>
                                                </li>
                                            </div>
                                        </div>



                                        <div class="row  mb-4">
                                            <div class="col-4">
                                                {{-- قائمة بيانات شئون الموظفين --}}
                                                <li>
                                                    <a href="#">قائمة جهاز البصمة</a>
                                                    <ul>

                                                        <li>
                                                            <a href="#"> جهاز البصمة</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'attendanceDeparturesFP') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">جهاز البصمة</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'attendanceDepartures') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox"
                                                                                        name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>

                                            </div>








                                            <div class="col-4">
                                                {{-- قائمة المستخدمين--}}
                                                <li>
                                                    <a href="#">قائمة المستخدمين</a>
                                                    <ul>

                                                        <li>
                                                            <a href="#">قائمة المستخدمين</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'UserList') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox" name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">المستخدمين</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'users') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox" name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>



                                                        <li>
                                                            <a href="#">الصلاحيات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'roles') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox" name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>


                                                        <li>
                                                            <a href="#">الأذونات</a>
                                                            <ul>

                                                                <ul>
                                                                    <li>
                                                                        @foreach ($permissions->where('category', 'permissions') as $permission)
                                                                            <div class="col-md-12">
                                                                                <label>
                                                                                    <input type="checkbox" name="permission[]"
                                                                                        value="{{ $permission->name }}"
                                                                                        {{ in_array($permission->id, $rolePermissions) ? 'checked' : '' }} />
                                                                                    {{ $permission->name }}
                                                                                </label>
                                                                            </div>
                                                                        @endforeach
                                                                    </li>
                                                                </ul>

                                                            </ul>
                                                        </li>

                                                    </ul>
                                                </li>
                                            </div>




                                        </div>



                                    </ul>
                                </div>

                            </div>

                            {{-- Submit --}}
                            <div class="row row-xs wd-xl-80p">
                                <div class="col-12">
                                    <div class="col-sm-3">
                                        <button type="submit" class="btn btn-danger-gradient btn-block">تأكيد
                                            البيانات</button>

                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>
    </div>


@endsection

@section('js')

    <script src="{{ URL::asset('dashboard/assets/plugins/treeview/treeview.js') }}"></script>
@endsection
