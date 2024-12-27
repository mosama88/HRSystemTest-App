<?php

namespace App\Http\Controllers\Dashboard\AffairsEmployees;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\DiscountTypeRequest;
use App\Models\DiscountType;
use App\Models\EmployeeSalaryDiscount;
use Illuminate\Support\Facades\DB;

class DiscountTypeController extends Controller
{
    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new DiscountType, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new EmployeeSalaryDiscount, ['com_code' => $com_code, 'discount_types_id' => $info->id]);
            }
        }

        return view('dashboard.affairs_employees.discount_types.index', ['data' => $data]);
    }

    public function create()
    {
        $com_code = auth()->user()->com_code;

        return view('dashboard.affairs_employees.discount_types.create');
    }

    public function store(DiscountTypeRequest $request)
    {
        try {

            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new DiscountType, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToInsert['name'] = $request->name;
            $DataToInsert['active'] = $request->active;
            $DataToInsert['created_by'] = auth()->user()->id;
            $DataToInsert['com_code'] = $com_code;
            insert(new DiscountType, $DataToInsert);
            DB::commit();

            return redirect()->route('dashboard.discount_types.index')->with(['success' => 'تم تسجيل البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا  حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new DiscountType, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.discount_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
        }

        return view('dashboard.affairs_employees.discount_types.edit', ['data' => $data]);
    }

    public function update($id, DiscountTypeRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new DiscountType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.discount_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }
            $CheckExsists = DiscountType::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا هذا الاسم مسجل من قبل '])->withInput();
            }
            DB::beginTransaction();
            $DataToUpdate['name'] = $request->name;
            $DataToUpdate['active'] = $request->active;
            $DataToUpdate['updated_by'] = auth()->user()->id;
            update(new DiscountType, $DataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.discount_types.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new DiscountType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.discount_types.index')->with(['error' => 'عفوا غير قادر للوصول الي البيانات المطلوبة']);
            }

            $counterUsed = get_count_where(new EmployeeSalaryDiscount, ['com_code' => $com_code, 'discount_types_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            DB::beginTransaction();
            destroy(new DiscountType, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.discount_types.index')->with(['success' => 'تم الحذف  البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ  '.$ex->getMessage()])->withInput();
        }
    }
}
