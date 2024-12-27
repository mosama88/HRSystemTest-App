<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\ResignationRequest;
use App\Models\Employee;
use App\Models\Resignation;
use Illuminate\Support\Facades\DB;

class ResignationController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:الأستقالة', ['only' => ['index']]);
        $this->middleware('permission:اضافة الأستقالة', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الأستقالة', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الأستقالة', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Resignation, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $info->id]);
            }
        }

        return view('dashboard.settings.resignations.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.resignations.create');
    }

    public function store(ResignationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new Resignation, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new Resignation, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.resignations.index')->with(['success' => 'تم ادخل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Resignation, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }

            return view('dashboard.settings.resignations.edit', ['data' => $data]);
        } catch (\Exception $ex) {
            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }

    public function update($id, ResignationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Resignation, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }
            $CheckExsists = Resignation::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !'])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new Resignation, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.resignations.index')->with(['success' => '  تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Resignation, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا غير قادر للوصول للبيانات المطلوبة !']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'resignation_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new Resignation, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.resignations.index')->with(['success' => '  تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.resignations.index')->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }
}
