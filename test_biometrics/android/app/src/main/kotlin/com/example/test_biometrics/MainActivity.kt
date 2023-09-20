package com.example.test_biometrics

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.view.WindowManager
import android.view.View
import android.view.ViewGroup
import androidx.compose.ui.platform.ComposeView

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "security"
    private var securityView: View? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createSecurityView()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupMethodChannel(flutterEngine)
    }

    private fun setupMethodChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableAppSecurity" -> {
                    enableAppSecurity()
                    result.success(null)
                }
                "disableAppSecurity" -> {
                    disableAppSecurity()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        toggleAppSecurity(hasFocus)
    }

    override fun onPause() {
        super.onPause()
        addSecurityView()
    }

    override fun onResume() {
        super.onResume()
        removeSecurityView()
    }

    private fun toggleAppSecurity(hasFocus: Boolean) {
        if (hasFocus) {
            removeSecurityView()
        } else {
            addSecurityView()
        }
    }

    private fun enableAppSecurity() {
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
    }

    private fun disableAppSecurity() {
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }

    private fun createSecurityView() {
        securityView = ComposeView(this).apply { setContent { SecurityScreen() } }
    }

    private fun addSecurityView() {
        removeSecurityView()
        securityView?.let { (window.decorView as ViewGroup).addView(it) }
    }

    private fun removeSecurityView() {
        securityView?.let { (window.decorView as ViewGroup).removeView(it) }
    }
}
