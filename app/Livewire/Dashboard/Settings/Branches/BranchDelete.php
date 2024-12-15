<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
use App\Models\Employee;
use App\Livewire\Dashboard\Settings\Branches\BranchTable;

class BranchDelete extends Component
{

public $branchDeleteRecored,$name;

    protected $listeners = ['deleteBranch'];
    public function deleteBranch($id){

        $this->branchDeleteRecored  = Branch::findOrFail($id);
        $this->name = $this->branchDeleteRecored->name;
        $this->dispatch('deleteModalToggle');
    }

    public function submit(){

        $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Branch(), array('*'), array("id" => $this->branchDeleteRecored->id, "com_code" => $com_code));
            if (empty($data)) {
                return redirect()->route('dashboard.branches.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
            }
            $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "branch_id" => $this->branchDeleteRecored->id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            
                // Save Data
    $this->branchDeleteRecored->delete();
    $this->reset('branchDeleteRecored');
      //Hide Modal
      $this->dispatch('deleteModalToggle');
      $this->dispatch('refreshTableBranch')->to(BranchTable::class);

    }



    public function render()
    {
        return view('dashboard.settings.branches.branch-delete');
    }
}
