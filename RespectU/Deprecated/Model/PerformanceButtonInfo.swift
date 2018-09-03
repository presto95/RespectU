//
//  RecordButtonInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class PerformanceButtonInfo: Object {
    @objc dynamic var normal: PerformanceRecordInfo?
    @objc dynamic var hard: PerformanceRecordInfo?
    @objc dynamic var maximum: PerformanceRecordInfo?
    @objc dynamic var highestSkillPoint: Double = 0
    @objc dynamic var highestSkillPointDifficulty: String = ""
    @objc dynamic var highestSkillPointNote: String = ""
    @objc dynamic var highestSkillPointRate: Double = 0
}
