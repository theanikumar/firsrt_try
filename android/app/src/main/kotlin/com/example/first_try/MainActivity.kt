package com.example.first_try

import android.app.Application
import android.os.Build
import android.os.Bundle
import android.webkit.WebView
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable WebView debugging for YouTube player
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WebView.setWebContentsDebuggingEnabled(true)
        }

        // Initialize WebView for Android
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                // CHANGED: Added Application. prefix to correctly reference the static system method
                val processName = Application.getProcessName()
                if (packageName != processName) {
                    WebView.setDataDirectorySuffix(processName)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
