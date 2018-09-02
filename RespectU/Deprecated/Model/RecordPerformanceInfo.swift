//
//  RecordPerformanceInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class RecordPerformanceInfo: Object {
    @objc dynamic var rank: String = ""
    @objc dynamic var rate: Double = 0
    @objc dynamic var note: String = ""
    @objc dynamic var skillPoint: Double = 0
}
