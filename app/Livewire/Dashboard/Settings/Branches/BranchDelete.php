<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
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
