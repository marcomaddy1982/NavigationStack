//
//  NotificationDispatcher.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 27/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import Foundation

enum NotificationName: String {
    case pushScreen = "NotificationPush"
    case presentScreen = "NotificationPresent"
}

class NotificationDispatcher {
    static let shared = NotificationDispatcher()

    private var timerPush = Timer()
    private var timerPresent = Timer()
    
    private init() {
        
    }
    
    public func dispatchPushScreenNotification() {
        timerPush = Timer.scheduledTimer(timeInterval: 5,
                                     target: self,
                                     selector: #selector(dispatchPushScreen),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    public func dispatchPresentScreenNotification() {
        timerPresent = Timer.scheduledTimer(timeInterval: 5,
                                            target: self,
                                            selector: #selector(dispatchPresentScreen),
                                            userInfo: nil,
                                            repeats: false)
    }
    
    @objc
    private func dispatchPushScreen() {
        NotificationCenter.default.post(name: Notification.Name(NotificationName.pushScreen.rawValue), object: nil)

    }
    
    @objc
    private func dispatchPresentScreen() {
        NotificationCenter.default.post(name: Notification.Name(NotificationName.presentScreen.rawValue), object: nil)
    }
    
}
