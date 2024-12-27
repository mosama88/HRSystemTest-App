<?php

namespace App\Livewire\Dashboard\Settings\Cities;

use App\Models\City;
use App\Models\Employee;
use Livewire\Component;

class CitiesDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteCities'];

    public function deleteCities($id)
    {

        $this->dataDeleteRecored = City::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $data = get_Columns_where_row(new City, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'city_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableCities')->to(CitiesTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.cities.cities-delete');
    }
}
