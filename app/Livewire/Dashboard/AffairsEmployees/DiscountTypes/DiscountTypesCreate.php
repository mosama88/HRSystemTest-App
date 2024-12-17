<?php

namespace App\Livewire\Dashboard\AffairsEmployees\DiscountTypes;

use Livewire\Component;
use App\Models\DiscountType;
use App\Http\Requests\Dashboard\DiscountTypeRequest;

class DiscountTypesCreate extends Component
{


    public $name,$active;


    public function rules()
    {
        return (new DiscountTypeRequest())->rules();
    }


    public function messages()
    {
        return (new DiscountTypeRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $CheckExsists = get_Columns_where_row(new DiscountType(), array("id"), array("com_code" => $com_code, 'name' => $this->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            DiscountType::create($dataCreate);
            $this->reset(['name']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableDiscount_types')->to(DiscountTypesTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');
    }


    public function render()
    {
        return view('dashboard.affairs_employees.discount_types.discount-types-create');
    }
}
