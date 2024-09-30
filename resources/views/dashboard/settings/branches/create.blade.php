 <!-- Scroll modal -->
 <div class="modal" id="modaldemo8">
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">أضف فرع جديد</h6><button aria-label="Close" class="close" data-dismiss="modal"
                     type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form id="ajaxForm" action="{{ route('dashboard.branches.store') }}" method="POST">
                     @csrf
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> اسم الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" name="name" id="name" class="form-control"
                                 value="{{ old('name') }}">
                             <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> عنوان الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" name="address" id="address" class="form-control"
                                 value="{{ old('address') }}">
                             <span class="text-danger" id="addressError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> هاتف الفرع</label> <span class="tx-danger">*</span>
                             <input type="text" name="phones" id="phones" class="form-control"
                                 value="{{ old('phones') }}">
                             <span class="text-danger" id="phonesError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> البريد الالكترونى للفرع</label>
                             <input type="email" name="email" id="email" class="form-control"
                                 value="{{ old('email') }}">
                             <span class="text-danger" id="emailError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select name="active" id="active" class="form-control">
                                 <option selected value="1">مفعل</option>
                                 <option value="0">معطل</option>
                             </select>
                             <span class="text-danger" id="activeError"></span> <!-- مكان عرض الخطأ -->

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
