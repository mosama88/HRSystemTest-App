<?php

namespace App\Livewire\Dashboard\AffairsEmployees\DiscountTypes;

use Livewire\Component;
use App\Models\DiscountType;
use App\Http\Requests\Dashboard\DiscountTypeRequest;

class DiscountTypesUpdate extends Component
{

    public $updateData;
    public $name,$active;

    protected $listeners = ['editDiscountTypes'];

    public function rules()
    {
        return (new DiscountTypeRequest())->rules();
    }

    public function messages()
    {
        return (new DiscountTypeRequest())->messages();
    }


    public function editDiscountTypes($id)
    {
        $this->updateData = DiscountType::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new DiscountType(), array("*"), array("com_code" => $com_code, 'id' => $this->updateData->id));
            if (empty($data)) {
                return redirect()->route('dashboard.discount_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = DiscountType::select("id")->where("com_code", "=", $com_code)->where("name", "=", $this->name)->where("id", "!=", $this->updateData->id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableDiscount_types')->to(DiscountTypesTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    
    }



    public function render()
    {
        return view('dashboard.affairs_employees.discount_types.discount-types-update');
    }
}
