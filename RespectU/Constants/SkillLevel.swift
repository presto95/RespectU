//
//  SkillLevel.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

enum SkillLevel {
    static let beginner = "BEGINNER"
    static let amateur4 = "AMATEUR 4"
    static let amateur3 = "AMATEUR 3"
    static let amateur2 = "AMATEUR 2"
    static let amateur1 = "AMATEUR 1"
    static let subDj4 = "SUB DJ 4"
    static let subDj3 = "SUB DJ 3"
    static let subDj2 = "SUB DJ 2"
    static let subDj1 = "SUB DJ 1"
    static let mainDj4 = "MAIN DJ 4"
    static let mainDj3 = "MAIN DJ 3"
    static let mainDj2 = "MAIN DJ 2"
    static let mainDj1 = "MAIN DJ 1"
    static let popDj4 = "POP DJ 4"
    static let popDj3 = "POP DJ 3"
    static let popDj2 = "POP DJ 2"
    static let popDj1 = "POP DJ 1"
    static let professional4 = "PROFESSIONAL 4"
    static let professional3 = "PROFESSIONAL 3"
    static let professional2 = "PROFESSIONAL 2"
    static let professional1 = "PROFESSIONAL 1"
    static let mixMaster3 = "MIX MASTER 3"
    static let mixMaster2 = "MIX MASTER 2"
    static let mixMaster1 = "MIX MASTER 1"
    static let superstar3 = "SUPERSTAR 3"
    static let superstar2 = "SUPERSTAR 2"
    static let superstar1 = "SUPERSTAR 1"
    static let djmaxGrandMaster = "DJMAX GRAND MASTER"
    static let theDjmax = "THE DJMAX"
    static var button4SkillLevels: [String] {
        return [beginner, amateur4, amateur3, amateur2, amateur1, subDj4, subDj3, subDj2, subDj1, mainDj4, mainDj3, mainDj2, mainDj1, popDj4, popDj3, popDj2, popDj1, professional3, professional2, professional1, mixMaster3, mixMaster2, mixMaster1, superstar3, superstar2, superstar1, djmaxGrandMaster, theDjmax]
    }
    static var button5SkillLevels: [String] {
        return [beginner, amateur4, amateur3, amateur2, amateur1, subDj4, subDj3, subDj2, subDj1, mainDj4, mainDj3, mainDj2, mainDj1, popDj4, popDj3, popDj2, popDj1, professional3, professional2, professional1, mixMaster3, mixMaster2, mixMaster1, superstar3, superstar2, superstar1, djmaxGrandMaster, theDjmax]
    }
    static var button6And8SkillLevels: [String] {
        return [beginner, amateur4, amateur3, amateur2, amateur1, subDj4, subDj3, subDj2, subDj1, mainDj4, mainDj3, mainDj2, mainDj1, popDj4, popDj3, popDj2, popDj1, professional4, professional3, professional2, professional1, mixMaster3, mixMaster2, mixMaster1, superstar3, superstar2, superstar1, djmaxGrandMaster, theDjmax]
    }
    
}
