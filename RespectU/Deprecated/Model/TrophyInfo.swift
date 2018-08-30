//
//  TrophyInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

@objcMembers class TrophyInfo: Object {
    dynamic var series: String = ""
    dynamic var rating: String = ""
    dynamic var image: String = ""
    dynamic var title: LanguageInfo = LanguageInfo()
    dynamic var content: LanguageInfo = LanguageInfo()
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title.korean {
            return korean
        } else {
            return title.english
        }
    }
    var localizedContent: String {
        if Locale.current.regionCode == "KR", let korean = content.korean {
            return korean
        } else {
            return content.english
        }
    }
    
    static func add(_ trophyInfo: TrophyResponse.Trophy) {
        let realm = try! Realm()
        let object = TrophyInfo()
        object.series = trophyInfo.series
        object.rating = trophyInfo.rating
        object.image = trophyInfo.image
        object.title.english = trophyInfo.title.english
        object.title.korean = trophyInfo.title.korean
        object.content.english = trophyInfo.content.english
        object.content.korean = trophyInfo.content.korean
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of series: String = "") -> Results<TrophyInfo> {
        let trophyInfo = try! Realm().objects(TrophyInfo.self)
        if series.isEmpty {
            return trophyInfo
        } else {
            let filtered = trophyInfo.filter(key: "series", value: series, method: FilterOperator.equal)
            return filtered
        }
    }
}


//class TrophyInfo: Object {
//
//    @objc dynamic var series: String = ""
//    @objc dynamic var titleKor: String = ""
//    @objc dynamic var contentKor: String = ""
//    @objc dynamic var titleEng: String = ""
//    @objc dynamic var contentEng: String = ""
//    @objc dynamic var rating: String = ""
//
//    //CREATE
//    static func add(_ series: String, _ titleKor: String, _ contentKor: String, _ titleEng: String, _ contentEng: String, _ rating: String){
//        let realm = try! Realm()
//        let trophy = TrophyInfo()
//        trophy.series = series
//        trophy.titleKor = titleKor
//        trophy.contentKor = contentKor
//        trophy.titleEng = titleEng
//        trophy.contentEng = contentEng
//        trophy.rating = rating
//        try! realm.write {
//            realm.add(trophy)
//        }
//    }
//
//    static func get() -> Results<TrophyInfo> {
//        let result = try! Realm().objects(TrophyInfo.self)
//        return result
//    }
//}
//
