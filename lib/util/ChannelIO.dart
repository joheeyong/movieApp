import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelIO {
  static const platform = const MethodChannel("com.example.SampleProject/channelIO");
  static const badgeChannel = const EventChannel("com.example.SampleProject/channelIO/badge");

  static Future<dynamic> boot() async {
    var a;
    debugPrint("test1");
    a = await platform.invokeMethod("boot", {
      "bootConfig" : {
        "pluginKey" : "yourPluginKey",
        "memberId" : "flutter-test",
      },
    }) as String;
    return a;
  }

  static void sleep() {
    platform.invokeMethod("sleep");
  }

  static void shutdown() {
    platform.invokeMethod("shutdown");
  }

  static void showChannelButton() {
    platform.invokeMethod("showChannelButton");
  }

  static void showMessenger() {
    platform.invokeMethod("showMessenger");
  }

  static void track(String eventName) {
    platform.invokeMethod("track", eventName);
  }

  static void setBadgeListener(Function listener) {
    badgeChannel.receiveBroadcastStream().listen((badgeCount) {
      listener.call(badgeCount);
    });
  }
}
