<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;

class LogRequests
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
         $logData = [
            'method' => $request->method(),
            'url' => $request->fullUrl(),
            'headers' => $request->header(),
            'body' => $request->all(), // Hanya untuk debugging, jangan digunakan di produksi jika ada password
            'ip' => $request->ip(),
            'user_agent' => $request->header('User-Agent'),
        ];

        // Simpan log ke storage/logs/laravel.log
        Log::info('Incoming Request:', $logData);

        return $next($request);
    }
}
