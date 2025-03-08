<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Helpers\ApiResponse;
use App\Models\ShiftsType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\ShiftsTypesResource;

class ShiftsTypesController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $shiftsTypes = ShiftsType::get();
        if (count($shiftsTypes) > 0) {
            return ApiResponse::sendResponse(200, 'Data Retrived Successfully', ShiftsTypesResource::collection($shiftsTypes));
        } else {
            return ApiResponse::sendResponse(200, 'Data Not Fount', []);
        }
    }
}
