<?php

namespace App\Livewire\Dashboard\Settings\Qualifications;

use Livewire\Component;
use App\Models\Qualification;
use App\Http\Requests\Dashboard\QualificationRequest;

class QualificationsUpdate extends Component
{
    public $updateData;
    public $name,$active;

    protected $listeners = ['editQualifications'];

    public function rules()
    {
        return (new QualificationRequest())->rules();
    }

    public function messages()
    {
        return (new QualificationRequest())->messages();
    }


    public function editQualifications($id)
    {
        $this->updateData = Qualification::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Qualification(), array("*"), array("com_code" => $com_code, 'id' => $this->updateData->id));
            if (empty($data)) {
                return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة !']);
            }
            $checkExsists = Qualification::select("id")->where("com_code", "=", $com_code)->where("name", "=", $this->name)->where("id", "!=", $this->updateData->id)->first();
            if (!empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذه الاسم مسجل من قبل '])->withInput();
            }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableQualification')->to(QualificationsTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    
    }

    public function render()
    {
        return view('dashboard.settings.qualifications.qualifications-update');
    }
}