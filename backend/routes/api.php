<?php

use App\Http\Controllers\PostController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Routes yang tidak memerlukan autentikasi
Route::post('/register', [PostController::class, 'register']);
Route::post('/login', [PostController::class, 'login'])->name('login');


// Routes yang memerlukan autentikasi
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return response()->json($request->user());
    });
 Route::get('/resep/user', [PostController::class, 'getUserResep']);
 Route::get('/resep', [PostController::class, 'getResep']);

Route::delete('/resep/{id}', [PostController::class, 'delete'])->withoutMiddleware(['auth:sanctum']);
Route::get('/resep/{id}', [PostController::class, 'getDetailResep']);


    Route::post('/post-resep', [PostController::class, 'store']);

    Route::post('/logout', [PostController::class, 'logout']);
});