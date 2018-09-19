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
        if regionCode == "KR", let korean = section?.korean {
            return korean
        } else {
            return section?.english ?? ""
        }
    }
    var localizedItem: String {
        if regionCode == "KR", let korean = item?.korean {
            return korean
        } else {
            return item?.english ?? ""
        }
    }
    
    static func add(_ achievementInfo: AchievementResponse.Achievement) {
        let realm = try! Realm()
        let object = AchievementInfo()
        let sectionInfo = LanguageInfo()
        let itemInfo = LanguageInfo()
        object.type = achievementInfo.type
        object.level = achievementInfo.level
        sectionInfo.english = achievementInfo.section.english
        sectionInfo.korean = achievementInfo.section.korean
        itemInfo.english = achievementInfo.item.english
        itemInfo.korean = achievementInfo.item.korean
        object.section = sectionInfo
        object.item = itemInfo
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of type: String = "") -> Results<AchievementInfo> {
        let achievementInfo = try! Realm().objects(AchievementInfo.self)
        if type.isEmpty {
            return achievementInfo
        } else {
            let filtered = achievementInfo.filter(key: "type", value: type, method: "=")
            return filtered
        }
    }
    
    static func update(_ object: AchievementResponse.Achievement, to achievementInfo: AchievementInfo) {
        let realm = try! Realm()
        try! realm.write {
            achievementInfo.type = object.type
            achievementInfo.level = object.level
            achievementInfo.section?.english = object.section.english
            achievementInfo.section?.korean = object.section.korean
            achievementInfo.item?.english = object.item.english
            achievementInfo.item?.korean = object.item.korean
        }
    }
}
