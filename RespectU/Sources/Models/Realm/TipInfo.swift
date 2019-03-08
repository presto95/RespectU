//
//  TipInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

final class TipInfo: Object {
  
  @objc dynamic var title: LanguageInfo?
  
  var localizedTitle: String {
    if regionCode == "KR", let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
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
  
  static func fetch() -> Results<TipInfo> {
    let tipInfo = try! Realm().objects(TipInfo.self)
    return tipInfo
  }
  
  static func update(_ object: TipResponse.Tip, to tipInfo: TipInfo) {
    let realm = try! Realm()
    try! realm.write {
      tipInfo.title?.english = object.title.english
      tipInfo.title?.korean = object.title.korean
    }
  }
}
