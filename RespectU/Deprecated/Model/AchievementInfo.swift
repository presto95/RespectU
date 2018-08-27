//
//  AchievementInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class AchievementInfo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var level: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var item: String = ""
    
    //CREATE
    static func add(_ title: String, _ level: Int, _ type: String, _ item : String) {
        let realm = try! Realm()
        let achievement = AchievementInfo()
        achievement.title = title; achievement.level = level; achievement.type = type; achievement.item = item
        try! realm.write{
            realm.add(achievement)
        }
    }
    
    //READ
    static func get() -> Results<AchievementInfo> {
        let result = try! Realm().objects(AchievementInfo.self)
        return result
    }
}
