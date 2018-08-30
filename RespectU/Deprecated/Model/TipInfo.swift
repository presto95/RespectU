//
//  TipInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

@objcMembers class TipInfo: Object {
    dynamic var title: LanguageInfo = LanguageInfo()
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title.korean {
            return korean
        } else {
            return title.english
        }
    }
    
    static func add(_ tipInfo: TipResponse.Tip) {
        let realm = try! Realm()
        let object = TipInfo()
        object.title.english = tipInfo.title.english
        object.title.korean = tipInfo.title.korean
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch() -> Results<TipInfo> {
        let tipInfo = try! Realm().objects(TipInfo.self)
        return tipInfo
    }
}

//class TipInfo: Object {
//
//    @objc dynamic var tip: String = ""
//
//    //CREATE
//    static func add(_ tip: String) {
//        let realm = try! Realm()
//        let tipInfo = TipInfo()
//        tipInfo.tip = tip
//        try! realm.write{
//            realm.add(tipInfo)
//        }
//    }
//
//    //READ
//    static func get() -> Results<TipInfo> {
//        let result = try! Realm().objects(TipInfo.self)
//        return result
//    }
//}
