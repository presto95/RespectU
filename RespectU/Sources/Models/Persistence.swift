//
//  Persistence.swift
//  RespectU
//
//  Created by Presto on 13/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

/// The `struct` that defines user defaults persistence.
struct Persistence {
  
  /// The favorite button.
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
  
  /// The nickname.
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
  
  /// The number of launching.
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
  
  /// The favorite bpm.
  static var bpm: Double {
    get {
      return UserDefaults.standard.double(forKey: "bpm")
    }
    set {
      UserDefaults.standard.do {
        $0.set(newValue, forKey: "bpm")
        $0.synchronize()
      }
    }
  }
}
