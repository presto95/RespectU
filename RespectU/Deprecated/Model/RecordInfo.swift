//
//  RecordInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class DifficultyRecord: Object {
    @objc dynamic var rank: String = ""
    @objc dynamic var rate: Double = 0
    @objc dynamic var note: String = ""
    @objc dynamic var skillPoint: Double = 0
}

class RecordButton: Object {
    @objc dynamic var normal: DifficultyRecord?
    @objc dynamic var hard: DifficultyRecord?
    @objc dynamic var maximum: DifficultyRecord?
    @objc dynamic var highestSkillPoint: Double = 0
    @objc dynamic var highestSkillPointDifficulty: String = ""
    @objc dynamic var highestSkillPointNote: String = ""
    @objc dynamic var highestSkillPointRate: Double = 0
}

class RecordInfo: Object {
    @objc dynamic var title: LanguageInfo?
    @objc dynamic var series: String = ""
    @objc dynamic var button4: RecordButton?
    @objc dynamic var button5: RecordButton?
    @objc dynamic var button6: RecordButton?
    @objc dynamic var button8: RecordButton?
    
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title?.korean {
            return korean
        } else {
            return title?.english ?? ""
        }
    }
    
    static func add(_ recordInfo: RecordInfo) {
        let realm = try! Realm()
        let object = RecordInfo()
        object.title = recordInfo.title
        object.button4 = recordInfo.button4
        object.button5 = recordInfo.button5
        object.button6 = recordInfo.button6
        object.button8 = recordInfo.button8
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of title: String = "") -> Results<RecordInfo> {
        let recordInfo = try! Realm().objects(RecordInfo.self)
        if title.isEmpty {
            return recordInfo
        } else {
            let filtered = recordInfo.filter(key: "title", value: title, method: FilterOperator.equal)
            return filtered
        }
    }

    static func update(_ object: RecordInfo, with dictionary: [String: Any]) {
        let realm = try! Realm()
        try! realm.write {
            for (key, value) in dictionary {
                object.setValue(value, forKeyPath: key)
            }
        }
    }
}
