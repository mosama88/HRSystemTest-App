<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use Livewire\Component;
use App\Http\Requests\Dashboard\BranchRequest;
use App\Livewire\Dashboard\Settings\Branches\BranchTable;

class BranchCreate extends Component
{

    public $name,$address,$phones,$email;


    public function rules(){
        return (new BranchRequest())->rules();
    }


    public function messages(){
        return (new BranchRequest())->messages();
    }



    public function submit(){

        $com_code = auth()->user()->com_code;
        $branchCreate = $this->validate();
        $branchCreate['active'] = 1;
        $branchCreate['created_by'] = auth()->user()->id;
        $branchCreate['com_code'] = $com_code;
        Branch::create($branchCreate);
        $this->reset(['name','address','phones','email']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableBranch')->to(BranchTable::class);
    }




    public function render()
    {
        return view('dashboard.settings.branches.branch-create');
    }
}
