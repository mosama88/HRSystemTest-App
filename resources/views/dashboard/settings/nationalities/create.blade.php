 <!-- Scroll modal -->
 <div class="modal" id="modaldemo8">
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">أضف جنسية جديدة</h6><button aria-label="Close" class="close" data-dismiss="modal"
                     type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form id="ajaxForm" action="{{ route('dashboard.nationalities.store') }}" method="POST">
                     @csrf
                     <div class="col-md-12">
                         <div class="form-group">
                             <label>اسم الجنسية</label> <span class="tx-danger">*</span>
                             <input type="text" name="name" id="name" class="form-control"
                                 value="{{ old('name') }}">
                             <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->
                         </div>
                     </div>

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select name="active" id="active" class="form-control">
                                 <option @if (old('active') == 1) selected @endif value="1">مفعل</option>
                                 <option @if (old('active') == 0 and old('active') != '') selected @endif value="0">معطل</option>
                             </select>
                             @error('active')
                                 <span class="text-danger">{{ $message }}</span>
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
