//
//  AppDelegate.swift
//  RespectU
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
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
        //개발용
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
                let controller = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController")
                window?.rootViewController = controller
            } else {
                UserDefaults.standard.set(450, forKey: "bpm")
                let controller = UIViewController.instantiate(storyboard: "Init", identifier: InitViewController.classNameToString)
                window?.rootViewController = controller
            }
        } else {
            let controller = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignNavigationController")
            window?.rootViewController = controller
        }
        window?.makeKeyAndVisible()
        UIApplication.shared.isStatusBarHidden = false
        if UserDefaults.standard.double(forKey: "bpm") == 0 {
            UserDefaults.standard.set(450, forKey: "bpm")
        }
        if let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") {
            UserDefaults.standard.set(favoriteButton.lowercased(), forKey: "favoriteButton")
        }
        // 전역 프로퍼티 설정
        let navigationBar = UINavigationBar.appearance()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        let tableView = UITableView.appearance()
        tableView.backgroundColor = .white
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.layer.borderColor = UIColor.main.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.tableFooterView = UIView()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        let launchScreen = UIView(frame: UIScreen.main.bounds)
        launchScreen.tag = 100
        guard let window = window else { return }
        launchScreen.backgroundColor = .white
        launchScreen.alpha = 0
        window.addSubview(launchScreen)
        launchScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchScreen.topAnchor.constraint(equalTo: window.topAnchor),
            launchScreen.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            launchScreen.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            launchScreen.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "respectuColor"))
        launchScreen.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: launchScreen.centerXAnchor),
            imageView.centerYAnchor.constraint(lessThanOrEqualTo: launchScreen.centerYAnchor)
            ])
        UIView.animate(withDuration: 0.2) {
            launchScreen.alpha = 1
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let view = window?.viewWithTag(100)
        UIView.animate(withDuration: 0.2, animations: {
            view?.alpha = 0
        }, completion: { _ in
            view?.removeFromSuperview()
        })
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
