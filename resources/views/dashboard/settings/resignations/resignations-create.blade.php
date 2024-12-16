<x-create-modal-component titleModel="أضف نوع أستقالة جديدة">

    <div class="col-md-12">
        <div class="form-group"> <span class="tx-danger">*</span>
            <label>اسم النوع الأستقاله</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            <span class="text-danger" id="nameError"></span> <!-- مكان عرض الخطأ -->
        </div>
    </div>
</x-create-modal-component>
