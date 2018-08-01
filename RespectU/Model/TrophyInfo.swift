//
//  TrophyInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class TrophyInfo: Object {
    @objc dynamic var series: String = ""
    @objc dynamic var titleKor: String = ""
    @objc dynamic var contentKor: String = ""
    @objc dynamic var titleEng: String = ""
    @objc dynamic var contentEng: String = ""
    @objc dynamic var rating: String = ""
    
    static func add(_ series: String, _ titleKor: String, _ contentKor: String, _ titleEng: String, _ contentEng: String, _ rating: String){
        let realm = try! Realm()
        let trophy = TrophyInfo()
        trophy.series = series
        trophy.titleKor = titleKor
        trophy.contentKor = contentKor
        trophy.titleEng = titleEng
        trophy.contentEng = contentEng
        trophy.rating = rating
        try! realm.write {
            realm.add(trophy)
        }
    }
}

