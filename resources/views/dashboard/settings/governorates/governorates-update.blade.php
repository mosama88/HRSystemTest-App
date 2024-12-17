<x-update-modal-component titleModel="تعديل بيانات المحافظة">

    <div class="col-md-12">
        <div class="form-group">
            <label>اسم المحافظة</label>
            <input type="text" wire:model="name" id="name" class="form-control">
            @error('name')
                <span class="text-danger">{{ $message }}</span>
            @enderror
        </div>
    </div>

    {{-- countries Input --}}
    <div class="col-md-12">
        <div class="form-group">
            <label>البلد التابع لها المحافظة</label> <span class="tx-danger">*</span>
            <select wire:model="country_id" id="country_id" class="form-control select2">
                <option value="">-- اختر البلد التابع لها المحافظة
                    --</option>
                @if (isset($other['countries']) && !empty($other['countries']))
                    @foreach ($other['countries'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }}
                        </option>
                    @endforeach
                @endif
            </select>
            @error('country_id')
                <div class="alert alert-danger">{{ $message }}</div>
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
