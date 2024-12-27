<?php

namespace App\Livewire\Dashboard\Settings\Holidays;

use App\Models\Holiday;
use Livewire\Component;

class HolidaysDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteHolidays'];

    public function deleteHolidays($id)
    {

        $this->dataDeleteRecored = Holiday::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableHolidays')->to(HolidaysTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.holidays.holidays-delete');
    }
}
