<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\NationalityRequest;
use App\Models\Employee;
use App\Models\Nationality;
use Illuminate\Support\Facades\DB;

class NationalityController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:الجنسيات', ['only' => ['index']]);
        $this->middleware('permission:اضافة الجنسيات', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الجنسيات', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الجنسيات', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Nationality, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'nationality_id' => $info->id]);
            }
        }

        return view('dashboard.settings.nationalities.index', ['data' => $data]);
    }

    public function create()
    {
        $com_code = auth()->user()->com_code;

        return view('dashboard.settings.nationalities.create');
    }

    public function store(NationalityRequest $request)
    {
        try {

            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new Nationality, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new Nationality, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.nationalities.index')->with(['success' => 'تم تسجيل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا  حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Nationality, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }

        return view('dashboard.settings.nationalities.edit', ['data' => $data]);
    }

    public function update($id, NationalityRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Nationality, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = Nationality::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToUpdate['name'] = $request->name;
            $DataToUpdate['active'] = $request->active;
            $DataToUpdate['updated_by'] = auth()->user()->id;
            update(new Nationality, $DataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.nationalities.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Nationality, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'nationality_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.nationalities.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new Nationality, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.nationalities.index')->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }
}
