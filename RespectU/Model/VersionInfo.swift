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
    
    static func fetch() -> Results<VersionInfo> {
        let versionInfo = try! Realm().objects(VersionInfo.self)
        return versionInfo
    }
    
    static func add(_ versionInfo: VersionResponse) {
        let realm = try! Realm()
        let object = VersionInfo()
        object.serverVersion = versionInfo.serverVersion
        object.gameVersion = versionInfo.gameVersion
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func update(_ object: VersionResponse, to versionInfo: VersionInfo) {
        let realm = try! Realm()
        try! realm.write {
            versionInfo.serverVersion = object.serverVersion
            versionInfo.gameVersion = object.gameVersion
        }
    }
}
