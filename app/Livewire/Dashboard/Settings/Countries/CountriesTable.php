<?php

namespace App\Livewire\Dashboard\Settings\Countries;

use App\Models\Country;
use App\Models\Employee;
use Livewire\Component;
use Livewire\WithPagination;

class CountriesTable extends Component
{
    use WithPagination;

    public $name_search;

    protected $listeners = ['refreshTableCountries' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Country)->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%'.$this->name_search.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'country_id' => $info->id]);
            }
        }

        return view('dashboard.settings.countries.countries-table', compact('data'));
    }
}
