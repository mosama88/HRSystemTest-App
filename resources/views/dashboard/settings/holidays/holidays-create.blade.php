<x-create-modal-component titleModel="أضف عطلة رسمية جديدة">

    <div class="col-md-12">
        <div class="form-group">
            <label> اسم العطلة الرسمية</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>


    <div class="col-md-12">
        <div class="form-group">
            <label> تبدأ من تاريخ </label> <span class="tx-danger">*</span>
            <!-- حقل إدخال التاريخ -->
            <div class="input-group">
                <input type="date" wire:model.live="from_date" id="from_date" placeholder="يوم / شهر / سنه"
                    class="form-control">
            </div>
            @error('from_date')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>

    <div class="col-md-12">
        <div class="form-group">
            <label> تنتهي الي تاريخ </label> <span class="tx-danger">*</span>
            <!-- حقل إدخال التاريخ -->
            <div class="input-group">
                <input type="date" wire:model.live="to_date" id="to_date" placeholder="يوم / شهر / سنه"
                    class="form-control">
            </div>
            @error('to_date')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>

    <div class="col-md-12">
        <div class="form-group">
            <label> عدد الايام</label>
            <input readonly type="text" wire:model.live="days_counter" id="days_counter"
                oninput="this.value=this.value.replace(/[^0-9.]/g,'');" class="form-control">
            @error('days_counter')
                <div class="alert alert-danger mt-2">{{ $message }}</div>
            @enderror
        </div>
    </div>
</x-create-modal-component>
