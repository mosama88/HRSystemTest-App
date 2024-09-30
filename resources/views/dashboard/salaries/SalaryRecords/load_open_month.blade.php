<!-- Grid modal -->
{{-- <div class="modal" id="modaldemo8">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-content-demo">
            <div class="modal-header">
                <h6 class="modal-title">فتح الشهر المالى</h6><button aria-label="Close" class="close" data-dismiss="modal"
                    type="button"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="{{ route('dashboard.salaryRecords.do_open_month', $info['id']) }}" method="POST">
                    @csrf

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

                    </div>
                    <div class="modal-footer">
                        <button class="btn ripple btn-danger" type="submit" type="button">أفتح الشهر الأن !</button>
                        <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">أغلاق</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div> --}}
<!--End Grid modal -->
