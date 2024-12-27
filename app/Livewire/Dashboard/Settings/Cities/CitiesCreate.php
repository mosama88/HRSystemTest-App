<?php

namespace App\Livewire\Dashboard\Settings\Cities;

use App\Http\Requests\Dashboard\CityRequest;
use App\Models\City;
use App\Models\Governorate;
use Livewire\Component;

class CitiesCreate extends Component
{
    public $name;

    public $governorate_id;

    public $active;

    public function rules()
    {
        return (new CityRequest)->rules();
    }

    public function messages()
    {
        return (new CityRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new City, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        City::create($dataCreate);
        $this->reset(['name', 'governorate_id']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableCities')->to(CitiesTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        $other['governorates'] = Governorate::all();

        return view('dashboard.settings.cities.cities-create', compact('other'));
    }
}
