 <!-- Scroll modal -->
 <div class="modal fade" id="updatedBranchModal" wire:ignore.self>
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">أضف فرع جديد</h6><button aria-label="Close" class="close" data-dismiss="modal"
                     type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form wire:submit.prevent="submit">
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> اسم الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" wire:model="name" id="name" class="form-control">
                             @error('name')
                                 <div class="alert alert-danger mt-2">{{ $message }}</div>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> عنوان الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" wire:model="address" id="address" class="form-control">
                             @error('address')
                                 <div class="alert alert-danger mt-2">{{ $message }}</div>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> هاتف الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" wire:model="phones" id="phones" class="form-control">
                             @error('phones')
                                 <div class="alert alert-danger mt-2">{{ $message }}</div>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> البريد الالكترونى للفرع</label>
                             <input type="text" wire:model="email" id="email" class="form-control">
                             @error('email')
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
                             <div class="spinner-border text-dark" wire:loading wire:target="submit" role="status">
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
 <!--End Scroll modal -->
