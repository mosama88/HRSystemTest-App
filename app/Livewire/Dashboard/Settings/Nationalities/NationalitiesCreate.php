<?php

namespace App\Livewire\Dashboard\Settings\Nationalities;

use Livewire\Component;
use App\Models\Nationality;
use App\Http\Requests\Dashboard\NationalityRequest;

class NationalitiesCreate extends Component
{


    public $name,$active;


    public function rules()
    {
        return (new NationalityRequest())->rules();
    }


    public function messages()
    {
        return (new NationalityRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $CheckExsists = get_Columns_where_row(new Nationality(), array("id"), array("com_code" => $com_code, 'name' => $this->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }

            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            Nationality::create($dataCreate);
            $this->reset(['name']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableNationalities')->to(NationalitiesTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');
    }


    
    public function render()
    {
        return view('dashboard.settings.nationalities.nationalities-create');
    }
}