<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\VacationRequest;
use App\Models\Employee;
use App\Models\VacationType;
use Illuminate\Support\Facades\DB;

class VacationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new VacationType, ['*'], ['com_code' => $com_code], 'id', 'ASC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $info->id]);
            }
        }

        return view('dashboard.settings.vacationsTypes.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.vacationsTypes.create');
    }

    public function store(VacationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new VacationType, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new VacationType, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.vacationsTypes.index')->with(['success' => 'تم ادخل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new VacationType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }

            return view('dashboard.settings.vacationsTypes.edit', ['data' => $data]);
        } catch (\Exception $ex) {
            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }

    public function update($id, VacationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new VacationType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }
            $CheckExsists = VacationType::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !'])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new VacationType, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.vacationsTypes.index')->with(['success' => '  تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new VacationType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new VacationType, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.vacationsTypes.index')->with(['success' => '  تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.vacationsTypes.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }
}
