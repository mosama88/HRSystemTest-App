<?php

namespace App\Livewire\Dashboard\Settings\Governorates;

use App\Http\Requests\Dashboard\GovernorateRequest;
use App\Models\Country;
use App\Models\Governorate;
use Livewire\Component;

class GovernoratesUpdate extends Component
{
    public $updateData;

    public $name;

    public $country_id;

    public $active;

    protected $listeners = ['editGovernorates'];

    public function rules()
    {
        return (new GovernorateRequest)->rules();
    }

    public function messages()
    {
        return (new GovernorateRequest)->messages();
    }

    public function editGovernorates($id)
    {
        $this->updateData = Governorate::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->country_id = $this->updateData->country_id;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $data = get_Columns_where_row(new Governorate, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $CheckExsists = Governorate::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableGovernorates')->to(GovernoratesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        $other['countries'] = Country::all();

        return view('dashboard.settings.governorates.governorates-update', compact('other'));
    }
}
