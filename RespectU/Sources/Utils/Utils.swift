//
//  Utils.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

/// The `class` that defines utility functions.
final class Utils {
  
  /// Converts `speed` to the recommended speed.
  ///
  /// - Parameter speed: The `speed` value.
  ///
  /// - Returns: The converted string matching each case.
  ///
  /// - Note: `3.14` -> `3.00 ~ 3.50`
  static func convertToRecommendedSpeed(by speed: Double) -> String? {
    switch speed {
    case ..<0.50:
      return "0.50"
    case 0.50..<0.75:
      return "0.50 ~ 0.75"
    case 0.75..<1.00:
      return "0.75 ~ 1.00"
    case 1.00..<1.25:
      return "1.00 ~ 1.25"
    case 1.25..<1.50:
      return "1.25 ~ 1.50"
    case 1.50..<1.75:
      return "1.50 ~ 1.75"
    case 1.75..<2.00:
      return "1.75 ~ 2.00"
    case 2.00..<2.25:
      return "2.00 ~ 2.25"
    case 2.25..<2.50:
      return "2.25 ~ 2.50"
    case 2.50..<2.75:
      return "2.50 ~ 2.75"
    case 2.75..<3.00:
      return "2.75 ~ 3.00"
    case 3.00..<3.25:
      return "3.00 ~ 3.25"
    case 3.25..<3.50:
      return "3.25 ~ 3.50"
    case 3.50..<3.75:
      return "3.50 ~ 3.75"
    case 3.75..<4.00:
      return "3.75 ~ 4.00"
    case 4.00..<4.25:
      return "4.00 ~ 4.25"
    case 4.25..<4.50:
      return "4.25 ~ 4.50"
    case 4.50..<4.75:
      return "4.50 ~ 4.75"
    case 4.75..<5.00:
      return "4.75 ~ 5.00"
    case 5.00...:
      return "5.00"
    default:
      return nil
    }
  }
  
  /// Converts `rate` contains percent symbol to `Double` value.
  ///
  /// - Parameter rate: The `rate` contains percent symbol.
  ///
  /// - Returns: The converted `rate` represented to `Double`.
  static func convertToDouble(withPercent rate: String) -> Double {
    if case let value? = rate.components(separatedBy: "%").first {
      return Double(value) ?? 0
    } else {
      return 0
    }
  }
}
