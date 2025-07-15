//
//  ChannelIOManager.swift
//  Runner
//
//  Created by 조희용 on 7/14/25.
//
// ChannelIOManager
import ChannelIOFront

class ChannelIOManager {
  static let CHANNEL_CHANNELIO = "com.example.SampleProject/channelIO"
  static let CHANNEL_BADGE_EVENT = "com.example.SampleProject/channelIO/badge"
  
  static let shared: ChannelIOManager = ChannelIOManager()
  
  private var eventSink: FlutterEventSink?
  
  func boot(bootConfig: [String:Any?]?, result: @escaping FlutterResult) {
    ChannelIO.delegate = self
    
    let config: BootConfig = BootConfig()
    config.pluginKey = bootConfig?["pluginKey"] as? String ?? ""
    config.memberId = bootConfig?["memberId"] as? String
    ChannelIO.boot(with: config) { bootStatus, user in
      result(bootStatus == .success ? "SUCCESS" : "ERROR")
    }
  }
  
  func sleep() {
    ChannelIO.sleep()
  }
  
  func shutdown() {
    ChannelIO.shutdown()
  }
  
  func showChannelButton() {
    ChannelIO.showChannelButton()
  }
  
  func showMessenger() {
    ChannelIO.showMessenger()
  }
  
  func track(eventName: String?) {
    guard let eventName = eventName else { return }
    ChannelIO.track(eventName: eventName)
  }
  
  func setBadgeListener(_ eventSink: FlutterEventSink?) {
    self.eventSink = eventSink
  }
  
  func openStoredPushNotification() {
    if ChannelIO.hasStoredPushNotification() {
      ChannelIO.openStoredPushNotification()
    }
  }

    func updateProfile(_ profile: [String:Any?]?) {
    guard let profile else { return }
    
    ChannelIO.updateUser(with: profile)
  }
}

extension ChannelIOManager: ChannelPluginDelegate {
  func onBadgeChanged(count: Int) {
    guard let eventSink = self.eventSink else { return }
    eventSink(count)
  }
}
