<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Allowances;

use Livewire\Component;
use App\Models\Allowance;
use App\Models\EmployeeFixedAllowance;

class AllowancesDelete extends Component
{
    public $dataDeleteRecored,$name;

    protected $listeners = ['deleteAllowances'];
    public function deleteAllowances($id){

        $this->dataDeleteRecored  = Allowance::findOrFail($id);
        $this->name = $this->dataDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Allowance(), array("*"), array("com_code" => $com_code, 'id' => $this->dataDeleteRecored->id));
        if (empty($data)) {
            return redirect()->route('dashboard.allowances.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }

        $counterUsed = get_count_where(new EmployeeFixedAllowance(), array("com_code" => $com_code, "allowance_id" => $this->dataDeleteRecored->id));

        if ($counterUsed > 0) {
            return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
        }
            
                // Save Data
    $this->dataDeleteRecored->delete();
    $this->reset('dataDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableAllowances')->to(AllowancesTable::class);

    }



    public function render()
    {
        return view('dashboard.affairs_employees.allowances.allowances-delete');
    }
}
