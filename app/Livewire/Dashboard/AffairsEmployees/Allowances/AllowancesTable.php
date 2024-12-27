<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Allowances;

use App\Models\Allowance;
use App\Models\EmployeeFixedAllowance;
use Livewire\Component;
use Livewire\WithPagination;

class AllowancesTable extends Component
{
    use WithPagination;

    public $name_search;

    protected $listeners = ['refreshTableAllowances' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Allowance)->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%'.$this->name_search.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new EmployeeFixedAllowance, ['com_code' => $com_code, 'allowance_id' => $info->id]);
            }
        }

        return view('dashboard.affairs_employees.allowances.allowances-table', compact('data'));
    }
}
