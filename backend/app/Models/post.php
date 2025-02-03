<?php

namespace App\Models;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class post extends Model
{
    protected $fillable = [
        'image',
        'title',
        'user_id',
        'description',
    ];

     public function user()
    {
        return $this->belongsTo(User::class);
    }

     // Tambahkan accessor untuk mengubah path menjadi URL
    public function getImageUrlAttribute()
    {
        return asset(Storage::url($this->image));
    }

    public function getUserResep($id) {
        Log::info('Fetching resep for user: ' . $id); // Logging
        $resep = Post::where('user_id', $id)->get();
        Log::info('Found recipes: ' . $resep->count()); // Logging
        return response()->json($resep);
    }
}
