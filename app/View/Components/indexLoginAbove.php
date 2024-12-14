<?php

namespace App\View\Components;

use Closure;
use Illuminate\View\Component;
use App\Models\AdminPanelSetting;
use Illuminate\Contracts\View\View;

class indexLoginAbove extends Component
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

        return view('components.index-login-above',compact('data'));
    }
}

