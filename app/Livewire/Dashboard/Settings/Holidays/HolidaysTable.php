<?php

namespace App\Livewire\Dashboard\Settings\Holidays;

use App\Models\Holiday;
use Livewire\Component;
use Livewire\WithPagination;

class HolidaysTable extends Component
{
    use WithPagination;

    public $name;

    protected $listeners = ['refreshTableHolidays' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Holiday)->query();

        if ($this->name) {
            $query->where('name', 'like', '%'.$this->name.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        return view('dashboard.settings.holidays.holidays-table', compact('data'));
    }
}
