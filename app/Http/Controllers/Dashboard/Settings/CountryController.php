<?php

namespace App\Http\Controllers\Dashboard\Settings;
use App\Models\Country;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\CountryRequest;

class CountryController extends Controller
{
    
    
    public function __construct()
    {
        $this->middleware('permission:البلاد', ['only' => ['index']]);
        $this->middleware('permission:اضافة البلاد', ['only' => ['create','store']]);
        $this->middleware('permission:تعديل البلاد', ['only' => ['update','edit']]);
        $this->middleware('permission:حذف البلاد', ['only' => ['destroy']]);
    }


    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Country(), array("*"), array("com_code" => $com_code), 'id', 'DESC')->get();
        if (!empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "country_id" => $info->id));
            }
        }
        return view('dashboard.settings.countries.index', ['data' => $data]);
    }

    public function create()
    {
        $com_code = auth()->user()->com_code;
        return view('dashboard.settings.countries.create');
    }

    public function store(CountryRequest $request)
    {
        try {

            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new Country(), array("id"), array("com_code" => $com_code, 'name' => $request->name));
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new Country(), $DataToInsert);
            DB::commit();
            return redirect()->route('dashboard.countries.index')->with(['success' => 'تم تسجيل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا  حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Country(), array("*"), array("com_code" => $com_code, 'id' => $id));
        if (empty($data)) {
            return redirect()->route('dashboard.countries.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }
        return view('dashboard.settings.countries.edit', ['data' => $data]);
    }

    public function update($id, CountryRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Country(), array("*"), array("com_code" => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.countries.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = Country::select("id")->where("com_code", "=", $com_code)->where("name", "=", $request->name)->where('id', '!=', $id)->first();
            if (!empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToUpdate['name'] = $request->name;
            $DataToUpdate['active'] = $request->active;
            $DataToUpdate['updated_by'] = auth()->user()->id;
            update(new Country(), $DataToUpdate, array("com_code" => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.countries.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }
    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Country(), array("*"), array("com_code" => $com_code, 'id' => $id));
            if (empty($data)) {
                return redirect()->route('dashboard.countries.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $counterUsed = get_count_where(new Employee(), array("com_code" => $com_code, "country_id" => $id));
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.countries.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }
            DB::beginTransaction();
            destroy(new Country(), array("com_code" => $com_code, 'id' => $id));
            DB::commit();
            return redirect()->route('dashboard.countries.index')->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();
            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  ' . $ex->getMessage()])->withInput();
        }
    }
}
