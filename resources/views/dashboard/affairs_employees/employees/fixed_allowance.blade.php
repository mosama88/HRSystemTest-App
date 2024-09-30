<!-- Scroll modal -->
<div class="modal" id="modaldemo8">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">أضف بدل ثابت جديد</h6><button aria-label="Close" class="close" data-dismiss="modal"
                    type="button"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="ajaxForm" action="{{ route('dashboard.employees.add_allowance', $data['id']) }}"
                    method="POST">
                    @csrf
                    <div class="col-md-12 mb-3">
                        <div class="form-group">
                            <label> اسم نوع البدل الثابت</label> <span class="tx-danger">*</span>
                            <select name="allowance_id" id="allowance_id" class="form-control select2">
                                <option value="">-- اختر نوع البدل للموظف --
                                </option>
                                @if (isset($other['allowances']) && !empty($other['allowances']))
                                    @foreach ($other['allowances'] as $info)
                                        <option value="{{ $info->id }}" {{ old('allowance_id') }}>
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
                            <label> قيمة البدل الثابت</label> <span class="tx-danger">*</span>
                            <input type="text" name="value" id="allowance_value" class="form-control"
                                value="{{ old('value') }}" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="text-danger" id="valueError"></span> <!-- مكان عرض الخطأ -->
                        </div>
                    </div>

                    {{-- Notes Type Input --}}
                    <div class="col-md-12 mb-3">
                        <div class="form-group">
                            <label> ملاحظات </label>
                            <textarea type="text" name="notes" id="notes" class="form-control">{{ old('notes') }}</textarea>
                            @error('notes')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button id="do_add_allowance" class="btn ripple btn-primary" type="submit">تأكيد
                            البيانات</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--End Scroll modal -->
