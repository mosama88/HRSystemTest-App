<!--End Scroll modal -->
<x-create-modal-component titleModel="أضف وظيفه جديدة">
    <div class="col-md-12">
        <div class="form-group">
            <label>اسم الوظيفة</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
</x-create-modal-component>
