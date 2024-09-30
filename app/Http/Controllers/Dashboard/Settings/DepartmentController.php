<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Models\Department;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\DepartmentRequest;

class DepartmentController extends Controller
{
  
    
    
    public function __construct()
    {
        $this->middleware('permission:الأدارات', ['only' => ['index']]);
        $this->middleware('permission:اضافة الأدارات', ['only' => ['create','store']]);
        $this->middleware('permission:تعديل الأدارات', ['only' => ['update','edit']]);
        $this->middleware('permission:حذف الأدارات', ['only' => ['destroy']]);
    }


    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Department(), array("*"), array('com_code' => $com_code), 'id', 'DESC')->get();
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "department_id" => $info->id));
            }
        }
        return view('dashboard.settings.departments.index', ['data' => $data]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('dashboard.settings.Departments.create');
    }

    public function store(DepartmentRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new Department(), array('id'), array("com_code" => $com_code, 'name' => $request->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا اسم الادارة مسجل من قبل !'])->withInput();
            }
            DB::beginTransaction();
            $dataToinsert['name'] = $request->name;
            $dataToinsert['phones'] = $request->phones;
            $dataToinsert['notes'] = $request->notes;
            $dataToinsert['active'] = $request->active;
            $dataToinsert['created_by'] = auth()->user()->id;
            $dataToinsert['com_code'] = $com_code;
            insert(new Department(), $dataToinsert);
            DB::commit();
            return  redirect()->route('dashboard.departments.index')->with(['success' => 'تم ادخال البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما ' . $ex->getMessage()])->withInput();
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
    }

    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Department(), array("*"), array('com_code' => $com_code, 'id' => $id));
        if (empty($data)) {
            return redirect()->route('dashboard.departments.index')->with(['error' => 'عفوا غير قادر الي الوصول البي البيانات المطلوبة !']);
        }
        return view('dashboard.settings.Departments.edit', ['data' => $data]);
    }
    public function update($id, DepartmentRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Department(), array("*"), array('com_code' => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.departments.index')->with(['error' => 'عفوا غير قادر الي الوصول البي البيانات المطلوبة !']);
            }
            $CheckExsists = Department::select("id")->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا اسم الادارة مسجل من قبل !'])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['phones'] = $request->phones;
            $dataToUpdate['notes'] = $request->notes;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new Department(), $dataToUpdate, array('com_code' => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.departments.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما ' . $ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Department(), array("*"), array('com_code' => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.departments.index')->with(['error' => 'عفوا غير قادر الي الوصول البي البيانات المطلوبة !']);
            }
            $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "department_id" => $id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.departments.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new Department(), array('com_code' => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.departments.index')->with(['success' => 'تم حذف البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما ' . $ex->getMessage()])->withInput();
        }
    }
}
