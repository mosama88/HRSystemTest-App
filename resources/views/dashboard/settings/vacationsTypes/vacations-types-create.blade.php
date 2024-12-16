<x-create-modal-component titleModel="أضف نوع أجازه جديدة">

    <div class="col-md-12">
        <div class="form-group"> <span class="tx-danger">*</span>
            <label>اسم النوع الأجازه</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
</x-create-modal-component>
