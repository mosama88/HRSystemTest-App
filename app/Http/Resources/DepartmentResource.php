<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DepartmentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "Department Code" => $this->id,
            "Department Name" => $this->name,
            "Telephone" => $this->phones,
            "Notes" => $this->notes,
            "Status" => $this->active == 1 ? "Active" : "InActive",
            "created_by" => $this->createdBy->name,

        ];
    }
}
