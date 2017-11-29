//
//  RateApp.swift
//  ParseStarterProject-Swift
//
//  Created by Pablo Guardiola on 27/01/16.
//  Copyright © 2016 Parse. All rights reserved.
//
import UIKit

// ----APP RATE SETTINGS ---
let APP_ID = "1291664067"

let showRateTimes = 5 //Times rateApp() called before alert shows
// -------------------------
let RATED_DEFAULT_KEY = "RATEDAPPKEY"
let RATE_CNT_KEY = "RATECNTKEY"

var defaults: UserDefaults!
var viewLoaded: Int = 0

func showRateAlertInmediatly (_ view: UIViewController) {
    rateApp(view, immediatly: true)
}

func rateApp(_ view: UIViewController, immediatly: Bool?) {
    if  defaults == nil {
        defaults = UserDefaults()
        viewLoaded = defaults.object(forKey: RATE_CNT_KEY) == nil ? 0 : defaults.object(forKey: RATE_CNT_KEY) as! Int
    }
    
    var immed = false
    
    if immediatly != nil {
        immed = immediatly!
    }
    
    if !immed {
        viewLoaded += 1
    }
    
    defaults.set(viewLoaded, forKey: "viewLoadedCntRateApp")
    
    if viewLoaded % showRateTimes == 0 || immed {
        if (defaults.object(forKey: RATED_DEFAULT_KEY) == nil || immed) {
            viewLoaded = 0
            let rateAlert = UIAlertController(title: "Please Rate RespectU!".localized, message: "Thanks for your support!".localized, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Go to rate".localized, style: .default, handler: {(alert: UIAlertAction!) in
                noMoreRate()
                let url=URL(string: "itms-apps://itunes.apple.com/app/id\(APP_ID)")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            })
            rateAlert.addAction(yesAction)
            let notNowAction = UIAlertAction(title: "Not now".localized, style: .default, handler: nil)
            rateAlert.addAction(notNowAction)
            let noThanksAction = UIAlertAction(title: "Don't Ask Again".localized, style: .default, handler: {(alert: UIAlertAction!) in noMoreRate()})
            rateAlert.addAction(noThanksAction)
            view.present(rateAlert, animated: true, completion: nil)
        }
    }
}


func noMoreRate () {
    let defaults = UserDefaults()
    
    defaults.set(true, forKey: RATED_DEFAULT_KEY)
}

func getRateAlertCountdown() -> Int {
    defaults = UserDefaults()
    if defaults.object(forKey: RATED_DEFAULT_KEY) == nil {
        return showRateTimes - viewLoaded
    }
    else {
        return 0
    }
}

func showCloseAlert (_ view: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Close", style: .default, handler: nil)
    alert.addAction(alertAction)
    
    view.present(alert, animated: true, completion: nil)
}
