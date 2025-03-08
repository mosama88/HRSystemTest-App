<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Models\Department;
use App\Helpers\ApiResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\DepartmentResource;

class DepartmentController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $departments = Department::get();
        if (count($departments) > 0) {
            return ApiResponse::sendResponse(200, "Data Retrived Successfully", DepartmentResource::collection($departments));
        } else {
            return ApiResponse::sendResponse(200, "Data Not Found", []);
        }
    }
}
