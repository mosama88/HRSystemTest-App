<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Helpers\ApiResponse;
use App\Models\Governorate;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\GovernorateResource;

class GovernorateController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $governorates = Governorate::where('country_id', $request->input('country'))->get();
        if (count($governorates) > 0) {
            return ApiResponse::sendResponse(200, "Data Retrived Successefully", GovernorateResource::collection($governorates));
        } else {
            return ApiResponse::sendResponse(200, "Data Not Found", []);
        }
    }
}