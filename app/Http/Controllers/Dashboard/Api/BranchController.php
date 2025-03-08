<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Models\Branch;
use App\Helpers\ApiResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\BranchResourse;

class BranchController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $branches = Branch::get();
        if ($branches) {
            return ApiResponse::sendResponse(200, "Data Retrived Successfully", BranchResourse::collection($branches));
        } else {
            return ApiResponse::sendResponse(200, "Data Not Found", []);
        }
    }
}
