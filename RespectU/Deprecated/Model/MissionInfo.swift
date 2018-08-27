//
//  MissionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class MissionInfo: Object {
    
    @objc dynamic var type: String = ""
    @objc dynamic var section: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var song1title: String = ""
    @objc dynamic var song1level: String = ""
    @objc dynamic var song1key: String = ""
    @objc dynamic var song2title: String = ""
    @objc dynamic var song2level: String = ""
    @objc dynamic var song2key: String = ""
    @objc dynamic var song3title: String = ""
    @objc dynamic var song3level: String = ""
    @objc dynamic var song3key: String = ""
    @objc dynamic var song4title: String = ""
    @objc dynamic var song4level: String = ""
    @objc dynamic var song4key: String = ""
    @objc dynamic var song5title: String = ""
    @objc dynamic var song5level: String = ""
    @objc dynamic var song5key: String = ""
    @objc dynamic var song6title: String = ""
    @objc dynamic var song6level: String = ""
    @objc dynamic var song6key: String = ""
    @objc dynamic var scoreLim: Int = 0
    @objc dynamic var feverLim: Int = 0   //"X"+feverLim
    @objc dynamic var comboLim: Int = 0
    @objc dynamic var rateLim: Int = 0    //rateLim+"%"
    @objc dynamic var breakLim: Int = 0
    @objc dynamic var more: String = ""   //기타 사항(이펙터)
    @objc dynamic var reward: String = ""
    
    //CREATE
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission = MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim;
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ song2title: String, _ song2level: String, _ song2key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission = MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.song2title = song2title
        mission.song2level = song2level
        mission.song2key = song2key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ song2title: String, _ song2level: String, _ song2key: String, _ song3title: String, _ song3level: String, _ song3key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission = MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.song2title = song2title
        mission.song2level = song2level
        mission.song2key = song2key
        mission.song3title = song3title
        mission.song3level = song3level
        mission.song3key = song3key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ song2title: String, _ song2level: String, _ song2key: String, _ song3title: String, _ song3level: String, _ song3key: String, _ song4title: String, _ song4level: String, _ song4key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission = MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.song2title = song2title
        mission.song2level = song2level
        mission.song2key = song2key
        mission.song3title = song3title
        mission.song3level = song3level
        mission.song3key = song3key
        mission.song4title = song4title
        mission.song4level = song4level
        mission.song4key = song4key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim;
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ song2title: String, _ song2level: String, _ song2key: String, _ song3title: String, _ song3level: String, _ song3key: String, _ song4title: String, _ song4level: String, _ song4key: String, _ song5title: String, _ song5level: String, _ song5key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission=MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.song2title = song2title
        mission.song2level = song2level
        mission.song2key = song2key
        mission.song3title = song3title
        mission.song3level = song3level
        mission.song3key = song3key
        mission.song4title = song4title
        mission.song4level = song4level
        mission.song4key = song4key
        mission.song5title = song5title
        mission.song5level = song5level
        mission.song5key = song5key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    
    static func add(_ type: String, _ section: String, _ title: String, _ song1title: String, _ song1level: String, _ song1key: String, _ song2title: String, _ song2level: String, _ song2key: String, _ song3title: String, _ song3level: String, _ song3key: String, _ song4title: String, _ song4level: String, _ song4key: String, _ song5title: String, _ song5level: String, _ song5key: String, _ song6title: String, _ song6level: String, _ song6key: String, _ scoreLim: Int, _ feverLim: Int, _ comboLim: Int, _ rateLim: Int, _ breakLim: Int, _ more: String, _ reward: String){
        let realm = try! Realm()
        let mission=MissionInfo()
        mission.type = type
        mission.section = section
        mission.title = title
        mission.song1title = song1title
        mission.song1level = song1level
        mission.song1key = song1key
        mission.song2title = song2title
        mission.song2level = song2level
        mission.song2key = song2key
        mission.song3title = song3title
        mission.song3level = song3level
        mission.song3key = song3key
        mission.song4title = song4title
        mission.song4level = song4level
        mission.song4key = song4key
        mission.song5title = song5title
        mission.song5level = song5level
        mission.song5key = song5key
        mission.song6title = song6title
        mission.song6level = song6level
        mission.song6key = song6key
        mission.scoreLim = scoreLim
        mission.feverLim = feverLim
        mission.comboLim = comboLim
        mission.rateLim = rateLim
        mission.breakLim = breakLim
        mission.more = more
        mission.reward = reward
        try! realm.write {
            realm.add(mission)
        }
    }
    
    //READ
    static func get() -> Results<MissionInfo> {
        let result = try! Realm().objects(MissionInfo.self)
        return result
    }
}

