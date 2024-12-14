<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
use App\Models\Employee;
use Livewire\WithPagination;

class BranchTable extends Component
{

    use  WithPagination;
    public $name,$phones;


        public function updatingSearch(){
            $this->resetPage();
        }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Branch())->query();

        if($this->name){
            $query->where('name','like','%'. $this->name.'%')->orWhere('email','like','%'. $this->name.'%');
        }


        if($this->phones){
            $query->where('phones','like','%'. $this->phones.'%');
        }


        $data = $query->orderBy("id", "DESC")->where("com_code" , $com_code)->paginate(10);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "branch_id" => $info->id));
            }
        }


        return view('dashboard.settings.branches.branch-table', compact('data'));
    }
}
