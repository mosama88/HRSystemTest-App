<x-update-modal-component titleModel="تعديل بيانات الوظيفه">
    <div class="col-md-12">
        <div class="form-group">
            <label> اسم الوظيفة</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
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
</x-update-modal-component>
