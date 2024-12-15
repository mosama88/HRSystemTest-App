<!-- Basic modal -->
<div class="modal" id="createShiftsTypesModal" wire:ignore.self>
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">أضافة شيفت جديد</h6>
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form  wire:submit.prevent="submit" autocomplete="off">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> نوع الشفت </label> <span class="tx-danger">*</span>
                            <select wire:model="type" id="type" class="form-control">
                                <option value="">اختر النوع</option>
                                <option @if (old('type') == 1) selected @endif value="1">صباحي</option>
                                <option @if (old('type') == 2) selected @endif value="2">مسائي</option>
                                <option @if (old('type') == 3) selected @endif value="3"> يوم كامل
                                </option>
                            </select>
                            <span class="text-danger" id="typeError"></span> <!-- مكان عرض الخطأ -->
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> يبدأ من الساعة </label> <span class="tx-danger">*</span>
                                <input type="time" wire:model="from_time" id="from_time" class="form-control"
                                    value="{{ old('from_time') }}">
                                    <span class="text-danger" id="from_timeError"></span> <!-- مكان عرض الخطأ -->
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> ينتهي الساعة </label> <span class="tx-danger">*</span>
                                <input type="time" wire:model="to_time" id="to_time" class="form-control"
                                    value="{{ old('to_time') }}">
                                    <span class="text-danger" id="to_timeError"></span> <!-- مكان عرض الخطأ -->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> عدد الساعات</label>
                            <input type="text" wire:model="total_hours" id="total_hours" class="form-control"
                                value="{{ old('total_hours') }}"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" readonly>
                            @error('total_hours')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> حالة التفعيل</label>
                            <select wire:model="active" id="active" class="form-control">
                                <option @if (old('active') == 1) selected @endif value="1">مفعل</option>
                                <option @if (old('active') == 0 and old('active') != '') selected @endif value="0">معطل</option>
                            </select>
                            <span class="text-danger" id="activeError"></span> <!-- مكان عرض الخطأ -->
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-md btn-primary  d-grid d-flex align-items-center justify-content-center"
                        type="submit">
                        <div wire:loading.remove>
                            <span>تأكيد البيانات</span>
                        </div>
                        <div class="spinner-border text-white" wire:loading wire:target="submit" role="status">
                            <span class="sr-only">تحميل...</span>
                        </div>
                    </button>
                                            <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Basic modal -->





