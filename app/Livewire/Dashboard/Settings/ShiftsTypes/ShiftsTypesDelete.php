<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use Livewire\Component;
use App\Models\Employee;
use App\Models\ShiftsType;

class ShiftsTypesDelete extends Component
{

    public $shiftsTypesDeleteRecored, $type;

    protected $listeners = ['deleteshiftsTypes'];
    public function deleteshiftsTypes($id)
    {

        $this->shiftsTypesDeleteRecored = ShiftsType::findOrFail($id);
        $this->type = $this->shiftsTypesDeleteRecored->type;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new ShiftsType(), array('*'), array("id" => $this->shiftsTypesDeleteRecored->id, "com_code" => $com_code));
        if (empty($data)) {
            return redirect()->route('dashboard.shiftsTypes.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
        }

        $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "shift_types_id" => $this->shiftsTypesDeleteRecored->id));
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.shiftsTypes.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->shiftsTypesDeleteRecored->delete();
        $this->reset('shiftsTypesDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
    }



    public function render()
    {
        return view('dashboard.settings.shiftsTypes.shifts-types-delete');
    }
}
