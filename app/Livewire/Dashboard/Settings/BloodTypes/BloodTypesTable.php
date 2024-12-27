<?php

namespace App\Livewire\Dashboard\Settings\BloodTypes;

use App\Models\BloodType;
use App\Models\Employee;
use Livewire\Component;
use Livewire\WithPagination;

class BloodTypesTable extends Component
{
    use WithPagination;

    public $name_search;

    protected $listeners = ['refreshTableBloodTypes' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new BloodType)->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%'.$this->name_search.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'blood_types_id' => $info->id]);
            }
        }

        return view('dashboard.settings.bloodTypes.blood-types-table', compact('data'));
    }
}
