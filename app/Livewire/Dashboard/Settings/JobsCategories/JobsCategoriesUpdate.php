<?php

namespace App\Livewire\Dashboard\Settings\JobsCategories;

use App\Http\Requests\Dashboard\JobsCategoryRequest;
use App\Models\JobsCategory;
use Livewire\Component;

class JobsCategoriesUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editjobsCategories'];

    public function rules()
    {
        return (new JobsCategoryRequest)->rules();
    }

    public function messages()
    {
        return (new JobsCategoryRequest)->messages();
    }

    public function editjobsCategories($id)
    {
        $this->updateData = JobsCategory::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobsCategory, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }

        $CheckExsists = JobsCategory::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTablejobsCategories')->to(JobsCategoriesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.settings.jobsCategories.jobs-categories-update');
    }
}
