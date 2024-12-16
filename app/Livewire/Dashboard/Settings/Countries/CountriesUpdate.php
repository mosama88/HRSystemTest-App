<?php

namespace App\Livewire\Dashboard\Settings\Countries;

use App\Models\Country;
use Livewire\Component;
use App\Http\Requests\Dashboard\CountryRequest;

class CountriesUpdate extends Component
{

    public $updateData;
    public $name,$active;

    protected $listeners = ['editCountries'];

    public function rules()
    {
        return (new CountryRequest())->rules();
    }

    public function messages()
    {
        return (new CountryRequest())->messages();
    }


    public function editCountries($id)
    {
        $this->updateData = Country::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Country(), array("*"), array("com_code" => $com_code, 'id' => $this->updateData->id));
            if (empty($data)) {
                return redirect()->route('dashboard.countries.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = Country::select("id")->where("com_code", "=", $com_code)->where("name", "=", $this->name)->where('id', '!=', $this->updateData->id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableCountries')->to(CountriesTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    
    }


    
    public function render()
    {
        return view('dashboard.settings.countries.countries-update');
    }
}