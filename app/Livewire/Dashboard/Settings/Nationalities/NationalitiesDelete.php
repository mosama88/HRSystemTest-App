<?php

namespace App\Livewire\Dashboard\Settings\Nationalities;

use App\Models\Employee;
use App\Models\Nationality;
use Livewire\Component;

class NationalitiesDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteNationalities'];

    public function deleteNationalities($id)
    {

        $this->dataDeleteRecored = Nationality::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Nationality, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'nationality_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableNationalities')->to(NationalitiesTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.nationalities.nationalities-delete');
    }
}
