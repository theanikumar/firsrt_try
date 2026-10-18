package com.example.first_try

import android.os.Bundle
import android.webkit.WebView
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable WebView debugging for YouTube player
        WebView.setWebContentsDebuggingEnabled(true)
    }
}
