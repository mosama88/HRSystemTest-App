 <!-- Scroll modal -->
 <div class="modal edit" id="edit{{ $info->id }}">
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">تعديل بيانات الفرع</h6>
                 <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                    aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form action="{{ route('dashboard.branches.update', $info->id) }}" method="POST">
                     @csrf
                     @method('PUT')

                     <div class="form-group">
                         <div class="col-md-12">
                             <div class="form-group">
                                 <label> اسم الفرع</label>
                                 <input type="text" name="name" id="name" class="form-control"
                                     value="{{ old('name', $info->name) }}">
                                 @error('name')
                                     <span class="text-danger">{{ $message }}</span>
                                 @enderror
                             </div>
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> عنوان الفرع</label>
                             <input type="text" name="address" id="address" class="form-control"
                                 value="{{ old('address', $info->address) }}">
                             @error('address')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> هاتف الفرع</label>
                             <input type="text" name="phones" id="phones" class="form-control"
                                 value="{{ old('phones', $info->phones) }}">
                             @error('phones')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> البريد الالكترونى للفرع</label>
                             <input type="email" name="email" id="email" class="form-control"
                                 value="{{ old('email', $info->email) }}">
                             @error('email')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select name="active" id="active" class="form-control">
                                 <option {{ old($info->active)==1 ? 'selected' : ''}} value="1">مفعل</option>
                                 <option  {{ old($info->active)==0 ? 'selected' : ''}} value="0">معطل</option>
                             </select>
                             @error('active')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>
             </div>
             <div class="modal-footer">
                <button class="btn ripple btn-primary" type="submit" type="button">تعديل البيانات</button>
                <button class="btn ripple btn-secondary" data-dismiss="modal" type="button">إغلاق</button>
            </div>
             </form>
         </div>
     </div>
 </div>
 <!--End Scroll modal -->
