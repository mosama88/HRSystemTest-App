 <!-- Scroll modal -->
 <div class="modal edit" id="edit{{ $info->id }}">
     <div class="modal-dialog" role="document">
         <div class="modal-content modal-content-demo">
             <div class="modal-header">
                 <h6 class="modal-title">تعديل بيانات العطلة</h6>
                 <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                    aria-hidden="true">&times;</span></button>
             </div>
             <div class="modal-body">
                 <form action="{{ route('dashboard.holidays.update', $info->id) }}" method="POST">
                     @csrf
                     @method('PUT')

                     <div class="col-md-12">
                        <div class="form-group">
                           <label>اسم العطلة</label>
                           <input type="text" name="name" id="name" class="form-control" value="{{ old('name',$info['name']) }}"  >
                           @error('name')
                           <span class="text-danger">{{ $message }}</span>
                           @enderror
                        </div>
                     </div>
                     <div class="col-md-12">
                        <div class="form-group">
                           <label> تبدأ من تاريخ </label>
                           <input  type="date" name="from_date" id="from_date" class="form-control" value="{{ old('from_date',$info['from_date']) }}"  >
                           @error('from_date')
                           <span class="text-danger">{{ $message }}</span>
                           @enderror
                        </div>
                     </div>
                     <div class="col-md-12">
                        <div class="form-group">
                           <label> تنتهي  الي تاريخ </label>
                           <input  type="date" name="to_date" id="to_date" class="form-control" value="{{ old('to_date',$info['to_date']) }}"  >
                           @error('to_date')
                           <span class="text-danger">{{ $message }}</span>
                           @enderror
                        </div>
                     </div>
                     <div class="col-md-12">
                        <div class="form-group">
                           <label> عدد الايام</label>
                           <input  type="text" name="days_counter" id="days_counter" oninput="this.value=this.value.replace(/[^0-9.]/g,'');"  class="form-control" value="{{ old('days_counter',$info['days_counter']) }}"  >
                           @error('days_counter')
                           <span class="text-danger">{{ $message }}</span>
                           @enderror
                        </div>
                     </div>
                     <div class="col-md-12">
                        <div class="form-group">
                           <label> حالة التفعيل</label>
                           <select name="active" id="active" class="form-control">
                           <option @if(old('active',$info['active'])==1) selected @endif  value="1">مفعل</option>
                           <option  @if(old('active',$info['active'])==0) selected @endif  value="0">معطل</option>
                           </select>
                           @error('active')
                           <span class="text-danger">{{ $message }}</span>
                           @enderror
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
