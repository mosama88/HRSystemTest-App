<?php

namespace App\Livewire\Dashboard\Settings\JobGrades;

use Livewire\Component;
use App\Models\Employee;
use App\Models\JobGrade;
use Livewire\WithPagination;

class JobGradesTable extends Component
{
    use  WithPagination;
    public $name;

    protected $listeners = ['refreshTableJobGrade' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }


    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new JobGrade())->query();

        if ($this->name) {
            $query->where('name', 'like', '%' . $this->name . '%');
        }

        $data = $query->orderBy("id", "DESC")->where("com_code", $com_code)->paginate(10);
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "job_grade_id" => $info->id));
            }
        }

        return view('dashboard.settings.jobGrades.job-grades-table',compact('data'));
    }
}