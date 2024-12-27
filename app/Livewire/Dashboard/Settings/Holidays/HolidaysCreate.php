<?php

namespace App\Livewire\Dashboard\Settings\Holidays;

use App\Http\Requests\Dashboard\HolidayRequest;
use App\Models\Holiday;
use DateTime;
use Livewire\Component;

class HolidaysCreate extends Component
{
    public $name;

    public $from_date;

    public $to_date;

    public $days_counter;

    public $active;

    public function rules()
    {
        return (new HolidayRequest)->rules();
    }

    public function messages()
    {
        return (new HolidayRequest)->messages();
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
        if ($this->days_counter > 0) {
            return $this->days_counter;
        } else {
            $this->days_counter = 0;
        }
    }

    public function submit()
    {

        $com_code = auth()->user()->com_code;
        $dataCreate = $this->validate();
        $checkExsists = get_Columns_where_row(new Holiday, ['id'], ['com_code' => $com_code, 'name' => $this->name]);
        if (! empty($checkExsists)) {
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
