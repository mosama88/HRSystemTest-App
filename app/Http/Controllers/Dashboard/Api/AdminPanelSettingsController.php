<?php

namespace App\Http\Controllers\Dashboard\Api;

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

        $adminPanelSetting = AdminPanelSetting::get();
        return  AdminPanelSettingsResourse::collection($adminPanelSetting);
    }
}
