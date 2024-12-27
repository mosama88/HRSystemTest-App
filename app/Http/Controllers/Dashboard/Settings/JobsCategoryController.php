<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\JobsCategoryRequest;
use App\Models\Employee;
use App\Models\JobsCategory;
use Illuminate\Support\Facades\DB;

class JobsCategoryController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:الوظائف', ['only' => ['index']]);
        $this->middleware('permission:اضافة الوظائف', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الوظائف', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الوظائف', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new JobsCategory, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_categories_id' => $info->id]);
            }
        }

        return view('dashboard.settings.jobsCategories.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.jobsCategories.create');
    }

    public function store(JobsCategoryRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new JobsCategory, ['id'], ['name' => $request->name, 'com_code' => $com_code]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }
            DB::beginTransaction();
            $dataToInsert['name'] = $request->name;
            $dataToInsert['active'] = $request->active;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;
            insert(new JobsCategory, $dataToInsert);
            DB::commit();

            return redirect()->route('dashboard.jobsCategories.index')->with(['success' => 'تم اضافة البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobsCategory, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }

        return view('dashboard.settings.jobsCategories.edit', ['data' => $data]);
    }

    public function update($id, JobsCategoryRequest $request)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobsCategory, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }
        try {
            $CheckExsists = JobsCategory::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new JobsCategory, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.jobsCategories.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطا '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new JobsCategory, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_categories_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            DB::beginTransaction();
            destroy(new JobsCategory, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.jobsCategories.index')->with(['success' => 'تم الحذف بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.jobsCategories.index')->with(['error' => 'عفوا حدث خطا '.$ex->getMessage()]);
        }
    }
}
