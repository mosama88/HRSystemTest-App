<?php

namespace App\Livewire\Dashboard\Settings\BloodTypes;

use App\Http\Requests\Dashboard\BloodTypeRequest;
use App\Models\BloodType;
use Livewire\Component;

class BloodTypesUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editBloodTypes'];

    public function rules()
    {
        return (new BloodTypeRequest)->rules();
    }

    public function messages()
    {
        return (new BloodTypeRequest)->messages();
    }

    public function editBloodTypes($id)
    {
        $this->updateData = BloodType::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $data = get_Columns_where_row(new BloodType, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.bloodTypes.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        $CheckExsists = BloodType::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }

        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableBloodTypes')->to(BloodTypesTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.bloodTypes.blood-types-update');
    }
}
