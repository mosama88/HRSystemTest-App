<?php

namespace App\Livewire\Dashboard\AffairsEmployees\DiscountTypes;

use Livewire\Component;
use App\Models\DiscountType;
use Livewire\WithPagination;
use App\Models\EmployeeSalaryDiscount;

class DiscountTypesTable extends Component
{
    use  WithPagination;
    
    public $name_search;

    protected $listeners = ['refreshTableDiscount_types' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new DiscountType())->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%' . $this->name_search . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);

        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new EmployeeSalaryDiscount(), array("com_code" => $com_code, "discount_types_id" => $info->id));
            }
        }
        return view('dashboard.affairs_employees.discount_types.discount-types-table',compact('data'));
    }
}
