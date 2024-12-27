<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Allowances;

use App\Http\Requests\Dashboard\AllowanceRequest;
use App\Models\Allowance;
use Livewire\Component;

class AllowancesCreate extends Component
{
    public $name;

    public $active;

    public function rules()
    {
        return (new AllowanceRequest)->rules();
    }

    public function messages()
    {
        return (new AllowanceRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new Allowance, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        Allowance::create($dataCreate);
        $this->reset(['name']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableAllowances')->to(AllowancesTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.affairs_employees.allowances.allowances-create');
    }
}
