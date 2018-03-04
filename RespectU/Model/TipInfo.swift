//
//  TipInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class TipInfo: Object{
    @objc dynamic var tip: String=""
}

func addTip(_ tip: String){
    let realm = try! Realm()
    let tipInfo = TipInfo()
    tipInfo.tip = tip
    try! realm.write{
        realm.add(tipInfo)
    }
}
