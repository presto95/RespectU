//
//  VersionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class VersionInfo: Object {
    @objc dynamic var serverVersion: String = ""
    @objc dynamic var gameVersion: String = ""
}
