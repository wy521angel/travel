package com.example.travel

import com.wy521angel.plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        registerSelfPlugin(shimPluginRegistry);
    }

    /**
     * 百度语音监听
     */
    private fun registerSelfPlugin(shimPluginRegistry: ShimPluginRegistry) {
        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.wy521angel.plugin.asr.AsrPlugin"))

    }

}
