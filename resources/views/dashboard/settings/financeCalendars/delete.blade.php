<!-- End Modal effects-->
<div class="modal delete" id="delete{{ $info->id }}">

    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-danger mg-b-20">إحذر: ستقوم بحذف العملية !</h4>

                <form action="{{ route('dashboard.financeCalendars.destroy', $info->id) }}" method="post">
                    {{ method_field('delete') }}
                    {{ csrf_field() }}
                    <div class="modal-body">
                        <input type="hidden" name="id" value="{{ $info->id }}">
                        <h5>كود السنه</h5>
                        <h5 class="text-primary">{{ $info->finance_yr }}</h5>
                    </div>
                    <div class="modal-footer mx-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                        <button type="submit" class="btn btn-danger">تأكيد الحذف</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
