//
//  PlaylistInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift
import UIKit


func addPlaylist(series: String, title: String, composer: String, bpm: String, nm4: Int, hd4: Int, mx4: Int, nm5: Int, hd5: Int, mx5: Int, nm6: Int, hd6: Int, mx6: Int, nm8: Int, hd8: Int, mx8: Int){
    let playlist=PlaylistInfo()
    playlist.series=series; playlist.title=title; playlist.composer=composer; playlist.bpm=bpm
    playlist.nm4=nm4; playlist.nm5=nm5; playlist.nm6=nm6; playlist.nm8=nm8
    playlist.hd4=hd4; playlist.hd5=hd5; playlist.hd6=hd6; playlist.hd8=hd8
    playlist.mx4=mx4; playlist.mx5=mx5; playlist.mx6=mx6; playlist.mx8=mx8
    
    let realm=try! Realm()
    playlist.id = (realm.objects(PlaylistInfo.self).max(ofProperty: "id") as Int? ?? 0) + 1
    try! realm.write{
        realm.add(playlist)
    }
}
