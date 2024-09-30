@if (!@empty($data))

    <form action="{{ route('dashboard.employees.do_edit_allowances', $data->id) }}" method="POST">
        @csrf
        @method('PUT')
        <div class="col-md-12 mb-3">
            <div class="form-group">
                <label>اسم نوع البدل الثابت</label> <span class="tx-danger">*</span>
                <select disabled name="allowance_id" id="allowance_id" class="form-control select2">
                    <option value="">-- اختر نوع البدل للموظف --</option>
                    @if (isset($other['allowances']) && !empty($other['allowances']))
                        @foreach ($other['allowances'] as $info)
                            <option value="{{ $info->id }}"
                                {{ old('allowance_id', $data['allowance_id']) == $info->id ? 'selected' : '' }}>
                                {{ $info->name }}
                            </option>
                        @endforeach
                    @endif
                </select>
                <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->
            </div>
        </div>

        <div class="col-md-12 mb-3">
            <div class="form-group">
                <label>قيمة البدل الثابت</label> <span class="tx-danger">*</span>
                <input type="text" name="value" id="value_edit" class="form-control"
                    value="{{ old('value', $data->value) }}" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                <span class="text-danger" id="valueError"></span> <!-- مكان عرض الخطأ -->
            </div>
        </div>

        <div class="col-md-12 mb-3">
            <div class="form-group">
                <label>ملاحظات</label>
                <textarea type="text" name="notes" id="notes" class="form-control">{{ old('notes', $data->notes) }}</textarea>
                @error('notes')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
        </div>

        <div class="modal-footer">
            <button class="btn ripple btn-primary" id="do_edit_allowance" type="submit">تأكيد البيانات</button>
            <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
        </div>
    </form>

@endif
