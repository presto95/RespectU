//
//  TrophyInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class TrophyInfo: Object {
    @objc dynamic var series: String = ""
    @objc dynamic var rating: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var title: LanguageInfo?
    @objc dynamic var content: LanguageInfo?
    
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title?.korean {
            return korean
        } else {
            return title?.english ?? ""
        }
    }
    var localizedContent: String {
        if Locale.current.regionCode == "KR", let korean = content?.korean {
            return korean
        } else {
            return content?.english ?? ""
        }
    }
    
    static func add(_ trophyInfo: TrophyResponse.Trophy) {
        let realm = try! Realm()
        let object = TrophyInfo()
        let titleInfo = LanguageInfo()
        let contentInfo = LanguageInfo()
        object.series = trophyInfo.series
        object.rating = trophyInfo.rating
        object.image = trophyInfo.image
        titleInfo.english = trophyInfo.title.english
        titleInfo.korean = trophyInfo.title.korean
        contentInfo.english = trophyInfo.content.english
        contentInfo.korean = trophyInfo.content.korean
        object.title = titleInfo
        object.content = contentInfo
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of series: String = "") -> Results<TrophyInfo> {
        let trophyInfo = try! Realm().objects(TrophyInfo.self)
        if series.isEmpty {
            return trophyInfo
        } else {
            let filtered = trophyInfo.filter(key: "series", value: series, method: "=")
            return filtered
        }
    }
}
