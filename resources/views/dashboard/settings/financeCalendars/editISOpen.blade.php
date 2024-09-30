<!-- Scroll modal -->
<div class="modal" id="editIsOpen{{ $info->id }}">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تعديل السنه المالية</h6><button aria-label="Close" class="close"
                    data-dismiss="modal" type="button"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="{{ route('dashboard.financeCalendars.editISOpen', $info->id) }}" method="POST">
                    @csrf
                    @method('PUT')
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> الحالة</label>
                            <select name="is_open" id="is_open" class="form-control">
                                <option value="" selected>-- أختر الحالة --</option>
                                <option @if ($info->is_open == 0) selected @endif value="0">معلق</option>
                                <option @if ($info->is_open == 1) selected @endif value="1">مفتوح</option>
                                <option @if ($info->is_open == 2) selected @endif value="2">مؤرشف</option>
                            </select>
                            @error('is_open')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label> تاريخ بداية البصمة للشهر</label>
                                <input type="date" name="start_date_fp" id="start_date_fp" class="form-control"
                                    value="{{ $info['start_date_fp'] }}">
                                @error('start_date_fp')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label> تاريخ نهاية البصمة للشهر </label>
                                <input type="date" name="end_date_fp" id="end_date_fp" class="form-control"
                                    value="{{ $info['end_date_fp'] }}">

                                @error('end_date_fp')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    <div class="modal-footer">
                        <button class="btn ripple btn-primary" id="submit" type="submit">تأكيد البيانات</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--End Scroll modal -->
