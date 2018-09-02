//
//  AppDelegate.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 26..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleSignIn
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        /**
         * 로그인(회원가입) -> 데이터가져오기 -> 퍼포먼스뷰컨
         * 세션 만료시간은 무한으로
         * 아이디는 키체인에 저장
         * 세션이 없으면 로그인 화면부터
         * 있으면 데이터 있으면 퍼포먼스뷰컨으로, 없으면 데이터가져오기 뷰컨으로
         */
        let existsSession: Bool = false
        if existsSession {
            if TipInfo.fetch().count != 0 {
                let controller = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController")
                window?.rootViewController = controller
            } else {
                do {
                    try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
                } catch {
                    print(error.localizedDescription)
                }
                UserDefaults.standard.set(450, forKey: "bpm")
                let controller = UIViewController.instantiate(storyboard: "Init", identifier: "InitViewController")
                window?.rootViewController = controller
            }
        } else {
            do {
                try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            } catch {
                print(error.localizedDescription)
            }
            let controller = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignNavigationController")
            window?.rootViewController = controller
        }
        window?.makeKeyAndVisible()
//        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
//            do {
//                try FileManager.default.removeItem(at: fileURL)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        let config = Realm.Configuration(
//            schemaVersion: 12,  //Increment this each time your schema changes
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                    //If you need to transfer any data
//                    //(in your case you don't right now) you will transfer here
//                }
//        })
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        UIApplication.shared.isStatusBarHidden = false
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // User is signed in
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

