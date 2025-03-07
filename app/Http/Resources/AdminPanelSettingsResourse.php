<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AdminPanelSettingsResourse extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'Company Name' => $this->company_name,
            'Company Mobile' => $this->phons,
            'Company address' => $this->address,
            'Company Email' => $this->email,
        ];
    }
}
