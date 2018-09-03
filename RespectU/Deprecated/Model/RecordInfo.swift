//
//  OldRecordInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class RecordInfo: Object {
    
    @objc dynamic var series: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var nm4Rank: String = "-"
    @objc dynamic var nm4Rate: String = "-"
    @objc dynamic var nm4Note: String = "-"
    @objc dynamic var hd4Rank: String = "-"
    @objc dynamic var hd4Rate: String = "-"
    @objc dynamic var hd4Note: String = "-"
    @objc dynamic var mx4Rank: String = "-"
    @objc dynamic var mx4Rate: String = "-"
    @objc dynamic var mx4Note: String = "-"
    @objc dynamic var nm5Rank: String = "-"
    @objc dynamic var nm5Rate: String = "-"
    @objc dynamic var nm5Note: String = "-"
    @objc dynamic var hd5Rank: String = "-"
    @objc dynamic var hd5Rate: String = "-"
    @objc dynamic var hd5Note: String = "-"
    @objc dynamic var mx5Rank: String = "-"
    @objc dynamic var mx5Rate: String = "-"
    @objc dynamic var mx5Note: String = "-"
    @objc dynamic var nm6Rank: String = "-"
    @objc dynamic var nm6Rate: String = "-"
    @objc dynamic var nm6Note: String = "-"
    @objc dynamic var hd6Rank: String = "-"
    @objc dynamic var hd6Rate: String = "-"
    @objc dynamic var hd6Note: String = "-"
    @objc dynamic var mx6Rank: String = "-"
    @objc dynamic var mx6Rate: String = "-"
    @objc dynamic var mx6Note: String = "-"
    @objc dynamic var nm8Rank: String = "-"
    @objc dynamic var nm8Rate: String = "-"
    @objc dynamic var nm8Note: String = "-"
    @objc dynamic var hd8Rank: String = "-"
    @objc dynamic var hd8Rate: String = "-"
    @objc dynamic var hd8Note: String = "-"
    @objc dynamic var mx8Rank: String = "-"
    @objc dynamic var mx8Rate: String = "-"
    @objc dynamic var mx8Note: String = "-"
    @objc dynamic var nm4: Int = 0
    @objc dynamic var nm5: Int = 0
    @objc dynamic var nm6: Int = 0
    @objc dynamic var nm8: Int = 0
    @objc dynamic var hd4: Int = 0
    @objc dynamic var hd5: Int = 0
    @objc dynamic var hd6: Int = 0
    @objc dynamic var hd8: Int = 0
    @objc dynamic var mx4: Int = 0
    @objc dynamic var mx5: Int = 0
    @objc dynamic var mx6: Int = 0
    @objc dynamic var mx8: Int = 0
    @objc dynamic var button4SkillPoint: Double = 0.0
    @objc dynamic var button5SkillPoint: Double = 0.0
    @objc dynamic var button6SkillPoint: Double = 0.0
    @objc dynamic var button8SkillPoint: Double = 0.0
    @objc dynamic var button4HighestSkillPointDifficulty: String = ""
    @objc dynamic var button4HighestSkillPointRate: String = ""
    @objc dynamic var button4HighestSkillPointNote: String = ""
    @objc dynamic var button5HighestSkillPointDifficulty: String = ""
    @objc dynamic var button5HighestSkillPointRate: String = ""
    @objc dynamic var button5HighestSkillPointNote: String = ""
    @objc dynamic var button6HighestSkillPointDifficulty: String = ""
    @objc dynamic var button6HighestSkillPointRate: String = ""
    @objc dynamic var button6HighestSkillPointNote: String = ""
    @objc dynamic var button8HighestSkillPointDifficulty: String = ""
    @objc dynamic var button8HighestSkillPointRate: String = ""
    @objc dynamic var button8HighestSkillPointNote: String = ""
    @objc dynamic var lowercase: String = ""

    static func get() -> Results<RecordInfo> {
        let oldConfig = Realm.Configuration(fileURL: Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("default.realm"), schemaVersion: 13, migrationBlock: { (migration, oldVersion) in
            if oldVersion < 1 {}
        })
        let result = try! Realm(configuration: oldConfig).objects(RecordInfo.self)
        return result
    }
}
