 <!-- Scroll modal -->
 <div class="modal" id="modaldemo8">
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">أضف عطلة رسمية</h6><button aria-label="Close" class="close" data-dismiss="modal"
                     type="button"><span aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form id="ajaxForm" action="{{ route('dashboard.holidays.store') }}" method="POST">
                     @csrf
                     <div class="col-md-12">
                         <div class="form-group">
                             <label> اسم العطلة الرسمية</label> <span class="tx-danger">*</span>
                             <input type="text" name="name" id="name" class="form-control"
                                 value="{{ old('name') }}">
                                 <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->
                         </div>
                     </div>


                     <div class="col-md-12">
                         <div class="form-group">
                             <label> تبدأ من تاريخ </label> <span class="tx-danger">*</span>
                             <!-- حقل إدخال التاريخ -->
                             <div class="input-group">
                                 <div class="input-group-prepend">
                                     <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                 </div>
                                 <input type="text" name="from_date" id="from_date" placeholder="يوم / شهر / سنه"
                                     class="form-control flatpickr bg-transparent" value="{{ old('from_date') }}">
                                 <div class="input-group-append">
                                     <button type="button" class="btn btn-dark"
                                         onclick="document.getElementById('from_date')._flatpickr.clear()"><i
                                             class="fa fa-times"></i> محو</button>
                                 </div>
                             </div>
                             <span class="text-danger" id="from_dateError"></span> <!-- مكان عرض الخطأ -->
                         </div>
                     </div>

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> تنتهي الي تاريخ </label> <span class="tx-danger">*</span>
                             <!-- حقل إدخال التاريخ -->
                             <div class="input-group">
                                 <div class="input-group-prepend">
                                     <span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                                 </div>
                                 <input type="text" name="to_date" id="to_date" placeholder="يوم / شهر / سنه"
                                     class="form-control flatpickr bg-transparent" value="{{ old('to_date') }}">
                                 <div class="input-group-append">
                                     <button type="button" class="btn btn-dark"
                                         onclick="document.getElementById('to_date')._flatpickr.clear()"><i
                                             class="fa fa-times"></i> محو</button>
                                 </div>
                             </div>
                             <span class="text-danger" id="to_dateError"></span> <!-- مكان عرض الخطأ -->
                         </div>
                     </div>

                     <div class="col-md-12">
                         <div class="form-group">
                             <label> عدد الايام</label>
                             <input type="text" name="days_counter" id="days_counter"
                                 oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control"
                                 value="{{ old('days_counter') }}">
                             @error('days_counter')
                                 <span class="text-danger">{{ $message }}</span>
                             @enderror
                         </div>
                     </div>


                     <div class="col-md-12">
                         <div class="form-group">
                             <label> حالة التفعيل</label>
                             <select name="active" id="active" class="form-control">
                                 <option @if (old('active') == 1) selected @endif value="1">مفعل
                                 </option>
                                 <option @if (old('active') == 0 and old('active') != '') selected @endif value="0">معطل
                                 </option>
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
