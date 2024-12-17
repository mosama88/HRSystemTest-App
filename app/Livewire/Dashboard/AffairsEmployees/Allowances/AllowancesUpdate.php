<?php

namespace App\Livewire\Dashboard\AffairsEmployees\Allowances;

use Livewire\Component;
use App\Models\Allowance;
use App\Http\Requests\Dashboard\AllowanceRequest;

class AllowancesUpdate extends Component
{

    public $updateData;
    public $name,$active;

    protected $listeners = ['editAllowances'];

    public function rules()
    {
        return (new AllowanceRequest())->rules();
    }

    public function messages()
    {
        return (new AllowanceRequest())->messages();
    }


    public function editAllowances($id)
    {
        $this->updateData = Allowance::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Allowance(), array("*"), array("com_code" => $com_code, 'id' => $this->updateData->id));
            if (empty($data)) {
                return redirect()->route('dashboard.allowances.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = Allowance::select("id")->where("com_code", "=", $com_code)->where("name", "=", $this->name)->where("id", "!=", $this->updateData->id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableAllowances')->to(AllowancesTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    
    }



    public function render()
    {
        return view('dashboard.affairs_employees.allowances.allowances-update');
    }
}
