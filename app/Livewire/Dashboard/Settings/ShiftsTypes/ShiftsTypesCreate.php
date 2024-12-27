<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use App\Http\Requests\Dashboard\ShiftsTypeRequest;
use App\Models\ShiftsType;
use Carbon\Carbon;
use Livewire\Component;

class ShiftsTypesCreate extends Component
{
    public $type;

    public $from_time;

    public $to_time;

    public $total_hours;

    public $active;

    public function rules()
    {
        return (new ShiftsTypeRequest)->rules();
    }

    public function messages()
    {
        return (new ShiftsTypeRequest)->messages();
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
        $com_code = auth()->user()->com_code;
        $createShiftTypes = $this->validate();
        $this->active = 1;
        $createShiftTypes['created_by'] = auth()->user()->id;
        $createShiftTypes['com_code'] = $com_code;
        ShiftsType::create($createShiftTypes);
        $this->reset(['type', 'from_time', 'to_time', 'total_hours']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableShiftsType')->to(ShiftsTypesTable::class);
    }

    public function render()
    {
        return view('dashboard.settings.shiftsTypes.shifts-types-create');
    }
}
