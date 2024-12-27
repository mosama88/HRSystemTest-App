<?php

namespace App\Livewire\Dashboard\Settings\Resignations;

use App\Http\Requests\Dashboard\ResignationRequest;
use App\Models\Resignation;
use Livewire\Component;

class ResignationsUpdate extends Component
{
    public $updateData;

    public $name;

    public $active;

    protected $listeners = ['editResignations'];

    public function rules()
    {
        return (new ResignationRequest)->rules();
    }

    public function messages()
    {
        return (new ResignationRequest)->messages();
    }

    public function editResignations($id)
    {
        $this->updateData = Resignation::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Resignation, ['*'], ['com_code' => $com_code, 'id' => $this->updateData->id]);
        if (empty($data)) {
            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
        }
        $CheckExsists = Resignation::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !'])->withInput();
        }
        $updatedData = $this->validate();
        $this->updateData['updated_by'] = auth()->user()->id;
        $this->updateData['com_code'] = $com_code;
        $this->updateData->update($updatedData);
        $this->dispatch('updateModalToggle');
        $this->dispatch('refreshTableResignation')->to(ResignationsTable::class);
        session()->flash('message', 'تم تعديل البيانات بنجاح');

    }

    public function render()
    {
        return view('dashboard.settings.resignations.resignations-update');
    }
}
