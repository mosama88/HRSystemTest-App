<?php

namespace App\Livewire\Dashboard\Settings\Holidays;

use App\Models\Holiday;
use Livewire\Component;
use App\Http\Requests\Dashboard\HolidayRequest;

class HolidaysCreate extends Component
{

    public $name,$from_date,$to_date,$days_counter,$active;


    public function rules()
    {
        return (new HolidayRequest())->rules();
    }


    public function messages()
    {
        return (new HolidayRequest())->messages();
    }



    public function submit()
    {

            $com_code = auth()->user()->com_code;

            $dataCreate = $this->validate();
            $checkExsists = get_Columns_where_row(new Holiday(), array("id"), array("com_code" => $com_code, "name" => $this->name));
            if (!empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  هذا الاسم مسجل من قبل '])->withInput();
            }
            $dataCreate['active'] = 1;
            $dataCreate['created_by'] = auth()->user()->id;
            $dataCreate['com_code'] = $com_code;
            Holiday::create($dataCreate);
            $this->reset(['name', 'from_date', 'to_date', 'days_counter']);
            $this->dispatch('createModalToggle');
            $this->dispatch('refreshTableHolidays')->to(HolidaysTable::class);
            session()->flash('message', 'تم إضافة البيانات بنجاح');
    }


    
    public function render()
    {
        return view('dashboard.settings.holidays.holidays-create');
    }
}