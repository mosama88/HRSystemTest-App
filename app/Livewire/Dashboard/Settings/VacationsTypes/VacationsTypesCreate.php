<?php

namespace App\Livewire\Dashboard\Settings\VacationsTypes;

use App\Http\Requests\Dashboard\VacationRequest;
use App\Models\VacationType;
use Livewire\Component;

class VacationsTypesCreate extends Component
{
    public $name;

    public $active;

    public function rules()
    {
        return (new VacationRequest)->rules();
    }

    public function messages()
    {
        return (new VacationRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new VacationType, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        VacationType::create($dataCreate);
        $this->reset(['name']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableVacationsTypes')->to(VacationsTypesTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.settings.vacationsTypes.vacations-types-create');
    }
}
