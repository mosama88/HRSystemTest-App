<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\QualificationRequest;
use App\Models\Employee;
use App\Models\Qualification;
use Illuminate\Support\Facades\DB;

class QualificationController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:المؤهل', ['only' => ['index']]);
        $this->middleware('permission:اضافة المؤهل', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل المؤهل', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف المؤهل', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Qualification, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'qualification_id' => $info->id]);
            }
        }

        return view('dashboard.settings.qualifications.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.qualifications.create');
    }

    public function store(QualificationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $checkExsists = get_Columns_where_row(new Qualification, ['id'], ['name' => $request->name, 'com_code' => $com_code]);
            if (! empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل !!'])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->com_code;
            $DataToInsert['com_code'] = $com_code;
            insert(new Qualification, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.qualifications.index')->with(['success' => 'تم ادخال البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Qualification, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة !']);
        }

        return view('dashboard.settings.qualifications.edit', ['data' => $data]);
    }

    public function update($id, QualificationRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Qualification, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة !']);
            }
            $checkExsists = Qualification::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($checkExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذه الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new Qualification, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.qualifications.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Qualification, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة !']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'qualification_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.qualifications.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new Qualification, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.qualifications.index')->with(['success' => 'تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ '.$ex->getMessage()]);
        }
    }
}
