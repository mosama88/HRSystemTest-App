<?php

namespace App\View\Components;

use App\Models\AdminPanelSetting;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class indexLoginUnder extends Component
{
    /**
     * Create a new component instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {

        $data = AdminPanelSetting::select('*')->first();

        return view('components.index-login-under', compact('data'));
    }
}
