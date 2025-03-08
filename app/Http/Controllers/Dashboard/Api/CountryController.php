<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Models\Country;
use App\Helpers\ApiResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\CountryResource;

class CountryController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $caountries = Country::get();
        if (count($caountries) > 0) {
            return ApiResponse::sendResponse(200, "Data Retrived Successfully", CountryResource::collection($caountries));
        } else {
            return ApiResponse::sendResponse(200, "Data Not Found", []);
        }
    }
}