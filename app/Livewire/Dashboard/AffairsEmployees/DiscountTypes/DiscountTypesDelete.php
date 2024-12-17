<?php

namespace App\Livewire\Dashboard\AffairsEmployees\DiscountTypes;

use Livewire\Component;
use App\Models\DiscountType;
use App\Models\EmployeeSalaryDiscount;

class DiscountTypesDelete extends Component
{

    public $dataDeleteRecored,$name;

    protected $listeners = ['deleteDiscountTypes'];
    public function deleteDiscountTypes($id){

        $this->dataDeleteRecored  = DiscountType::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new DiscountType(), array("*"), array("com_code" => $com_code, 'id' => $this->dataDeleteRecored->id));
            if (empty($data)) {
                return redirect()->route('dashboard.discount_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }

            $counterUsed = get_count_where(new EmployeeSalaryDiscount(), array("com_code" => $com_code, "discount_types_id" => $this->dataDeleteRecored->id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            
                // Save Data
    $this->dataDeleteRecored->delete();
    $this->reset('dataDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableDiscount_types')->to(DiscountTypesTable::class);

    }




    public function render()
    {
        return view('dashboard.affairs_employees.discount_types.discount-types-delete');
    }
}
