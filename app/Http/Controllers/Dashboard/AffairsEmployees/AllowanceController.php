<?php

namespace App\Http\Controllers\Dashboard\AffairsEmployees;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\AllowanceRequest;
use App\Models\Allowance;
use App\Models\EmployeeFixedAllowance;
use Illuminate\Support\Facades\DB;

class AllowanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Allowance, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();

        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new EmployeeFixedAllowance, ['com_code' => $com_code, 'allowance_id' => $info->id]);
            }
        }

        return view('dashboard.affairs_employees.allowances.index', ['data' => $data]);
    }

    public function create()
    {
        $com_code = auth()->user()->com_code;

        return view('dashboard.affairs_employees.allowances.create');
    }

    public function store(AllowanceRequest $request)
    {
        try {

            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new Allowance, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new Allowance, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.allowances.index')->with(['success' => 'تم تسجيل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا  حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new Allowance, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.allowances.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }

        return view('dashboard.affairs_employees.allowances.edit', ['data' => $data]);
    }

    public function update($id, AllowanceRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Allowance, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.allowances.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = Allowance::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToUpdate['name'] = $request->name;
            $DataToUpdate['active'] = $request->active;
            $DataToUpdate['updated_by'] = auth()->user()->id;
            update(new Allowance, $DataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.allowances.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Allowance, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.allowances.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }

            $counterUsed = get_count_where(new EmployeeFixedAllowance, ['com_code' => $com_code, 'allowance_id' => $id]);

            if ($counterUsed > 0) {
                return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            DB::beginTransaction();
            destroy(new Allowance, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.allowances.index')->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }
}
