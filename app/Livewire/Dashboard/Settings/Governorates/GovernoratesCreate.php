<?php

namespace App\Livewire\Dashboard\Settings\Governorates;

use App\Http\Requests\Dashboard\GovernorateRequest;
use App\Models\Country;
use App\Models\Governorate;
use Livewire\Component;

class GovernoratesCreate extends Component
{
    public $name;

    public $country_id;

    public $active;

    public function rules()
    {
        return (new GovernorateRequest)->rules();
    }

    public function messages()
    {
        return (new GovernorateRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new Governorate, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        Governorate::create($dataCreate);
        $this->reset(['name', 'country_id']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableGovernorates')->to(GovernoratesTable::class);
        session()->flash('message', value: 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        $other['countries'] = Country::all();

        return view('dashboard.settings.governorates.governorates-create', compact('other'));
    }
}
