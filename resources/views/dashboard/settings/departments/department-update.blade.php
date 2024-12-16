 <!-- Scroll modal -->
 <div class="modal fade" id="updatedDepartmentModal" wire:ignore.self>
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">تعديل بيانات الأدارة</h6>
                 <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                         aria-hidden="true">&times;</span></button>
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
                             <label> اسم الادارة</label>
                             <input type="text" wire:model="name" id="name" class="form-control">
                             @error('name')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> هاتف الادارة</label>
                             <input type="text" wire:model="phones" id="phones" class="form-control">
                             @error('phones')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> ملاحظات علي الادارة</label>
                             <input type="text" wire:model="notes" id="notes" class="form-control">
                             @error('notes')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select wire:model="active" id="active" class="form-control">
                                 <option value="1">مفعل</option>
                                 <option value="2">معطل</option>
                             </select>
                             @error('active')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
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
     <!--End Scroll modal -->
