//
//  Buttons.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The `enum` that defines buttons.
enum Button: String {
  
  /// 4B TUNES.
  case button4 = "4b"
  
  /// 5B TUNES.
  case button5 = "5b"
  
  /// 6B TUNES.
  case button6 = "6b"
  
  /// 8B TUNES.
  case button8 = "8b"
  
  /// Only in mission - 10 button mode.
  case xb
  
  /// Only in mission - TECHNIKA mode.
  case tb
  
  /// Expands the raw value of each case.
  ///
  /// If a passed value is `xb` or `tb`, it returns `nil`.
  /// - Note: `4b` -> `button4` / `5b` -> `button5` / `xb` -> `nil`
  var expansion: String? {
    switch self {
    case .button4: return "button4"
    case .button5: return "button5"
    case .button6: return "button6"
    case .button8: return "button8"
    default: return nil
    }
  }
  
  static let all: [Button] = [.button4, .button5, .button6, .button8]
}
