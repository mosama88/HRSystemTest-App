 <!-- Scroll modal -->
 <div class="modal" id="createModal" wire:ignore.self>
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">{{ $titleModel }}</h6><button aria-label="Close" class="close"
                     data-dismiss="modal" type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form wire:submit.prevent="submit">
                     @if (session('error') != null)
                         <div class="alert alert-danger text-center">
                             {{ session('error') }}
                         </div>
                     @endif
                     {{ $slot }}

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
