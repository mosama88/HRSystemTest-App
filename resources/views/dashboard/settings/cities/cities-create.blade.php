<x-create-modal-component titleModel="أضف منطقه جديدة">

    <div class="col-md-12">
        <div class="form-group">
            <label>اسم الحى / المنطقه</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control" value="{{ old('name') }}">
            @error('name')
                <div class="alert alert-danger">{{ $message }}</div>
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
                    @foreach ($other['governorates'] as $info)
                        <option value="{{ $info->id }}">
                            {{ $info->name }}
                        </option>
                    @endforeach
                @endif
            </select>
            @error('governorate_id')
                <div class="alert alert-danger">{{ $message }}</div>
            @enderror
        </div>
    </div>

</x-create-modal-component>
