<?php

namespace App\Http\Resources;

use App\Models\Country;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GovernorateResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'Governorate Name' => $this->name,
            // 'Country of Origin' => $this->country->name,
            'Country of Origin' => new CountryResource($this->country), // I can Retrive Collection
        ];
    }
}
