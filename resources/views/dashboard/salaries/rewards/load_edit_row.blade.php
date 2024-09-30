@if (!@empty($finance_cln_periods_data) and !@empty($sanctions) and !@empty($main_salary_employees_data))


    <div class="row">
        <div class="col-12">
            <div class="form-group">
                <label> أسم الموظف </label>
                <select name="employee_code_edit" id="employee_code_edit" class="form-control select2" style="width: 100%;">
                    <option value="">اختر الموظف</option>
                    @if (@isset($employees) && !@empty($employees))
                        @foreach ($employees as $info)
                            <option @if ($info['employee_code'] == $sanctions->employee_code) selected="selected" @endif
                                value="{{ $info->employee_code }}" data-sa="{{ $info->EmployeeData['salary'] }}"
                                data-dp="{{ $info->EmployeeData['day_price'] }}">
                                {{ $info->EmployeeData['name'] }}
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
                    <label> أجر اليوم الواحد</label>
                    <input type="text" name="day_price_edit" id="day_price_edit"
                        value="{{ $sanctions['day_price'] * 1 }}" class="form-control" readonly>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>نوع المكافئة</label>
                <select name="additional_types_id_edit" id="additional_types_id_edit" class="form-control select2" style="width: 100%;">
                    <option value="">اختر نوع المكافئة</option>
                    @if (@isset($additionals) && !@empty($additionals))
                        @foreach ($additionals as $add)
                            <option @if ($sanctions['additional_types_id'] == $add->id) selected @endif value="{{ $add->id }}">
                                {{ $add->name }}</option>
                        @endforeach
                    @else
                        <div class="alert alert-warning" role="alert" dir="rtl">
                            <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
                            <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
                                لعرضها!</span>
                        </div>
                    @endif
                </select>
                @error('additional_types_id')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>


        <div class="col-md-6">
            <div class="form-group">
                <label>أجمالى قيمة المكافئة</label>
                <input autofocus type="text" oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                    name="total_edit" id="total_edit" class="form-control" value="{{ $sanctions['total'] }}">
                @error('total')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label>ملاحظات</label>
                <textarea class="form-control" name="notes_edit" id="notes_edit" placeholder="Textarea" rows="3">{{ $sanctions['notes'] }}</textarea>
                @error('notes')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>
    </div>


    <div class="modal-footer">
        <button id="do_edit_now" data-id="{{ $sanctions['id'] }}"
            data-main_salary_employees_id="{{ $sanctions['main_salary_employees_id'] }}"
            class="btn ripple btn-primary"type="submit" name="submit">تعديل
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
