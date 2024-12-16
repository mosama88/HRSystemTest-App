 <!-- Scroll modal -->
 <div class="modal" id="createModal" wire:ignore.self>
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">أضف وظيفه جديدة</h6><button aria-label="Close" class="close" data-dismiss="modal"
                     type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form wire:submit.prevent="submit">
                     @if (session('error') != null)
                         <div class="alert alert-danger text-center">
                             {{ session('error') }}
                         </div>
                     @endif
                     <div class="col-md-12">
                         <div class="form-group">
                             <label>اسم الوظيفة</label> <span class="tx-danger">*</span>
                             <input type="text" wire:model="name" id="name" class="form-control">
                             @error('name')
                                 <div class="alert alert-danger mt-2">{{ $message }}</div>
                             @enderror
                         </div>
                     </div>

                     <div class="modal-footer">
                         <button class="btn ripple btn-primary" type="submit">تأكيد البيانات</button>
                         <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
                     </div>
                 </form>
             </div>
         </div>
     </div>
 </div>
 <!--End Scroll modal -->
