<?php

namespace App\Livewire\Dashboard\AffairsEmployees\AdditionalTypes;

use App\Http\Requests\Dashboard\AdditionalTypeRequest;
use App\Models\AdditionalType;
use Livewire\Component;

class AdditionalTypesUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editAdditionalTypes'];

    public function rules()
    {
        return (new AdditionalTypeRequest)->rules();
    }

    public function messages()
    {
        return (new AdditionalTypeRequest)->messages();
    }

    public function editAdditionalTypes($id)
    {
        $this->updateData = AdditionalType::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new AdditionalType, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.additional_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $CheckExsists = AdditionalType::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableAdditionalType')->to(AdditionalTypesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.affairs_employees.additional_types.additional-types-update');
    }
}
