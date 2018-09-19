//
//  RecordButtonInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class NewRecordButtonInfo: Object {
    
    @objc dynamic var normal: NewRecordDifficultyInfo?
    @objc dynamic var hard: NewRecordDifficultyInfo?
    @objc dynamic var maximum: NewRecordDifficultyInfo?
    @objc dynamic var skillPoint: Double = 0
    @objc dynamic var skillPointDifficulty: String = ""
    @objc dynamic var skillPointNote: String = ""
    @objc dynamic var skillPointRate: Double = 0
}
