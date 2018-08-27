//
//  Tip.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 27..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class Tip: Object {
    
    @objc dynamic var title: String = ""
    
    ///Tip 모델 CREATE
    static func add(_ title: String) {
        let realm = try! Realm()
        let object = Tip()
        object.title = title
        try! realm.write {
            realm.add(object)
        }
    }
    
    ///Tip 모델 READ
    static func fetch() -> Results<Tip> {
        let result = try! Realm().objects(Tip.self)
        return result
    }
    
    ///Tip 모델 UPDATE
    static func update(_ object: Tip, to model: Tip) {
        try! Realm().write {
            object.title = model.title
        }
    }
    
    ///Tip 모델 DELETE
    static func remove(_ object: Tip) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
