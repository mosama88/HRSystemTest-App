<?php

namespace App\Livewire\Dashboard\Settings\Governorates;

use App\Models\Employee;
use App\Models\Governorate;
use Livewire\Component;

class GovernoratesDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteGovernorates'];

    public function deleteGovernorates($id)
    {

        $this->dataDeleteRecored = Governorate::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $data = get_Columns_where_row(new Governorate, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'governorate_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableGovernorates')->to(GovernoratesTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.governorates.governorates-delete');
    }
}
