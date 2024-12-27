<?php

namespace App\Livewire\Dashboard\Settings\VacationsTypes;

use App\Http\Requests\Dashboard\VacationRequest;
use App\Models\VacationType;
use Livewire\Component;

class VacationsTypesUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editvacationsTypes'];

    public function rules()
    {
        return (new VacationRequest)->rules();
    }

    public function messages()
    {
        return (new VacationRequest)->messages();
    }

    public function editvacationsTypes($id)
    {
        $this->updateData = VacationType::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new VacationType, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
        }
        $CheckExsists = VacationType::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !'])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableVacationsTypes')->to(VacationsTypesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.vacationsTypes.vacations-types-update');
    }
}
