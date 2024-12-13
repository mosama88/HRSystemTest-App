<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Models\City;
use App\Models\Employee;
use App\Models\Governorate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\CityRequest;

class CityController extends Controller
{
  
    
    public function __construct()
    {
        $this->middleware('permission:المنطقه', ['only' => ['index']]);
        $this->middleware('permission:اضافة المنطقه', ['only' => ['create','store']]);
        $this->middleware('permission:تعديل المنطقه', ['only' => ['update','edit']]);
        $this->middleware('permission:حذف المنطقه', ['only' => ['destroy']]);
    }


    public function index()
    {
        $com_code = auth()->user()->com_code;
        $other['governorates'] = Governorate::all();
        $data = getColumnsIndex(new City(), array("*"), array("com_code" => $com_code), 'id', 'DESC')->get();
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "city_id" => $info->id));
            }
        }
        return view('dashboard.settings.cities.index', ['data' => $data,'other'=>$other]);
    }

    public function create()
    {
        $com_code = auth()->user()->com_code;
        return view('dashboard.settings.cities.create');
    }


    public function show(string $id)
    {
        //
    }


    public function store(CityRequest $request)
    {
        try {

            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new City(), array("id"), array("com_code" => $com_code, 'name' => $request->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['governorate_id'] = $request->governorate_id;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new City(), $DataToInsert);
            DB::commit();
            return redirect()->route('dashboard.cities.index')->with(['success' => 'تم تسجيل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا  حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new City(), array("*"), array("com_code" => $com_code, 'id' => $id));
        if (empty($data)) {
            return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        return view('dashboard.settings.cities.edit', ['data' => $data]);
    }

    public function update($id, CityRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new City(), array("*"), array("com_code" => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = City::select("id")->where("com_code", "=", $com_code)->where("name", "=", $request->name)->where('id', '!=', $id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToUpdate['name'] = $request->name;
            $DataToUpdate['governorate_id'] = $request->governorate_id;
            $DataToUpdate['active'] = $request->active;
            $DataToUpdate['updated_by'] = auth()->user()->id;
            update(new City(), $DataToUpdate, array("com_code" => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.cities.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }
    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new City(), array("*"), array("com_code" => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "city_id" => $id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.cities.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new City(), array("com_code" => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.cities.index')->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }


    public function gevernrateIndex()
    {
        $data = getColumnsIndex(new Governorate(), array("*"), array(), 'id', 'DESC')->get();
        return view('dashboard.governorates.index', ['data' => $data]);
    }
}
