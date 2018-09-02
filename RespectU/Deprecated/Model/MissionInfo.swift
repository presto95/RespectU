//
//  MissionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class Stage: Object {
    @objc dynamic var title: LanguageInfo?
    @objc dynamic var difficulty: String = ""
    @objc dynamic var button: String = ""
    
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title?.korean {
            return korean
        } else {
            return title?.english ?? ""
        }
    }
}

class MissionInfo: Object {
    @objc dynamic var series: String = ""
    @objc dynamic var section: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var score: Int = 0
    @objc dynamic var fever: Int = 0
    @objc dynamic var combo: Int = 0
    @objc dynamic var rate: Int = 0
    @objc dynamic var `break`: Int = 0
    @objc dynamic var effector: String = ""
    @objc dynamic var reward: LanguageInfo?
    @objc dynamic var stage1: Stage?
    @objc dynamic var stage2: Stage?
    @objc dynamic var stage3: Stage?
    @objc dynamic var stage4: Stage?
    @objc dynamic var stage5: Stage?
    @objc dynamic var stage6: Stage?
    
    var localizedReward: String {
        if Locale.current.regionCode == "KR", let korean = reward?.korean {
            return korean
        } else {
            return reward?.english ?? ""
        }
    }
    
    static func add(_ missionInfo: MissionResponse.Mission) {
        let realm = try! Realm()
        let object = MissionInfo()
        let rewardInfo = LanguageInfo()
        object.series = missionInfo.series
        object.section = missionInfo.section
        object.title = missionInfo.title
        object.score = missionInfo.score
        object.combo = missionInfo.combo
        object.rate = missionInfo.rate
        object.break = missionInfo.break
        object.effector = missionInfo.effector
        rewardInfo.english = missionInfo.reward.english
        rewardInfo.korean = missionInfo.reward.korean
        object.reward = rewardInfo
        if let stage = object.stage1 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage1?.title.english ?? ""
            titleInfo.korean = missionInfo.stage1?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage1?.difficulty ?? ""
            stage.button = missionInfo.stage1?.button ?? ""
        }
        if let stage = object.stage2 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage2?.title.english ?? ""
            titleInfo.korean = missionInfo.stage2?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage2?.difficulty ?? ""
            stage.button = missionInfo.stage2?.button ?? ""
        }
        if let stage = object.stage3 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage3?.title.english ?? ""
            titleInfo.korean = missionInfo.stage3?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage3?.difficulty ?? ""
            stage.button = missionInfo.stage3?.button ?? ""
        }
        if let stage = object.stage4 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage4?.title.english ?? ""
            titleInfo.korean = missionInfo.stage4?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage4?.difficulty ?? ""
            stage.button = missionInfo.stage4?.button ?? ""
        }
        if let stage = object.stage5 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage5?.title.english ?? ""
            titleInfo.korean = missionInfo.stage5?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage5?.difficulty ?? ""
            stage.button = missionInfo.stage5?.button ?? ""
        }
        if let stage = object.stage6 {
            let titleInfo = LanguageInfo()
            titleInfo.english = missionInfo.stage6?.title.english ?? ""
            titleInfo.korean = missionInfo.stage6?.title.korean
            stage.title = titleInfo
            stage.difficulty = missionInfo.stage6?.difficulty ?? ""
            stage.button = missionInfo.stage6?.button ?? ""
        }
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of series: String = "") -> Results<MissionInfo> {
        let missionInfo = try! Realm().objects(MissionInfo.self)
        if series.isEmpty {
            return missionInfo
        } else {
            let filtered = missionInfo.filter(key: "series", value: series, method: FilterOperator.equal)
            return filtered
        }
    }
}
