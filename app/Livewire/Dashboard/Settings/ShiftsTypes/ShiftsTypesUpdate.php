<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use App\Http\Requests\Dashboard\ShiftsTypeRequest;
use App\Models\ShiftsType;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Livewire\Component;

class ShiftsTypesUpdate extends Component
{
    public $UpdateShiftTypes;

    public $type;

    public $from_time;

    public $to_time;

    public $total_hours;

    public $active;

    protected $listeners = ['shiftsTypesEdit'];

    public function rules()
    {
        return (new ShiftsTypeRequest)->rules();
    }

    public function messages()
    {
        return (new ShiftsTypeRequest)->messages();
    }

    public function shiftsTypesEdit($id)
    {
        $this->UpdateShiftTypes = ShiftsType::findOrFail($id);
        $this->type = $this->UpdateShiftTypes->type;
        $this->from_time = $this->UpdateShiftTypes->from_time;
        $this->to_time = $this->UpdateShiftTypes->to_time;
        $this->total_hours = $this->UpdateShiftTypes->total_hours;
        $this->active = $this->UpdateShiftTypes->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function updated()
    {
        if ($this->from_time && $this->to_time) {
            $this->from_time = Carbon::parse($this->from_time)->format('H:i'); // تنسيق 24 ساعة
            $this->to_time = Carbon::parse($this->to_time)->format('H:i');
            $this->CalcDiffHours();
        }
    }

    public function CalcDiffHours()
    {
        $from = strtotime($this->from_time);
        $to = strtotime($this->to_time);

        // احسب الفرق بالأثواني بطريقة صحيحة
        $diffSecond = abs($to - $from);

        // تحويل الفرق إلى ساعات
        $this->total_hours = round($diffSecond / 3600, 2);
    }

    public function submit()
    {
        DB::beginTransaction();
        $com_code = auth()->user()->com_code;
        $updatedData = $this->validate();
        $this->UpdateShiftTypes['updated_by'] = auth()->user()->id;
        $this->UpdateShiftTypes['com_code'] = $com_code;
        $this->UpdateShiftTypes->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableShiftsType')->to(ShiftsTypesTable::class);
        DB::commit();
        session()->flash('message', 'تم تعديل البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.settings.shiftsTypes.shifts-types-update');
    }
}
