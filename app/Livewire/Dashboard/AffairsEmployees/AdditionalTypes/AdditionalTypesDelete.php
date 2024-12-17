<?php

namespace App\Livewire\Dashboard\AffairsEmployees\AdditionalTypes;

use Livewire\Component;
use App\Models\AdditionalType;
use App\Models\EmployeeSalaryRewards;

class AdditionalTypesDelete extends Component
{


    public $dataDeleteRecored,$name;

    protected $listeners = ['deleteAdditionalTypes'];
    public function deleteAdditionalTypes($id){

        $this->dataDeleteRecored  = AdditionalType::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new AdditionalType(), array("*"), array("com_code" => $com_code, "id" => $this->dataDeleteRecored->id));
        if (empty($data)) {
            return redirect()->route('dashboard.additional_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $counterUsed = get_count_where(new EmployeeSalaryRewards(), array("com_code" => $com_code, "additional_types_id" => $this->dataDeleteRecored->id));
        if ($counterUsed > 0) {
            return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }
            
                // Save Data
    $this->dataDeleteRecored->delete();
    $this->reset('dataDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableAdditionalType')->to(AdditionalTypesTable::class);

    }



    public function render()
    {
        return view('dashboard.affairs_employees.additional_types.additional-types-delete');
    }
}
