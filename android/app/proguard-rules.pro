# Keep WebView classes for YouTube player
-keep class android.webkit.** { *; }
-keep class androidx.webkit.** { *; }

# Keep JavaScript interface for YouTube player
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep YouTube player iframe classes
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }

# Keep URL launcher classes
-keep class io.flutter.plugins.urllauncher.** { *; }

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# WebView debugging
-keepattributes JavascriptInterface
-keepattributes *Annotation*
