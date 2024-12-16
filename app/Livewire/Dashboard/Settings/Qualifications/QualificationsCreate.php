<?php

namespace App\Livewire\Dashboard\Settings\Qualifications;

use Livewire\Component;
use App\Models\Qualification;
use App\Http\Requests\Dashboard\QualificationRequest;

class QualificationsCreate extends Component
{

    public $name,$active;


    public function rules()
    {
        return (new QualificationRequest())->rules();
    }


    public function messages()
    {
        return (new QualificationRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $com_code = auth()->user()->com_code;
            $checkExsists = get_Columns_where_row(new Qualification(), array("id"), array("name" => $this->name, "com_code" => $com_code));
            if (!empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !!'])->withInput();
            }

            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            Qualification::create($dataCreate);
            $this->reset(['name']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableQualification')->to(QualificationsTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');
    }


    
    public function render()
    {
        return view('dashboard.settings.qualifications.qualifications-create');
    }
}