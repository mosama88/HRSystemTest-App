<?php

namespace App\Livewire\Dashboard\Settings\Branches;

use App\Models\Branch;
use App\Models\Employee;
use Livewire\Component;
use Livewire\WithPagination;

class BranchTable extends Component
{
    use WithPagination;

    public $name;

    protected $listeners = ['refreshTableBranch' => 'refreshComponent', 'notify' => 'showNotification'];

    public function refreshComponent()
    {
        $this->render(); // إعادة تحميل الجدول
    }

    public function showNotification($type, $message)
    {
        session()->flash($type, $message);
    }

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {

        $com_code = auth()->user()->com_code;
        $query = (new Branch)->query();

        if ($this->name) {
            $query->where('name', 'like', '%' . $this->name . '%')->orWhere('email', 'like', '%' . $this->name . '%')
                ->orWhere('phones', 'like', '%' . $this->name . '%');
        }

        $data = $query->orderBy('id', 'DESC')->where('com_code', $com_code)->paginate(10);
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'branch_id' => $info->id]);
            }
        }

        return view('dashboard.settings.branches.branch-table', compact('data'));
    }
}
