<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:المستخدمين', ['only' => ['index']]);
        $this->middleware('permission:اضافة المستخدمين', ['only' => ['create', 'store']]);
        $this->middleware('permission:تعديل المستخدمين', ['only' => ['update', 'edit']]);
        $this->middleware('permission:حذف المستخدمين', ['only' => ['destroy']]);
    }

    public function index()
    {
        $users = Admin::get();
        return view('role-permission.user.index', ['users' => $users]);
    }

    public function create()
    {
        $roles = Role::pluck('name', 'name')->all();
        return view('role-permission.user.create', ['roles' => $roles]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:admins,email',
            'email' => 'required|email|max:255|unique:admins,email',
            'password' => 'required|string|min:8|max:20',
            'roles' => 'required',
            'status' => 'nullable|in:active,inactive',
        ]);

        $user = Admin::create([
            'name' => $request->name,
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'status' => 'active',
            'com_code' => 1,
            'created_by' => auth()->user()->id
        ]);

        $user->syncRoles($request->roles);

        return redirect('/users')->with('status', 'تم إنشاء المستخدم بالصلاحيات بنجاح');
    }

    public function edit(Admin $user)
    {
        $roles = Role::pluck('name', 'name')->all();
        $userRoles = $user->roles->pluck('name', 'name')->all();
        return view('role-permission.user.edit', [
            'user' => $user,
            'roles' => $roles,
            'userRoles' => $userRoles
        ]);
    }

    public function update(Request $request, Admin $user)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'password' => 'required|string|min:8|max:20',
            'roles' => 'required',
            'status' => 'nullable|in:active,inactive',
        ]);

        $data = [
            'name' => $request->name,
            'username' => $request->username,
            'status' => $request->status,
            'com_code' => 1,
            'updated_by' => auth()->user()->id
        ];

        if (!empty($request->password)) {
            $data += [
                'password' => Hash::make($request->password),
            ];
        }

        $user->update($data);
        $user->syncRoles($request->roles);

        return redirect('/users')->with('status', 'تم تعديل المستخدم بالصلاحيات بنجاح');
    }

    public function destroy($userId)
    {
        $user = Admin::findOrFail($userId);
        $user->delete();

        return redirect('/users')->with('status', 'حذف المستخدم بنجاح');
    }
}
