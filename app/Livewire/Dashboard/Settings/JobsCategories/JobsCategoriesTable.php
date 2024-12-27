<?php

namespace App\Livewire\Dashboard\Settings\JobsCategories;

use App\Models\Employee;
use App\Models\JobsCategory;
use Livewire\Component;
use Livewire\WithPagination;

class JobsCategoriesTable extends Component
{
    use WithPagination;

    public $name;

    protected $listeners = ['refreshTablejobsCategories' => 'refresh'];

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new JobsCategory)->query();

        if ($this->name) {
            $query->where('name', 'like', '%'.$this->name.'%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_categories_id' => $info->id]);
            }
        }

        return view('dashboard.settings.jobsCategories.jobs-categories-table', compact('data'));
    }
}
