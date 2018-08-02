//
//  PlaylistInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift
import UIKit


class PlaylistInfo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var series: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var composer: String = ""
    @objc dynamic var bpm: String = ""
    @objc dynamic var nm4: Int = 0
    @objc dynamic var nm5: Int = 0
    @objc dynamic var nm6: Int = 0
    @objc dynamic var nm8: Int = 0
    @objc dynamic var hd4: Int = 0
    @objc dynamic var hd5: Int = 0
    @objc dynamic var hd6: Int = 0
    @objc dynamic var hd8: Int = 0
    @objc dynamic var mx4: Int = 0
    @objc dynamic var mx5: Int = 0
    @objc dynamic var mx6: Int = 0
    @objc dynamic var mx8: Int = 0
    
    //CREATE
    static func add(series: String, title: String, composer: String, bpm: String, nm4: Int, hd4: Int, mx4: Int, nm5: Int, hd5: Int, mx5: Int, nm6: Int, hd6: Int, mx6: Int, nm8: Int, hd8: Int, mx8: Int) {
        let playlist = PlaylistInfo()
        playlist.series = series
        playlist.title = title
        playlist.composer = composer
        playlist.bpm = bpm
        playlist.nm4 = nm4
        playlist.nm5 = nm5
        playlist.nm6 = nm6
        playlist.nm8 = nm8
        playlist.hd4 = hd4
        playlist.hd5 = hd5
        playlist.hd6 = hd6
        playlist.hd8 = hd8
        playlist.mx4 = mx4
        playlist.mx5 = mx5
        playlist.mx6 = mx6
        playlist.mx8 = mx8
        let realm = try! Realm()
        playlist.id = (realm.objects(PlaylistInfo.self).max(ofProperty: "id") as Int? ?? 0) + 1
        try! realm.write {
            realm.add(playlist)
        }
    }
    
    //READ
    static func get() -> Results<PlaylistInfo> {
        let result = try! Realm().objects(PlaylistInfo.self)
        return result
    }
}
