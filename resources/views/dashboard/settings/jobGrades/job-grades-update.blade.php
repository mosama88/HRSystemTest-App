<x-update-modal-component titleModel="تعديل بيانات الدرجه الوظيفية">

    <div class="col-md-12">
        <div class="form-group">
            <label> كود الدرجه الوظيفية</label>
            <input readonly type="text" wire:model="job_grades_code" id="job_grades_code" class="form-control">
            @error('job_grades_code')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>


    <div class="col-md-12">
        <div class="form-group">
            <label> اسم الدرجه الوظيفية</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> الحد الأدنى للمرتب</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="min_salary" id="min_salary" class="form-control"
                oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
            @error('min_salary')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> الحد الأقصى للمرتب</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="max_salary" id="max_salary" class="form-control"
                oninput="this.value=this.value.replace(/[^0-9.]/g,'');">
            @error('max_salary')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> ملاحظات</label>
            <textarea type="text" wire:model="notes" id="notes" class="form-control"></textarea>
            @error('notes')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
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
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
</x-update-modal-component>
