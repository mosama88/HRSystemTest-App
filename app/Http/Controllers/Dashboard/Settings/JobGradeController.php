<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\JobGradeRequest;
use App\Models\Employee;
use App\Models\JobGrade;
use Illuminate\Support\Facades\DB;

class JobGradeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new JobGrade, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_grade_id' => $info->id]);
            }
        }

        return view('dashboard.settings.jobGrades.index', ['data' => $data]);
    }

    public function create()
    {
        return view('dashboard.settings.jobGrades.create');
    }

    public function store(JobGradeRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $CheckExsists = get_Columns_where_row(new JobGrade, ['id'], ['name' => $request->name, 'com_code' => $com_code]);
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }

            $last_job_grades_code = get_cols_where_row_orderby(new JobGrade, ['job_grades_code'], ['com_code' => $com_code], 'job_grades_code', 'DESC');

            if (! empty($last_job_grades_code)) {  // لو القيم مش فاضية
                $dataToInsert['job_grades_code'] = $last_job_grades_code['job_grades_code'] + 1;          //هيزود رقم على كل موظف
            } else { //أول موظف يتم تسجيلة
                $dataToInsert['job_grades_code'] = 1; //بداية الترقيم
            }
            DB::beginTransaction();
            $dataToInsert['name'] = $request->name;
            $dataToInsert['min_salary'] = $request->min_salary;
            $dataToInsert['max_salary'] = $request->max_salary;
            $dataToInsert['notes'] = $request->notes;
            $dataToInsert['active'] = $request->active;
            $dataToInsert['created_by'] = auth()->user()->id;
            $dataToInsert['com_code'] = $com_code;
            insert(new JobGrade, $dataToInsert);
            DB::commit();

            return redirect()->route('dashboard.jobGrades.index')->with(['success' => 'تم اضافة البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطأ ما '.$ex->getMessage()])->withInput();
        }
    }

    public function edit($id)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobGrade, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }

        return view('dashboard.settings.jobGrades.edit', ['data' => $data]);
    }

    public function update($id, JobGradeRequest $request)
    {
        $com_code = auth()->user()->com_code;
        $data = get_Columns_where_row(new JobGrade, ['*'], ['com_code' => $com_code, 'id' => $id]);
        if (empty($data)) {
            return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
        }
        try {
            $CheckExsists = JobGrade::select('id')->where('com_code', '=', $com_code)->where('name', '=', $request->name)->where('id', '!=', $id)->first();
            if (! empty($CheckExsists)) {
                return redirect()->back()->with(['error' => 'عفوا  اسم الوظيفة مسجل من قبل ! '])->withInput();
            }
            DB::beginTransaction();
            $dataToUpdate['name'] = $request->name;
            $dataToUpdate['min_salary'] = $request->min_salary;
            $dataToUpdate['max_salary'] = $request->max_salary;
            $dataToUpdate['notes'] = $request->notes;
            $dataToUpdate['active'] = $request->active;
            $dataToUpdate['updated_by'] = auth()->user()->id;
            update(new JobGrade, $dataToUpdate, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.jobGrades.index')->with(['success' => 'تم تحديث البيانات بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->back()->with(['error' => 'عفوا حدث خطا '.$ex->getMessage()])->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new JobGrade, ['*'], ['com_code' => $com_code, 'id' => $id]);
            if (empty($data)) {
                return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا غير قادر الي الوصول الي البيانات المطلوبة']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'job_grade_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            DB::beginTransaction();
            destroy(new JobGrade, ['com_code' => $com_code, 'id' => $id]);
            DB::commit();

            return redirect()->route('dashboard.jobGrades.index')->with(['success' => 'تم الحذف بنجاح']);
        } catch (\Exception $ex) {
            DB::rollBack();

            return redirect()->route('dashboard.jobGrades.index')->with(['error' => 'عفوا حدث خطا '.$ex->getMessage()]);
        }
    }
}
