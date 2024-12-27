<?php

namespace App\Livewire\Dashboard\AffairsEmployees\AdditionalTypes;

use App\Http\Requests\Dashboard\AdditionalTypeRequest;
use App\Models\AdditionalType;
use Livewire\Component;

class AdditionalTypesCreate extends Component
{
    public $name;

    public $active;

    public function rules()
    {
        return (new AdditionalTypeRequest)->rules();
    }

    public function messages()
    {
        return (new AdditionalTypeRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new AdditionalType, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        AdditionalType::create($dataCreate);
        $this->reset(['name']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableAdditionalType')->to(AdditionalTypesTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.affairs_employees.additional_types.additional-types-create');
    }
}
