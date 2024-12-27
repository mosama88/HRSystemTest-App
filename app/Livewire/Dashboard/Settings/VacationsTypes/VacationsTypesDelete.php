<?php

namespace App\Livewire\Dashboard\Settings\VacationsTypes;

use App\Models\Employee;
use App\Models\VacationType;
use Livewire\Component;

class VacationsTypesDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deletevacationsTypes'];

    public function deletevacationsTypes($id)
    {

        $this->dataDeleteRecored = VacationType::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new VacationType, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableVacationsTypes')->to(VacationsTypesTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.vacationsTypes.vacations-types-delete');
    }
}
