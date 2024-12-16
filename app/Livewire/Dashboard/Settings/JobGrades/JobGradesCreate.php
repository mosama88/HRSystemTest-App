<?php

namespace App\Livewire\Dashboard\Settings\JobGrades;

use Livewire\Component;
use App\Models\JobGrade;
use App\Http\Requests\Dashboard\JobGradeRequest;

class JobGradesCreate extends Component
{

    public $name,$job_grades_code,$min_salary,$max_salary,$notes,$active;


    public function rules()
    {
        return (new JobGradeRequest())->rules();
    }


    public function messages()
    {
        return (new JobGradeRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $CheckExsists = get_Columns_where_row(new JobGrade(), array("id"), array("name" => $this->name, 'com_code' => $com_code));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }

            $last_job_grades_code = get_cols_where_row_orderby(new JobGrade(), array("job_grades_code"), array("com_code" => $com_code), "job_grades_code", "DESC");

            if (!empty($last_job_grades_code)) {  // لو القيم مش فاضية
                $dataCreate['job_grades_code'] =  $last_job_grades_code['job_grades_code'] + 1;          //هيزود رقم على كل موظف
            } else //أول موظف يتم تسجيلة
            {
                $dataCreate['job_grades_code'] = 1; //بداية الترقيم
            }
            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            JobGrade::create($dataCreate);
            $this->reset(['name', 'min_salary', 'max_salary', 'notes']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableJobGrade')->to(JobGradesTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');

      
    }




    
    public function render()
    {
        return view('dashboard.settings.jobGrades.job-grades-create');
    }
}