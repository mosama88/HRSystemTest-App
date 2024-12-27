<?php

namespace App\Livewire\Dashboard\Settings\Governorates;

use App\Models\Country;
use App\Models\Employee;
use App\Models\Governorate;
use Livewire\Component;
use Livewire\WithPagination;

class GovernoratesTable extends Component
{
    use WithPagination;

    public $name_search;

    public $country_search;

    protected $listeners = ['refreshTableGovernorates' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Governorate)->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%'.$this->name_search.'%');
        }

        if ($this->country_search) {
            $query->where('country_id', 'like', '%'.$this->country_search.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'governorate_id' => $info->id]);
            }
        }

        $other['countries'] = Country::all();

        return view('dashboard.settings.governorates.governorates-table', compact('data', 'other'));
    }
}
