<!-- Basic modal -->
<div class="modal edit" id="edit{{ $info->id }}">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تعديل الشيفت</h6>
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="POST" action="{{ route('dashboard.shiftsTypes.update', $info->id) }}" autocomplete="off">
                    @csrf
                    @method('PUT')
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> نوع الشفت </label>
                            <select name="type" id="type" class="form-control">
                                <option value="">اختر النوع</option>
                                <option @if (old('type', $info['type']) == 1) selected @endif value="1">صباحي</option>
                                <option @if (old('type', $info['type']) == 2) selected @endif value="2">مسائي</option>
                                <option @if (old('type', $info['type']) == 3) selected @endif value="3"> يوم كامل
                                </option>
                            </select>
                            @error('type')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> يبدأ من الساعة </label>
                                <input type="time" name="from_time" id="from_time_update" class="form-control"
                                    value="{{ old('from_time', $info['from_time']) }}">
                                @error('from_time')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label> ينتهي الساعة </label>
                                <input type="time" name="to_time" id="to_time_update" class="form-control"
                                    value="{{ old('to_time', $info['to_time']) }}">
                                @error('to_time')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> عدد الساعات</label>
                            <input type="text" name="total_hours" id="total_hours_update" class="form-control"
                                value="{{ old('total_hours', $info['total_hours']) }}"
                                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" readonly>
                            @error('total_hours')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> حالة التفعيل</label>
                            <select name="active" id="active" class="form-control">
                                <option @if (old('active', $info['active']) == 1) selected @endif value="1">مفعل</option>
                                <option @if (old('active', $info['active']) == 0) selected @endif value="0">معطل</option>
                            </select>
                            @error('active')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn ripple btn-primary" type="submit" type="button">تعديل البيانات</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Basic modal -->
