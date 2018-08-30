//
//  Notification.Name+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveFirebaseFetch = Notification.Name("DidReceiveFirebaseFetch")
    static let didReceiveFirebaseUpload = Notification.Name("DidReceiveFirebaseUpload")
    
    static let didReceiveSongs = Notification.Name("DidReceiveSongs")
    static let errorReceiveSongs = Notification.Name("ErrorReceiveSongs")
    static let didReceiveMissions = Notification.Name("DidReceiveMissions")
    static let errorReceiveMissions = Notification.Name("ErrorReceiveMissions")
    static let didReceiveTrophies = Notification.Name("DidReceiveTrophies")
    static let errorReceiveTrophies = Notification.Name("ErrorReceiveTrophies")
    static let didReceiveAchievements = Notification.Name("DidReceiveAchievements")
    static let errorReceiveAchievements = Notification.Name("ErrorReceiveAchievements")
    static let didReceiveTips = Notification.Name("DidReceiveTips")
    static let errorReceiveTips = Notification.Name("ErrorReceiveTips")
    static let didReceiveRecords = Notification.Name("DidReceiveRecords")
    static let errorReceiveRecords = Notification.Name("ErrorReceiveRecords")
}
