<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\ShiftsTypeRequest;
use App\Models\Employee;
use App\Models\ShiftsType;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ShiftsTypeController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:الشفتات', ['only' => ['index']]);
        $this->middleware('permission:اضافة الشفتات', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الشفتات', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الشفتات', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new ShiftsType, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'shift_types_id' => $info->id]);
            }
        }

        return view('dashboard.settings.shiftsTypes.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('dashboard.settings.shiftsTypes.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ShiftsTypeRequest $request)
    {
        try {
            DB::beginTransaction();
            $ShiftsType['com_code'] = auth()->user()->com_code;
            $ShiftsType['type'] = $request->type;
            $ShiftsType['from_time'] = $request->from_time;
            $ShiftsType['to_time'] = $request->to_time;
            $ShiftsType['total_hours'] = $request->total_hours;

            $checkExists = get_Columns_where_row(new ShiftsType, ['id'], $ShiftsType);
            if (! empty($checkExists)) {
                return redirect()->back()->with(['error', 'عفوآ هذه البيانات مسجله من قبل !'])->withInput();
            }

            $ShiftsType['active'] = $request->active;
            $ShiftsType['created_by'] = auth()->user()->id;

            insert(new ShiftsType, $ShiftsType);

            DB::commit();
            session()->flash('success', 'تم أضافة البيانات بنجاح');

            return redirect()->route('dashboard.shiftsTypes.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: '.$e->getMessage()]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $com_code = auth()->user()->com_code;
        $info = get_Columns_where_row(new ShiftsType, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->back()->with(['error', 'عفوآ هذه البيانات مسجله من قبل !'])->withInput();
        }

        return view('dashboard.settings.shiftsTypes.edit', compact('info'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ShiftsTypeRequest $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;

            $data = get_Columns_where_row(new ShiftsType, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->back()->with(['error', 'عفوآ هذه البيانات مسجله من قبل !'])->withInput();
            }

            $checkExists = ShiftsType::select('id')
                ->where('type', $request->type)
                ->where('from_time', $request->from_time)
                ->where('to_time', $request->to_time)->where('id', '!=', $id)
                ->first();
            if (! empty($checkExists)) {
                return redirect()->back()->with(['error', 'عفوآ هذه البيانات مسجله من قبل !'])->withInput();
            }

            DB::beginTransaction();

            $dataToUpdate['type'] = $request->type;
            $dataToUpdate['from_time'] = $request->from_time;
            $dataToUpdate['to_time'] = $request->to_time;
            $dataToUpdate['total_hours'] = $request->total_hours;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            $dataToUpdate['com_code'] = $com_code;
            $dataToUpdate['active'] = $request->active;

            $flag = update(new ShiftsType, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            if ($flag) {
                $dataToUpdateEmployee['daily_work_hour'] = $dataToUpdate['total_hours'];
                $flag = update(new Employee, $dataToUpdateEmployee, ['com_code' => $com_code, 'has_fixed_shift' => 'Yes', 'shift_types_id' => $id]);
            }
            DB::commit();
            session()->flash('success', 'تم تعديل البيانات بنجاح');

            return redirect()->route('dashboard.shiftsTypes.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء تعديل البيانات : '.$e->getMessage()]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new ShiftsType, ['*'], ['id' => $id, 'com_code' => $com_code]);
            if (empty($data)) {
                return redirect()->route('dashboard.shiftsTypes.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
            }

            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'shift_types_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.shiftsTypes.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            destroy(new ShiftsType, ['id' => $id, 'com_code' => $com_code]);

            DB::commit();
            session()->flash('success', 'تم حذف البيانات بنجاح');

            return redirect()->route('dashboard.shiftsTypes.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: '.$e->getMessage()]);
        }
    }

    public function ajax_search(Request $request)
    {
        if ($request->ajax()) {
            $type_search = $request->type_search;
            $from_hour_search = $request->from_hour_search;
            $to_hour_search = $request->to_hour_search;
            if ($type_search == 'all') {
                //هنا نعمل شرط دائم التحقق
                $field1 = 'id';
                $operator1 = '>';
                $value1 = 0;
            } else {
                $field1 = 'type';
                $operator1 = '=';
                $value1 = $type_search;
            }
            if ($from_hour_search == '') {
                //هنا نعمل شرط دائم التحقق
                $field2 = 'id';
                $operator2 = '>';
                $value2 = 0;
            } else {
                $field2 = 'total_hour';
                $operator2 = '>=';
                $value2 = $from_hour_search;
            }
            if ($to_hour_search == '') {
                //هنا نعمل شرط دائم التحقق
                $field3 = 'id';
                $operator3 = '>';
                $value3 = 0;
            } else {
                $field3 = 'total_hour';
                $operator3 = '<=';
                $value3 = $to_hour_search;
            }
            $data = ShiftsType::select('*')->where($field1, $operator1, $value1)->where($field2, $operator2, $value2)->where($field3, $operator3, $value3)->orderby('id', 'DESC')->paginate();

            return view('dashboard.settings.shiftsTypes.index', ['data' => $data]);
        }
    }
}
