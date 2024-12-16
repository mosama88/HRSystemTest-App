<!-- End Modal effects-->
<div class="modal fade out" id="deleteModal" wire:ignore.self>

    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-danger mg-b-20">إحذر: ستقوم بحذف العملية !</h4>

                <form wire:submit.prevent="submit">
                    {{ $slot }}
                    <div class="modal-footer mx-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                        <button class="btn btn-md btn-danger  d-grid d-flex align-items-center justify-content-center"
                            type="submit">
                            <div wire:loading.remove>
                                <span>تأكيد الحذف</span>
                            </div>
                            <div class="spinner-border text-white" wire:loading wire:target="submit" role="status">
                                <span class="sr-only">تحميل...</span>
                            </div>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
