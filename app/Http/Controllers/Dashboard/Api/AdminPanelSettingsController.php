<?php

namespace App\Http\Controllers\Dashboard\Api;

use App\Helpers\ApiResponse;
use Illuminate\Http\Request;
use App\Models\AdminPanelSetting;
use App\Http\Controllers\Controller;
use App\Http\Resources\AdminPanelSettingsResourse;

class AdminPanelSettingsController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        // Send All Data That's Security issue
        //best way and security wize make resources
        // $adminPanelSetting = AdminPanelSetting::findOrFail(1);
        // return  new AdminPanelSettingsResourse($adminPanelSetting);

        // $adminPanelSetting = AdminPanelSetting::get();
        // return  AdminPanelSettingsResourse::collection($adminPanelSetting);

        $adminPanelSetting = AdminPanelSetting::findOrFail(1);
        if ($adminPanelSetting) return ApiResponse::sendResponse(201, 'Admin PanelSettings Retrived Successfully', new AdminPanelSettingsResourse($adminPanelSetting));
    }
}
