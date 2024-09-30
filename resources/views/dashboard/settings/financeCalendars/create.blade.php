<!-- Basic modal -->
<div class="modal" id="modaldemo8">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">تكويد سنه مالية</h6>
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="ajaxForm" method="POST" action="{{ route('dashboard.financeCalendars.store') }}" autocomplete="off">
                    @csrf
                    <div class="form-group mb-3">
                        <label> كود السنة المالية</label> <span class="tx-danger">*</span>
                        <input type="text" name="finance_yr" id="finance_yr" class="form-control"
                            value="{{ old('finance_yr') }}">
                            <span class="text-danger" id="finance_yrError"></span> <!-- مكان عرض الخطأ -->
                    </div>

                    <div class="form-group mb-3">
                        <label> وصف السنة المالية</label> <span class="tx-danger">*</span>
                        <input type="text" name="finance_yr_desc" id="finance_yr_desc" class="form-control"
                            value="{{ old('finance_yr_desc') }}">
                            <span class="text-danger" id="finance_yr_descError"></span> <!-- مكان عرض الخطأ -->
                    </div>

                    <div class="form-group mb-3">
                        <label> تاريخ بداية السنة المالية</label> <span class="tx-danger">*</span>
                        <input type="date" name="start_date" id="start_date" class="form-control"
                            value="{{ old('start_date') }}">
                            <span class="text-danger" id="start_dateError"></span> <!-- مكان عرض الخطأ -->
                    </div>

                    <div class="form-group mb-3">
                        <label> تاريخ نهاية السنة المالية</label> <span class="tx-danger">*</span>
                        <input type="date" name="end_date" id="end_date" class="form-control"
                            value="{{ old('end_date') }}">
                            <span class="text-danger" id="end_dateError"></span> <!-- مكان عرض الخطأ -->
                    </div>

                    <div class="modal-footer">
                        <button class="btn ripple btn-primary" type="submit" type="button">تأكيد البيانات</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Basic modal -->

