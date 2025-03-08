<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BranchResourse extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'Branch Code' => $this->id,
            'Name' => $this->name,
            'Address' => $this->address,
            'Phones' => $this->phones,
            'Email' => $this->email,
            'Status' => $this->active
        ];
    }
}
