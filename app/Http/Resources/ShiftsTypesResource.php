<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ShiftsTypesResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "Shift Code" => $this->id,
            "Type Of Shift" => $this->type,
            "Shift From Time" => $this->from_time,
            "Shift to Time" => $this->to_time,
            "Total Hours Works" => $this->total_hours,
            "Status" => $this->active,
        ];
    }
}
