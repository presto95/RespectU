//
//  SongButtonInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class SongButtonInfo: Object {
    @objc dynamic var normal: Int = 0
    @objc dynamic var hard: Int = 0
    @objc dynamic var maximum: Int = 0
}
