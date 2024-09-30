@if (!@empty($finance_cln_periods_data) and !@empty($mainSalaryEmployee_data))
    <form action="{{ route('dashboard.mainSalaryEmployees.doArchiveSalary', $mainSalaryEmployee_data['id']) }}"
        method="POST">
        @csrf
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label>حالة مرتب الموظف الأن</label>
                    <select name="salaryStatusNowBeforArchive" id="salaryStatusNowBeforArchive" class="form-control">
                        @if ($mainSalaryEmployee_data['net_salary'] > 0)
                            <option {{ old('net_salary') == 1 }} selected value="1">دائن ومستحق له</option>
                        @elseif ($mainSalaryEmployee_data['net_salary'] < 0)
                            <option {{ old('net_salary') == 2 }} selected value="2">مدين ومستحق عليه</option>
                        @else
                            <option {{ old('net_salary') == 0 }} selected value="0">ليس له مستحقات أو عليه</option>
                        @endif
                    </select>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    @if ($mainSalaryEmployee_data['net_salary'] > 0)
                        <label>صافى المبلغ المستحق للموظف</label>
                        <input readonly type="text" name="net_salary" id="net_salary"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 }}" class="form-control">
                    @elseif ($mainSalaryEmployee_data['net_salary'] < 0)
                        <label>صافى المبلغ المستحق على لموظف</label>
                        <input readonly type="text" name="net_salary" id="net_salary"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 * -1 }}" class="form-control">
                    @else
                        <label>ليس له مستحقات أو عليه</label>
                        <input readonly type="text" name="net_salary" id="net_salary"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 }}" class="form-control">
                    @endif
                </div>
            </div>

            <div class="col-md-12">

                <div class="form-group">
                    @if ($mainSalaryEmployee_data['net_salary'] > 0)
                        <label>صافى المبلغ المصروف له الأن</label>
                        <input readonly type="text" name="action_money_value_now" id="action_money_value_now"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 }}"
                            data-max={{ $mainSalaryEmployee_data['net_salary'] }}
                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                    @elseif ($mainSalaryEmployee_data['net_salary'] < 0)
                        <label>صافى المبلغ المدين بة الموظف و سيرحل للشهر القادم</label>
                        <input readonly type="text" name="action_money_value_now" id="action_money_value_now"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 * -1 }}"
                            data-max={{ $mainSalaryEmployee_data['net_salary'] }}
                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                    @else
                        <label>ليس له مستحقات أو عليه</label>
                        <input readonly type="text" name="action_money_value_now" id="action_money_value_now"
                            value="{{ $mainSalaryEmployee_data['net_salary'] * 1 }}"
                            data-max={{ $mainSalaryEmployee_data['net_salary'] }}
                            oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
                    @endif
                </div>
            </div>




        </div>

        <div class="modal-footer">
            <button id="do_archive_now" class="btn ripple btn-primary" type="submit" name="submit">أرشفة المرتب
                الأن</button>
            <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
        </div>
    </form>
@else
    <div class="alert alert-warning" role="alert" dir="rtl">
        <span class="alert-inner--icon"><i class="fe fe-info"></i></span>
        <span class="alert-inner--text"><strong> عفواً :</strong> لا توجد بيانات
            لعرضها!</span>
    </div>
@endif
