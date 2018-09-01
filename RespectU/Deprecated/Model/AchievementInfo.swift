//
//  AchievementInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class AchievementInfo: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var level: Int = 0
    @objc dynamic var section: LanguageInfo?
    @objc dynamic var item: LanguageInfo?
    
    var localizedSection: String {
        if Locale.current.regionCode == "KR", let korean = section?.korean {
            return korean
        } else {
            return section?.english ?? ""
        }
    }
    var localizedItem: String {
        if Locale.current.regionCode == "KR", let korean = item?.korean {
            return korean
        } else {
            return item?.english ?? ""
        }
    }
    
    static func add(_ achievementInfo: AchievementResponse.Achievement) {
        let realm = try! Realm()
        let object = AchievementInfo()
        object.type = achievementInfo.type
        object.level = achievementInfo.level
        object.section?.english = achievementInfo.section.english
        object.section?.korean = achievementInfo.section.korean
        object.item?.english = achievementInfo.item.english
        object.item?.korean = achievementInfo.item.korean
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of type: String = "") -> Results<AchievementInfo> {
        let achievementInfo = try! Realm().objects(AchievementInfo.self)
        if type.isEmpty {
            return achievementInfo
        } else {
            let filtered = achievementInfo.filter(key: "type", value: type, method: FilterOperator.equal)
            return filtered
        }
    }
}

//class AchievementInfo: Object {
//    @objc dynamic var title: String = ""
//    @objc dynamic var level: Int = 0
//    @objc dynamic var type: String = ""
//    @objc dynamic var item: String = ""
//
//    //CREATE
//    static func add(_ title: String, _ level: Int, _ type: String, _ item : String) {
//        let realm = try! Realm()
//        let achievement = AchievementInfo()
//        achievement.title = title; achievement.level = level; achievement.type = type; achievement.item = item
//        try! realm.write{
//            realm.add(achievement)
//        }
//    }
//
//    //READ
//    static func get() -> Results<AchievementInfo> {
//        let result = try! Realm().objects(AchievementInfo.self)
//        return result
//    }
//}
