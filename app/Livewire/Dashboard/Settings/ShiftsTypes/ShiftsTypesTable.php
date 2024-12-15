<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use Livewire\Component;
use App\Models\Employee;
use App\Models\ShiftsType;

class ShiftsTypesTable extends Component
{


    protected $listeners = ['refreshTableShiftsType'=>'refresh'];

    public function render()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new ShiftsType(), array("*"), array("com_code" => $com_code), "id", "DESC")->get();
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "shift_types_id" => $info->id));
            }
        }
        return view('dashboard.settings.shiftsTypes.shifts-types-table',compact('data'));
    }
}
