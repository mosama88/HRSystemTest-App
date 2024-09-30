<!-- Basic modal -->
<div class="modal edit" id="edit{{ $info->id }}">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تعديل سنه مالية</h6>
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="POST" action="{{ route('dashboard.financeCalendars.update', $info->id) }}"
                    autocomplete="off">
                    @csrf
                    @method('PUT')
                    <div class="form-group mb-3">
                        <label> كود السنة المالية</label>
                        <input type="text" name="finance_yr" id="finance_yr" class="form-control"
                            value="{{ $info->finance_yr }}">
                        @error('finance_yr')
                            <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label> وصف السنة المالية</label>
                        <input type="text" name="finance_yr_desc" id="finance_yr_desc" class="form-control"
                            value="{{ $info->finance_yr_desc }}">
                        @error('finance_yr_desc')
                            <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label> تاريخ بداية السنة المالية</label>
                        <input type="date" name="start_date" id="start_date" class="form-control"
                            value="{{ $info->start_date }}">
                        @error('start_date')
                            <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label> تاريخ نهاية السنة المالية</label>
                        <input type="date" name="end_date" id="end_date" class="form-control"
                            value="{{ $info->end_date }}">
                        @error('end_date')
                            <span class="text-danger">{{ $message }}</span>
                        @enderror
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
