<?php

namespace App\Livewire\Dashboard\Settings\Nationalities;

use Livewire\Component;
use App\Models\Employee;
use App\Models\Nationality;
use Livewire\WithPagination;

class NationalitiesTable extends Component
{
    use  WithPagination;
    
    public $name_search;

    protected $listeners = ['refreshTableNationalities' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Nationality())->query();

        if ($this->name_search) {
            $query->where('name', 'like', '%' . $this->name_search . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);

        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "nationality_id" => $info->id));
            }
        }
        return view('dashboard.settings.nationalities.nationalities-table',compact('data'));
    }
}