<!-- Basic modal -->
<div class="modal edit" id="updatedShiftsTypesModal" wire:ignore.self>
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تعديل الشيفت</h6>
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form wire:submit.prevent="submit" autocomplete="off">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> نوع الشفت </label> <span class="tx-danger">*</span>
                            <select wire:model="type" id="type" class="form-control">
                                <option value="">اختر النوع</option>
                                <option value="1">صباحي</option>
                                <option value="2">مسائي</option>
                                <option value="3"> يوم كامل
                                </option>
                            </select>
                            @error('type')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> يبدأ من الساعة </label> <span class="tx-danger">*</span>
                                <input type="time" wire:model.live="from_time" id="from_time" class="form-control">
                                @error('from_time')
                                    <div class="alert alert-danger mt-2">{{ $message }}</div>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> ينتهي الساعة </label> <span class="tx-danger">*</span>
                                <input type="time" wire:model.live="to_time" id="to_time" class="form-control">
                                @error('to_time')
                                    <div class="alert alert-danger mt-2">{{ $message }}</div>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> عدد الساعات</label>
                            <input readonly type="text" wire:model.live="total_hours" id="total_hours"
                                class="form-control" oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
                            @error('total_hours')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> حالة التفعيل</label>
                            <select wire:model="active" id="active" class="form-control">
                                <option selected value=""> -- أختر --</option>
                                <option value="1">مفعل</option>
                                <option value="2">معطل</option>
                            </select>
                            @error('active')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
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
