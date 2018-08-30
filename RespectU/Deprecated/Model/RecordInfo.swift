//
//  RecordInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

@objcMembers class RecordInfo: Object {
    @objcMembers class Button: Object {
        @objcMembers class Difficulty: Object {
            dynamic var rank: String = ""
            dynamic var rate: Double = 0
            dynamic var note: String = ""
            dynamic var skillPoint: Double = 0
        }
        dynamic var normal: Difficulty = Difficulty()
        dynamic var hard: Difficulty = Difficulty()
        dynamic var maximum: Difficulty = Difficulty()
        dynamic var highestSkillPoint: Double = 0
        dynamic var highestSkillPointDifficulty: String = ""
        dynamic var highestSkillPointNote: String = ""
        dynamic var highestSkillPointRate: Double = 0
    }
    dynamic var title: LanguageInfo = LanguageInfo()
    dynamic var series: String = ""
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
    
    static func add(_ recordInfo: RecordInfo) {
        let realm = try! Realm()
        let object = RecordInfo()
        object.title = recordInfo.title
        object.button4 = recordInfo.button4
        object.button5 = recordInfo.button5
        object.button6 = recordInfo.button6
        object.button8 = recordInfo.button8
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func fetch(of title: String) -> Results<RecordInfo> {
        let recordInfo = try! Realm().objects(RecordInfo.self).filter(key: "title", value: title, method: FilterOperator.equal)
        return recordInfo
    }

    static func update(_ object: RecordInfo, with dictionary: [String: Any]) {
        let realm = try! Realm()
        try! realm.write {
            for (key, value) in dictionary {
                object.setValue(value, forKey: key)
            }
        }
    }
}

//class RecordInfo: Object {
//
//    @objc dynamic var series: String = ""
//    @objc dynamic var title: String = ""
//    @objc dynamic var nm4Rank: String = "-"
//    @objc dynamic var nm4Rate: String = "-"
//    @objc dynamic var nm4Note: String = "-"
//    @objc dynamic var hd4Rank: String = "-"
//    @objc dynamic var hd4Rate: String = "-"
//    @objc dynamic var hd4Note: String = "-"
//    @objc dynamic var mx4Rank: String = "-"
//    @objc dynamic var mx4Rate: String = "-"
//    @objc dynamic var mx4Note: String = "-"
//    @objc dynamic var nm5Rank: String = "-"
//    @objc dynamic var nm5Rate: String = "-"
//    @objc dynamic var nm5Note: String = "-"
//    @objc dynamic var hd5Rank: String = "-"
//    @objc dynamic var hd5Rate: String = "-"
//    @objc dynamic var hd5Note: String = "-"
//    @objc dynamic var mx5Rank: String = "-"
//    @objc dynamic var mx5Rate: String = "-"
//    @objc dynamic var mx5Note: String = "-"
//    @objc dynamic var nm6Rank: String = "-"
//    @objc dynamic var nm6Rate: String = "-"
//    @objc dynamic var nm6Note: String = "-"
//    @objc dynamic var hd6Rank: String = "-"
//    @objc dynamic var hd6Rate: String = "-"
//    @objc dynamic var hd6Note: String = "-"
//    @objc dynamic var mx6Rank: String = "-"
//    @objc dynamic var mx6Rate: String = "-"
//    @objc dynamic var mx6Note: String = "-"
//    @objc dynamic var nm8Rank: String = "-"
//    @objc dynamic var nm8Rate: String = "-"
//    @objc dynamic var nm8Note: String = "-"
//    @objc dynamic var hd8Rank: String = "-"
//    @objc dynamic var hd8Rate: String = "-"
//    @objc dynamic var hd8Note: String = "-"
//    @objc dynamic var mx8Rank: String = "-"
//    @objc dynamic var mx8Rate: String = "-"
//    @objc dynamic var mx8Note: String = "-"
//    @objc dynamic var nm4: Int = 0
//    @objc dynamic var nm5: Int = 0
//    @objc dynamic var nm6: Int = 0
//    @objc dynamic var nm8: Int = 0
//    @objc dynamic var hd4: Int = 0
//    @objc dynamic var hd5: Int = 0
//    @objc dynamic var hd6: Int = 0
//    @objc dynamic var hd8: Int = 0
//    @objc dynamic var mx4: Int = 0
//    @objc dynamic var mx5: Int = 0
//    @objc dynamic var mx6: Int = 0
//    @objc dynamic var mx8: Int = 0
//    @objc dynamic var button4SkillPoint: Double = 0.0
//    @objc dynamic var button5SkillPoint: Double = 0.0
//    @objc dynamic var button6SkillPoint: Double = 0.0
//    @objc dynamic var button8SkillPoint: Double = 0.0
//    @objc dynamic var button4HighestSkillPointDifficulty: String = ""
//    @objc dynamic var button4HighestSkillPointRate: String = ""
//    @objc dynamic var button4HighestSkillPointNote: String = ""
//    @objc dynamic var button5HighestSkillPointDifficulty: String = ""
//    @objc dynamic var button5HighestSkillPointRate: String = ""
//    @objc dynamic var button5HighestSkillPointNote: String = ""
//    @objc dynamic var button6HighestSkillPointDifficulty: String = ""
//    @objc dynamic var button6HighestSkillPointRate: String = ""
//    @objc dynamic var button6HighestSkillPointNote: String = ""
//    @objc dynamic var button8HighestSkillPointDifficulty: String = ""
//    @objc dynamic var button8HighestSkillPointRate: String = ""
//    @objc dynamic var button8HighestSkillPointNote: String = ""
//    @objc dynamic var lowercase: String = ""
//
//    //CREATE
//    static func add(_ title: String, _ nm4rank: String, _ nm4rate: String, _ nm4note: String, _ nm5rank: String, _ nm5rate: String, _ nm5note: String, _ nm6rank: String, _ nm6rate: String, _ nm6note: String, _ nm8rank: String, _ nm8rate: String, _ nm8note: String, _ hd4rank: String, _ hd4rate: String, _ hd4note: String, _ hd5rank: String, _ hd5rate: String, _ hd5note: String, _ hd6rank: String, _ hd6rate: String, _ hd6note: String, _ hd8rank: String, _ hd8rate: String, _ hd8note: String, _ mx4rank: String, _ mx4rate: String, _ mx4note: String, _ mx5rank: String, _ mx5rate: String, _ mx5note: String, _ mx6rank: String, _ mx6rate: String, _ mx6note: String, _ mx8rank: String, _ mx8rate: String, _ mx8note: String) {
//        let realm = try! Realm()
//        let record = realm.objects(RecordInfo.self).last!
//        record.nm4Rank = nm4rank
//        record.nm4Rate = nm4rate
//        record.nm4Note = nm4note
//        record.nm5Rank = nm5rank
//        record.nm5Rate = nm5rate
//        record.nm5Note = nm5note
//        record.nm6Rank = nm6rank
//        record.nm6Rate = nm6rate
//        record.nm6Note = nm6note
//        record.nm8Rank = nm8rank
//        record.nm8Rate = nm8rate
//        record.nm8Note = nm8note
//        record.hd4Rank = hd4rank
//        record.hd4Rate = hd4rate
//        record.hd4Note = hd4note
//        record.hd5Rank = hd5rank
//        record.hd5Rate = hd5rate
//        record.hd5Note = hd5note
//        record.hd6Rank = hd6rank
//        record.hd6Rate = hd6rate
//        record.hd6Note = hd6note
//        record.hd8Rank = hd8rank
//        record.hd8Rate = hd8rate
//        record.hd8Note = hd8note
//        record.mx4Rank = mx4rank
//        record.mx4Rate = mx4rate
//        record.mx4Note = mx4note
//        record.mx5Rank = mx5rank
//        record.mx5Rate = mx5rate
//        record.mx5Note = mx5note
//        record.mx6Rank = mx6rank
//        record.mx6Rate = mx6rate
//        record.mx6Note = mx6note
//        record.mx8Rank = mx8rank
//        record.mx8Rate = mx8rate
//        record.mx8Note = mx8note
//        try! realm.write {
//            realm.add(record)
//        }
//    }
//
//    //READ
//    static func get() -> Results<RecordInfo> {
//        let result = try! Realm().objects(RecordInfo.self)
//        return result
//    }
//
//    //UPDATE
//    static func update(_ object: RecordInfo, with dictionary: [String: Any]) {
//
//    }
//
//    //DELETE
//    static func remove(_ title: String, _ type: String) {
//        let realm = try! Realm()
//        let record = realm.objects(RecordInfo.self).last!
//        try! realm.write {
//            switch type {
//            case "nm4":
//                record.nm4Rank="-"; record.nm4Note="-"; record.nm4Rate="-"
//            case "nm5":
//                record.nm5Rank="-"; record.nm5Note="-"; record.nm5Rate="-"
//            case "nm6":
//                record.nm6Rank="-"; record.nm6Note="-"; record.nm6Rate="-"
//            case "nm8":
//                record.nm8Rank="-"; record.nm8Note="-"; record.nm8Rate="-"
//            case "hd4":
//                record.hd4Rank="-"; record.hd4Note="-"; record.hd4Rate="-"
//            case "hd5":
//                record.hd5Rank="-"; record.hd5Note="-"; record.hd5Rate="-"
//            case "hd6":
//                record.hd6Rank="-"; record.hd6Note="-"; record.hd6Rate="-"
//            case "hd8":
//                record.hd8Rank="-"; record.hd8Note="-"; record.hd8Rate="-"
//            case "mx4":
//                record.mx4Rank="-"; record.mx4Note="-"; record.mx4Rate="-"
//            case "mx5":
//                record.mx5Rank="-"; record.mx5Note="-"; record.mx5Rate="-"
//            case "mx6":
//                record.mx6Rank="-"; record.mx6Note="-"; record.mx6Rate="-"
//            case "mx8":
//                record.mx8Rank="-"; record.mx8Note="-"; record.mx8Rate="-"
//            default:
//                break
//            }
//        }
//    }
//
//    static func initialize(_ series: String, _ title: String) {
//        let realm = try! Realm()
//        let record = RecordInfo()
//        record.series = series
//        record.title = title
//        record.nm4Rank = "-"
//        record.nm4Rate = "-"
//        record.nm4Note = "-"
//        record.nm5Rank = "-"
//        record.nm5Rate = "-"
//        record.nm5Note = "-"
//        record.nm6Rank = "-"
//        record.nm6Rate = "-"
//        record.nm6Note = "-"
//        record.nm8Rank = "-"
//        record.nm8Rate = "-"
//        record.nm8Note = "-"
//        record.hd4Rank = "-"
//        record.hd4Rate = "-"
//        record.hd4Note = "-"
//        record.hd5Rank = "-"
//        record.hd5Rate = "-"
//        record.hd5Note = "-"
//        record.hd6Rank = "-"
//        record.hd6Rate = "-"
//        record.hd6Note = "-"
//        record.hd8Rank = "-"
//        record.hd8Rate = "-"
//        record.hd8Note = "-"
//        record.mx4Rank = "-"
//        record.mx4Rate = "-"
//        record.mx4Note = "-"
//        record.mx5Rank = "-"
//        record.mx5Rate = "-"
//        record.mx5Note = "-"
//        record.mx6Rank = "-"
//        record.mx6Rate = "-"
//        record.mx6Note = "-"
//        record.mx8Rank = "-"
//        record.mx8Rate = "-"
//        record.mx8Note = "-"
//        try! realm.write {
//            realm.add(record)
//        }
//    }
//
//    static func initializeDifficulty(_ title: String, _ nm4: Int, _ nm5: Int, _ nm6: Int, _ nm8: Int, _ hd4: Int, _ hd5: Int, _ hd6: Int, _ hd8: Int, _ mx4: Int, _ mx5: Int, _ mx6: Int, _ mx8: Int) {
//        let realm = try! Realm()
//        let record = realm.objects(RecordInfo.self).last!
//        try! realm.write{
//            record.nm4=nm4; record.nm5=nm5; record.nm6=nm6; record.nm8=nm8; record.hd4=hd4; record.hd5=hd5; record.hd6=hd6; record.hd8=hd8;
//            record.mx4=mx4; record.mx5=mx5; record.mx6=mx6; record.mx8=mx8
//        }
//    }
//}
//
//
