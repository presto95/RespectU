//
//  LanguageInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

class LanguageInfo: Object {
    @objc dynamic var english: String = ""
    @objc dynamic var korean: String?
}
