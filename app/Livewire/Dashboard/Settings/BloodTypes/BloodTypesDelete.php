<?php

namespace App\Livewire\Dashboard\Settings\BloodTypes;

use Livewire\Component;
use App\Models\Employee;
use App\Models\BloodType;

class BloodTypesDelete extends Component
{

    public $dataDeleteRecored,$name;

    protected $listeners = ['deleteBloodTypes'];
    public function deleteBloodTypes($id){

        $this->dataDeleteRecored  = BloodType::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;

            $data = get_Columns_where_row(new BloodType(), array("*"), array("com_code" => $com_code, 'id' => $this->dataDeleteRecored->id));
            if (empty($data)) {
                return redirect()->route('dashboard.bloodTypes.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }

            $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "blood_types_id" => $this->dataDeleteRecored->id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.bloodTypes.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            
                // Save Data
    $this->dataDeleteRecored->delete();
    $this->reset('dataDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableBloodTypes')->to(BloodTypesTable::class);

    }

    
    public function render()
    {
        return view('dashboard.settings.bloodTypes.blood-types-delete');
    }
}