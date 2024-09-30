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
                 <form action="{{ route('dashboard.jobGrades.update', $info->id) }}" method="POST">
                     @csrf
                     @method('PUT')

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> اسم الدرجه الوظيفية</label> <span class="tx-danger">*</span>
                             <input type="text" name="name" id="name" class="form-control"
                                 value="{{ old('name', $info['name']) }}">
                             <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> الحد الأدنى للمرتب</label> <span class="tx-danger">*</span>
                             <input type="text" name="min_salary" id="min_salary" class="form-control"
                                 oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                 value="{{ old('min_salary', $info['min_salary']) }}">
                             <span class="text-danger" id="min_salaryError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> الحد الأقصى للمرتب</label> <span class="tx-danger">*</span>
                             <input type="text" name="max_salary" id="max_salary" class="form-control"
                                 oninput="this.value=this.value.replace(/[^0-9.]/g,'');"
                                 value="{{ old('max_salary', $info['max_salary']) }}">
                             <span class="text-danger" id="max_salaryError"></span> <!-- مكان عرض الخطأ -->

                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> ملاحظات</label>
                             <textarea type="text" name="notes" id="notes" class="form-control">{{ old('notes',$info['notes']) }}</textarea>
                             <span class="text-danger" id="notesError"></span> <!-- مكان عرض الخطأ -->
                         </div>
                     </div>
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select name="active" id="active" class="form-control">
                                 <option {{ old($info->active) == 1 ? 'selected' : '' }} value="1">مفعل</option>
                                 <option {{ old($info->active) == 0 ? 'selected' : '' }} value="0">معطل</option>
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
