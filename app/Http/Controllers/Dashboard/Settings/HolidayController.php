<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\HolidayRequest;
use App\Models\Holiday;
use Illuminate\Support\Facades\DB;

class HolidayController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:العطلات الرسمية', ['only' => ['index']]);
        $this->middleware('permission:اضافة العطلات الرسمية', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل العطلات الرسمية', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف العطلات الرسمية', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Holiday, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();

        return view('dashboard.settings.holidays.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.holidays.create');
    }

    public function store(HolidayRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $checkExsists = get_Columns_where_row(new Holiday, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $dataToInsert['name'] = $request->name;
            $dataToInsert['from_date'] = $request->from_date;
            $dataToInsert['to_date'] = $request->to_date;
            /*$timeDiffrence=abs((strtotime($dataToInsert['to_date'])-strtotime($dataToInsert['from_date'])));
$dataToInsert['days_counter']=intval($timeDiffrence/86400);
*/
            $dataToInsert['days_counter'] = $request->days_counter;
            $dataToInsert['active'] = $request->active;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;
            insert(new Holiday, $dataToInsert);
            DB::commit();

            return redirect()->route('dashboard.holidays.index')->with(['success' => 'تم ادخال البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Holiday, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.holidays.index')->with(['error' => 'عفوا هذه البيانات غير موجوده']);
        }

        return view('dashboard.settings.holidays.edit', ['data' => $data]);
    }

    public function update($id, HolidayRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Holiday, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.holidays.index')->with(['error' => 'عفوا هذه البيانات غير موجوده']);
            }
            $checkExsists = Holiday::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['from_date'] = $request->from_date;
            $dataToUpdate['to_date'] = $request->to_date;
            $dataToUpdate['days_counter'] = $request->days_counter;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new Holiday, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.holidays.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Holiday, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.holidays.index')->with(['error' => 'عفوا هذه البيانات غير موجوده']);
            }
            DB::beginTransaction();
            destroy(new Holiday, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.holidays.index')->with(['success' => 'تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.holidays.index')->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()]);
        }
    }
}
