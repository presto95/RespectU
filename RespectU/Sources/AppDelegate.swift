//
//  AppDelegate.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 26..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

import RealmSwift
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    var config = Realm.Configuration()
    if let fileURL = config.fileURL {
      config.fileURL = fileURL.deletingLastPathComponent().appendingPathComponent("new.realm")
      config.schemaVersion = 1
      config.migrationBlock = { migration, oldSchemaVersion in
        if oldSchemaVersion < 1 {
          
        }
      }
      Realm.Configuration.defaultConfiguration = config
    }
    // 개발용
    //        KeychainWrapper.standard.set("", forKey: "id")
    //        do {
    //            try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.tintColor = .main
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if !id.isEmpty {
      if TipInfo.fetch().count != 0 {
        let controller = StoryboardScene.Performance.performanceNavigationController.instantiate()
        window?.rootViewController = controller
      } else {
        Persistence.bpm = 450
        let controller = StoryboardScene.Init.initViewController.instantiate()
        window?.rootViewController = controller
      }
    } else {
      let controller = StoryboardScene.SignIn.signNavigationController.instantiate()
      window?.rootViewController = controller
    }
    window?.makeKeyAndVisible()
    if UserDefaults.standard.double(forKey: "bpm") == 0 {
      UserDefaults.standard.set(450, forKey: "bpm")
    }
    if let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") {
      UserDefaults.standard.set(favoriteButton.lowercased(), forKey: "favoriteButton")
    }
    UINavigationBar.appearance().do {
      $0.setBackgroundImage(.init(), for: .default)
      $0.shadowImage = .init()
      $0.backgroundColor = .clear
      $0.isTranslucent = true
    }
    UITableView.appearance().do {
      $0.backgroundColor = .white
      $0.separatorColor = .lightGray
      $0.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
      $0.layer.borderColor = UIColor.main.cgColor
      $0.layer.borderWidth = 3
      $0.layer.cornerRadius = 10
      $0.tableFooterView = .init()
    }
    return true
  }
}
