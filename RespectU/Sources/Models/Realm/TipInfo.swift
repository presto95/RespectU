//
//  TipInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about tip.
final class TipInfo: Object {
  
  /// The title of the tip.
  @objc dynamic var title: LanguageInfo?
  
  /// The localized title of the tip.
  var localizedTitle: String {
    if isInKorea, let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
  /// Adds the `tipInfo` to realm.
  ///
  /// - Parameter tipInfo: The tip information will be added.
  static func add(_ tipInfo: TipResponse.Tip) {
    let realm = try! Realm()
    let object = TipInfo()
    let languageInfo = LanguageInfo()
    languageInfo.english = tipInfo.title.english
    languageInfo.korean = tipInfo.title.korean
    object.title = languageInfo
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Fetches tips.
  ///
  /// - Returns: The fetched tips.
  static func fetch() -> Results<TipInfo> {
    let tipInfo = try! Realm().objects(TipInfo.self)
    return tipInfo
  }
  
  /// Updates `tipInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:   The source tip information.
  ///   - tipInfo:  The updated tip information.
  static func update(_ object: TipResponse.Tip, to tipInfo: TipInfo) {
    let realm = try! Realm()
    try! realm.write {
      tipInfo.title?.english = object.title.english
      tipInfo.title?.korean = object.title.korean
    }
  }
}
