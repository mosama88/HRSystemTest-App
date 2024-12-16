<?php

namespace App\Livewire\Dashboard\Settings\JobsCategories;

use Livewire\Component;
use App\Models\JobsCategory;
use App\Http\Requests\Dashboard\JobsCategoryRequest;

class JobsCategoriesCreate extends Component
{

    public $name, $active;


    public function rules()
    {
        return (new JobsCategoryRequest())->rules();
    }


    public function messages()
    {
        return (new JobsCategoryRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $departmentCreate = $this->validate();
            $CheckExsists = get_Columns_where_row(new JobsCategory(), array("id"), array("name" => $this->name, 'com_code' => $com_code));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }
            $departmentCreate['active'] = 1;
            $departmentCreate['created_by'] = auth()->user()->id;
            $departmentCreate['com_code'] = $com_code;
            JobsCategory::create($departmentCreate);
            $this->reset(['name']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTablejobsCategories')->to(JobsCategoriesTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');

      
    }


    
    public function render()
    {
        return view('dashboard.settings.jobsCategories.jobs-categories-create');
    }
}