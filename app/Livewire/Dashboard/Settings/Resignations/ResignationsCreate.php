<?php

namespace App\Livewire\Dashboard\Settings\Resignations;

use App\Http\Requests\Dashboard\ResignationRequest;
use App\Models\Resignation;
use Livewire\Component;

class ResignationsCreate extends Component
{
    public $name;

    public $active;

    public function rules()
    {
        return (new ResignationRequest)->rules();
    }

    public function messages()
    {
        return (new ResignationRequest)->messages();
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;

        $dataCreate = $this->validate();
        $CheckExsists = get_Columns_where_row(new Resignation, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($CheckExsists)) {
            return redirect()->back()->with(['error' => 'عفوا الاسم مسجل من قبل '])->withInput();
        }

        $dataCreate['active'] = 1;
        $dataCreate['created_by'] = auth()->user()->id;
        $dataCreate['com_code'] = $com_code;
        Resignation::create($dataCreate);
        $this->reset(['name']);
        $this->dispatch('createModalToggle');
        $this->dispatch('refreshTableResignation')->to(ResignationsTable::class);
        session()->flash('message', 'تم إضافة البيانات بنجاح');
    }

    public function render()
    {
        return view('dashboard.settings.resignations.resignations-create');
    }
}
