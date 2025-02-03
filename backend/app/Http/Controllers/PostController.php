<?php

namespace App\Http\Controllers;

use App\Models\post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Laravel\Sanctum\HasApiTokens;

class PostController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        // Generate token
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
                'user' => [
                    'id' => $user->id, // Tambahkan user ID di sini
                    'name' => $user->name,
                    'email' => $user->email,
                ],
                'token' => $token
            ]);
    }

    public function logout(Request $request) {
        $request->user()->tokens()->delete();
        return response()->json(['message' => 'Logged out succesfully'], 200);
    }
    public function register(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Buat user baru
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json([
            'message' => 'Akun berhasil dibuat, silakan login',
            'user' => $user
        ], 201);
    }



    public function store(Request $request)
    {
         $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'required|string',
        'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
    ]);

    // Simpan gambar ke dalam storage public
    $imagePath = $request->file('image')->store('resep_images', 'public');
    $imageUrl = Storage::url($imagePath); // Menghasilkan URL untuk gambar

    // Simpan data ke database
    $resep = Post::create([
        'user_id' => $request->user()->id, // Ambil ID user dari token
        'title' => $request->title,
        'description' => $request->description,
        'image' => $imageUrl, // Simpan URL gambar
    ]);

    return response()->json([
        'status' => 201,
        'message' => 'Resep berhasil dibuat',
        'data' => $resep
    ], 201);
    }

public function getUserResep(Request $request) 
{
    // Dapatkan user dari token
    $user = Auth::user();
    
    // Log untuk debugging
    Log::info('User ID: ' . $user->id);
    
    $resep = Post::where('user_id', $user->id)
                 ->orderBy('created_at', 'desc')
                 ->get();
    
    Log::info('Jumlah resep: ' . $resep->count());
    
    if ($resep->isEmpty()) {
        return response()->json(['message' => 'Tidak ada resep ditemukan']);
    }
    
    return response()->json($resep);
}

public function getResep(Request $request) 
{
    // Ambil semua resep dari database, urutkan berdasarkan yang terbaru
    $resep = Post::orderBy('created_at', 'desc')->get();

    // Log jumlah resep untuk debugging
    Log::info('Jumlah total resep: ' . $resep->count());

    // Jika tidak ada resep, kirim pesan
    if ($resep->isEmpty()) {
        return response()->json(['message' => 'Tidak ada resep ditemukan'], 200);
    }

    return response()->json($resep, 200);
}



// Di Laravel controller
public function delete($id) {
    $resep = post::find($id);
    
    if (!$resep) {
        return response()->json(['message' => 'Resep tidak ditemukan'], 404);
    }

    // Debugging sebelum hapus
    Log::info("Menghapus resep dengan ID: " . $id);
    
    $resep->delete();
    return response()->json(['message' => 'Resep berhasil dihapus'], 200);
}

public function getDetailResep($id)
{
    $resep = Post::find($id);

    if (!$resep) {
        return response()->json(['message' => 'Resep tidak ditemukan'], 404);
    }

    return response()->json($resep, 200);
}


}
