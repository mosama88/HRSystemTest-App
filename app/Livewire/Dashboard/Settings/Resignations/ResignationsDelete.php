<?php

namespace App\Livewire\Dashboard\Settings\Resignations;

use App\Models\Employee;
use App\Models\Resignation;
use Livewire\Component;

class ResignationsDelete extends Component
{
    public $dataDeleteRecored;

    public $name;

    protected $listeners = ['deleteResignations'];

    public function deleteResignations($id)
    {

        $this->dataDeleteRecored = Resignation::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Resignation, ['*'], ['com_code' => $com_code, 'id' => $this->dataDeleteRecored->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
        }
        $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $this->dataDeleteRecored->id]);
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }

        // Save Data
        $this->dataDeleteRecored->delete();
        $this->reset('dataDeleteRecored');
        //Hide Modal
        $this->dispatch('deleteModalToggle');
        $this->dispatch('refreshTableResignation')->to(ResignationsTable::class);

    }

    public function render()
    {
        return view('dashboard.settings.resignations.resignations-delete');
    }
}
