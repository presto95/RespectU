//
//  MissionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

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
    @objc dynamic var stage1: MissionStageInfo?
    @objc dynamic var stage2: MissionStageInfo?
    @objc dynamic var stage3: MissionStageInfo?
    @objc dynamic var stage4: MissionStageInfo?
    @objc dynamic var stage5: MissionStageInfo?
    @objc dynamic var stage6: MissionStageInfo?
    
    var localizedReward: String {
        if regionCode == "KR", let korean = reward?.korean {
            return korean
        } else {
            return reward?.english ?? ""
        }
    }
    
    static func add(_ missionInfo: MissionResponse.Mission) {
        guard let realm = try? Realm() else { return }
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
        if let stage = missionInfo.stage1 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage1 = stageInfo
        }
        if let stage = missionInfo.stage2 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage2 = stageInfo
        }
        if let stage = missionInfo.stage3 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage3 = stageInfo
        }
        if let stage = missionInfo.stage4 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage4 = stageInfo
        }
        if let stage = missionInfo.stage5 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage5 = stageInfo
        }
        if let stage = missionInfo.stage6 {
            let stageInfo = MissionStageInfo()
            let titleInfo = LanguageInfo()
            titleInfo.english = stage.title.english
            titleInfo.korean = stage.title.korean
            stageInfo.title = titleInfo
            stageInfo.difficulty = stage.difficulty
            stageInfo.button = stage.button
            object.stage6 = stageInfo
        }
        try? realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of series: String = "") -> Results<MissionInfo> {
        let realm = try! realm()
        let missionInfo = realm.objects(MissionInfo.self)
        if series.isEmpty {
            return missionInfo
        } else {
            let filtered = missionInfo.filter(key: "series", value: series, method: "=")
            return filtered
        }
    }
    
    ///타이틀로 필터링한 내부 데이터베이스 갱신
    static func update(_ object: MissionResponse.Mission, to missionInfo: MissionInfo) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            missionInfo.series = object.series
            missionInfo.section = object.section
            missionInfo.title = object.title
            missionInfo.score = object.score
            missionInfo.fever = object.fever
            missionInfo.combo = object.combo
            missionInfo.rate = object.rate
            missionInfo.break = object.break
            missionInfo.effector = object.effector
            missionInfo.reward?.english = object.reward.english
            missionInfo.reward?.korean = object.reward.korean
            
        }
    }
}
