//
//  VersionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about version.
final class VersionInfo: Object {
  
  /// The server version.
  @objc dynamic var serverVersion: String = ""
  
  /// The in-game version.
  @objc dynamic var gameVersion: String = ""
  
  /// Fetches version information.
  ///
  /// - Returns: The fetched version information.
  static func fetch() -> Results<VersionInfo> {
    let versionInfo = try! Realm().objects(VersionInfo.self)
    return versionInfo
  }
  
  /// Adds the `versionInfo` to realm.
  ///
  /// - Parameter versionInfo: The version information will be added.
  static func add(_ versionInfo: VersionResponse) {
    let realm = try! Realm()
    let object = VersionInfo()
    object.serverVersion = versionInfo.serverVersion
    object.gameVersion = versionInfo.gameVersion
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Updates `versionInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:       The source version information.
  ///   - versionInfo:  The updated version information.
  static func update(_ object: VersionResponse, to versionInfo: VersionInfo) {
    let realm = try! Realm()
    try! realm.write {
      versionInfo.serverVersion = object.serverVersion
      versionInfo.gameVersion = object.gameVersion
    }
  }
  
  /// Updates `object` with `dictionary`.
  ///
  /// - Parameters:
  ///   - object:     The updated version information.
  ///   - dictionary: The dictionary contains version information.
  static func update(_ object: VersionInfo, with dictionary: [String: Any]) {
    let realm = try! Realm()
    try! realm.write {
      for (key, value) in dictionary {
        object.setValue(value, forKey: key)
      }
    }
  }
}
