<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class MainController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'file' => 'required|file|max:2048', // max 2MB
        ]);

        $path = Storage::disk('minio')->put('uploads', $request->file('file'));

        $url = Storage::disk('minio')->url($path);
        // return $url;
        return back()->with('success', 'File uploaded successfully.');
    }
}
