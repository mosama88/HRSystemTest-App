<x-update-modal-component titleModel="تعديل بيانات البلد">
    <div class="col-md-12">
        <div class="form-group">
            <label> اسم البلد</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
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
