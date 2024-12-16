<?php

namespace App\Livewire\Dashboard\Settings\Holidays;

use DateTime;
use App\Models\Holiday;
use Livewire\Component;
use App\Http\Requests\Dashboard\HolidayRequest;

class HolidaysUpdate extends Component
{

    public $updateData;
    public $name,$from_date,$to_date,$days_counter,$active;

    protected $listeners = ['editHolidays'];

    public function rules()
    {
        return (new HolidayRequest())->rules();
    }

    public function messages()
    {
        return (new HolidayRequest())->messages();
    }



    public function updated()
    {
        if ($this->from_date && $this->to_date) {

            $this->CalcDiffDays();
        }
    }

    public function CalcDiffDays()
    {

        $from_date_format = new DateTime($this->from_date);
        $to_date_format = new DateTime($this->to_date);


       // حساب الفرق بين التاريخين
       $interval = $from_date_format->diff($to_date_format);

       // الحصول على الفرق بالأيام
       $this->days_counter = $interval->days + 1;
       if ($this->days_counter  > 0) {
            return $this->days_counter;
        } else {
            $this->days_counter = 0;
        }
    }

    public function editHolidays($id)
    {
        $this->updateData = Holiday::findOrFail($id);
        $this->name = $this->updateData->name;
        $this->from_date = $this->updateData->from_date;
        $this->to_date = $this->updateData->to_date;
        $this->days_counter = $this->updateData->days_counter;
        $this->active = $this->updateData->active;
        $this->resetValidation();
        $this->dispatch('updateModalToggle');
    }


    public function submit()
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Holiday(), array("*"), array("com_code" => $com_code, "id" => $this->updateData->id));
        if (empty($data)) {
            return redirect()->route('dashboard.holidays.index')->with(['error' => 'عفوا هذه البيانات غير موجوده']);
        }
        $checkExsists = Holiday::select('id')->where('com_code', '=', $com_code)->where('name', '=', $this->name)->where('id', '!=', $this->updateData->id)->first();
        if (!empty($checkExsists)) {
            return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
        }
            $updatedData = $this->validate();
            $this->updateData['updated_by'] = auth()->user()->id;
            $this->updateData['com_code'] = $com_code;
            $this->updateData->update($updatedData);
            $this->dispatch('updateModalToggle');
            $this->dispatch('refreshTableHolidays')->to(HolidaysTable::class);
            session()->flash('message', 'تم تعديل البيانات بنجاح');
    }

    
    public function render()
    {
        return view('dashboard.settings.holidays.holidays-update');
    }
}