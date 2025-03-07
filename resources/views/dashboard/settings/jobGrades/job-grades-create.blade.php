<x-create-modal-component titleModel="أضف درجة وظيفية جديدة">

    <div class="col-md-12">
        <div class="form-group">
            <label> اسم الدرجه الوظيفية</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control" value="{{ old('name') }}">
            @error('name')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> الحد الأدنى للمرتب</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="min_salary" id="min_salary" class="form-control"
                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" value="{{ old('min_salary') }}">
            @error('min_salary')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> الحد الأقصى للمرتب</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="max_salary" id="max_salary" class="form-control"
                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" value="{{ old('max_salary') }}">
            @error('max_salary')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label> ملاحظات</label>
            <textarea type="text" wire:model="notes" id="notes" class="form-control">{{ old('notes') }}</textarea>
            @error('notes')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>

</x-create-modal-component>
