<?php

namespace App\Livewire\Dashboard\Settings\JobGrades;

use Livewire\Component;
use App\Models\JobGrade;
use App\Http\Requests\Dashboard\JobGradeRequest;

class JobGradesUpdate extends Component
{

    public $updateData;
    public $name,$job_grades_code,$min_salary,$max_salary,$notes,$active;

    protected $listeners = ['editjobGrades'];

    public function rules()
    {
        return (new JobGradeRequest())->rules();
    }

    public function messages()
    {
        return (new JobGradeRequest())->messages();
    }


    public function editjobGrades($id)
    {
        $this->updateData = JobGrade::findOrFail($id);
        $this->job_grades_code = $this->updateData->job_grades_code;
        $this->name = $this->updateData->name;
        $this->min_salary = $this->updateData->min_salary;
        $this->max_salary = $this->updateData->max_salary;
        $this->notes = $this->updateData->notes;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new JobGrade(), array("*"), array("com_code" => $com_code, 'id' => $this->updateData->id));
            if (empty($data)) {
                return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
            }

                $CheckExsists = JobGrade::select("id")->where("com_code", "=", $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
                if (!empty($CheckExsists)) {
                    return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
                }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableJobGrade')->to(JobGradesTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    
    }



    
    public function render()
    {
        return view('dashboard.settings.jobGrades.job-grades-update');
    }
}