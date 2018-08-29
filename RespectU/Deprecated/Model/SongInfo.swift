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
}

//
//class SongInfo: Object {
//    @objc dynamic var series: String = ""
//    @objc dynamic var title: String = ""
//    @objc dynamic var composer: String = ""
//    @objc dynamic var bpm: String = ""
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
//    @objc dynamic var lowercase: String = ""
//
//    //CREATE
//    static func add(_ series: String, _ title: String, _ composer: String, _ bpm: String, _ nm4: Int, _ hd4: Int, _ mx4: Int, _ nm5: Int, _ hd5: Int, _ mx5: Int, _ nm6: Int, _ hd6: Int, _ mx6: Int, _ nm8: Int, _ hd8: Int, _ mx8: Int){
//        let realm = try! Realm()
//        let song = SongInfo()
//        song.series = series
//        song.title = title
//        song.composer = composer
//        song.bpm = bpm
//        song.nm4 = nm4
//        song.nm5 = nm5
//        song.nm6 = nm6
//        song.nm8 = nm8
//        song.hd4 = hd4
//        song.hd5 = hd5
//        song.hd6 = hd6
//        song.hd8 = hd8
//        song.mx4 = mx4
//        song.mx5 = mx5
//        song.mx6 = mx6
//        song.mx8 = mx8
//        try! realm.write {
//            realm.add(song)
//        }
//    }
//
//    //READ
//    static func get() -> Results<SongInfo> {
//        let songInfo = try! Realm().objects(SongInfo.self)
//        return songInfo
//    }
//
//    //UPDATE
//
//    //DELETE
//}

