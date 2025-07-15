//
//  BadgeHandler.swift
//  Runner
//
//  Created by 조희용 on 7/14/25.
//
import ChannelIOFront


class BadgeHandler: NSObject, FlutterStreamHandler {
  func onListen(
    withArguments arguments: Any?,
    eventSink events: @escaping FlutterEventSink
  ) -> FlutterError? {
    ChannelIOManager.shared.setBadgeListener(events)
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    return nil
  }
}
