package com.example.examproject1

import android.app.Activity
import android.util.Log
import com.tekartik.sqflite.Constant.TAG
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import com.zoyi.channel.plugin.android.ChannelIO
import com.zoyi.channel.plugin.android.open.config.BootConfig
import com.zoyi.channel.plugin.android.open.enumerate.BootStatus
import com.zoyi.channel.plugin.android.open.listener.ChannelPluginListener
import com.zoyi.channel.plugin.android.open.model.PopupData
import com.zoyi.channel.plugin.android.open.model.User
import io.channel.com.google.gson.Gson

// ChannelIOManager
class ChannelIOManager : ChannelPluginListener {

    private var eventSink: EventChannel.EventSink? = null

    fun boot(bootConfig: HashMap<String, Any?>?, result: MethodChannel.Result) {
        val bootConfig = BootConfig.create("yourKey")
        ChannelIO.setListener(this)
        val config: BootConfig? = BootConfig.fromJson(Gson().toJson(bootConfig))
        ChannelIO.boot(config) { bootStatus: BootStatus, user: User? ->
            Log.e(TAG, "bootStatus: $bootStatus")
            result.success(bootStatus)
        }

    }

    fun sleep() {
        ChannelIO.sleep()
    }

    fun shutdown() {
        ChannelIO.shutdown()
    }

    fun showChannelButton() {
        ChannelIO.showChannelButton()
    }

    fun showMessenger(activity: Activity) {
        ChannelIO.showMessenger(activity)
    }

    fun track(eventName: String?) {
        eventName?.also { ChannelIO.track(it) }
    }

    fun setBadgeListener(eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
    }

    override fun onShowMessenger() {
        TODO("Not yet implemented")
    }

    override fun onHideMessenger() {
        TODO("Not yet implemented")
    }

    override fun onChatCreated(p0: String?) {
        TODO("Not yet implemented")
    }

    override fun onBadgeChanged(count: Int) {
        this.eventSink?.success(count)
    }

    override fun onBadgeChanged(p0: Int, p1: Int) {
        TODO("Not yet implemented")
    }

    override fun onFollowUpChanged(p0: MutableMap<String, String>?) {
        TODO("Not yet implemented")
    }

    override fun onUrlClicked(p0: String?): Boolean {
        TODO("Not yet implemented")
    }

    override fun onPushNotificationClicked(p0: String?): Boolean {
        TODO("Not yet implemented")
    }

    override fun onPopupDataReceived(p0: PopupData?) {
        TODO("Not yet implemented")
    }

}