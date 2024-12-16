<?php

namespace App\Livewire\Dashboard\Settings\Qualifications;

use Livewire\Component;
use App\Models\Employee;
use Livewire\WithPagination;
use App\Models\Qualification;

class QualificationsTable extends Component
{
    use  WithPagination;
    public $name;

    protected $listeners = ['refreshTableQualification' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Qualification())->query();

        if ($this->name) {
            $query->where('name', 'like', '%' . $this->name . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "qualification_id" => $info->id));
            }
        }


        return view('dashboard.settings.qualifications.qualifications-table',compact('data'));
    }
}