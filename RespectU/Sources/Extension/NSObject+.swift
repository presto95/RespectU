//
//  NSObject+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

extension NSObject {
  
  /// The type name of the class.
  var name: String {
    return NSStringFromClass(type(of: self))
  }
  
  /// The type name of the class.
  static var name: String {
    return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
  }
  
  /// The region code of the user.
  var regionCode: String {
    return Locale.current.regionCode ?? ""
  }
  
  /// A boolean value indicating whether the user uses region code of Korea.
  var isInKorea: Bool {
    return regionCode == "KR"
  }
  
  /// The version of the application.
  var version: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
  }
}
