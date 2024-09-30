
<label>    المدينة/المركز</label>
<select name="city_id" id="city_id" class="form-control select2 ">
  <option value="">اختر المدينة التابع لها الموظف</option>
  @if (@isset($other['cities']) && !@empty($other['cities']))
    @foreach ($other['cities'] as $info )
    <option @if(old('city_id')==$info->id) selected="selected" @endif value="{{ $info->id }}"> {{ $info->name }}
    </option>
    @endforeach
    @endif
</select>
@error('city_id')
<span class="text-danger">{{ $message }}</span>
@enderror

@section("js")

<script>
   //Initialize Select2 Elements
   $('.select2').select2({
     theme: 'bootstrap4'
   });

</script>
@endsection
