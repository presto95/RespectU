//
//  Result.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The `enum` that defines note.
enum Note: String {
  
  /// MAX COMBO.
  case maxCombo = "MC"
  
  /// PERFECT PLAY.
  case perfectPlay = "PP"
  
  /// NONE.
  case none = ""
  
  /// Initializes a `Note` with the expanded note string.
  init?(expansion: String) {
    switch expansion {
    case "PERFECT PLAY":
      self = .perfectPlay
    case "MAX COMBO":
      self = .maxCombo
    case "":
      self = .none
    default:
      return nil
    }
  }
}

// MARK: - Extension

extension Note {
  
  /// Expanded string.
  ///
  /// - Note: `Note.maxCombo` -> `MAX COMBO`
  var expansion: String {
    switch self {
    case .maxCombo:
      return "MAX COMBO"
    case .perfectPlay:
      return "PERFECT PLAY"
    case .none:
      return ""
    }
  }
}
