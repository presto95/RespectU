//
//  Persistence.swift
//  RespectU
//
//  Created by Presto on 13/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

struct Persistence {
  
  static var favoriteButton: Button {
    get {
      let buttonString = UserDefaults.standard.string(forKey: "favoriteButton") ?? ""
      return Button(rawValue: buttonString) ?? .button4
    }
    set {
      UserDefaults.standard.do {
        $0.set(newValue.rawValue, forKey: "favoriteButton")
        $0.synchronize()
      }
    }
  }
  
  static var nickname: String {
    get {
      return UserDefaults.standard.string(forKey: "nickname") ?? L10n.nicknameSetting
    }
    set {
      UserDefaults.standard.do {
        $0.set(newValue, forKey: "nickname")
        $0.synchronize()
      }
    }
  }
  
  static var numberOfLaunching: Int {
    get {
      return UserDefaults.standard.integer(forKey: "appOpenCount")
    }
    set {
      UserDefaults.standard.do {
        $0.set(newValue, forKey: "appOpenCount")
        $0.synchronize()
      }
    }
  }
}
