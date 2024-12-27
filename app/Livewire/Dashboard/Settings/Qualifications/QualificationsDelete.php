<?php

namespace App\Livewire\Dashboard\Settings\Qualifications;

use App\Models\Employee;
use App\Models\Qualification;
use Livewire\Component;

class QualificationsDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteQualifications'];

    public function deleteQualifications($id)
    {

        $this->dataDeleteRecored = Qualification::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Qualification, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة !']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'qualification_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableQualification')->to(QualificationsTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.qualifications.qualifications-delete');
    }
}
