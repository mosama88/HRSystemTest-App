<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use Livewire\Component;
use App\Models\ShiftsType;
use App\Http\Requests\Dashboard\ShiftsTypeRequest;
use App\Livewire\Dashboard\Settings\ShiftsTypes\ShiftsTypesTable;

class ShiftsTypesCreate extends Component
{


    public $type, $from_time, $to_time, $total_hours, $active;

    public function rules()
    {
        return (new ShiftsTypeRequest())->rules();
    }


    public function messages()
    {
        return (new ShiftsTypeRequest())->messages();
    }

    public function updated()
    {
        if ($this->from_time && $this->to_time) {
            $this->CalcDiffHours();
        }
    }


    public function CalcDiffHours()
    {
        $from = strtotime($this->from_time);
        $to = strtotime($this->to_time);

        $diffSecond =  $to - $from;

        if ($diffSecond > 0) {
            $this->total_hours = round($diffSecond / 3600, 2);
        } else {
            $this->total_hours = 0;

        }
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
