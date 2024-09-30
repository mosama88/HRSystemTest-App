<link href="{{ URL::asset('dashboard/assets/css/style-load_active_attendance.css') }}" rel="stylesheet">
<style>
    .table-container {
        max-height: 600px;
        overflow-y: auto;
        border: 1px solid #ddd;
        box-sizing: border-box;
        /* تأكد من أن الحاوية لا تتجاوز بسبب الحدود */
    }

    .table-container table {
        width: 100%;
        /* تأكد من أن الجدول يأخذ العرض الكامل للحاوية */
    }

    .table-container table thead th {
        position: sticky;
        top: 0;
        background-color: #DDE2EF;
        color: #4D5875;
        z-index: 1;
    }

    /* إزالة التمرير المزدوج من الجدول */
    .table-container table tbody {
        overflow-y: visible;
        /* تأكد من عدم تطبيق أي تمرير على tbody */
    }

    .table-container {
        overflow: auto;
        /* تأكد من أن الـ div قابل للتمرير */
        scrollbar-width: thick;
        /* حجم شريط التمرير في فايرفوكس */
        scrollbar-color: #999faf #f1f1f1;
        /* ألوان شريط التمرير في فايرفوكس */
    }

    /* تحسين شريط التمرير لمتصفحات WebKit (مثل Chrome وSafari) */
    .table-container::-webkit-scrollbar {
        width: 16px;
        /* عرض شريط التمرير العمودي */
        height: 16px;
        /* عرض شريط التمرير الأفقي */
    }

    .table-container::-webkit-scrollbar-thumb {
        background-color: #999faf;
        /* لون شريط التمرير */
        border-radius: 10px;
        /* تقويس الزوايا */
        border: 3px solid #f1f1f1;
        /* لون خلفي للتمرير */
    }

    .table-container::-webkit-scrollbar-track {
        background-color: #f1f1f1;
        /* لون الخلفية لمسار التمرير */
    }

    .totaly {
        height: 65px;
    }
</style>
<div class="row row-sm">
    <div class="col-12 mb-3">

        <strong class=""><span class="text-danger">ملاحظة</span>: أكبر تاريخ بصمة مسجله بالسيستم
            ( {{ $max_attendance_date }} )</strong>

    </div>
</div>
@can('طباعه بصمات الموظفين')
    <a href="{{ route('dashboard.attendanceDepartures.print_one_fp_details', ['employee_code' => $other['employee_data']['employee_code'], 'finance_cln_periods_id' => $other['finance_cln_periods_data']['id']]) }}"
        class="btn mb-3" target="_blank" id="print_one_fp_details" style="background-color:#6A9AB0;color:white">
        <i class="fas fa-print fa-lg ml-1"></i> طباعه
    </a>
@endcan

@if (isset($other['data']) && $other['data']->isNotEmpty())
    <div class="table-container">
        <table class="table table-bordered table-striped table-hover">
            <thead class="bg-primary">
                <tr>
                    <th>#</th>
                    <th>التاريخ</th>
                    <th>الحضور</th>
                    <th>الأنصراف</th>
                    <th>البصمات</th>
                    <th>المتغيرات</th>
                    <th>خصم أيام</th>
                    <th>هل أجازه</th>
                    <th>حضور متأخر</th>
                    <th>إنصراف مبكر</th>
                    <th>أذون ساعات</th>
                    <th>ساعات عمل</th>
                    <th>غياب ساعات</th>
                    <th>اضافى ساعات</th>
                    <th>أخذ إجراء</th>
                </tr>
            </thead>
            <tbody>
                <?php $i = 0; ?>
                @foreach ($other['data'] as $info)
                    <?php $i++; ?>

                    <tr @if ($info->date_time_in == null && $info->date_time_out == null) style="background-color:#a3a3a3; color:white" @endif>
                        {{-- مسلسل --}}
                        <td class="text-center">{{ $i }}</td>
                        {{-- التاريخ	 --}}
                        <td id="the_day_date{{ $info->id }}" class="text-center"> {{ $info->week_day_name_ar }}
                            {{ $info->the_day_date }}
                        </td>
                        {{-- الحضور --}}
                        <td class="text-center">
                            @if ($info->date_time_in != null)
                                @php echo date("H:i", strtotime($info->date_time_in)) @endphp
                            @endif
                        </td>
                        {{-- الأنصراف --}}
                        <td class="text-center">
                            @if ($info->date_time_out != null)
                                @php echo date("H:i", strtotime($info->date_time_out)) @endphp
                            @endif
                        </td>
                        {{-- البصمات --}}
                        <td>
                            @can('عرض حركات بصمات الموظفين')
                                <button data-id={{ $info->id }} class="btn load_my_actions btn-sm btn-dark btn-block"
                                    style="width:120px">
                                    عرض الحركات ( {{ $info->attendance_departure_actions_counter }} )
                                </button>
                            @endcan
                        </td>
                        {{-- المتغيرات --}}
                        <td>
                            <div style="width: 10vw">
                                <input type="text" class="form-control text-center variables"
                                    name="variables{{ $info->id }}" id="variables{{ $info->id }}"
                                    value="{{ $info->variables }}">
                            </div>
                        </td>
                        {{-- خصم أيام --}}
                        <td>
                            <div style="width: 5vw">
                                <input oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center cut" name="cut{{ $info->id }}"
                                    id="cut{{ $info->id }}" value="{{ $info->cut * 1 }}">
                            </div>
                        </td>
                        {{-- هل أجازه --}}
                        <td>
                            <div style="width: 10vw">
                                <select name="vacations_types_id{{ $info->id }}"
                                    id="vacations_types_id{{ $info->id }}"
                                    class="form-control text-center vacations_types_id">
                                    <option value="" selected> لا </option>
                                    @if (@isset($other['VacationType']) && !@empty($other['VacationType']))
                                        @foreach ($other['VacationType'] as $vacType)
                                            <option @if ($info->vacations_types_id == $vacType->id) selected="selected" @endif
                                                value="{{ $vacType->id }}">
                                                {{ $vacType->name }} </option>
                                        @endforeach
                                    @endif
                                </select>
                            </div>
                        </td>
                        {{-- حضور متأخر --}}
                        <td>
                            <div style="width: 5vw">
                                <input oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center attendance_delay"
                                    name="attendance_delay{{ $info->id }}"
                                    id="attendance_delay{{ $info->id }}"
                                    value="{{ $info->attendance_delay * 1 }}">
                            </div>
                            <!-- أضف المعرفات للروابط -->
                            <a href="javascript:void(0);" onclick="scrollToElement('the_day_date{{ $info->id }}')">
                                <i class="far fa-hand-point-right"></i>
                            </a>
                            <a href="javascript:void(0);" onclick="scrollToElement('make_go_row{{ $info->id }}')">
                                <i class="float-left mt-1 far fa-hand-point-left"></i>
                            </a>
                        </td>
                        {{-- إنصراف مبكر --}}
                        <td>
                            <div style="width: 5vw">
                                <input oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center early_departure"
                                    name="early_departure{{ $info->id }}" id="early_departure{{ $info->id }}"
                                    value="{{ $info->early_departure * 1 }}">
                            </div>
                        </td>
                        {{-- أذون ساعات --}}
                        <td>
                            <div style="width: 10vw">
                                <input type="text" class="form-control text-center permission_hours"
                                    name="permission_hours{{ $info->id }}"
                                    id="permission_hours{{ $info->id }}" value="{{ $info->permission_hours }}">
                            </div>
                        </td>
                        {{-- ساعات عمل --}}
                        <td>
                            <div style="width: 5vw">
                                <input readonly
                                    oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center total_hours"
                                    name="total_hours{{ $info->id }}" id="total_hours{{ $info->id }}"
                                    value="{{ $info->total_hours * 1 }}">
                            </div>
                        </td>
                        {{-- غياب ساعات --}}
                        <td>
                            <div style="width: 5vw">
                                <input oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center absence_hours"
                                    name="absence_hours{{ $info->id }}" id="absence_hours{{ $info->id }}"
                                    value="{{ $info->absence_hours * 1 }}">
                            </div>
                        </td>
                        {{-- اضافى ساعات --}}
                        <td>
                            <div style="width: 5vw">
                                <input oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '');"
                                    type="text" class="form-control text-center additional_hours"
                                    name="additional_hours{{ $info->id }}"
                                    id="additional_hours{{ $info->id }}"
                                    value="{{ $info->additional_hours * 1 }}">
                            </div>
                        </td>

                        {{-- هل تم أخذ إجراء --}}
                        <td id="make_go_row{{ $info->id }}">
                            <button style="background-color: #19832a;color:white"
                                class="btn btn-small make_save_changes_row" data-id="{{ $info->id }}"><i
                                    class="fas fa-save fa-lg"></i></button>
                        </td>
                    </tr>
                @endforeach
                <tr class="totaly" style="background-color: #8590af;color: #ffffff;">
                    <td class="text-center" style="background-color:#dde2ef;color:#4a4a4a" colspan="5">
                        <h4 style="font-weight: bold">الأجمالى</h4>

                    </td>
                    <td></td>
                    <td class="text-center">{{ $other['total_cut'] * 1 }} يوم</td>
                    <td class="text-center"> {{ $other['total_vacations_types'] * 1 }} يوم
                        @can('تفاصيل أجازه الموظفين الموظفين')
                            <a class="modal-effect btn btn-sm" style="background-color: #1a5f78;color:white;"
                                data-effect="effect-slide-in-bottom" data-toggle="modal"
                                href="#vacationDetails{{ $info->id }}">
                                <i class="fas fa-info-circle ml-2"></i>تفاصيل الأجازه</a>
                        @endcan
                    </td>
                    <td class="text-center">{{ $other['total_attendance_delay'] * 1 }} دقيقه</td>
                    <td class="text-center">{{ $other['total_early_departure'] * 1 }} دقيقه</td>
                    <td class="text-center">{{ $other['total_permission_hours'] * 1 }} يوم</td>
                    <td class="text-center">{{ $other['total_hours_total'] * 1 }} ساعه</td>
                    <td class="text-center">{{ $other['total_absence_hours'] * 1 }} ساعه</td>
                    <td class="text-center">{{ $other['total_additional_hours'] * 1 }} ساعه</td>
                    <td class="text-center"></td>
                </tr>

            </tbody>
        </table>
    </div>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif



<!-- End Modal effects-->
<div class="modal fade vacationDetails" id="vacationDetails{{ $info->id }}">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-info lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-dark mg-b-20">تفاصيل الراحه الأسبوعية !</h4>
                @if (isset($other['vacationType_distinct']) && $other['vacationType_distinct']->isNotEmpty())

                    @if (isset($other['vacationType_distinct']) && $other['vacationType_distinct']->isNotEmpty())
                        <table class="table table-bordered mg-b-0 text-md-nowrap">
                            @foreach ($other['vacationType_distinct'] as $vac)
                                <tr>
                                    <td> {{ $vac->counter * 1 }}</td>
                                    <td> {{ $vac->name }}</td>
                                </tr>
                            @endforeach
                        </table>
                    @endif
                @else
                    <div class="alert alert-warning" role="alert" dir="rtl">
                        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                            لعرضها!</span>
                    </div>
                @endif
            </div>
            <div class="modal-footer">
                <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
            </div>
        </div>
    </div>
</div>


<script>
    $('.vacationDetails').modal({
        backdrop: 'static',
        keyboard: false,
        show: false // عدم فتح المودال تلقائيًا
    });
</script>
<script>
    function scrollToElement(elementId) {
        // الحصول على العنصر المطلوب التحرك إليه
        var element = document.getElementById(elementId);
        if (element) {
            // تحريك الصفحة إلى العنصر المحدد
            element.scrollIntoView({
                behavior: 'smooth',
                block: 'nearest',
                inline: 'start'
            });
        }
    }
</script>
