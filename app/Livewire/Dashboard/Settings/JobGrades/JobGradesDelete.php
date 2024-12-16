<?php

namespace App\Livewire\Dashboard\Settings\JobGrades;

use Livewire\Component;
use App\Models\Employee;
use App\Models\JobGrade;

class JobGradesDelete extends Component
{

    public $dataDeleteRecored,$name;

    protected $listeners = ['deletejobGrades'];
    public function deletejobGrades($id){

        $this->dataDeleteRecored  = JobGrade::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobGrade(), array("*"), array("com_code" => $com_code, 'id' => $this->dataDeleteRecored->id));
        if (empty($data)) {
            return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "job_grade_id" => $this->dataDeleteRecored->id));
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

            
                // Save Data
    $this->dataDeleteRecored->delete();
    $this->reset('dataDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableJobGrade')->to(JobGradesTable::class);

    }



    
    public function render()
    {
        return view('dashboard.settings.jobGrades.job-grades-delete');
    }
}