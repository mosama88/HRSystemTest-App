<x-update-modal-component titleModel="تعديل بيانات الحى / المنطقه">

    <div class="col-md-12">
        <div class="form-group">
            <label>اسم الحى / المنطقه</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <span class="text-danger">{{ $message }}</span>
            @enderror
        </div>
    </div>

    {{-- Governorate Input --}}
    <div class="col-md-12">
        <div class="form-group">
            <label>المحافظة التابع لها الموظف</label> <span class="tx-danger">*</span>
            <select wire:model="governorate_id" id="governorate_id" class="form-control select2">
                <option value="">-- اختر المحافظة التابع لها الموظف
                    --</option>
                @if (isset($other['governorates']) && !empty($other['governorates']))
                    @foreach ($other['governorates'] as $gover)
                        <option value="{{ $gover->id }}">
                            {{ $gover->name }}
                        </option>
                    @endforeach
                @endif
            </select>
            @error('governorate_id')
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
