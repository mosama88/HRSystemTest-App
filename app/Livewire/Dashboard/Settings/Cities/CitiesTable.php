<?php

namespace App\Livewire\Dashboard\Settings\Cities;

use App\Models\City;
use App\Models\Employee;
use App\Models\Governorate;
use Livewire\Component;
use Livewire\WithPagination;

class CitiesTable extends Component
{
    use WithPagination;

    public $name_search;

    public $governorate_search;

    protected $listeners = ['refreshTableCities' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new City)->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%'.$this->name_search.'%');
        }

        if ($this->governorate_search) {
            $query->where('governorate_id', $this->governorate_search); // استخدام `=` بدلاً من `like`
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'city_id' => $info->id]);
            }
        }

        $other['governorates'] = Governorate::all();

        return view('dashboard.settings.cities.cities-table', compact('data', 'other'));
    }
}
