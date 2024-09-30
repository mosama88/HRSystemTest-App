@if (!@empty($data_row))
    <div class="row">
        <div class="col-12">
            <div class="form-group">
                <label> أسم الموظف </label>
                <select name="employee_code_edit" id="employee_code_edit" class="form-control select2" style="width: 100%;">
                    <option value="">اختر الموظف</option>
                    @if (@isset($employees) && !@empty($employees))
                        @foreach ($employees as $info)
                            <option @if ($info['employee_code'] == $data_row->employee_code) selected="selected" @endif
                                value="{{ $info['employee_code'] }}" data-sa="{{ $info['salary'] }}"
                                data-dp="{{ $info['day_price'] }}">
                                {{ $info['name'] }}
                                ({{ $info->employee_code }})
                            </option>
                        @endforeach
                    @else
                        <div class="alert alert-warning" role="alert" dir="rtl">
                            <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                            <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                                لعرضها!</span>
                        </div>
                    @endif
                </select>
                @error('employee_code_edit')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <div class="form-group related_employee_edit">
                    <label> راتب الموظف الشهرى</label>
                    <input type="text" name="employee_salary_edit" id="employee_salary_edit"
                        value="{{ $data_row['employee_salary'] }}" class="form-control" readonly>
                </div>
            </div>
        </div>


    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>أجمالى قيمة السلفة المستديمة</label>
                <input autofocus type="text" name="total_edit" id="total_edit"
                    oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                    value="{{ $data_row['total'] }}">
                @error('total')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>

        <div class="col-md-6">
            <div class="form-group">
                <label>عدد شهور الأقساط</label>
                <input autofocus type="text" name="month_number_installment_edit" id="month_number_installment_edit"
                    oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                    value="{{ $data_row['month_number_installment'] }}">
                @error('month_number_installment')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>قيمة القسط الشهرى</label>

                <input autofocus type="text" name="month_installment_value_edit" id="month_installment_value_edit"
                    readonly oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="form-control"
                    value="{{ $data_row['month_installment_value'] }}">
                @error('month_installment_value')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>


        <div class="col-md-6">
            <div class="form-group">
                <label>يبدأ سداد أول قسط فى تاريخ</label>
                <!-- حقل إدخال التاريخ -->
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                    </div>
                    <input type="text" name="year_month_start_date_edit" id="year_month_start_date_edit"
                        placeholder="يوم / شهر / سنه" class="form-control flatpickr bg-transparent"
                        value="{{ $data_row['year_month_start_date'] }}">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-dark"
                            onclick="document.getElementById('year_month_start_date_edit')._flatpickr.clear()"><i
                                class="fa fa-times"></i> محو</button>
                    </div>
                </div>
                @error('year_month_start_date_edit')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label>ملاحظات</label>
                <textarea class="form-control" name="notes_edit" id="notes_edit" placeholder="أكتب ملاحظة" rows="3">{{ $data_row['notes'] }}</textarea>
                @error('notes')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>





    <div class="modal-footer">
        <button id="do_edit_now" data-id="{{ $data_row['id'] }}" class="btn ripple btn-primary"type="submit"
            name="submit">تعديل
            البيانات</button>
        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
    </div>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif



<script>
    function recalculate_edit_permanent_installment() {
        var total_edit = $("#total_edit").val();
        if (total_edit == "") {
            total_edit = 0;
        }
        var month_number_installment_edit = $("#month_number_installment_edit").val();
        if (month_number_installment_edit == "") {
            month_number_installment_edit = 0;
        }

        if (total_edit != 0 && month_number_installment_edit != 0) {
            var month_installment_value_edit = parseFloat(total_edit) / parseFloat(
                month_number_installment_edit);
            $("#month_installment_value_edit").val(month_installment_value_edit.toFixed(2) * 1);
        } else {
            $("#month_installment_value_edit").val(0);
        }
    }

    // Trigger the recalculation on input changes
    $(document).on('input', '#total_edit', function(e) {
        recalculate_edit_permanent_installment();
    });

    $(document).on('input', '#month_number_installment_edit', function(e) {
        recalculate_edit_permanent_installment();
    });
</script>
<script>
    flatpickr('#year_month_start_date_edit', {
        dateFormat: 'Y-m-d',
        locale: "ar",
    });
</script>
