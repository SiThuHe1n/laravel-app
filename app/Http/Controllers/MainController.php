<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MainController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'file' => 'required|file|max:2048', // max 2MB
        ]);

        $file = $request->file('file');
        // $filename = time() . '_' . $file->getClientOriginalName();
        $path = $request->file('file')->store("public");
        // $file->move(public_path('uploads'), $filename);

        return back()->with('success', 'File uploaded successfully.');
    }
}
