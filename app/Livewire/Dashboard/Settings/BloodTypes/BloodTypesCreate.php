<?php

namespace App\Livewire\Dashboard\Settings\BloodTypes;

use Livewire\Component;
use App\Models\BloodType;
use App\Http\Requests\Dashboard\BloodTypeRequest;

class BloodTypesCreate extends Component
{
    public $name,$active;


    public function rules()
    {
        return (new BloodTypeRequest())->rules();
    }


    public function messages()
    {
        return (new BloodTypeRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $CheckExsists = get_Columns_where_row(new BloodType(), array("id"), array("com_code" => $com_code, 'name' => $this->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }

            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            BloodType::create($dataCreate);
            $this->reset(['name']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableBloodTypes')->to(BloodTypesTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');
    }


    
    public function render()
    {
 
        return view('dashboard.settings.bloodTypes.blood-types-create');
    }
}