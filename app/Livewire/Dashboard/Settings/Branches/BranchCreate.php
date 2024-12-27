<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Http\Requests\Dashboard\BranchRequest;
use App\Models\Branch;
use Livewire\Component;

class BranchCreate extends Component
{
    public $name;

    public $address;

    public $phones;

    public $email;

    public $active;

    public function rules()
    {
        return (new BranchRequest)->rules();
    }

    public function messages()
    {
        return (new BranchRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $branchCreate = $this->validate();
        $checkExists = get_Columns_where_row(new Branch, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($checkExists)) {
            return redirect()->back()->with('error', 'الفرع مسجل بالفعل ');
        }
        $branchCreate['active'] = 1;
        $branchCreate['created_by'] = auth()->user()->id;
        $branchCreate['com_code'] = $com_code;
        Branch::create($branchCreate);
        $this->reset(['name', 'address', 'phones', 'email']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableBranch')->to(BranchTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.branches.branch-create');
    }
}
