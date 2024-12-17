@php
    use Carbon\Carbon;
@endphp

<div>
    <div class="bg-gray-100 nav-bg">
        <nav class="nav nav-tabs">
            <a class="nav-link active" data-toggle="tab" href="#tabCont1">بيانات
                شخصية</a>
            <a class="nav-link" data-toggle="tab" href="#tabCont2">بيانات وظيفية</a>
            <a class="nav-link" data-toggle="tab" href="#tabCont3">بيانات إضافية</a>
        </nav>
    </div>

    <form wire:submit.prevent="submit">

        <div class="card-body tab-content">
            <div class="tab-pane active show" id="tabCont1">
                <div class="row">
                    {{-- FP Code Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> كود بصمة الموظف</label> <span class="tx-danger">*</span>
                            <input autofocus type="text" wire.model="fp_code" id="fp_code"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                            @error('fp_code')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Name Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> اسم الموظف بالكامل</label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="name" id="name" class="form-control">
                            @error('name')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror

                        </div>
                    </div>

                    {{-- Gender Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> نوع الجنس</label> <span class="tx-danger">*</span>
                            <select wire.model="gender" id="gender" class="form-control">
                                <option value="" selected>-- أختر النوع --</option>
                                <option value="Male">ذكر</option>
                                <option value="Female">انثي</option>
                            </select>
                            @error('gender')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Branch Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الفرع التابع له الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="branch_id" id="branch_id" class="form-control select2">
                                <option value="" selected>-- أختر الفرع --</option>
                                @if (@isset($other['branches']) && !@empty($other['branches']))
                                    @foreach ($other['branches'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('branch_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Qualifications Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> المؤهل الدراسي</label>
                            <select wire.model="qualification_id" id="qualification_id" class="form-control select2">
                                <option value="" selected>-- أختر المؤهل --</option>
                                @if (@isset($other['qualifications']) && !@empty($other['qualifications']))
                                    @foreach ($other['qualifications'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('qualification_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Qualifications Year Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label>سنة التخرج</label>
                            <input type="text" wire.model="qualification_year" id="qualification_year"
                                class="form-control" oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                            @error('qualification_year')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Qualifications Year Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> تقدير التخرج</label>
                            <select wire.model="graduation_estimate" id="graduation_estimate" class="form-control">
                                <option value="" selected>-- أختر التقدير --</option>
                                <option value="Fair">مقبول</option>
                                <option value="Good">جيد</option>
                                <option value="Very_Good">جيد جدآ</option>
                                <option value="Excellent">أمتياز</option>

                            </select>
                            @error('graduation_estimate')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- major Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> تخصص التخرج</label>
                            <input type="text" wire.model="major" id="major" class="form-control">
                            @error('major')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Birth Date Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group" id="employee_birth_date_input">
                            <label> تاريخ الميلاد</label> <span class="tx-danger">*</span>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="birth_date" id="birth_date"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('birth_date')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('birth_date')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- National ID Date Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> رقم بطاقة الهوية</label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="national_id" id="national_id"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                            @error('national_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- National ID Place Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> مركز اصدار بطاقة الهوية </label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="national_id_place" id="national_id_place"
                                class="form-control">
                            @error('national_id_place')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- End National ID Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> تاريخ انتهاء بطاقة الهوية</label> <span class="tx-danger">*</span>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="end_national_id" id="end_national_id"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('end_national_id')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('end_national_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- Social Status Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الحالة الأجتماعية</label>
                            <select wire.model="social_status" id="social_status" class="form-control">
                                <option value="" selected>-- أختر الحالة --</option>
                                <option value="Married">متزوج</option>
                                <option value="Single">أعزب</option>
                                <option value="Widowed">أرمل</option>
                                <option value="Divorced">مطلق</option>
                            </select>
                            @error('social_status')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Children Number Input --}}
                    <div class="col-md-4 mb-3" id="children_number_hideandshow">
                        <div class="form-group">
                            <label> عدد الأطفال</label>
                            <input type="text" wire.model="children_number"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" id="children_number"
                                class="form-control">
                            @error('children_number')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Blood Group ID Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> فصيلة الدم</label>
                            <select wire.model="blood_types_id" id="blood_types_id" class="form-control select2 ">
                                <option value="" selected>-- أختر الفصية --</option>
                                @if (@isset($other['blood_types']) && !@empty($other['blood_types']))
                                    @foreach ($other['blood_types'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('blood_types_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Nationality Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الجنسية</label> <span class="tx-danger">*</span>
                            <select wire.model="nationality_id" id="nationality_id" class="form-control select2 ">
                                <option value="" selected>-- أختر الجنسية --</option>
                                @if (@isset($other['nationalities']) && !@empty($other['nationalities']))
                                    @foreach ($other['nationalities'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('nationality_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Languages Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> اللغة الاساسية التي يتحدث بها</label>
                            <select wire.model="language_id" id="language_id" class="form-control select2 ">
                                <option value="" selected>-- أختر الوظيفه --</option>
                                @if (@isset($other['languages']) && !@empty($other['languages']))
                                    @foreach ($other['languages'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('language_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Religion Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الديانة</label>
                            <select wire.model="religion" id="religion" class="form-control">
                                <option value="" selected>-- أختر الديانه --</option>
                                <option value="Muslim">مسلم</option>
                                <option value="Christian">مسيحى</option>
                            </select>
                            @error('religion')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Email Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> البريد الالكتروني</label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="email" id="email" class="form-control">
                            @error('email')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Country Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label>الدولة التابع لها الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="country_id" id="country_id" class="form-control select2">
                                <option value="">-- اختر الدولة التابع لها الموظف --
                                </option>
                                @if (@isset($other['countires']) && !@empty($other['countires']))
                                    @foreach ($other['countires'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('country_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Governorate Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group" id="governorates_Div">
                            <label>المحافظة التابع لها الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="governorate_id" id="governorate_id" class="form-control select2">
                                <option value="">-- اختر المحافظة التابع لها الموظف
                                    --</option>
                                @if (isset($other['governorates']) && !empty($other['governorates']))
                                    @foreach ($other['governorates'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }}
                                        </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('governorate_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- City Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group" id="centers_div">
                            <label>المدينة/المركز</label> <span class="tx-danger">*</span>
                            <select wire.model="city_id" id="city_id" class="form-control select2">
                                <option value="">-- اختر المدينة التابع لها الموظف --
                                </option>
                                @if (isset($other['cities']) && !empty($other['cities']))
                                    @foreach ($other['cities'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }}
                                        </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('city_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Staies Address Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> عنوان الاقامة الحالي للموظف</label>
                            <input type="text" wire.model="staies_address" id="staies_address"
                                class="form-control">
                            @error('staies_address')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Work Telephone Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هاتف المحمول</label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="mobile" id="mobile" class="form-control">
                            @error('mobile')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Home Telephone Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هاتف المنزل</label>
                            <input type="text" wire.model="home_telephone" id="home_telephone"
                                class="form-control">
                            @error('home_telephone')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Work Telephone Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هاتف العمل</label>
                            <input type="text" wire.model="work_telephone" id="work_telephone"
                                class="form-control">
                            @error('work_telephone')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Military Input --}}
                    <div class="col-md-4 mb-3" id="military_hideandshow">
                        <div class="form-group">
                            <label> حالة الخدمة العسكرية</label>
                            <select wire.model="military" id="military" class="form-control">
                                <option value="" selected>-- أختر الحالة --</option>
                                <option value="Exemption">إعفاء نهائى</option>
                                <option value="Exemption_Temporary">إعفاء مؤقت</option>
                                <option value="Complete">أدى الخدمه</option>
                            </select>
                            @error('military')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Miltary Date From Input --}}
                    <div class="col-md-4 mb-3 related_miltary_1" id="military_date_from_hideandshow">
                        <div class="form-group">
                            <label> تاريخ بداية الخدمة العسكرية </label>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="military_date_from" id="military_date_from"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('military_date_from')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('military_date_from')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>



                    {{-- Miltary Date To Input --}}
                    <div class="col-md-4 mb-3 related_miltary_1" id="military_date_to_hideandshow">
                        <div class="form-group">
                            <label> تاريخ نهاية الخدمة العسكرية </label>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="military_date_to" id="military_date_to"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('military_date_to')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('military_date_to')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Miltary Wepon Input --}}
                    <div class="col-md-4 mb-3 related_miltary_1" id="military_wepon_hideandshow">
                        <div class="form-group">
                            <label> سلاح الخدمة العسكرية </label>
                            <input type="text" wire.model="military_wepon" id="military_wepon"
                                class="form-control">
                            @error('qualification_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Miltary Exemption Date Input --}}
                    <div class="col-md-4 mb-3 related_miltary_2" id="military_exemption_date_hideandshow">
                        <div class="form-group">
                            <label> تاريخ اعفاء الخدمة العسكرية </label>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="military_exemption_date"
                                    id="military_exemption_date" placeholder="يوم / شهر / سنه"
                                    class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('military_exemption_date')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('military_wepon')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Miltary Exemption Reason Input --}}
                    <div class="col-md-4 mb-3 related_miltary_2" id="military_exemption_reason_hideandshow">
                        <div class="form-group">
                            <label> سبب اعفاء الخدمة العسكرية </label>
                            <input type="text" wire.model="military_exemption_reason"
                                id="military_exemption_reason" class="form-control">
                            @error('military_exemption_reason')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Miltary Postponement Reason Input --}}
                    <div class="col-md-4 mb-3 related_miltary_3" id="military_postponement_reason_hideandshow">
                        <div class="form-group">
                            <label> سبب ومدة تأجيل الخدمة العسكرية</label>
                            <input type="text" wire.model="military_postponement_reason"
                                id="military_postponement_reason" class="form-control">
                            @error('military_postponement_reason')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Driving License Input --}}
                    <div class="col-md-4 mb-3" id="driving_license_hideandshow">
                        <div class="form-group">
                            <label> هل يمتلك رخصة قيادة</label>
                            <select wire.model="driving_license" id="driving_license" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('driving_license')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Driving License ID Input --}}
                    <div class="col-md-4 mb-3 related_does_has_Driving_License" id="driving_License_id_hideandshow">
                        <div class="form-group">
                            <label> رقم رخصة القيادة</label>
                            <input type="text" wire.model="driving_License_id"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" id="driving_License_id"
                                class="form-control">
                            @error('driving_License_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Driving License Type Input --}}
                    <div class="col-md-4 mb-3 related_does_has_Driving_License" id="driving_license_type_hideandshow">
                        <div class="form-group">
                            <label> نوع رخصة القيادة</label>
                            <select wire.model="driving_license_type" id="driving_license_type"
                                class="form-control select2 ">
                                <option value=""> -- اختر النوع --</option>
                                <option value="Special">رخصة خاصة</option>
                                <option value="First">رخصة درجه أولى</option>
                                <option value="Second">رخصة درجه ثانية</option>
                                <option value="Third">رخصة درجه ثالثه</option>
                                <option value="Fourth">رخصة درجه رابعه</option>
                                <option value="Pro">رخصة مهنية</option>
                                <option value="Motorcycle">رخصة دراجه بخارية</option>
                            </select>
                            @error('driving_license_type')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Has Relatives Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل يمتلك أقارب بالعمل </label>
                            <select wire.model="has_relatives" id="has_relatives" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('has_relatives')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Relatives Details Input --}}
                    <div class="col-md-8 Related_Relatives_detailsDiv mb-3" id="relatives_details_hideandshow">
                        <div class="form-group">
                            <label> تفاصيل الاقارب</label>
                            <textarea type="text" wire.model="relatives_details" id="relatives_details" class="form-control"></textarea>
                            @error('relatives_details')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Disabilities Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل يمتلك اعاقة / عمليات سابقة </label>
                            <select wire.model="disabilities" id="disabilities" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('disabilities')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Disabilities Type Input --}}
                    <div class="col-md-12 mb-3 Related_is_Disabilities_processesDiv"
                        id="disabilities_type_hideandshow">
                        <div class="form-group">
                            <label> تفاصيل الاعاقة / عمليات سابقة</label>
                            <textarea type="text" wire.model="disabilities_type" id="disabilities_type" class="form-control"></textarea>
                            @error('disabilities_type')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Notes Type Input --}}
                    <div class="col-md-12 mb-3">
                        <div class="form-group">
                            <label> ملاحظات علي الموظف </label>
                            <textarea type="text" wire.model="notes" id="notes" class="form-control"></textarea>
                            @error('notes')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="tabCont2">
                <div class="row">

                    {{-- Work Start Date Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group" id="employee_hiring_date_input">
                            <label> تاريخ التعيين</label> <span class="tx-danger">*</span>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="work_start_date" id="work_start_date"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('work_start_date')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('work_start_date')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Functional Status Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label>الحالة الوظيفية</label> <span class="tx-danger">*</span>
                            <select wire.model="functional_status" id="functional_status" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Employee">موظف</option>
                                <option value="Unemployed">لا يعمل</option>
                            </select>
                            @error('functional_status')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- job_grade_id Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الدرجه الوظيفية</label>
                            <span class="tx-danger">*</span>
                            <select wire.model="job_grade_id" id="job_grade_id" class="form-control select2 ">
                                <option value="">اختر الادارة</option>
                                @if (@isset($other['job_grades']) && !@empty($other['job_grades']))
                                    @foreach ($other['job_grades'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }}
                                            ({{ $info->min_salary * 1 }} -
                                            {{ $info->max_salary * 1 }})
                                        </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('job_grade_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- Department Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> الادارة التابع لها الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="department_id" id="department_id" class="form-control select2 ">
                                <option value="">اختر الادارة</option>
                                @if (@isset($other['departements']) && !@empty($other['departements']))
                                    @foreach ($other['departements'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('department_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Jobs Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> وظيفة الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="job_categories_id" id="job_categories_id"
                                class="form-control select2">
                                <option value="">-- اختر الوظيفة --</option>
                                @if (@isset($other['jobs']) && !@empty($other['jobs']))
                                    @foreach ($other['jobs'] as $info)
                                        <option value="{{ $info->id }}">
                                            {{ $info->name }} </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('job_categories_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Has Attendance Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له بصمة حضور وانصراف</label> <span class="tx-danger">*</span>
                            <select wire.model="has_attendance" id="has_attendance" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('has_attendance')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Has Fixed Shift Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له شفت ثابت</label> <span class="tx-danger">*</span>
                            <select wire.model="has_fixed_shift" id="has_fixed_shift" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>

                            </select>
                            @error('has_fixed_shift')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- shift Types_id Input --}}
                    <div class="col-md-7 mb-3" id="relatedfixced_shift_hideandshow">
                        <div class="form-group">
                            <label>أنواع الشفتات</label>
                            <select wire.model="shift_types_id" id="shift_types_id" class="form-control">
                                <option selected value=""> -- اختر نوع الشفت --
                                </option>
                                @if (@isset($other['shifts_types']) && !@empty($other['shifts_types']))
                                    @foreach ($other['shifts_types'] as $info)
                                        <option value="{{ $info->id }}">

                                            @if ($info->type == 1)
                                                صباحى
                                            @elseif ($info->type == 2)
                                                مسائى
                                            @else
                                                يوم كامل
                                            @endif
                                            من
                                            {{ \Carbon\Carbon::parse($info->from_time)->format('g:i') }}
                                            {{ \Carbon\Carbon::parse($info->from_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}
                                            إلى
                                            {{ \Carbon\Carbon::parse($info->to_time)->format('g:i') }}
                                            {{ \Carbon\Carbon::parse($info->to_time)->format('A') == 'AM' ? 'صباحًا' : 'مساءً' }}

                                            عدد ساعات
                                            @php
                                                $to_time = Carbon::parse($info['to_time']);
                                                $from_time = Carbon::parse($info['from_time']);
                                                $diff_in_minutes = $to_time->diffInMinutes($from_time);
                                                $hours = floor($diff_in_minutes / 60);
                                                $minutes = $diff_in_minutes % 60;
                                            @endphp
                                            {{ $hours }} ساعة و
                                            {{ $minutes }} دقيقة
                                        </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('shift_types_id')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Daily Work Hour Input --}}
                    <div class="col-md-4 mb-3" id="daily_work_hourDiv_hideandshow">
                        <div class="form-group">
                            <label> عدد ساعات العمل اليومي</label>
                            <input type="text" wire.model="daily_work_hour" id="daily_work_hour"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                            @error('daily_work_hour')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>





                    {{-- Add Service Input --}}
                    <div class="form-group mb-3 col-4" id="employee_add_service_input">
                        <label for="employee_add_service">أضافة سنوات الخدمه</label>
                        <input type="text" wire.model="add_service"
                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');" id="add_service"
                            class="form-control">
                        @error('add_service')
                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                <span class="alert-inner--icon"><i class="fe fe-slash"></i></span>
                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                    {{ $message }}</span>
                            </div>
                        @enderror
                    </div>

                    {{-- Years Service Input --}}
                    <div class="form-group mb-3 col-4" id="employee_years_service_input">
                        <label for="employee_years_service">عدد سنوات الخدمه</label> <span class="tx-danger">*</span>
                        <input type="text" wire.model="years_service" readonly
                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');" id="years_service"
                            class="form-control">
                        @error('years_service')
                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                <span class="alert-inner--icon"><i class="fe fe-slash"></i></span>
                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                    {{ $message }}</span>
                            </div>
                        @enderror
                    </div>

                    {{-- Num Vacation Days Input --}}
                    <div class="form-group mb-3 col-4" id="employee_num_vacation_days_input">
                        <label for="employee_num_vacation_days">رصيد الأجازات</label>
                        <input type="text" wire.model="num_vacation_days" id="num_vacation_days"
                            class="form-control" readonly>
                        @error('num_vacation_days')
                            <div class="alert alert-danger mb-0 mt-1" role="alert">
                                <span class="alert-inner--icon"><i class="fe fe-slash"></i></span>
                                <span class="alert-inner--text"><strong>خطأ!</strong>
                                    {{ $message }}</span>
                            </div>
                        @enderror
                    </div>


                    {{-- salary Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> راتب الموظف الشهري</label> <span class="tx-danger">*</span>
                            <input type="text" wire.model="salary" id="salary"
                                oninput="calculateDayPrice(); this.value=this.value.replace(/[^0-9]/g,'');"
                                class="form-control">
                            @error('salary')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror

                        </div>
                    </div>


                    {{-- Day Price Input --}}
                    <input type="hidden" wire.model="day_price" id="day_price"
                        oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="form-control">





                    {{-- Motivation Type Input --}}
                    <div class="col-md-4">
                        <div class="form-group">
                            <label> هل له حافز </label> <span class="tx-danger">*</span>
                            <select wire.model="motivation_type" id="motivation_type" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Fixed">ثابت</option>
                                <option value="Changeable">متغير</option>
                                <option value="None">لا يوجد</option>
                            </select>
                            @error('motivation_type')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Motivation Input --}}
                    <div class="col-md-4 mb-3" id="MotivationDIV_hideandshow">
                        <div class="form-group">
                            <label> قيمة الحافز الشهري الثابت</label>
                            <input type="text" wire.model="motivation" id="motivation"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                                value="{{ old('motivation') }}">
                            @error('motivation')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Is Social Insurance Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له تأمين اجتماعي </label>
                            <select wire.model="social_insurance" id="social_insurance" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('social_insurance')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Social Insurance Cut Monthely Input --}}
                    <div class="col-md-4 mb-3" id="social_insurance_cut_monthelyDIV_hideandshow">
                        <div class="form-group">
                            <label> قيمة التأمين الاجتماعي المستقطع شهرياً</label>
                            <input type="text" wire.model="social_insurance_cut_monthely"
                                id="social_insurance_cut_monthely"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                            @error('social_insurance_cut_monthely')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Social Insurance Number Input --}}
                    <div class="col-md-4 mb-3" id="social_insurance_numberDIV_hideandshow">
                        <div class="form-group">
                            <label> رقم التامين الاجتماعي للموظف</label>
                            <input type="text" wire.model="social_insurance_number"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" id="social_insurance_number"
                                class="form-control">
                            @error('social_insurance_number')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Medical Insurance Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له تأمين طبي </label>
                            <select wire.model="medical_insurance" id="medical_insurance" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('medical_insurance')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Medical Insurance Cut Monthely Input --}}
                    <div class="col-md-4 mb-3 relatedismedicalinsurance"
                        id="medicalinsurancecutmonthelyDIV_hideandshow">
                        <div class="form-group">
                            <label> قيمة التأمين الطبي المستقطع شهرياً</label>
                            <input type="text" wire.model="medical_insurance_cut_monthely"
                                id="medical_insurance_cut_monthely"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                            @error('medical_insurance_cut_monthely')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Medical Insurance Number Input --}}
                    <div class="col-md-4 mb-3 relatedismedicalinsurance" id="medicalinsuranceNumberDIV_hideandshow">
                        <div class="form-group">
                            <label> رقم التامين الطبي للموظف</label>
                            <input type="text" wire.model="medical_insurance_number" id="medical_insurance_number"
                                class="form-control" oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                            @error('medical_insurance_number')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Type Salary Receipt Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> نوع صرف راتب الموظف</label> <span class="tx-danger">*</span>
                            <select wire.model="Type_salary_receipt" id="Type_salary_receipt" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Cach">كاش</option>
                                <option value="Visa">فيزا</option>
                            </select>
                            @error('Type_salary_receipt')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Active Vacation Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له رصيد اجازات سنوي</label>
                            <select wire.model="active_vacation" id="active_vacation" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="Yes">نعم</option>
                                <option value="No">لا</option>
                            </select>
                            @error('active_vacation')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Urgent Person Details Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> شخص يمكن الرجوع اليه للضرورة </label>
                            <input type="text" wire.model="urgent_person_details" id="urgent_person_details"
                                class="form-control">
                            @error('urgent_person_details')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Fixed Allowances Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> هل له بدلات ثابتة </label> <span class="tx-danger">*</span>
                            <select wire.model="fixed_allowances" id="fixed_allowances" class="form-control">
                                <option value=""> -- اختر الحالة --</option>
                                <option value="1">نعم</option>
                                <option value="0">لا</option>
                            </select>
                            @error('fixed_allowances')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="tabCont3">
                {{-- بيانات إضافية --}}
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="form-group">

                            {{-- Name Sponsor Input --}}
                            <label> اسم الكفيل </label>
                            <input type="text" wire.model="name_sponsor" id="name_sponsor" class="form-control">
                            @error('name_sponsor')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Pasport Identity Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> رقم الباسبور ان وجد </label>
                            <input type="text" wire.model="pasport_identity" id="pasport_identity"
                                class="form-control" oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                            @error('pasport_identity')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Pasport Place Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label>جهة اصدار الباسبور </label>
                            <input type="text" wire.model="pasport_from_place" id="pasport_from_place"
                                class="form-control">
                            @error('pasport_from_place')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    {{-- Pasport Exp Date Input --}}
                    <div class="col-md-4 mb-3">
                        <div class="form-group">
                            <label> تاريخ انتهاء الباسبور </label>
                            <!-- حقل إدخال التاريخ -->
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                </div>
                                <input type="text" wire.model="pasport_exp_date" id="pasport_exp_date"
                                    placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent">
                                <div class="input-group-append">
                                    <button type="button" class="wd-80 btn btn-dark"
                                        onclick="document.getElementById('pasport_exp_date')._flatpickr.clear()"><i
                                            class="fa fa-times"></i> محو</button>
                                </div>
                            </div>
                            @error('pasport_exp_date')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>


                    {{-- Photo Input --}}
                    <div class="col-md-4 mb-3">
                        <label for="formFile" class="form-label">الصورة الشخصية للموظف</label>
                        <input class="form-control" wire:model="photo" type="file" id="formFile">
                        <div class="my-2" wire:loading wire:target="photo">Uploading...</div>
                        @error('photo')
                            <div class="alert alert-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    {{-- CV Input --}}
                    <div class="col-md-4 mb-3">
                        <label for="formFile" class="form-label">السيرة الذاتية للموظف</label>
                        <input class="form-control" wire:model="cv" type="file" id="formFile">
                        <div class="my-2" wire:loading wire:target="cv">Uploading...</div>

                        @error('cv')
                            <div class="alert alert-danger">{{ $message }}</div>
                        @enderror
                    </div>


                </div>
            </div>
        </div>
        <div class="form-group">
            <button class="btn btn-md btn-primary  d-grid d-flex align-items-center justify-content-center"
                type="submit">
                <div wire:loading.remove>
                    <span>تأكيد البيانات</span>
                </div>
                <div class="spinner-border text-white" wire:loading wire:target="submit" role="status">
                    <span class="sr-only">تحميل...</span>
                </div>
            </button>
        </div>
    </form>

</div>
