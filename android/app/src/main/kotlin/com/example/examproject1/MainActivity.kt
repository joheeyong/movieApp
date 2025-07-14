package com.example.examproject1

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

// MainActivity
class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.SampleProject/channelIO"
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val manager = ChannelIOManager()

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            // Log the method call for debugging
            Log.d("MainActivity", "Method called: ${call.method}, Arguments: ${call.arguments}")
            when (call.method) {
                "boot" -> manager.boot(
                    call.argument<HashMap<String, Any?>>("bootConfig"),
                    result
                )
                "sleep" -> manager.sleep()
                "shutdown" -> manager.shutdown()
                "showChannelButton" -> manager.showChannelButton()
                "showMessenger" -> manager.showMessenger(this)
                "track" -> manager.track(call.arguments<String>())
            }
        }

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.SampleProject/channelIO/badge"
        ).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                manager.setBadgeListener(events)
            }

            override fun onCancel(arguments: Any?) {
            }
        })
    }
}