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
