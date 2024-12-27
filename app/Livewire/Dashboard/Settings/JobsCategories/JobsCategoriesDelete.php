<?php

namespace App\Livewire\Dashboard\Settings\JobsCategories;

use App\Models\Employee;
use App\Models\JobsCategory;
use Livewire\Component;

class JobsCategoriesDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deletejobsCategories'];

    public function deletejobsCategories($id)
    {

        $this->dataDeleteRecored = JobsCategory::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobsCategory, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_categories_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTablejobsCategories')->to(JobsCategoriesTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.jobsCategories.jobs-categories-delete');
    }
}
