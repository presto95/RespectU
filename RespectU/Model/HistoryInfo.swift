//
//  HistoryInfo.swift
//  RespectU
//
//  Created by Presto on 16/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import RealmSwift

@objcMembers
class HistoryInfo: Object {
    
    dynamic var date: Date = Date()
    dynamic var title: LanguageInfo?
    dynamic var series: String = ""
    dynamic var historyType: String = ""        // RANK / RATE / NOTE
    dynamic var previousRecord: String = ""
    dynamic var currentRecord: String = ""
    
    var localizedTitle: String {
        if regionCode == "KR", let korean = title?.korean {
            return korean
        } else {
            return title?.english ?? ""
        }
    }
    var localizedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:dd"
        return dateFormatter.string(from: date)
    }
    
    static func add(_ historyInfo: HistoryInfo) {
        let realm = try! Realm()
        let object = HistoryInfo()
        let titleInfo = LanguageInfo()
        titleInfo.english = historyInfo.title?.english ?? ""
        titleInfo.korean = historyInfo.title?.korean
        object.title = titleInfo
        object.series = historyInfo.series
        object.historyType = historyInfo.historyType
        object.previousRecord = historyInfo.previousRecord
        object.currentRecord = historyInfo.currentRecord
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(_ date: Date) -> Results<HistoryInfo> {
        let historyInfo = try! Realm().objects(HistoryInfo.self)
        return historyInfo
        
    }
    
    static func remove(_ historyInfo: HistoryInfo) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(historyInfo)
        }
    }
    
    static func removeAll() {
        let realm = try! Realm()
        try! realm.write {
            
        }
    }
}
