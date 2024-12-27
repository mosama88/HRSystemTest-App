<?php

namespace App\Livewire\Dashboard\Settings\Countries;

use App\Http\Requests\Dashboard\CountryRequest;
use App\Models\Country;
use Livewire\Component;

class CountriesCreate extends Component
{
    public $name;

    public $active;

    public function rules()
    {
        return (new CountryRequest)->rules();
    }

    public function messages()
    {
        return (new CountryRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new Country, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        Country::create($dataCreate);
        $this->reset(['name']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableCountries')->to(CountriesTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.settings.countries.countries-create');
    }
}
