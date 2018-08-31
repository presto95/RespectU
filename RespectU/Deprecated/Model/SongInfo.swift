//
//  SongInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

@objcMembers class SongInfo: Object {
    @objcMembers class Button: Object {
        dynamic var normal: Int = 0
        dynamic var hard: Int = 0
        dynamic var maximum: Int = 0
    }
    dynamic var title: LanguageInfo = LanguageInfo()
    dynamic var lowercase: LanguageInfo = LanguageInfo()
    dynamic var series: String = ""
    dynamic var composer: String = ""
    dynamic var bpm: Int = 0
    dynamic var subBpm: Int?
    dynamic var button4: Button = Button()
    dynamic var button5: Button = Button()
    dynamic var button6: Button = Button()
    dynamic var button8: Button = Button()
    var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title.korean {
            return korean
        } else {
            return title.english
        }
    }
    var localizedLowercase: String {
        if Locale.current.regionCode == "KR", let korean = lowercase.korean {
            return korean
        } else {
            return lowercase.english
        }
    }
    var bpmToString: String {
        if let subBpm = subBpm {
            return "BPM \(bpm) ~ \(subBpm)"
        } else {
            return "BPM \(bpm)"
        }
    }
    
    static func add(_ songInfo: SongResponse.Song) {
        let realm = try! Realm()
        let object = SongInfo()
        object.title.english = songInfo.title.english
        object.title.korean = songInfo.title.korean
        object.lowercase.english = songInfo.title.english
        object.lowercase.korean = songInfo.lowercase.korean
        object.series = songInfo.series
        object.composer = songInfo.composer
        object.bpm = songInfo.bpm
        object.subBpm = songInfo.subBpm
        object.button4.normal = songInfo.button4.normal
        object.button4.hard = songInfo.button4.hard
        object.button4.maximum = songInfo.button4.maximum
        object.button5.normal = songInfo.button5.normal
        object.button5.hard = songInfo.button5.hard
        object.button5.maximum = songInfo.button5.maximum
        object.button6.normal = songInfo.button6.normal
        object.button6.hard = songInfo.button6.hard
        object.button6.maximum = songInfo.button6.maximum
        object.button8.normal = songInfo.button8.normal
        object.button8.hard = songInfo.button8.hard
        object.button8.maximum = songInfo.button8.maximum
        try! realm.write {
            realm.add(object)
        }
    }
    
    ///시리즈별 음악 가져오기
    static func fetch(of series: String = "") -> Results<SongInfo> {
        let songInfo = try! Realm().objects(SongInfo.self)
        if series.isEmpty {
            return songInfo
        } else {
            let filtered = songInfo.filter(key: "series", value: series, method: FilterOperator.equal)
            return filtered
        }
    }
    
    ///타이틀별 음악 가져오기
    static func fetch(by title: String) -> Results<SongInfo> {
        let songInfo = try! Realm().objects(SongInfo.self).filter(key: "localizedTitle", value: title, method: FilterOperator.equal)
        return songInfo
    }
}
