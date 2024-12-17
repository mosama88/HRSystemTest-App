<?php

namespace App\Livewire\Dashboard\AffairsEmployees\AdditionalTypes;

use Livewire\Component;
use Livewire\WithPagination;
use App\Models\AdditionalType;
use App\Models\EmployeeSalaryRewards;

class AdditionalTypesTable extends Component
{
    use  WithPagination;
    
    public $name_search;

    protected $listeners = ['refreshTableAdditionalType' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new AdditionalType())->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%' . $this->name_search . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);

        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new EmployeeSalaryRewards(), array("com_code" => $com_code, "additional_types_id" => $info->id));
            }
        }

        return view('dashboard.affairs_employees.additional_types.additional-types-table',compact('data'));
    }
}
