<?php

namespace App\Http\Controllers\Dashboard\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\BranchRequest;
use App\Models\Branch;
use App\Models\Employee;
use Illuminate\Support\Facades\DB;

class BranchController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:الفروع', ['only' => ['index']]);
        $this->middleware('permission:اضافة الفروع', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل الفروع', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف الفروع', ['only' => ['destroy']]);
    }

    public function index()
    {
        $com_code = auth()->user()->com_code;
        $data = getColumnsIndex(new Branch, ['*'], ['com_code' => $com_code], 'id', 'DESC')->get();
        if (! empty($data)) {
            foreach ($data as $info) {
                $info->counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'branch_id' => $info->id]);
            }
        }

        return view('dashboard.settings.branches.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('dashboard.settings.branches.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BranchRequest $request)
    {
        try {
            $com_code = auth()->user()->com_code;
            $checkExists = get_Columns_where_row(new Branch, ['id'], ['com_code' => $com_code, 'name' => $request->name]);
            if (! empty($checkExists)) {
                return redirect()->back()->withErrors(['error' => 'كود الشركة مسجل بالفعل ']);
            }
            DB::beginTransaction();
            $branch['name'] = $request->name;
            $branch['address'] = $request->address;
            $branch['phones'] = $request->phones;
            $branch['email'] = $request->email;
            $branch['com_code'] = $com_code;
            $branch['created_by'] = auth()->user()->id;
            $branch['active'] = $request->active;
            insert(new Branch, $branch);
            DB::commit();
            session()->flash('success', 'تم أضافة البيانات بنجاح');

            return redirect()->route('dashboard.branches.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: '.$e->getMessage()]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {

        $com_code = auth()->user()->com_code;
        $info = get_Columns_where_row(new Branch, ['*'], ['id' => $id, 'com_code' => $com_code]);
        if (empty($info)) {
            return redirect()->route('dashboard.branches.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
        }

        return view('dashboard.settings.branches.edit', compact('info'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BranchRequest $request, $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Branch, ['*'], ['id' => $id, 'com_code' => $com_code]);
            if (empty($data)) {
                return redirect()->route('dashboard.branches.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
            }

            $updateBranch['name'] = $request->name;
            $updateBranch['address'] = $request->address;
            $updateBranch['phones'] = $request->phones;
            $updateBranch['email'] = $request->email;
            $updateBranch['com_code'] = $com_code;
            $updateBranch['updated_by'] = auth()->user()->id;
            $updateBranch['active'] = $request->active;
            update(new Branch, $updateBranch, ['id' => $id, 'com_code' => $com_code]);

            DB::commit();
            session()->flash('success', 'تم تحديث البيانات بنجاح');

            return redirect()->route('dashboard.branches.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: '.$e->getMessage()]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $com_code = auth()->user()->com_code;
            $data = get_Columns_where_row(new Branch, ['*'], ['id' => $id, 'com_code' => $com_code]);
            if (empty($data)) {
                return redirect()->route('dashboard.branches.index')->withErrors(['error' => 'عفوآ غير قادر على الوصول للبيانات المطلوبه']);
            }
            $counterUsed = get_count_where(new Employee, ['com_code' => $com_code, 'branch_id' => $id]);
            if ($counterUsed > 0) {
                return redirect()->route('dashboard.branches.index')->with(['error' => 'عفوآ غير قادر على الحذف لانه قد تم أستخدامه من قبل']);
            }

            destroy(new Branch, ['id' => $id, 'com_code' => $com_code]);

            DB::commit();
            session()->flash('success', 'تم حذف البيانات بنجاح');

            return redirect()->route('dashboard.branches.index');
        } catch (\Exception $e) {
            DB::rollback();

            return redirect()->back()->withErrors(['error' => 'حدث خطأ أثناء إضافة البيانات: '.$e->getMessage()]);
        }
    }
}
