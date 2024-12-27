<?php

namespace App\Livewire\Dashboard\Settings\Nationalities;

use App\Http\Requests\Dashboard\NationalityRequest;
use App\Models\Nationality;
use Livewire\Component;

class NationalitiesUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editNationalities'];

    public function rules()
    {
        return (new NationalityRequest)->rules();
    }

    public function messages()
    {
        return (new NationalityRequest)->messages();
    }

    public function editNationalities($id)
    {
        $this->updateData = Nationality::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Nationality, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $CheckExsists = Nationality::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableNationalities')->to(NationalitiesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.nationalities.nationalities-update');
    }
}
