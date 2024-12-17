<x-create-modal-component titleModel="أضف محافظة جديدة">

    <div class="col-md-12">
        <div class="form-group">
            <label>اسم المحافظة</label> <span class="tx-danger">*</span>
            <input type="text" wire:model="name" id="name" class="form-control" value="{{ old('name') }}">
            @error('name')
                <div class="alert alert-danger">{{ $message }}</div>
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

</x-create-modal-component>
