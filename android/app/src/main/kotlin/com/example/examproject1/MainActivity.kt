package com.example.examproject1

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import com.zoyi.channel.plugin.android.ChannelIO
import com.zoyi.channel.plugin.android.open.config.BootConfig
import com.zoyi.channel.plugin.android.open.enumerate.BootStatus
import com.zoyi.channel.plugin.android.open.model.User


// MainActivity
class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.SampleProject/channelIO"
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val manager = ChannelIOManager()

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            val bootConfig = BootConfig.create("yourKey")

            ChannelIO.boot(bootConfig) { bootStatus: BootStatus, user: User? ->
                Log.d("ChannelIO", "Boot Status: $bootStatus")
            }

            ChannelIO.showChannelButton()
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