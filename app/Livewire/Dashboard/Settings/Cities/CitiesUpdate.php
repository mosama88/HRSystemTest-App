<?php

namespace App\Livewire\Dashboard\Settings\Cities;

use App\Http\Requests\Dashboard\CityRequest;
use App\Models\City;
use App\Models\Governorate;
use Livewire\Component;

class CitiesUpdate extends Component
{
    public $updateData;

    public $name;

    public $governorate_id;

    public $active;

    protected $listeners = ['editCities'];

    public function rules()
    {
        return (new CityRequest)->rules();
    }

    public function messages()
    {
        return (new CityRequest)->messages();
    }

    public function editCities($id)
    {
        $this->updateData = City::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->governorate_id = $this->updateData->governorate_id;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $data = get_Columns_where_row(new City, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $CheckExsists = City::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableCities')->to(CitiesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        $other['governorates'] = Governorate::all();

        return view('dashboard.settings.cities.cities-update', compact('other'));
    }
}
