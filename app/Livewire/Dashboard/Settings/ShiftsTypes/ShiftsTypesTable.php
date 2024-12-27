<?php

namespace App\Livewire\Dashboard\Settings\ShiftsTypes;

use App\Models\Employee;
use App\Models\ShiftsType;
use Livewire\Component;
use Livewire\WithPagination;

class ShiftsTypesTable extends Component
{
    use WithPagination;

    public $typeSearch;

    protected $listeners = ['refreshTableShiftsType' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {
        $com_code = auth()->user()->com_code;
        $query = (new ShiftsType)->query();

        if ($this->typeSearch) {
            $query->where('type', 'like', '%'.$this->typeSearch.'%');
        }
        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'shift_types_id' => $info->id]);
            }
        }

        return view('dashboard.settings.shiftsTypes.shifts-types-table', compact('data'));
    }
}
