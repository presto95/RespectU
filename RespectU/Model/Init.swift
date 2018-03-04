//
//  Init.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class Init{
   
    var realm: Realm! = nil
    
    init() {
        realm = try! Realm()
        if(!UserDefaults.standard.bool(forKey: "error1")){
            UserDefaults.standard.set(15, forKey: "version")
            UserDefaults.standard.set(true, forKey: "error1")
        }
        let version = UserDefaults.standard.integer(forKey: "version")
        
        if(version <= 15){
            try! realm.write{
                realm.delete(realm.objects(SongInfo.self))
                realm.delete(realm.objects(MissionInfo.self))
                realm.delete(realm.objects(TrophyInfo.self))
                realm.delete(realm.objects(AchievementInfo.self))
            }
            // Database - SongInfo
            
            //Clazziquai Edition
            addSong("CE", "Proposed, Flower, Wolf".localized, "ReX", "80", 1,3,6,1,6,0,1,4,7,1,3,7)
            addSong("CE", "Come to me".localized, "CLAZZIQUAI", "125", 3,5,8,4,0,8,2,7,9,4,8,12)
            addSong("CE", "To You".localized, "Sweetune", "133", 3,6,0,2,0,8,2,5,8,2,7,0)
            addSong("CE", "Forever".localized, "BEXTER", "114", 4,6,8,4,0,8,3,6,9,2,6,9)
            addSong("CE", "Closer", "3rd Coast", "120", 3,0,8,3,8,0,3,6,0,4,8,0)
            addSong("CE", "Coastal Tempo", "3rd Coast", "135", 5,7,11,3,8,12,4,7,11,4,8,11)
            addSong("CE", "Color", "CLAZZIQUAI", "120", 5,0,11,5,10,0,7,0,11,5,9,12)
            addSong("CE", "Creator", "CLAZZIQUAI", "117", 2,7,13,1,5,11,5,9,0,1,10,0)
            addSong("CE", "Electronics", "CLAZZIQUAI", "128", 4,8,11,4,8,13,5,8,12,4,9,13)
            addSong("CE", "Fate", "STi", "110", 3,7,9,3,8,10,3,9,0,3,7,10)
            addSong("CE", "First Kiss", "BJJ", "107", 2,4,8,2,4,7,2,5,7,2,4,8)
            addSong("CE", "Flea", "CLAZZIQUAI", "126", 4,9,12,4,9,12,5,9,12,6,0,13)
            addSong("CE", "Freedom", "CLAZZIQUAI", "126", 5,7,10,5,7,10,7,0,11,6,8,12)
            addSong("CE", "Here in the Moment", "Ruby Tuesday", "115", 4,7,10,4,8,10,6,8,10,5,0,10)
            addSong("CE", "In My Heart", "Tsukasa", "123", 3,7,10,4,7,10,4,8,10,3,7,11)
            addSong("CE", "Love Mode", "CLAZZIQUAI", "120", 3,8,0,2,6,9,4,9,0,2,6,10)
            addSong("CE", "Lover (CE Style)", "ND Lee", "145", 5,8,10,5,9,0,5,8,11,4,8,10)
            addSong("CE", "Tell Me", "Lee Geol".localized, "89", 1,6,0,2,5,9,3,6,8,1,8,0)
            addSong("CE", "The Clear Blue Sky", "Tsukasa", "178", 4,8,13,6,8,13,6,9,13,4,9,13)
            addSong("CE", "The Night Stage", "CLAZZIQUAI", "120", 3,6,0,3,7,0,3,8,0,3,7,10)
            addSong("CE", "Urban Night", "hYO", "93", 4,8,0,5,8,0,3,8,0,3,0,8)
            addSong("CE", "Y (CE Style)", "ND Lee", "130", 5,8,11,5,10,0,5,8,11,5,9,13)
            addSong("CE", "DARK ENVY", "Sugardonut", "195", 6, 11, 14, 6, 10, 14, 7, 10, 13, 6, 9, 14)
            
            //Trilogy
            addSong("Trilogy", "Memory of Wind".localized, "Forte Escape", "110", 3, 8, 0, 3, 6, 0, 3, 7, 0, 4, 9, 0)
            addSong("Trilogy", "A Lie ~Deep Inside Mix~", "Electronic Boutique", "110", 4, 9, 0, 6, 0, 11, 4, 11, 0, 6, 10, 0)
            addSong("Trilogy", "Bye Bye Love ~Nu Jazz Mix~", "Electronic Boutique", "130", 5, 8, 11, 6, 10, 0, 6, 8, 11, 6, 9, 11)
            addSong("Trilogy", "Catch You", "Forte Escape", "180", 3, 8, 0, 6, 8, 10, 4, 8, 0, 6, 8, 11)
            addSong("Trilogy", "For Seasons ~Air Guitar Mix~", "Planetboom", "116", 3, 10, 0, 5, 7, 10, 5, 0, 10, 5, 10, 0)
            addSong("Trilogy", "GET OUT ~Hip Noodle Mix~", "DJ EON", "123", 6, 10, 0, 5, 8, 12, 6, 9, 0, 5, 9, 12)
            addSong("Trilogy", "Mind Control", "NieN", "185", 8, 10, 13, 9, 11, 0, 9, 12, 14, 9, 11, 14)
            addSong("Trilogy", "My Jealousy", "3rd Coast", "130", 4, 7, 10, 6, 8, 0, 6, 8, 12, 6, 8, 11)
            addSong("Trilogy", "NB Girls", "NieN", "162", 6, 9, 0, 7, 0, 12, 5, 9, 11, 7, 12, 0)
            addSong("Trilogy", "sO mUCH iN LUV ~Melodic Twisted Mix~", "Forte Escape", "122", 5, 8, 0, 5, 8, 0, 4, 7, 10, 6, 8, 10)
            addSong("Trilogy", "Someday", "NieN", "136", 3, 5, 9, 4, 8, 10, 5, 7, 11, 4, 6, 10)
            addSong("Trilogy", "STOP", "3rd Coast", "90 ~ 162", 6, 10, 0, 8, 0, 12, 7, 9, 11, 6, 9, 12)
            addSong("Trilogy", "Streetlight", "Nauts", "115", 2, 7, 0, 3, 6, 0, 5, 9, 0, 4, 8, 0)
            addSong("Trilogy", "Syriana ~Blast Wave Mix~", "DJ EON", "135", 8, 10, 0, 8, 10, 12, 8, 11, 0, 8, 10, 13)
            addSong("Trilogy", "Talk! Talk!", "xxdbxx", "143", 5, 10, 13, 6, 8, 13, 8, 11, 13, 7, 9, 12)
            addSong("Trilogy", "Ventilator", "Cycle75", "145", 9, 11, 15, 9, 11, 14, 9, 12, 14, 9, 11, 14)
            addSong("Trilogy", "The One", "Paul Bazooka", "125", 5, 10, 0, 5, 9, 11, 7, 10, 12, 6, 9, 12)
            addSong("Trilogy", "Yo Creo Que Si ~Live House Version~", "BEXTER", "135", 7, 9, 12, 7, 9, 0, 6, 8, 12, 7, 9, 11)
            addSong("Trilogy", "Your Own Miracle ~Disco House Mix~", "makou", "130", 4, 8, 10, 5, 11, 0, 6, 0, 11, 3, 8, 0)
            addSong("Trilogy", "ZET", "BEXTER", "125", 7, 10, 0, 7, 10, 0, 7, 9, 13, 8, 11, 13)
            
            //Respect
            addSong("Respect", "Soar ~Stay With Me~".localized, "Mycin.T", "142", 4, 7, 0, 6, 10, 0, 6, 10, 11, 7, 11, 0)
            addSong("Respect", "2Nite", "ND Lee", "110", 4, 6, 0, 4, 9, 0, 3, 8, 0, 4, 8, 0)
            addSong("Respect", "Armored Phantom", "ned", "151", 3, 7, 0, 6, 11, 0, 7, 9, 12, 6, 11, 0)
            addSong("Respect", "Beautiful Day", "ND Lee", "83", 3, 6, 8, 4, 8, 0, 2, 8, 0, 4, 8, 0)
            addSong("Respect", "Beyond Yourself", "Mycin.T", "90", 6, 9, 0, 6, 10, 0, 7, 9, 12, 6, 11, 0)
            addSong("Respect", "Binary World", "Tsukasa", "182", 5, 8, 13, 5, 7, 13, 9, 12, 13, 5, 7, 13)
            addSong("Respect", "BlackCat", "BEXTER", "130", 5, 11, 0, 6, 11, 0, 5, 8, 12, 7, 12, 0)
            addSong("Respect", "Bullet, Wanted!", "Mycin.T", "150", 4, 8, 0, 7, 10, 0, 6, 9, 11, 7, 10, 0)
            addSong("Respect", "Child of Night", "GOTH", "130", 6, 8, 0, 7, 9, 12, 7, 10, 12, 7, 9, 12)
            addSong("Respect", "Don't Die", "Paul Bazooka", "175", 5, 9, 13, 7, 10, 14, 8, 11, 14, 7, 10, 14)
            addSong("Respect", "Enter The Universe", "GOTH", "162", 6, 9, 12, 7, 10, 14, 9, 12, 14, 7, 10, 14)
            addSong("Respect", "Far East Princess", "Nauts", "102", 5, 9, 10, 5, 10, 0, 3, 9, 12, 5, 9, 0)
            addSong("Respect", "glory day", "BEXTER / Mycin.T", "162", 8, 10, 0, 7, 10, 0, 6, 11, 0, 7, 10, 0)
            addSong("Respect", "Groovin Up", "Mycin.T", "120", 3, 6, 0, 5, 9, 0, 5, 8, 11, 5, 9, 0)
            addSong("Respect", "Heavenly", "Makou", "125", 5, 7, 0, 4, 8, 0, 5, 9, 12, 4, 9, 0)
            addSong("Respect", "KILLER BEE", "GOTH", "116 ~ 155", 4, 6, 11, 7, 11, 0, 8, 9, 13, 7, 12, 0)
            addSong("Respect", "Kung Brother", "Paul Bazooka", "145", 6, 9, 0, 6, 11, 0, 8, 10, 13, 6, 11, 0)
            addSong("Respect", "Liar", "zts", "140", 6, 9, 0, 8, 12, 0, 8, 10, 13, 8, 13, 0)
            addSong("Respect", "Lift You Up", "Makou", "88", 2, 5, 0, 4, 7, 0, 3, 7, 0, 4, 7, 0)
            addSong("Respect", "Mulch", "Sampling Masters MEGA", "200", 6, 12, 0, 7, 0, 14, 8, 12, 14, 7, 0, 15)
            addSong("Respect", "NB RANGER - Virgin Force", "NieN", "198", 5, 9, 0, 7, 12, 15, 7, 12, 14, 7, 11, 15)
            addSong("Respect", "Only for you", "NieN", "122", 1, 4, 9, 5, 7, 10, 4, 7, 11, 5, 7, 10)
            addSong("Respect", "OPEN FIRE", "JC", "140", 4, 7, 0, 4, 8, 0, 5, 7, 0, 5, 8, 0)
            addSong("Respect", "quixotic", "bermei.inazawa", "174", 7, 12, 0, 7, 11, 0, 6, 0, 13, 7, 11, 0)
            addSong("Respect", "Remains Of Doom", "NieN", "124", 7, 13, 0, 6, 9, 14, 9, 12, 15, 6, 10, 13)
            addSong("Respect", "Royal Clown", "bermei.inazawa", "143 ~ 164", 6, 9, 0, 7, 11, 0, 7, 10, 13, 7, 10, 0)
            addSong("Respect", "Nevermind", "Paul Bazooka", "142", 7, 10, 13, 7, 11, 0, 7, 10, 13, 6, 10, 15)
            addSong("Respect", "Runaway", "LeeZu", "140", 6, 10, 0, 8, 11, 0, 9, 11, 12, 8, 13, 0)
            addSong("Respect", "Running girl", "Mycin.T", "170", 5, 7, 0, 5, 9, 0, 4, 10, 12, 6, 10, 0)
            addSong("Respect", "Ruti'n (GOTH Wild Electro Remix)", "GOTH", "112", 6, 10, 0, 4, 10, 0, 7, 10, 13, 9, 12, 0)
            addSong("Respect", "Secret Dejavu", "DINY", "160", 4, 6, 10, 5, 10, 0, 6, 8, 11, 5, 10, 0)
            addSong("Respect", "Shadow Flower", "ned", "142", 3, 6, 0, 6, 9, 0, 5, 11, 0, 6, 9, 0)
            addSong("Respect", "The Feelings", "Supbaby", "130", 5, 7, 0, 6, 9, 0, 6, 10, 0, 6, 10, 0)
            addSong("Respect", "The Lost Story", "NEOWIZ Bless Soundteam", "70", 1, 4, 0, 4, 8, 0, 2, 7, 0, 4, 7, 0)
            addSong("Respect", "The Obliterator", "GOTH", "186", 5, 8, 0, 7, 11, 0, 8, 0, 13, 7, 11, 0)
            addSong("Respect", "U.A.D", "HAYAKO", "129", 3, 6, 0, 5, 10, 0, 6, 8, 11, 8, 0, 12)
            addSong("Respect", "v o l d e n u i t", "Cuve", "105", 5, 9, 12, 4, 9, 12, 5, 9, 12, 6, 9, 13)
            addSong("Respect", "waiting for me", "Croove", "150", 3, 8, 0, 4, 8, 0, 4, 9, 0, 5, 9, 0)
            addSong("Respect", "Waiting for you", "Mycin.T", "175", 4, 8, 0, 6, 10, 0, 6, 12, 0, 7, 11, 0)
            addSong("Respect", "We're All Gonna Die", "Paul Bazooka", "180", 7, 12, 14, 8, 12, 0, 11, 13, 15, 8, 12, 15)
            addSong("Respect", "WHY", "Nauts", "84", 3, 7, 0, 5, 10, 0, 2, 7, 10, 4, 7, 0)
            addSong("Respect", "Break a Spell", "Daisuke Ishiwatari", "200", 5, 9, 14, 6, 10, 0, 7, 9, 14, 7, 10, 14)
            addSong("Respect", "Holy Orders (Be Just Or Be Dead)", "Daisuke Ishiwatari", "120", 4, 9, 11, 6, 8, 11, 6, 9, 12, 6, 10, 12)
            addSong("Respect", "Marionette", "Daisuke Ishiwatari", "136", 5, 9, 13, 7, 12, 0, 6, 10, 13, 8, 0, 13)
            addSong("Respect", "Rising The Sonic", "Dayz", "137", 4,9,12,5,10,13,5,9,13,5,10,14)
            
            //Portable 1
            addSong("Portable1", "Ask to Wind".localized, "Forte Escape", "108", 1, 7, 0, 6, 7, 0, 3, 7, 9, 4, 8, 0)
            addSong("Portable1", "Every Morning".localized, "ND Lee", "150", 3, 8, 0, 8, 9, 0, 6, 9, 0, 8, 10, 0)
            addSong("Portable1", "Piano Concerto No.1".localized, "Wav Factory", "156", 5, 10, 0, 7, 11, 0, 7, 11, 0, 7, 11, 0)
            addSong("Portable1", "A.I", "Forte Escape", "138", 4, 9, 0, 8, 12, 0, 7, 11, 13, 8, 10, 0)
            addSong("Portable1", "Astro Fight", "Forte Escape", "183", 8, 13, 0, 8, 11, 0, 7, 13, 14, 8, 12, 0)
            addSong("Portable1", "BlythE", "M2U", "180", 6, 9, 14, 6, 11, 0, 8, 11, 13, 7, 0, 14)
            addSong("Portable1", "Bright Dream", "M2U", "130", 2, 4, 0, 5, 8, 0, 4, 7, 10, 6, 9, 0)
            addSong("Portable1", "Can We Talk", "Forte Escape", "125", 1, 7, 0, 7, 9, 13, 5, 8, 11, 8, 9, 12)
            addSong("Portable1", "Catch Me", "Forte Escape", "145", 3, 6, 0, 6, 0, 0, 7, 8, 0, 8, 12, 0)
            addSong("Portable1", "Chrono Breakers", "NieN", "178", 5, 7, 11, 7, 10, 0, 7, 12, 0, 8, 13, 0)
            addSong("Portable1", "CnP", "CrooFE", "127", 3, 8, 12, 4, 9, 12, 4, 9, 12, 5, 10, 12)
            addSong("Portable1", "Elastic STAR", "Forte Escape", "132", 4, 7, 0, 6, 7, 0, 4, 8, 0, 4, 7, 0)
            addSong("Portable1", "End of the Moonlight", "Forte Escape", "155", 3, 7, 10, 5, 9, 0, 5, 9, 12, 7, 11, 0)
            addSong("Portable1", "Enemy Storm", "Croove", "133", 2, 5, 13, 5, 8, 0, 6, 8, 11, 5, 10, 14)
            addSong("Portable1", "Eternal Memory".localized, "M2U", "125", 2, 6, 0, 3, 0, 0, 2, 7, 0, 5, 7, 0)
            addSong("Portable1", "Extreme Z4", "Forte Escape", "160", 3, 7, 0, 4, 8, 0, 7, 9, 0, 8, 12, 0)
            addSong("Portable1", "FEAR", "Supbaby", "182", 4, 9, 0, 5, 9, 12, 6, 12, 0, 8, 11, 13)
            addSong("Portable1", "Fever GJ", "xxdbxx", "98", 3, 7, 0, 3, 6, 0, 3, 7, 11, 7, 0, 0)
            addSong("Portable1", "FTR", "Supbaby", "140", 6, 10, 0, 5, 10, 0, 8, 11, 0, 7, 11, 0)
            addSong("Portable1", "Funky Chups", "Forte Escape", "127", 4, 0, 0, 5, 10, 0, 4, 6, 0, 7, 0, 0)
            addSong("Portable1", "Futurism", "Forte Escape", "142", 4, 8, 0, 7, 9, 0, 6, 8, 11, 8, 10, 0)
            addSong("Portable1", "HAMSIN", "makou", "150", 9, 0, 15, 6, 9, 13, 9, 12, 14, 6, 9, 14)
            addSong("Portable1", "JBG", "Croove", "102", 7, 11, 0, 7, 11, 0, 7, 10, 12, 11, 0, 0)
            addSong("Portable1", "Jupiter Driving", "xxdbxx", "144", 5, 9, 0, 5, 11, 0, 5, 8, 0, 7, 11, 0)
            addSong("Portable1", "KUDA", "Gonzo", "126", 8, 11, 0, 5, 9, 0, 8, 12, 0, 10, 0, 0)
            addSong("Portable1", "Lemonade", "M2U", "195", 8, 0, 0, 6, 13, 0, 7, 10, 0, 8, 12, 0)
            addSong("Portable1", "Let's Go Baby", "3rd Coast", "108", 2, 5, 0, 6, 8, 0, 3, 7, 10, 9, 0, 0)
            addSong("Portable1", "Light House", "xxdbxx", "162", 4, 9, 0, 4, 11, 0, 6, 8, 11, 7, 12, 0)
            addSong("Portable1", "Long Vacation", "ESTi", "138", 4, 8, 0, 3, 6, 0, 5, 9, 0, 7, 0, 0)
            addSong("Portable1", "Luv Flow", "3rd Coast", "115", 1, 5, 0, 3, 6, 0, 1, 5, 0, 6, 8, 0)
            addSong("Portable1", "MASAI", "Croove", "128", 4, 7, 0, 5, 8, 0, 7, 10, 12, 10, 0, 0)
            addSong("Portable1", "Memory of Beach", "M2U", "130", 6, 0, 0, 7, 0, 0, 6, 9, 12, 8, 0, 0)
            addSong("Portable1", "Minimal Life", "Earbreaker", "145", 5, 7, 0, 7, 9, 0, 8, 12, 0, 8, 10, 14)
            addSong("Portable1", "NB RANGER", "M2U", "140", 8, 12, 0, 7, 12, 0, 7, 10, 13, 9, 13, 0)
            addSong("Portable1", "Never Say", "ND Lee", "90", 3, 6, 0, 6, 7, 0, 2, 7, 12, 8, 0, 0)
            addSong("Portable1", "OBLIVION", "ESTi", "141", 3, 6, 11, 7, 0, 11, 3, 8, 11, 6, 11, 0)
            addSong("Portable1", "OBLIVION ~Rockin' Night Style~", "NieN", "141", 3, 8, 12, 4, 10, 12, 7, 9, 13, 6, 11, 12)
            addSong("Portable1", "ON", "ND Lee", "72", 3, 5, 0, 2, 6, 0, 6, 10, 0, 7, 0, 0)
            addSong("Portable1", "One the Love", "xxdbxx", "125", 2, 5, 0, 6, 8, 0, 3, 6, 11, 7, 8, 0)
            addSong("Portable1", "Out Law", "Croove", "126", 5, 12, 0, 7, 12, 0, 7, 11, 13, 8, 12, 0)
            addSong("Portable1", "Para-Q", "Forte Escape", "160", 3, 10, 0, 6, 8, 0, 7, 10, 0, 10, 0, 0)
            addSong("Portable1", "Ray of Illuminati", "ESTi", "150", 4, 7, 13, 6, 8, 13, 7, 10, 13, 8, 11, 0)
            addSong("Portable1", "RED", "Croove", "107", 4, 6, 0, 5, 13, 0, 6, 9, 12, 8, 13, 0)
            addSong("Portable1", "REVENGE", "ND Lee", "120", 5, 0, 10, 3, 7, 0, 8, 12, 0, 10, 0, 0)
            addSong("Portable1", "Road Of Death", "NieN", "180", 4, 9, 0, 7, 13, 0, 8, 11, 14, 7, 13, 0)
            addSong("Portable1", "Rock Or Die", "NieN", "106", 6, 0, 0, 6, 9, 0, 6, 10, 12, 6, 9, 0)
            addSong("Portable1", "Save My Dream", "Forte Escape", "125", 1, 4, 0, 2, 4, 0, 2, 5, 9, 5, 8, 0)
            addSong("Portable1", "SIN", "ESTi", "190", 3, 6, 11, 7, 10, 0, 7, 10, 0, 9, 12, 0)
            addSong("Portable1", "SIN ~The Last Scene~", "ESTi", "200", 7, 12, 14, 7, 11, 0, 8, 12, 14, 8, 13, 0)
            addSong("Portable1", "Sunny Side", "Croove", "112", 4, 8, 0, 5, 9, 0, 5, 8, 11, 10, 0, 0)
            addSong("Portable1", "Sunny Side ~Deepn' Soul Mix~", "makou", "122", 7, 10, 0, 7, 0, 0, 7, 0, 11, 8, 10, 0)
            addSong("Portable1", "Temptation", "S-TRO", "136", 4, 10, 0, 4, 10, 0, 6, 0, 12, 9, 0, 0)
            addSong("Portable1", "Triple Zoe", "Forte Escape", "150", 4, 11, 0, 6, 11, 0, 8, 12, 0, 10, 12, 0)
            addSong("Portable1", "Ya! Party!", "Forte Escape", "194", 4, 8, 0, 5, 10, 0, 5, 8, 12, 9, 0, 0)
            addSong("Portable1", "Dreadnought", "EarBreaker", "140", 6,9,12,8,11,0,8,0,13,8,13,0)
            
            //Portable 2
            addSong("Portable2", "HeartBeat".localized, "ND Lee", "155", 3, 5, 0, 4, 8, 0, 4, 7, 9, 6, 9, 0)
            addSong("Portable2", "Taekwonburi".localized, "xxdbxx", "162", 5, 7, 0, 6, 0, 11, 6, 10, 14, 7, 0, 12)
            addSong("Portable2", "A Lie", "makou", "100", 2, 5, 0, 5, 9, 0, 4, 6, 12, 7, 9, 0)
            addSong("Portable2", "Another DAY", "Forte Escape", "142", 3, 7, 11, 6, 8, 0, 5, 8, 10, 7, 9, 0)
            addSong("Portable2", "Brain Storm", "Croove", "172", 6, 9, 0, 7, 11, 14, 9, 13, 0, 8, 12, 14)
            addSong("Portable2", "Brandnew Days", "Planetboom", "124", 3, 8, 0, 6, 8, 0, 7, 10, 11, 7, 10, 0)
            addSong("Portable2", "Brave it Out", "BEXTER", "124", 6, 8, 0, 5, 9, 11, 6, 10, 13, 7, 10, 12)
            addSong("Portable2", "Bye Bye Love", "3rd Coast", "120", 2, 8, 0, 6, 7, 0, 6, 9, 11, 6, 8, 0)
            addSong("Portable2", "Chain of Gravity", "Tsukasa", "155", 5, 11, 0, 5, 10, 0, 7, 10, 12, 6, 11, 0)
            addSong("Portable2", "Cherokee", "xxdbxx", "136", 5, 8, 0, 7, 9, 0, 6, 9, 13, 7, 10, 0)
            addSong("Portable2", "DIVINE SERVICE", "Electronic Boutique", "151", 4, 7, 0, 4, 9, 0, 4, 8, 12, 7, 10, 0)
            addSong("Portable2", "Dream of You", "makou", "192", 4, 6, 11, 6, 10, 0, 5, 9, 11, 8, 11, 0)
            addSong("Portable2", "Fallen Angel", "DJ Mocha", "142", 4, 8, 0, 4, 8, 0, 3, 7, 10, 8, 10, 0)
            addSong("Portable2", "Fentanest", "Earbreaker / Eszett", "20 ~ 160", 4, 10, 0, 6, 9, 0, 7, 11, 0, 6, 9, 0)
            addSong("Portable2", "For Seasons", "makou", "116", 1, 6, 0, 6, 9, 0, 4, 7, 11, 5, 9, 0)
            addSong("Portable2", "For the IKARUS", "NieN", "154", 4, 8, 0, 5, 11, 0, 8, 0, 12, 6, 12, 0)
            addSong("Portable2", "Get on Top", "Planetboom", "125", 3, 7, 0, 6, 9, 0, 5, 8, 12, 7, 10, 0)
            addSong("Portable2", "GET OUT", "ND Lee", "112", 5, 8, 0, 4, 9, 0, 4, 8, 13, 7, 10, 0)
            addSong("Portable2", "Good Bye", "Ruby Tuesday", "136", 5, 7, 0, 4, 9, 0, 7, 0, 12, 6, 9, 0)
            addSong("Portable2", "Hello Pinky", "NieN", "141", 5, 8, 0, 5, 10, 0, 7, 11, 0, 6, 11, 0)
            addSong("Portable2", "Higher", "Supbaby", "137", 4, 8, 0, 6, 11, 0, 6, 9, 0, 4, 8, 12)
            addSong("Portable2", "Ladymade Star", "ESTi", "136", 2, 6, 0, 3, 8, 0, 5, 8, 10, 5, 8, 0)
            addSong("Portable2", "Lost n' found", "bermei.inazawa", "165", 3, 7, 0, 6, 8, 0, 5, 9, 0, 7, 9, 0)
            addSong("Portable2", "Memoirs", "M2U", "140", 4, 9, 0, 7, 10, 0, 6, 9, 11, 7, 10, 0)
            addSong("Portable2", "Mess it Up", "Nauts", "140", 5, 9, 0, 4, 9, 0, 9, 12, 0, 6, 10, 0)
            addSong("Portable2", "Midnight Blood", "NieN", "147", 6, 13, 0, 6, 13, 0, 7, 10, 13, 6, 9, 13)
            addSong("Portable2", "Miles", "Electronic Boutique", "130", 2, 10, 0, 5, 10, 13, 4, 9, 13, 4, 11, 13)
            addSong("Portable2", "Minus 3", "Croove", "147", 8, 11, 0, 6, 12, 0, 10, 0, 13, 7, 12, 0)
            addSong("Portable2", "My Alias", "Dayz", "110", 6, 9, 0, 6, 9, 12, 6, 9, 14, 5, 10, 0)
            addSong("Portable2", "NANO RISK", "Dayz", "176", 6, 0, 0, 7, 11, 0, 6, 9, 12, 7, 11, 0)
            addSong("Portable2", "NB POWER", "NieN", "185", 5, 7, 0, 6, 9, 13, 7, 11, 13, 7, 10, 0)
            addSong("Portable2", "NB Rangers -Returns-", "NieN", "145", 5, 9, 0, 7, 11, 0, 9, 11, 13, 7, 12, 0)
            addSong("Portable2", "Negative Nature", "Electronic Boutique", "125 ~ 145", 4, 8, 0, 4, 7, 0, 7, 12, 0, 4, 8, 0)
            addSong("Portable2", "Nightmare", "M2U", "190", 10, 12, 0, 8, 13, 15, 8, 13, 15, 8, 12, 15)
            addSong("Portable2", "Phantom Of Sky", "M2U", "115", 3, 7, 10, 4, 7, 0, 5, 10, 0, 4, 8, 0)
            addSong("Portable2", "plastic method", "zts", "118", 5, 8, 0, 8, 12, 0, 8, 12, 0, 8, 12, 0)
            addSong("Portable2", "Right Now", "makou", "90", 1, 5, 0, 4, 8, 0, 4, 8, 11, 6, 8, 0)
            addSong("Portable2", "Rocka-a-doodle-doo", "makou", "135", 3, 9, 0, 4, 8, 0, 7, 11, 0, 5, 9, 0)
            addSong("Portable2", "Rolling On the Duck", "NieN", "180", 7, 10, 0, 7, 10, 14, 8, 11, 14, 7, 10, 14)
            addSong("Portable2", "Seeker", "M2U", "150", 5, 9, 0, 8, 0, 14, 5, 9, 13, 7, 13, 0)
            addSong("Portable2", "Showtime", "Ruby Tuesday", "138", 6, 8, 0, 6, 9, 0, 8, 12, 0, 6, 10, 0)
            addSong("Portable2", "Smoky Quartz", "makou", "104", 3, 6, 0, 7, 10, 0, 6, 0, 11, 7, 13, 0)
            addSong("Portable2", "sO mUCH iN LUV", "3rd Coast", "130", 1, 6, 0, 3, 6, 0, 4, 7, 11, 7, 0, 0)
            addSong("Portable2", "SQUEEZE", "Oriental ST8", "147", 4, 9, 0, 7, 10, 0, 8, 10, 12, 7, 10, 0)
            addSong("Portable2", "STALKER", "ND Lee", "112", 5, 10, 0, 7, 9, 0, 6, 10, 12, 8, 0, 14)
            addSong("Portable2", "StarFish", "PlanetBoom", "150", 6, 9, 0, 7, 10, 0, 6, 10, 0, 6, 9, 0)
            addSong("Portable2", "Stay with me", "Ruby Tuesday", "140", 2, 4, 0, 4, 7, 0, 3, 7, 0, 5, 9, 0)
            addSong("Portable2", "Sunset Rider", "Nauts", "170", 5, 9, 0, 6, 10, 0, 5, 7, 11, 6, 9, 0)
            addSong("Portable2", "Syriana", "BEXTER", "135", 6, 9, 0, 6, 9, 0, 6, 9, 13, 5, 9, 0)
            addSong("Portable2", "WhiteBlue", "zts", "144", 7, 9, 13, 6, 10, 13, 7, 11, 13, 8, 11, 13)
            addSong("Portable2", "Yellowberry -AJ Mix-", "Forte Escape", "151", 4, 7, 0, 3, 6, 0, 5, 9, 0, 4, 8, 0)
            addSong("Portable2", "Yo Creo Que Si", "makou", "135", 6, 8, 0, 6, 9, 0, 8, 0, 12, 7, 9, 0)
            addSong("Portable2", "Your Own Miracle", "Ruby Tuesday", "136", 3, 9, 0, 3, 6, 10, 6, 10, 12, 7, 10, 13)
            
            //Database - Mission
            
            //Clazziquai Edition
            addMission("CE", "Electronic City", "Club Tour", "Love Mode", "NORMAL", "4B", "Come to me".localized, "NORMAL", "4B", "Freedom", "NORMAL", "4B", 850000,0,0,0,0,"Fever-Manual", "Gallery : Clear (Flea Ver.)")
            addMission("CE", "Electronic City", "Hunter & Hunter", "Cherokee", "NORMAL", "4B", "The Feelings", "NORMAL", "5B", "Proposed, Flower, Wolf".localized, "MAXIMUM", "6B", 0,3,0,0,0,"Fever-Manual","Gallery : "+"Forever".localized+" (3)")
            addMission("CE", "Electronic City", "BubiBubi", "The Night Stage", "HARD", "4B", "Color", "MAXIMUM", "4B", "Flea", "FX", "4B", "Electronics", "FX", "4B",0,0,0,0,30,"Fever-OFF","Gallery : Freedom (3)")
            addMission("CE", "Electronic City", "4DmaX", "To You".localized, "NORMAL", "5B", "Fate", "NORMAL", "5B", "Urban Night", "NORMAL", "5B", "Forever".localized, "NORMAL", "5B", 0,0,0,95,0,"Fever-OFF","Gallery : Creator (3)")
            addMission("CE", "Electronic City", "Catch Me If You Can", "Mess it Up", "HARD", "5B", "StarFish", "HARD", "6B", "Bullet, Wanted!", "HARD", "4B", "In My Heart", "MAXIMUM", "4B", 1000000,0,3000,0,0,"Fever-Manual / FOG","Gallery : In My Heart (3)")
            addMission("CE", "Electronic City", "CLAZZIQUAI", "Creator", "FX", "4B", "Come to me".localized, "FX", "4B", "Flea", "MAXIMUM", "6B", 0,0,0,95,0,"Fever-OFF / Gear : CE","Gallery : EXTRA (8)")
            addMission("CE", "Metropolis", "Heaven's Gate", "Closer", "NORMAL", "4B", "For the IKARUS", "NORMAL", "5B", "The Clear Blue Sky", "NORMAL", "6B", "Ask to Wind".localized, "NORMAL", "8B", 1000000,0,0,0,0,"Fever-Manual","Gallery : The Clear Blue Sky (3)")
            addMission("CE", "Metropolis","GLASS Field", "sO mUCH iN LUV", "HARD", "4B", "Secret Dejavu", "HARD", "4B", "Creator", "HARD", "4B", 0,3,1500,0,0,"Fever-Manual / FADE IN","Gallery : First Kiss (3)")
            addMission("CE", "Metropolis","Metro Project Vol.1", "Coastal Tempo", "FX", "4B", "Here in the Moment", "FX", "4B", "In My Heart", "FX", "4B", "Rising The Sonic", "FX", "4B", 0,0,0,92,0,"Fever-OFF","Gallery : Here in the Moment (3)")
            addMission("CE", "Metropolis","5inary Box", "RANDOM", "HARD", "4B", "RANDOM", "HARD", "5B", "RANDOM", "MAXIMUM", "6B", "RANDOM", "HARD", "8B", "RANDOM", "FX", "4B",0,0,0,0,25,"Fever-OFF","Gallery : Fate (3)")
            addMission("CE", "Metropolis", "DJMAX TOURNAMENT R3", "Dreadnought", "MAXIMUM", "4B", "Coastal Tempo", "MAXIMUM", "5B", "The Clear Blue Sky", "MAXIMUM", "6B", "Y (CE Style)", "MAXIMUM", "8B",0,0,0,0,0,"Fever-AUTO / vs AI","Plate : Clear (Flea Ver.) / Trophy : DJ Alpha Resigns")
            addMission("CE", "Metropolis","DJMAX TOURNAMENT LIVE", "First Kiss", "MAXIMUM", "6B", "Far East Princess", "MAXIMUM", "6B", "Proposed, Flower, Wolf".localized, "MAXIMUM", "6B", "Coastal Tempo","MAXIMUM", "6B", "Lover (CE Style)","MAXIMUM","6B",0,0,0,0,10,"Fever-OFF","Gallery : Fail (Flea Ver.) / Trophy : DJMAX ARTIST TEAM")
            
            //Respect
            addMission("Respect", "Departure", "Restarting Line", "Ask to Wind".localized, "NORMAL", "4B", "Only for you", "NORMAL", "4B", 400000, 0, 0, 0, 0, "Fever-Manual", "Music : Only for you")
            addMission("Respect", "Departure", "Mighty Fine Morning", "Every Morning".localized, "NORMAL", "4B", "HeartBeat".localized, "NORMAL", "4B", 0, 0, 0, 85, 0, "Fever OFF", "Plate : "+"Every Morning".localized)
            addMission("Respect", "Departure", "Day Dream", "Eternal Memory".localized, "NORMAL", "5B", "Long Vacation", "NORMAL", "5B", "Lift You Up", "NORMAL", "5B", 0, 0, 0, 0, 15, "Fever OFF", "Comment : "+"Super Rookie".localized)
            addMission("Respect", "Departure", "SweetCute", "Bright Dream", "NORMAL", "4B", "Catch Me", "NORMAL", "4B", "Beautiful Day", "NORMAL", "4B", 0, 2, 0, 0, 0, "Fever-Manual", "Plate : "+"HeartBeat".localized)
            addMission("Respect", "Departure", "Lovextreme", "sO mUCH iN LUV", "NORMAL", "4B", "Let's Go Baby", "NORMAL", "4B", "Secret Dejavu", "NORMAL", "4B", 0, 0, 300, 0, 0, "Fever-Manual", "Music : Secret Dejavu")
            addMission("Respect", "Departure", "Angelic Eyes", "Luv Flow", "NORMAL", "5B", "Save My Dream", "HARD", "5B", "Far East Princess", "NORMAL", "5B", 750000, 0, 0, 0, 0, "Fever-Manual", "Plate : Departure")
            addMission("Respect", "CLUB Road645", "enTRANCE", "Jupiter Driving", "NORMAL", "4B", "Futurism", "NORMAL", "4B", "Binary World", "NORMAL", "4B", 0, 0, 600, 0, 0, "Fever-Manual", "Music : Binary World")
            addMission("Respect", "CLUB Road645", "Dancing Stage", "Ladymade Star", "NORMAL", "5B", "Good Bye", "NORMAL", "5B", "Groovin Up", "NORMAL", "5B", 0, 0, 0, 0, 10, "Fever OFF / Gear&Note : Ladymade Star", "Comment : "+"Entertainer".localized)
            addMission("Respect", "CLUB Road645", "Show me the MAX", "Fever GJ", "NORMAL", "5B", "GET OUT", "NORMAL", "5B", "JBG", "NORMAL", "5B", "OPEN FIRE", "NORMAL", "5B", 0, 0, 0, 90, 0, "Fever OFF", "Plate : Binary World")
            addMission("Respect", "CLUB Road645", "Purple Lounge", "Mess it Up", "NORMAL", "4B", "Dream of You", "NORMAL", "4B", "RED", "NORMAL", "4B", "The Feelings", "NORMAL", "4B", 1000000, 0, 0, 0, 0, "Fever-Manual / FADE OUT", "Gallery : The Feelings (2)")
            addMission("Respect", "CLUB Road645", "Groove Zet Coaster", "Extreme Z4", "NORMAL", "4B", "Chain of Gravity", "NORMAL", "4B", "For the IKARUS", "NORMAL", "4B", "v o l d e n u i t", "NORMAL", "4B", 0, 0, 0, 0, 15, "Fever OFF / SLIDE UP", "Comment : "+"I Hate Fast Songs!".localized)
            addMission("Respect", "CLUB Road465", "Live in Summer", "Memory of Beach", "NORMAL", "6B", "Yo Creo Que Si", "NORMAL", "6B", "Your Own Miracle", "NORMAL", "4B", "Waiting for you", "NORMAL", "6B", 1100000, 3, 0, 0, 0, "Fever-Manual", "Plate : CLUB Road645")
            addMission("Respect", "MAX Theater", "Cosmic Fantasy", "End of the Moonlight", "NORMAL", "5B", "One the Love", "NORMAL", "5B", "Ray of Illuminati", "NORMAL", "5B", "Soar ~Stay With Me~".localized, "NORMAL", "5B", 0, 0, 0, 92, 0, "Fever OFF", "Music : "+"Soar ~Stay With Me~".localized)
            addMission("Respect", "MAX Theater", "Animal Symphony", "For Seasons", "HARD", "4B", "Light House", "NORMAL", "4B", "Showtime", "NORMAL", "4B", 830000, 0, 0, 0, 0, "Fever-Manual / Gear&Note : Chicken&Egg", "Note : Egg")
            addMission("Respect", "MAX Theater", "Emotion Pulse", "DIVINE SERVICE", "NORMAL", "6B", "Stay with me", "HARD", "6B", "Brandnew Days", "NORMAL", "6B", "waiting for me", "HARD", "6B", 0, 0, 0, 93, 0, "Fever OFF", "Plate : Brandnew Days")
            addMission("Respect", "MAX Theater", "The Decisive Moment", "MASAI", "HARD", "4B", "OBLIVION", "HARD", "4B", "Minus 3", "NORMAL", "4B", "The Obliterator", "HARD", "4B", 0, 0, 1200, 0, 0, "Speed : 1.00 / Fever-Manual / FADE IN", "Music : The Obliterator")
            addMission("Respect", "MAX Theater", "Virtual Reality", "Lost n' found", "NORMAL", "6B", "Beyond Yourself", "NORMAL", "6B", "FEAR", "NORMAL", "6B", "U.A.D", "NORMAL", "6B", 0, 0, 0, 0, 30, "Fever OFF / CHAOS W", "Plate : MAX Theater")
            addMission("Respect", "MAX Theater", "NB is an Open Door", "NB RANGER", "NORMAL", "5B", "NB Rangers -Returns-", "NORMAL", "5B", "NB POWER", "HARD", "5B", "NB RANGER - Virgin Force", "NORMAL", "5B", 0, 0, 3000, 0, 0, "Fever-Manual / Gear&Note : NB RANGER", "Music : NB RANGER - Virgin Force")
            addMission("Respect", "Another WORLD", "Girl Crush", "StarFish", "NORMAL", "6B", "Out Law", "NORMAL", "6B", "GET OUT", "HARD", "6B", "Runaway", "NORMAL", "6B", 1150000, 0, 0, 0, 0, "Fever-Manual", "Gallery : Runaway (2)")
            addMission("Respect", "Another WORLD", "Resurrection", "Fallen Angel", "HARD", "6B", "Seeker", "HARD", "6B", "SIN", "NORMAL", "6B", "Don't Die", "NORMAL", "6B", 0, 3, 0, 0, 0, "Fever-Manual / Gear&Note : SIN", "Comment : "+"Night Owl".localized)
            addMission("Respect", "Another WORLD", "Deadly Poison", "The Feelings", "NORMAL", "5B", "Piano Concerto No.1".localized, "NORMAL", "5B", "Midnight Blood", "NORMAL", "5B", "Funky Chups", "NORMAL", "5B", 1050000, 0, 0, 0, 10, "Fever OFF", "Gear : NB Ranger")
            addMission("Respect", "Another WORLD", "Metal Kombat", "plastic method", "NORMAL", "6B", "Rocka-a-doodle-doo", "NORMAL", "6B", "Get on Top", "HARD", "6B", "Armored Phantom", "HARD", "6B", 0, 3, 0, 92, 0, "Fever-Manual", "Comment : "+"Don't Be Careless!".localized)
            addMission("Respect", "Another WORLD", "Fairy Tales", "Phantom Of Sky", "HARD", "5B", "Memoirs", "NORMAL", "5B", "Sunny Side ~Deepn' Soul Mix~", "NORMAL", "5B", "quixotic", "NORMAL", "5B", 0, 0, 1000, 93, 0, "Fever OFF / FOG", "Gallery : Open Fire (2)")
            addMission("Respect", "Another WORLD", "Global Sensation", "Triple Zoe", "NORMAL", "6B", "Another DAY", "HARD", "6B", "KUDA", "NORMAL", "6B", "Mulch", "NORMAL", "6B", 1280000, 0, 0, 0, 0, "Fever OFF / Gear&Note : Mulch", "Plate : Another World")
            addMission("Respect", "Back STAGE", "Emotional Sense", "Every Morning".localized, "NORMAL", "5B", "Memory of Beach", "NORMAL", "5B", "Sunny Side", "HARD", "5B", "End of the Moonlight", "HARD", "5B", "SIN", "HARD", "5B", 0, 0, 0, 95, 20, "Fever OFF / Gear&Note : Portable 1&Classic", "Gear : Portable 1")
            addMission("Respect", "Back STAGE", "Sound Miracle", "Your Own Miracle", "NORMAL", "8B", "Brandnew Days", "NORMAL", "8B", "Ladymade Star", "HARD", "8B", "Syriana", "HARD", "8B", "WhiteBlue", "HARD", "8B", 1400000, 3, 0, 0, 0, "Fever-Manual / Gear&Note : Portable 2&Classic", "Plate : Portable 2")
            addMission("Respect", "Back STAGE", "Nauts", "WHY", "HARD", "4B", "Far East Princess", "HARD", "4B", "Mess it Up", "HARD", "4B", "Sunset Rider", "HARD", "4B", 0, 0, 5500, 0, 0, "Fever-Manual / FADE OUT", "Comment : "+"Diet Starts Tomorrow".localized)
            addMission("Respect", "Back STAGE", "Makou Syndrome", "Lift You Up", "HARD", "8B", "Heavenly", "HARD", "8B", "A Lie", "HARD", "8B", "HAMSIN", "NORMAL", "8B", 1270000, 0, 0, 96, 0, "Fever-Manual", "Gallery : HAMSIN (2)")
            addMission("Respect", "Back STAGE", "NieNova", "Only for you", "HARD", "6B", "Chrono Breakers", "NORMAL", "6B", "For the IKARUS", "NORMAL", "6B", "Remains Of Doom", "NORMAL", "6B", 0, 4, 7000, 0, 0, "Fever-Manual / FOG / Gear&Note : Only for you", "Plate : Only for you")
            addMission("Respect", "Back STAGE", "ND Lee", "Beautiful Day", "HARD", "8B", "ON", "NORMAL", "8B", "STALKER", "NORMAL", "8B", "2Nite", "HARD", "8B", 0, 0, 0, 0, 30, "Fever OFF / BLINK", "Plate : Back STAGE")
            addMission("Respect", "Chaos theory", "Formula 1", "Chain of Gravity", "HARD", "6B", "Jupiter Driving", "HARD", "6B", "Runaway", "HARD", "6B", "Bullet, Wanted!", "HARD", "6B", 1250000, 0, 0, 95, 0, "Fever-Manual / SLIDE UP", "Comment : "+"New Type".localized)
            addMission("Respect", "Chaos theory", "Randomelody", "RANDOM", "NORMAL", "4B", "RANDOM", "HARD", "4B", "RANDOM", "MAXIMUM", "4B", 920000, 0, 0, 0, 0, "Fever-Manual", "Music : BlythE")
            addMission("Respect", "Chaos theory", "MAX It Up", "RANDOM", "NORMAL", "5B", "RANDOM", "HARD", "5B", "RANDOM", "MAXIMUM", "5B", 0, 0, 7000, 0, 0, "Fever-Manual", "Comment : "+"Versatile".localized)
            addMission("Respect", "Chaos theory", "Russian Roulette", "RANDOM", "NORMAL", "6B", "RANDOM", "HARD", "6B", "RANDOM", "MAXIMUM", "6B", 0, 4, 0, 97, 0, "Fever-Manual", "Comment : "+"Born to Jam".localized)
            addMission("Respect", "Chaos theory", "The Genius", "RANDOM", "NORMAL", "8B", "RANDOM", "HARD", "8B", "RANDOM", "MAXIMUM", "8B", 0, 0, 0, 0, 15, "Fever OFF", "Plate : Chaos theory")
            addMission("Respect", "Chaos theory", "Bigbang Theory", "NANO RISK", "NORMAL", "4B", "Brain Storm", "NORMAL", "8B", "Para-Q", "HARD", "5B", "Royal Clown", "HARD", "6B", 880000, 0, 0, 0, 0, "Fever OFF / CHAOS W", "Music : Brain Storm")
            addMission("Respect", "Sound Lab", "Beat Generation", "OBLIVION ~Rockin' Night Style~", "HARD", "6B", "Sunny Side ~Deepn' Soul Mix~", "MAXIMUM", "6B", "Ruti'n (GOTH Wild Electro Remix)", "HARD", "6B", "SIN ~The Last Scene~", "HARD", "6B", 0, 5, 3000, 0, 0, "Fever-Manual", "Gallery : Lift You Up (3)")
            addMission("Respect", "Sound Lab", "R.O.D", "Rock Or Die", "HARD", "6B", "Road Of Death", "HARD", "6B", "Rolling On the Duck", "HARD", "8B", "Remains Of Doom", "HARD", "8B", 1250000, 5, 0, 0, 0, "Fever-Manual", "Plate : Remains Of Doom")
            addMission("Respect", "Sound Lab", "ned", "Running girl", "HARD", "4B", "Shadow Flower", "HARD", "4B", "The Obliterator", "HARD", "4B", "Armored Phantom", "HARD", "4B", 0, 0, 2000, 98, 0, "Speed : 1.50 / Fever OFF", "Note : Don't Die")
            addMission("Respect", "Sound Lab", "Mycin.Test", "Beyond Yourself", "HARD", "5B", "Waiting for you", "HARD", "5B", "Groovin Up", "HARD", "5B", "Bullet, Wanted!", "HARD", "5B", 1300000, 4, 0, 0, 0, "Fever-Manual", "Plate : Running girl")
            addMission("Respect", "Sound Lab", "7 SEQUENCE", "Extreme Z4", "HARD", "8B", "Catch Me", "HARD", "8B", "Brave it Out", "MAXIMUM", "8B", "Higher", "MAXIMUM", "8B", 0, 0, 7777, 97, 0, "Fever-Manual", "Comment : "+"Guru".localized)
            addMission("Respect", "Sound Lab", "GOTHic+orpheus", "Enter The Universe", "HARD", "6B", "Child of Night", "MAXIMUM", "6B", "Ruti'n (GOTH Wild Electro Remix)", "MAXIMUM", "6B", "The Obliterator", "MAXIMUM", "6B", "KILLER BEE", "MAXIMUM", "6B", 0, 0, 0, 0, 30, "Fever OFF / Gear&Note : OBLIVION", "Plate : Sound Lab")
            addMission("Respect", "Visualizer", "TARIta", "Lemonade", "NORMAL", "4B", "Hello Pinky", "HARD", "5B", "FTR", "NORMAL", "8B", "Shadow Flower", "HARD", "6B", 0, 5, 0, 98, 0, "Fever-Manual", "Note : OBLIVION")
            addMission("Respect", "Visualizer", "ECOmotion", "Astro Fight", "NORMAL", "5B", "Kung Brother", "HARD", "5B", "Taekwonburi".localized, "MAXIMUM", "5B", "Liar", "HARD", "5B", 1350000, 0, 6000, 0, 0, "Fever-Manual", "Plate : Mulch")
            addMission("Respect", "Visualizer", "BJ STUDIO", "Miles", "HARD", "4B", "2Nite", "HARD", "5B", "Brandnew Days", "HARD", "6B", "WHY", "HARD", "8B", 0, 0, 3950, 0, 0, "Fever OFF", "Comment : "+"Grandpa Gamer".localized)
            addMission("Respect", "Visualizer", "Type B.Person", "Fentanest", "HARD", "6B", "U.A.D", "HARD", "5B", "Negative Nature", "HARD", "6B", "Royal Clown", "HARD", "5B", 0, 0, 0, 0, 5, "Fever OFF", "Gallery : EXTRA (4)")
            addMission("Respect", "Visualizer", "Dumping Life", "glory day", "HARD", "4B", "Binary World", "HARD", "4B", "NB RANGER - Virgin Force", "HARD", "4B", "BlackCat", "HARD", "4B", 0, 0, 8000, 98, 0, "Fever-Manual", "Comment : "+"Left Hand Only".localized)
            addMission("Respect", "Visualizer", "Just 100%", "RANDOM", "NORMAL", "4B", 0, 0, 0, 100, 0, "Fever OFF", "Plate : Visualizer")
            addMission("Respect", "D-VELOPERS", "Light Water", "sO mUCH iN LUV", "MAXIMUM", "6B", "Right Now", "MAXIMUM", "6B", "Ya! Party!", "MAXIMUM", "6B", "Running girl", "MAXIMUM", "6B", 1300000, 0, 0, 0, 0, "Fever-Manual", "Plate : Lift You Up")
            addMission("Respect", "D-VELOPERS", "juking must die", "One the Love", "HARD", "4B", "WhiteBlue", "NORMAL", "4B", 0, 0, 0, 97, 1, "Fever OFF / SLIDE DOWN", "Comment : "+"Classic Game Fanatic".localized)
            addMission("Respect", "D-VELOPERS", "c12Lover", "OBLIVION ~Rockin' Night Style~", "HARD", "5B", "Secret Dejavu", "HARD", "5B", "NB RANGER - Virgin Force", "HARD", "5B", "Rolling On the Duck", "HARD", "5B", 0, 0, 8500, 97, 10, "Fever AUTO", "Plate : quixotic")
            addMission("Respect", "D-VELOPERS", "BEXTER", "KUDA", "HARD", "6B", "Syriana", "HARD", "8B", "glory day", "HARD", "6B", "BlackCat", "MAXIMUM", "6B", 1350000, 0, 0, 0, 5, "Fever-Manual / Gear&Note : glory day", "Plate : Syriana")
            addMission("Respect", "D-VELOPERS", "NKO", "Heavenly", "HARD", "4B", "Chrono Breakers", "HARD", "4B", "Ray of Illuminati", "HARD", "6B", "KILLER BEE", "HARD", "6B", 982410, 4, 2010, 90, 23, "Fever-Manual", "Comment : "+"Doting Father".localized)
            addMission("Respect", "D-VELOPERS", "SSS", "A.I", "HARD", "4B", "Brain Storm", "HARD", "5B", "We're All Gonna Die", "HARD", "6B", "Don't Die", "MAXIMUM", "8B", 0, 0, 0, 0, 0, "Fever AUTO / vs AI", "Plate : D-VELOPERS / Trophy : DJ Alpha Resigns")
            addMission("Respect", "Destination", "Bloody MANIcure", "Nightmare", "HARD", "8B", "quixotic", "MAXIMUM", "6B", "Midnight Blood", "HARD", "5B", "SIN ~The Last Scene~", "HARD", "4B", 1230000, 0, 0, 0, 0, "Fever-Manual / FOG", "Music : SIN ~The Last Scene~")
            addMission("Respect", "Destination", "GIGA BREAK", "Miles", "MAXIMUM", "8B", "v o l d e n u i t", "MAXIMUM", "8B", "STALKER", "MAXIMUM", "8B", "Minimal Life", "MAXIMUM", "8B", 0, 0, 0, 0, 35, "Fever OFF", "Comment : "+"Genius".localized)
            addMission("Respect", "Destination", "MAXimum Impact", "RANDOM", "MAXIMUM", "4B", "RANDOM", "MAXIMUM", "5B", "RANDOM", "MAXIMUM", "6B", "RANDOM", "MAXIMUM", "8B", 0, 5, 9999, 0, 0, "Fever-Manual", "Plate : Nightmare")
            addMission("Respect", "Destination", "HeLLord", "Rock Or Die", "MAXIMUM", "6B", "Don't Die", "MAXIMUM", "5B", "We're All Gonna Die", "MAXIMUM", "4B", 0, 5, 0, 98, 0, "Fever-Manual", "Comment : "+"Super Master".localized)
            addMission("Respect", "Destination", "Skyscraper", "waiting for me", "SPECIAL", "XB", "Sunny Side", "SPECIAL", "XB", "Out Law", "SPECIAL", "XB", "Minus 3", "SPECIAL", "XB", "Enemy Storm", "SPECIAL", "XB", 1600000, 0, 4500, 96, 0, "Fever-Manual", "Plate : Destination")
            addMission("Respect", "Destination", "RESPECT FOR PLAYERS", "BlythE", "MAXIMUM", "4B", "Seeker", "MAXIMUM", "5B", "Remains Of Doom", "MAXIMUM", "6B", "HAMSIN", "MAXIMUM", "8B", "Nightmare", "MAXIMUM", "8B", "We're All Gonna Die", "SPECIAL", "XB", 2000000, 5, 10000, 97, 50, "Fever-Manual", "Plate : BlackCat")
            
            //Trilogy
            addMission("Trilogy", "T-SIDE", "Over Your Dream", "Catch You", "HARD", "4B", "Memory of Wind".localized, "HARD", "4B", 500000, 0, 0, 0, 0, "Fever-Manual / Gear&Note : Trilogy&Classic", "Plate : Catch You")
            addMission("Trilogy", "T-SIDE", "Missing You", "My Jealousy", "NORMAL", "6B", "Streetlight", "NORMAL", "6B", "Someday", "HARD", "6B", 0, 0, 0, 0, 10, "Fever OFF", "Plate : Someday")
            addMission("Trilogy", "T-SIDE", "5! Ducks", "OBLIVION", "NORMAL", "5B", "Ladymade Star", "NORMAL", "5B", "Taekwonburi".localized, "NORMAL", "5B", 0, 0, 500, 0, 0, "Fever-Manual", "Plate : Talk! Talk!")
            addMission("Trilogy", "T-SIDE", "Electronic License", "ZET", "NORMAL", "4B", "Syriana ~Blast Wave Mix~", "NORMAL", "5B", "Nevermind", "NORMAL", "6B", 0, 0, 0, 0, 0, "Fever OFF / vs AI prototype", "Plate : My Jealousy / Trophy : DJ Alpha Resigns")
            addMission("Trilogy", "T-SIDE", "Max Boy", "Your Own Miracle ~Disco House Mix~", "NORMAL", "6B", "sO mUCH iN LUV ~Melodic Twisted Mix~", "NORMAL", "5B", "A Lie ~Deep Inside Mix~", "NORMAL", "4B", 0, 3, 0, 90, 0, "Speed : 1.50 / Fever-Manual", "Plate : Streetlight")
            addMission("Trilogy", "T-SIDE", "DJMAX RESPECT U", "Only for you", "MAXIMUM", "4B", "Someday", "MAXIMUM", "4B", "Waiting for you", "HARD", "4B", "Running girl", "HARD", "4B", "KILLER BEE", "MAXIMUM", "4B", 0, 0, 0, 0, 30, "Fever OFF / Gear&Note : glory day", "Gallery : DJMAX RESPECT U / Trophy : "+"다음 이벤트도 기대해주세요".localized)
            addMission("Trilogy", "R-SIDE", "2nd Impression", "GET OUT ~Hip Noodle Mix~", "HARD", "4B", "For Seasons ~Air Guitar Mix~", "MAXIMUM", "6B", "STOP", "HARD", "4B", "NB Girls", "HARD", "6B", 0, 0, 0, 95, 0, "Fever OFF / FADE OUT", "")
            addMission("Trilogy", "R-SIDE", "Beat Phobia", "The One", "HARD", "5B", "Yo Creo Que Si ~Live House Version~", "HARD", "5B", "Nevermind", "HARD", "5B", "ZET", "HARD", "5B", 0, 4, 0, 85, 0, "Fever-Manual / FOG", "Plate : ZET")
            addMission("Trilogy", "R-SIDE", "Critical Period", "RANDOM", "HARD", "4B", "RANDOM", "HARD", "5B", "RANDOM", "HARD", "6B", "RANDOM", "HARD", "8B", 0, 0, 0, 0, 25, "Fever OFF", "Plate : STOP")
            addMission("Trilogy", "R-SIDE", "Under Control", "Talk! Talk!", "HARD", "6B", "My Alias", "HARD", "6B", "Ventilator", "HARD", "6B", "Mind Control", "HARD", "6B", 1150000, 5, 0, 0, 0, "Fever-Manual", "")
            addMission("Trilogy", "R-SIDE", "Boss Match", "SIN ~The Last Scene~", "MAXIMUM", "4B", "HAMSIN", "MAXIMUM", "5B", "Seeker", "MAXIMUM", "6B", "Don't Die", "MAXIMUM", "8B", 1353924, 0, 0, 93, 13, "Fever AUTO", "Gallery : DJMAX RESPECT U (2)")
            addMission("Trilogy", "R-SIDE", "In My Dream", "CnP", "HARD", "4B", "Sunset Rider", "HARD", "5B", "glory day", "HARD", "6B", 0, 5, 0, 97, 0, "Fever-Manual", "Plate : "+"Memory of Wind".localized)
            
            //Datebase - Trophy Info
            addTrophy("Respect", "RESPECT You", "모든 트로피를 획득했다.", "RESPECT You", "Collected all DJMAX RESPECT Trophies.", "PLATINUM")
            addTrophy("Respect", "디맥 그랜드 마스터", "레벨 99를 달성했다.", "DJMAX GRAND MASTER", "You have reached Level 99.", "GOLD")
            addTrophy("Respect", "비트 마에스트로", "미션 50개를 클리어했다.", "BEAT MAESTRO", "Cleared 50 missions.", "GOLD")
            addTrophy("Respect", "한계 돌파", "500개의 패턴을 MAX COMBO로 클리어했다.", "Break the Limit", "Cleared 500 patterns in MAX COMBO.", "GOLD")
            addTrophy("Respect", "완벽 그 자체", "누적 점수가 300,000,000점을 돌파했다.", "Perfect Perfectionist", "Accumulated 300,000,000 points.", "GOLD")
            addTrophy("Respect", "절반의 성공", "레벨 50을 달성했다.", "Half Empty? Half Full!", "You have reached Level 50.", "SILVER")
            addTrophy("Respect", "프로다운 실력", "미션 30개를 클리어했다.", "You Must Be a Pro", "Cleared 30 missions.", "SILVER")
            addTrophy("Respect", "열심히 해야지 방법이 없습니다", "누적 점수가 200,000,000점을 돌파했다.", "Diligence Will Pay Off One Day", "Accumulated 200,000,000 points.", "SILVER")
            addTrophy("Respect", "S랭크 마스터", "S랭크로 50회 클리어했다.", "S Rank Master", "Acquired S Rank for 50 times.", "SILVER")
            addTrophy("Respect", "콤보를 위해 판정은 포기!", "300개의 패턴을 MAX COMBO로 클리어했다.", "Combos First!", "Cleared 300 patterns in MAX COMBO.", "SILVER")
            addTrophy("Respect", "THE LORD OF COMBO", "999999 콤보를 달성했다.", "THE LORD OF COMBO", "Accomplished 999999 combos.", "SILVER")
            addTrophy("Respect", "JUST 100%", "RESPECT 곡을 PERFECT로 클리어했다.", "JUST 100%", "Cleared a pattern from RESPECT category with PERFECT.", "SILVER")
            addTrophy("Respect", "아 너무 무섭다", "5000 콤보 이상으로 클리어했다.", "Jaw Dropping Performance", "Cleared with 5000 or more combos.", "SILVER")
            addTrophy("Respect", "이 게임은 내가 지배한다", "모든 곡을 클리어했다.", "I Will Rule This Game", "Cleared all songs.", "SILVER")
            addTrophy("Respect", "ARCADE KID", "ARCADE 모드를 4버튼으로 클리어했다.", "ARCADE KID", "Cleared ARCADE Mode with 4 Buttons.", "BRONZE")
            addTrophy("Respect", "The 5th Wave", "ARCADE 모드를 5버튼으로 클리어했다. ", "The 5th Wave", "Cleared ARCADE Mode with 5 Buttons.", "BRONZE")
            addTrophy("Respect", "Awesome MIX!", "ARCADE 모드를 6버튼으로 클리어했다.", "Awesome MIX!", "Cleared ARCADE Mode with 6 Buttons.", "BRONZE")
            addTrophy("Respect", "Try your ability. Do it!!", "ARCADE 모드를 8버튼으로 클리어했다.", "Try your ability. Do it!!", "Cleared ARCADE Mode with 8 Buttons.", "BRONZE")
            addTrophy("Respect", "대신귀여운트로피를드리겠습니다", "처음으로 클리어에 실패했다.", "Hopefully This Trophy Will Help You Keep Calm", "Failed a stage for the first time.", "BRONZE")
            addTrophy("Respect", "나만 운없어..", "BREAK 1개로 클리어했다.", "Maybe Next Time..", "Cleared with a single BREAK.", "BRONZE")
            addTrophy("Respect", "슈퍼 루키", "레벨 10을 달성했다.", "Super Rookie", "You have reached Level 10.", "BRONZE")
            addTrophy("Respect", "순탄한 여행", "미션 10개를 클리어했다.", "A Smooth Ride", "Cleared 10 missions.", "BRONZE")
            addTrophy("Respect", "숨겨왔던 재능", "100개의 패턴을 MAX COMBO로 클리어했다.", "Hidden Talent", "Cleared 100 patterns in MAX COMBO.", "BRONZE")
            addTrophy("Respect", "점수를 모아야 이득인 부분", "누적 점수가 100,000,000점을 돌파했다.", "Each Single Point Counts", "Accumulated 100,000,000 points.", "BRONZE")
            addTrophy("Respect", "하고싶은거 다 해", "A랭크로 100회 클리어했다.", "YOLO", "Acquired A Rank for 100 times.", "BRONZE")
            addTrophy("Respect", "콤보 마이스터", "100000 콤보를 달성했다.", "Combo Meister", "Accomplished 100000 combos.", "BRONZE")
            addTrophy("Respect", "럭키 해피 데이", "정확하게 777 콤보로 클리어했다.", "Happy Lucky Day", "Cleared with 777 combos.", "BRONZE")
            addTrophy("Respect", "Ask to Wind".localized, "ARCADE 모드에서 DMP1 곡으로만 클리어했다.", "Ask to Wind".localized, "Cleared only with \"Portable 1\" songs in ARCADE Mode.", "BRONZE")
            addTrophy("Respect", "Your Own Miracle", "ARCADE 모드에서 DMP2 곡으로만 클리어했다.", "Your Own Miracle", "Cleared only with \"Portable 2\" songs in ARCADE Mode.", "BRONZE")
            addTrophy("Respect", "플레이트 콜렉터", "플레이트를 30개 획득했다.", "Plate Collector", "Acquired 30 plates.", "BRONZE")
            addTrophy("Respect", "기어중의 기어", "기어를 15개 획득했다.", "The Gear of All Gears", "Acquired 15 gears.", "BRONZE")
            addTrophy("Respect", "노트의 형태", "노트를 10개 획득했다.", "Everything about Notes", "Acquired 10 notes.", "BRONZE")
            addTrophy("Respect", "마이 리틀 갤러리", "이미지를 100장 획득했다.", "My Little Gallery", "Acquired 100 images.","BRONZE")
            addTrophy("Respect", "아무 말 대잔치", "코멘트를 50개 획득했다.", "Slang Festival", "Acquired 50 comments.", "BRONZE")
            addTrophy("Respect", "실력 검증", "난이도 10 이상의 패턴 30개를 MAX COMBO로 클리어했다.", "Testing Your Skills", "Cleared 30 patterns with difficulty level 10 or higher in MAX COMBO.", "BRONZE")
            addTrophy("Respect", "푹 빠졌구나", "4버튼 마스터 스코어의 달성률이 70%에 도달했다.", "You're So Into This", "Accomplished 70% success rate of 4 Button Master Score.", "BRONZE")
            addTrophy("Respect", "고고학자", "처음으로 숨겨진 BGA를 발견했다.", "Archeologist", "Found a hidden BGA for the first time.", "BRONZE")
            addTrophy("Respect", "내 마음속에 저장", "모든 숨겨진 BGA를 발견했다.", "Saved in My Heart", "Found all the hidden BGA.", "BRONZE")
            addTrophy("Respect", "DJ Alpha Resigns", "미션에서 A.I를 상대로 승리했다.", "DJ Alpha Resigns", "Beat the mission against A.I.", "BRONZE")
            addTrophy("Respect", "엔비레인저가 되고싶어", "콜렉션에서 NB RANGER 시리즈의 모든 뮤직 비디오를 감상했다.", "Become an NB RANGER", "Watched all NB RANGER videos in Collection.", "BRONZE")
            addTrophy("Respect", "지기 싫다고 생각하고 있어", "온라인 매치를 10번 플레이했다.", "No One Likes to Lose", "Played Online Match 10 times.", "BRONZE")
            addTrophy("Respect", "언제나 감사합니다", "처음으로 CREDIT을 감상했다.", "This is for You", "Watched CREDITS for the first time.", "BRONZE")
            
            addTrophy("Trilogy", "당신은 대체...", "TRILOGY 곡을 모두 S랭크로 클리어했다.", "Where Did You Come From...?", "Cleared all TRILOGY songs in S Rank.", "GOLD")
            addTrophy("Trilogy", "제 여자친구가 확실합니다!", "\"Someday\"를 MAX COMBO로 클리어했다.", "That's Gotta be My Girlfriend!", "Cleared \"Someday\" in MAX COMBO.", "SILVER")
            addTrophy("Trilogy", "트릴로지 메타", "ARCADE를 TRILOGY 곡으로만 클리어했다.", "TRILOGY Metaplay", "Cleared ARCADE Mode playing only TRILOGY songs.", "BRONZE")
            addTrophy("Trilogy", "뉴 스킨 작렬...!", "TRILOGY UI 스킨을 적용했다.", "Here Comes a New Skin...!", "Used TRILOGY UI Skin.", "BRONZE")
            addTrophy("Trilogy", "다음 이벤트도 기대해주세요", "DJMAX RESPECT U 미션을 클리어했다.", "Don't Miss Out On Upcoming Events!", "Cleared mission \"DJMAX RESPECT U\".", "BRONZE")
            addTrophy("Trilogy", "대신푸우른USB를드리겠습니다", "10장의 TRILOGY 곡 이미지를 획득했다.", "And Now You Deserve This Handmade Trophy!", "Acquired 10 TRILOGY Song Images.", "BRONZE")
            addTrophy("Trilogy", "나올수도 있고 안나올수도 있습니다", "TRILOGY 곡 중 숨겨진 BGA를 발견했다.", "Pikaboo!", "Found a Hidden BGA from a TRILOGY song.", "BRONZE")
            
            addTrophy("CE", "클리어 위주로 갑시다", "Clazziquai Edition 곡을 모두 S랭크로 클리어했다", "Let ME Be \"Clear\" On These", "Cleared all Clazziquai Edition songs in S Rank.", "GOLD")
            addTrophy("CE", "클럽 투어에 오신것을 환영합니다", "Electronic City를 클리어했다.","Welcome to the CLUB TOUR","Cleared \"Electronic City\".","SILVER")
            addTrophy("CE","이제와서 족자를 다 모을수도 없고","First Kiss 기어의 모든 캐릭터를 보았다.", "Is it too late to start collecting these?","Watched all characters of the Gear : First Kiss.","BRONZE")
            addTrophy("CE","역시 프로 리듬게이머는 달라","Clazziquai Edition 곡으로만 100000 콤보를 달성했다.", "What Makes A Professional Rhythm Gamer","Achieved 100000 Combos with songs only from the Clazziquai Edition.","BRONZE")
            addTrophy("CE", "DJMAX ARTIST TEAM", "DJMAX TOURNAMENT LIVE 미션을 클리어했다.","DJMAX ARTIST TEAM","Cleared mission \"DJMAX TOURNAMENT LIVE\".","BRONZE")
            addTrophy("CE", "METROTRONICS", "ARCADE를 Clazziquai Edition 곡으로만 클리어했다.","METROTRONICS","Cleared Arcade mode playing only Clazziquai Edition Songs.","BRONZE")
            addTrophy("CE", "Go Back From the Top", "Clazziquai Edition 곡 중 숨겨진 BGA를 발견했다.", "Go Back From the Top","Found a Hidden BGA from a Clazziquai Edition Song.","BRONZE")
            
            //Database - AchievementInfo
            addAchievement("Play Count", 1, "MUSIC", "Syriana")
            addAchievement("Play Count", 2, "MUSIC", "OPEN FIRE")
            addAchievement("Play Count", 3, "MUSIC", "Don't Die")
            addAchievement("Play Count", 4, "NOTE SKIN", "Mulch")
            addAchievement("Play Count", 5, "MUSIC", "OBLIVION ~Rockin' Night Style~")
            addAchievement("Play Count", 6, "COMMENT", "GLHF".localized) //즐겜해요 祝你好運！
            addAchievement("Play Count", 7, "PLATE", "NB RED")
            addAchievement("Play Count", 8, "GALLERY", "Binary World (2)")
            addAchievement("Play Count", 9, "COMMENT", "Rhythm Game Maniac".localized) //리듬게임 매니아 音樂游戲愛好者
            addAchievement("Play Count", 10, "PLATE", "Out Law")
            addAchievement("Player Level", 1, "MUSIC", "Waiting for you")
            addAchievement("Player Level", 2, "GEAR SKIN", "Only for you")
            addAchievement("Player Level", 3, "MUSIC", "NB POWER")
            addAchievement("Player Level", 4, "MUSIC", "Royal Clown")
            addAchievement("Player Level", 5, "MUSIC", "BlackCat")
            addAchievement("Player Level", 6, "GEAR SKIN", "PORTABLE 3")
            addAchievement("Player Level", 7, "PLATE", "SIN")
            addAchievement("Player Level", 8, "PLATE", "Seeker")
            addAchievement("Player Level", 9, "GEAR SKIN", "TECHNIKA 3")
            addAchievement("Player Level", 10, "PLATE", "HAMSIN")
            addAchievement("ARCADE Mode Cleared", 1, "GEAR SKIN", "TECHNIKA 1")
            addAchievement("ARCADE Mode Cleared", 2, "MUSIC", "FTR")
            addAchievement("ARCADE Mode Cleared", 3, "MUSIC", "Beyond Yourself")
            addAchievement("ARCADE Mode Cleared", 4, "GALLERY", "Royal Clown (2)")
            addAchievement("ARCADE Mode Cleared", 5, "GALLERY", "Far East Princess (3)")
            addAchievement("ARCADE Mode Cleared", 6, "COMMENT", "Eager Beaver".localized) //들어올 땐 마음대로 已經上癮了吧？
            addAchievement("ARCADE Mode Cleared", 7, "PLATE", "Light House")
            addAchievement("ARCADE Mode Cleared", 8, "GALLERY", "2NITE (2)")
            addAchievement("ARCADE Mode Cleared", 9, "COMMENT", "Always On Duty".localized)   //평생 현역 終身值班
            addAchievement("ARCADE Mode Cleared", 10, "PLATE", "DIVINE SERVICE")
            addAchievement("4B TUNES Cleared", 1, "MUSIC", "Running girl")
            addAchievement("4B TUNES Cleared", 2, "MUSIC", "The Feelings")
            addAchievement("4B TUNES Cleared", 3, "MUSIC", "Eternal Memory".localized)
            addAchievement("4B TUNES Cleared", 4, "PLATE", "Hello Pinky")
            addAchievement("4B TUNES Cleared", 5, "COMMENT", "Every Morning".localized)
            addAchievement("4B TUNES Cleared", 6, "MUSIC", "Sunny Side ~Deepn' Soul Mix~")
            addAchievement("4B TUNES Cleared", 7, "GALLERY", "One The Love (2)")
            addAchievement("4B TUNES Cleared", 8, "PLATE", "OBLIVION")
            addAchievement("4B TUNES Cleared", 9, "GALLERY", "Groovin Up (2)")
            addAchievement("4B TUNES Cleared", 10, "COMMENT", "4B TUNES Love".localized)    //4버튼이 좋아요 贊美4鍵模式
            addAchievement("5B TUNES Cleared", 1, "MUSIC", "Seeker")
            addAchievement("5B TUNES Cleared", 2, "GEAR SKIN", "TECHNIKA 2")
            addAchievement("5B TUNES Cleared", 3, "MUSIC", "JBG")
            addAchievement("5B TUNES Cleared", 4, "COMMENT", "I Love Dogs!".localized)    //강아지 좋아요! 我愛狗！
            addAchievement("5B TUNES Cleared", 5, "MUSIC", "Funky Chups")
            addAchievement("5B TUNES Cleared", 6, "PLATE", "For The IKARUS")
            addAchievement("5B TUNES Cleared", 7, "GALLERY", "Only for you (2)")
            addAchievement("5B TUNES Cleared", 8, "PLATE", "CHICKEN")
            addAchievement("5B TUNES Cleared", 9, "GALLERY", "KILLER BEE (3)")
            addAchievement("5B TUNES Cleared", 10, "COMMENT", "5B TUNES Love".localized)  //5버튼이 좋아요 贊美5鍵模式
            addAchievement("6B TUNES Cleared", 1, "MUSIC", "A.I")
            addAchievement("6B TUNES Cleared", 2, "COMMENT", "Waiting for Weekend".localized)   //주말반 모집 중 注意力不夠
            addAchievement("6B TUNES Cleared", 3, "MUSIC", "KUDA")
            addAchievement("6B TUNES Cleared", 4, "MUSIC", "Negative Nature")
            addAchievement("6B TUNES Cleared", 5, "COMMENT", "Stud".localized)  //미소년 美少年
            addAchievement("6B TUNES Cleared", 6, "MUSIC", "Ya! Party!")
            addAchievement("6B TUNES Cleared", 7, "PLATE", "TAP SONIC")
            addAchievement("6B TUNES Cleared", 8, "PLATE", "Sunny Side")
            addAchievement("6B TUNES Cleared", 9, "GALLERY", "quixotic (3)")
            addAchievement("6B TUNES Cleared", 10, "COMMENT", "6B TUNES Love".localized)    //6버튼이 좋아요 贊美6鍵模式
            addAchievement("8B TUNES Cleared", 1, "GEAR SKIN", "PORTABLE 2")
            addAchievement("8B TUNES Cleared", 2, "MUSIC", "Minimal Life")
            addAchievement("8B TUNES Cleared", 3, "COMMENT", "Mr. Perfect")
            addAchievement("8B TUNES Cleared", 4, "MUSIC", "Piano Concerto No.1".localized)
            addAchievement("8B TUNES Cleared", 5, "COMMENT", "NB RANGER".localized) //엔비 레인져 NB RANGER
            addAchievement("8B TUNES Cleared", 6, "MUSIC", "STALKER")
            addAchievement("8B TUNES Cleared", 7, "GALLERY", "EXTRA (3)")
            addAchievement("8B TUNES Cleared", 8, "PLATE", "Taekwonburi".localized)
            addAchievement("8B TUNES Cleared", 9, "GALLERY", "The Obliterator (2)")
            addAchievement("8B TUNES Cleared", 10, "COMMENT", "8B TUNES Love".localized)    //8버튼이 좋아요 贊美8鍵模式
            addAchievement("FREE STYLE Combo", 1, "MUSIC", "WHY")
            addAchievement("FREE STYLE Combo", 2, "GEAR SKIN", "TAP SONIC")
            addAchievement("FREE STYLE Combo", 3, "MUSIC", "Mulch")
            addAchievement("FREE STYLE Combo", 4, "MUSIC", "Rolling On the Duck")
            addAchievement("FREE STYLE Combo", 5, "MUSIC", "Nightmare")
            addAchievement("FREE STYLE Combo", 6, "COMMENT", "Sheepish".localized)  //굽신굽신 卑躬屈膝
            addAchievement("FREE STYLE Combo", 7, "GALLERY", "End of the Moonlight (3)")
            addAchievement("FREE STYLE Combo", 8, "COMMENT", "FEVER Free Zone".localized)   //피버 안써욧 FEVER FREE ZONE
            addAchievement("FREE STYLE Combo", 9, "GALLERY", "quixotic (7)")
            addAchievement("FREE STYLE Combo", 10, "PLATE", "BlythE")
            addAchievement("MISSION Cleared", 1, "PLATE", "NB BLUE")
            addAchievement("MISSION Cleared", 2, "PLATE", "NB GREEN")
            addAchievement("MISSION Cleared", 3, "PLATE", "NB BLACK")
            addAchievement("MISSION Cleared", 4, "PLATE", "NB YELLOW")
            addAchievement("MISSION Cleared", 5, "PLATE", "NB RANGER")
            addAchievement("MISSION Cleared", 6, "GEAR SKIN", "glory day")
            addAchievement("Total Break", 1, "COMMENT", "Can't Focus".localized)    //집중력 부족 注意力不夠
            addAchievement("Total Break", 2, "PLATE", "Memoy of Beach")
            addAchievement("Total Break", 3, "MUSIC", "GET OUT")
            addAchievement("Total Break", 4, "COMMENT", "Lefty".localized)  //왼손잡이 左撇子
            addAchievement("Total Break", 5, "GEAR SKIN", "Mulch")
            addAchievement("Total Break", 6, "GALLERY", "Miles (2)")
            addAchievement("Total Break", 7, "COMMENT", "Novice Here".localized)    //초보입니다 新手來了
            addAchievement("Total Break", 8, "GALLERY", "NB RANGER (3)")
            addAchievement("Total Break", 9, "GALLERY", "Brain Storm (2)")
            addAchievement("Total Break", 10, "COMMENT", "High Class".localized)    //오늘따라 잘 안되네 不可忽視的才能
            addAchievement("Maximum MAX COMBO", 1, "MUSIC", "Far East Princess")
            addAchievement("Maximum MAX COMBO", 2, "GALLERY", "Running girl (2)")
            addAchievement("Maximum MAX COMBO", 3, "PLATE", "Ruti'n (GOTH Wild Electro Remix)")
            addAchievement("Maximum MAX COMBO", 4, "MUSIC", "Chrono Breakers")
            addAchievement("Maximum MAX COMBO", 5, "COMMENT", "Hawk Eye".localized) //엄청난 동체시력 鷹眼
            addAchievement("Maximum MAX COMBO", 6, "PLATE", "Ladymade Star")
            addAchievement("Maximum MAX COMBO", 7, "GALLERY", "glory day (3)")
            addAchievement("Maximum MAX COMBO", 8, "COMMENT", "HAXXOR".localized)   //킹갓엠페러제네럴 超越者
            addAchievement("MAX COMBO Cleared", 1, "MUSIC", "Out Law")
            addAchievement("MAX COMBO Cleared", 2, "NOTE SKIN", "Only for you")
            addAchievement("MAX COMBO Cleared", 3, "MUSIC", "WhiteBlue")
            addAchievement("MAX COMBO Cleared", 4, "GEAR SKIN", "CE")
            addAchievement("MAX COMBO Cleared", 5, "NOTE SKIN", "TECHNIKA 3")
            addAchievement("MAX COMBO Cleared", 6, "GALLERY", "Child of Night (2)")
            addAchievement("MAX COMBO Cleared", 7, "COMMENT", "Jack of All Trades".localized)   //올라운더 靈丹妙藥
            addAchievement("MAX COMBO Cleared", 8, "GALLERY", "Brandnew Days (4)")
            addAchievement("MAX COMBO Cleared", 9, "GALLERY", "We're All Gonna Die (2)")
            addAchievement("MAX COMBO Cleared", 10, "PLATE", "The Obliterator")
            addAchievement("S RANK Cleared", 1, "MUSIC", "Midnight Blood")
            addAchievement("S RANK Cleared", 2, "COMMENT", "Come at Me".localized)    //도전하시겠습니까? 想挑戰嗎？
            addAchievement("S RANK Cleared", 3, "NOTE SKIN", "TAP SONIC")
            addAchievement("S RANK Cleared", 4, "MUSIC", "Road Of Death")
            addAchievement("S RANK Cleared", 5, "PLATE", "Good Bye")
            addAchievement("S RANK Cleared", 6, "GALLERY", "NB RANGER - Virgin Force (2)")
            addAchievement("S RANK Cleared", 7, "GALLERY", "Showtime (2)")
            addAchievement("S RANK Cleared", 8, "COMMENT", "Unforgettable".localized)   //늘 기억되고 싶은 사람 勿忘我
            addAchievement("S RANK Cleared", 9, "COMMENT", "Most Popular".localized)    //인기만점 超級紅人
            addAchievement("S RANK Cleared", 10, "PLATE", "Midnight Blood")
            addAchievement("A RANK Cleared", 1, "MUSIC", "DIVINE SERVICE")
            addAchievement("A RANK Cleared", 2, "MUSIC", "Yo Creo Que Si")
            addAchievement("A RANK Cleared", 3, "GALLERY", "Far East Princess (4)")
            addAchievement("A RANK Cleared", 4, "COMMENT", "I Love Cats!".localized)    //고양이 좋아요! 我愛貓！
            addAchievement("A RANK Cleared", 5, "GALLERY", "Armored Phantom (2)")
            addAchievement("A RANK Cleared", 6, "GALLERY", "Bullet, Wanted! (2)")
            addAchievement("A RANK Cleared", 7, "GALLERY", "Beyond Yourself (3)")
            addAchievement("A RANK Cleared", 8, "COMMENT", "Clear All Songs!".localized)    //목표는 전곡 클리어! 目標是全曲闖闗
            addAchievement("A RANK Cleared", 9, "GALLERY", "Sunny Side (2)")
            addAchievement("A RANK Cleared", 10, "PLATE", "Memoirs")
            addAchievement("NORMAL Difficulty Mode Cleared", 1, "COMMENT", "I Want You.".localized) //친추 환영 添加好友大歡迎
            addAchievement("NORMAL Difficulty Mode Cleared", 2, "MUSIC", "Shadow Flower")
            addAchievement("NORMAL Difficulty Mode Cleared", 3, "GEAR SKIN", "CHICKEN")
            addAchievement("NORMAL Difficulty Mode Cleared", 4, "MUSIC", "Showtime")
            addAchievement("NORMAL Difficulty Mode Cleared", 5, "COMMENT", "Holy Land".localized)   //성지순례 聖地巡禮
            addAchievement("NORMAL Difficulty Mode Cleared", 6, "GALLERY", "OBLIVION (2)")
            addAchievement("NORMAL Difficulty Mode Cleared", 7, "MUSIC", "RED")
            addAchievement("NORMAL Difficulty Mode Cleared", 8, "GALLERY", "Runaway (3)")
            addAchievement("NORMAL Difficulty Mode Cleared", 9, "PLATE", "TECHNIKA 2")
            addAchievement("NORMAL Difficulty Mode Cleared", 10, "COMMENT", "Only Study".localized) //이젠 정말 공부뿐이야 學習第一！
            addAchievement("HARD Difficulty Mode Cleared", 1, "MUSIC", "quixotic")
            addAchievement("HARD Difficulty Mode Cleared", 2, "GALLERY", "Every Morning (3)".localized) //아침형 인간 (3) Every Morning (3)
            addAchievement("HARD Difficulty Mode Cleared", 3, "MUSIC", "Taekwonburi".localized)
            addAchievement("HARD Difficulty Mode Cleared", 4, "MUSIC", "SQUEEZE")
            addAchievement("HARD Difficulty Mode Cleared", 5, "COMMENT", "Most Improved".localized) //일취월장 日新月異
            addAchievement("HARD Difficulty Mode Cleared", 6, "MUSIC", "Chain of Gravity")
            addAchievement("HARD Difficulty Mode Cleared", 7, "GALLERY", "Secret Dejavu (2)")
            addAchievement("HARD Difficulty Mode Cleared", 8, "MUSIC", "Enter The Universe")
            addAchievement("HARD Difficulty Mode Cleared", 9, "COMMENT", "Sprint".localized)    //전력질주 全力奔跑
            addAchievement("HARD Difficulty Mode Cleared", 10, "PLATE", "PORTABLE 3")
            addAchievement("MAXIMUM Difficulty Mode Cleared", 1, "MUSIC", "Remains Of Doom")
            addAchievement("MAXIMUM Difficulty Mode Cleared", 2, "GALLERY", "U.A.D (2)")
            addAchievement("MAXIMUM Difficulty Mode Cleared", 3, "MUSIC", "HAMSIN")
            addAchievement("MAXIMUM Difficulty Mode Cleared", 4, "GALLERY", "Remains Of Doom (2)")
            addAchievement("MAXIMUM Difficulty Mode Cleared", 5, "COMMENT", "Rhythm Power".localized)   //리듬! 파워! 집중력! 節奏！力量！集中！
            addAchievement("X2 FEVER Activated", 1, "MUSIC", "End of the Moonlight")
            addAchievement("X2 FEVER Activated", 2, "NOTE SKIN", "CAT")
            addAchievement("X2 FEVER Activated", 3, "MUSIC", "Yellowberry -AJ Mix-")
            addAchievement("X2 FEVER Activated", 4, "GALLERY", "Only for you (3)")
            addAchievement("X2 FEVER Activated", 5, "MUSIC", "Mess it Up")
            addAchievement("X2 FEVER Activated", 6, "GEAR SKIN", "SIN")
            addAchievement("X2 FEVER Activated", 7, "GALLERY", "NB RANGER - Virgin Force (3)")
            addAchievement("X2 FEVER Activated", 8, "COMMENT", "Shut In".localized) //은둔형 외톨이 隱蔽青年
            addAchievement("X2 FEVER Activated", 9, "GALLERY", "Binary World (3)")
            addAchievement("X2 FEVER Activated", 10, "COMMENT", "I'm the Boss".localized)   //대장님 我就是老大
            addAchievement("X3 FEVER Activated", 1, "MUSIC", "Rocka-a-doodle-doo")
            addAchievement("X3 FEVER Activated", 2, "MUSIC", "Bye Bye Love")
            addAchievement("X3 FEVER Activated", 3, "GALLERY", "glory day (4)")
            addAchievement("X3 FEVER Activated", 4, "MUSIC", "ON")
            addAchievement("X3 FEVER Activated", 5, "COMMENT", "DMP Lover".localized)   //포터블 경험자 DMP經曆者
            addAchievement("X3 FEVER Activated", 6, "MUSIC", "Fentanest")
            addAchievement("X3 FEVER Activated", 7, "GALLERY", "Memory of Beach (3)")
            addAchievement("X3 FEVER Activated", 8, "PLATE", "Secret Dejavu")
            addAchievement("X3 FEVER Activated", 9, "GALLERY", "Brandnew Days (3)")
            addAchievement("X3 FEVER Activated", 10, "COMMENT", "What a Bookworm".localized)    //문과생이 또 文科小子！
            addAchievement("X4 FEVER Activated", 1, "MUSIC", "StarFish")
            addAchievement("X4 FEVER Activated", 2, "MUSIC", "For The IKARUS")
            addAchievement("X4 FEVER Activated", 3, "COMMENT", "DMO Lover".localized)   //온라인 경험자 DMO經曆者
            addAchievement("X4 FEVER Activated", 4, "MUSIC", "Runaway")
            addAchievement("X4 FEVER Activated", 5, "GALLERY", "sO mUCH iN LUV (2)")
            addAchievement("X4 FEVER Activated", 6, "MUSIC", "Dream of You")
            addAchievement("X4 FEVER Activated", 7, "GALLERY", "Chrono Breakers (2)")
            addAchievement("X4 FEVER Activated", 8, "COMMENT", "Go Easy On Me.".localized)  //제발 살살 좀 請手下留情
            addAchievement("X4 FEVER Activated", 9, "COMMENT", "Condition Disorder".localized)  //컨디션 난조 狀態不佳
            addAchievement("X4 FEVER Activated", 10, "GALLERY", "Enemy Storm (2)")
            addAchievement("X5 FEVER Activated", 1, "MUSIC", "FEAR")
            addAchievement("X5 FEVER Activated", 2, "MUSIC", "Sunset Rider")
            addAchievement("X5 FEVER Activated", 3, "COMMENT", "Cute".localized)    //귀여워 可愛
            addAchievement("X5 FEVER Activated", 4, "GALLERY", "Out Law (2)")
            addAchievement("X5 FEVER Activated", 5, "MUSIC", "v o l d e n u i t")
            addAchievement("X5 FEVER Activated", 6, "GALLERY", "BlackCat (2)")
            addAchievement("X5 FEVER Activated", 7, "GALLERY", "Save My Dream (2)")
            addAchievement("X5 FEVER Activated", 8, "MUSIC", "Triple Zoe")
            addAchievement("X5 FEVER Activated", 9, "COMMENT", "No Comment")
            addAchievement("X5 FEVER Activated", 10, "PLATE", "Sunset Rider")
            addAchievement("Effector", 1, "MUSIC", "Para-Q")
            addAchievement("Effector", 2, "COMMENT", "You See That?".localized) //그게 보여요? 那也能看得到嗎？
            addAchievement("Effector", 3, "GALLERY", "Enter The Universe (2)")
            addAchievement("Effector", 4, "MUSIC", "Fever GJ")
            addAchievement("Effector", 5, "GALLERY", "Ruti'n (GOTH Wild Electro Remix) (2)")
            addAchievement("Effector", 6, "COMMENT", "Craving Technika".localized)  //테크니카 하고싶다 TECHNIKA渴望中
            addAchievement("Total Score", 1, "MUSIC", "KILLER BEE")
            addAchievement("Total Score", 2, "MUSIC", "Minus 3")
            addAchievement("Total Score", 3, "COMMENT", "Yes Sir!".localized)   //충성충성 絕對忠誠
            addAchievement("Total Score", 4, "GALLERY", "Don't Die (3)")
            addAchievement("Total Score", 5, "COMMENT", "!?")
            addAchievement("Total Score", 6, "NOTE SKIN", "glory day")
            addAchievement("Total Score", 7, "GALLERY", "Road Of Death (2)")
            addAchievement("Total Score", 8, "GALLERY", "glory day (2)")
            addAchievement("Total Score", 9, "GALLERY", "WHY (3)")
            addAchievement("Total Score", 10, "COMMENT", "Hard Worker".localized)   //노력형 플레이어 努力家
            addAchievement("ONLINE Mode Playcount", 1, "MUSIC", "MASAI")
            addAchievement("ONLINE Mode Playcount", 2, "COMMENT", "Let's Be Friends".localized) //친해지고 싶어요 想親近
            addAchievement("ONLINE Mode Playcount", 3, "COMMENT", "Lurker".localized)   //온라인 서식중 網絡潛伏者
            addAchievement("ONLINE Mode Playcount", 4, "GALLERY", "Heavenly (2)")
            addAchievement("ONLINE Mode Playcount", 5, "COMMENT", "DJMAX Missionary".localized) //디맥 전도사 DJMAX 傳教士
            addAchievement("ONLINE Mode Playcount", 6, "GALLERY", "Lift You Up (2)")
            addAchievement("ONLINE Mode Playcount", 7, "GALLERY", "Long Vacation (2)")
            addAchievement("ONLINE Mode Playcount", 8, "COMMENT", "Test your Might".localized)  //누구든지 덤벼 放馬過來吧
            addAchievement("ONLINE Mode Playcount", 9, "GALLERY", "Brandnew Days (2)")
            addAchievement("ONLINE Mode Playcount", 10, "PLATE", "KILLER BEE")
        }
        
        
        
        //1.13 이하의 UserDefaults에 기록된 성과 정보 Realm으로 옮김
        //삭제하지 말고 그냥 두기
//        if(version <= 13){
//            try! realm.write{
//                realm.delete(realm.objects(RecordInfo.self))
//            }
//            let songResults = try! Realm().objects(SongInfo.self)
//            let userDefaults = UserDefaults.standard
//            for i in songResults{
//                let title = i.title
//                initRecord(i.series, title)
//                initRecordDifficulty(title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
//                addRecord(title, userDefaults.string(forKey: title+"4BnormalRank") ?? "-", userDefaults.string(forKey: title+"4BnormalAccuracy") ?? "-", userDefaults.string(forKey: title+"4BnormalNote") ?? "-", userDefaults.string(forKey: title+"5BnormalRank") ?? "-",userDefaults.string(forKey: title+"5BnormalAccuracy") ?? "-",userDefaults.string(forKey: title+"5BnormalNote") ?? "-",userDefaults.string(forKey: title+"6BnormalRank") ?? "-",userDefaults.string(forKey: title+"6BnormalAccuracy") ?? "-",userDefaults.string(forKey: title+"6BnormalNote") ?? "-",userDefaults.string(forKey: title+"8BnormalRank") ?? "-",userDefaults.string(forKey: title+"8BnormalAccuracy") ?? "-",userDefaults.string(forKey: title+"8BnormalNote") ?? "-",userDefaults.string(forKey: title+"4BhardRank") ?? "-",userDefaults.string(forKey: title+"4BhardAccuracy") ?? "-",userDefaults.string(forKey: title+"4BhardNote") ?? "-",userDefaults.string(forKey: title+"5BhardRank") ?? "-",userDefaults.string(forKey: title+"5BhardAccuracy") ?? "-",userDefaults.string(forKey: title+"5BhardNote") ?? "-",userDefaults.string(forKey: title+"6BhardRank") ?? "-",userDefaults.string(forKey: title+"6BhardAccuracy") ?? "-",userDefaults.string(forKey: title+"6BhardNote") ?? "-",userDefaults.string(forKey: title+"8BhardRank") ?? "-",userDefaults.string(forKey: title+"8BhardAccuracy") ?? "-",userDefaults.string(forKey: title+"8BhardNote") ?? "-", userDefaults.string(forKey: title+"4BmaximumRank") ?? "-",userDefaults.string(forKey: title+"4BmaximumAccuracy") ?? "-",userDefaults.string(forKey: title+"4BmaximumNote") ?? "-",userDefaults.string(forKey: title+"5BmaximumRank") ?? "-",userDefaults.string(forKey: title+"5BmaximumAccuracy") ?? "-",userDefaults.string(forKey: title+"5BmaximumNote") ?? "-",userDefaults.string(forKey: title+"6BmaximumRank") ?? "-",userDefaults.string(forKey: title+"6BmaximumAccuracy") ?? "-",userDefaults.string(forKey: title+"6BmaximumNote") ?? "-",userDefaults.string(forKey: title+"8BmaximumRank") ?? "-",userDefaults.string(forKey: title+"8BmaximumAccuracy") ?? "-",userDefaults.string(forKey: title+"8BmaximumNote") ?? "-")
//                if(i.nm4 == 0 && userDefaults.string(forKey: title+"4BnormalRank") != nil){
//                    removeRecord(title, "nm4")
//                }
//                if(i.nm5 == 0 && userDefaults.string(forKey: title+"5BnormalRank") != nil){
//                    removeRecord(title, "nm5")
//                }
//                if(i.nm6 == 0 && userDefaults.string(forKey: title+"6BnormalRank") != nil){
//                    removeRecord(title, "nm6")
//                }
//                if(i.nm8 == 0 && userDefaults.string(forKey: title+"8BnormalRank") != nil){
//                    removeRecord(title, "nm8")
//                }
//                if(i.hd4 == 0 && userDefaults.string(forKey: title+"4BhardRank") != nil){
//                    removeRecord(title, "hd4")
//                }
//                if(i.hd5 == 0 && userDefaults.string(forKey: title+"5BhardRank") != nil){
//                    removeRecord(title, "hd5")
//                }
//                if(i.hd6 == 0 && userDefaults.string(forKey: title+"6BhardRank") != nil){
//                    removeRecord(title, "hd6")
//                }
//                if(i.hd8 == 0 && userDefaults.string(forKey: title+"8BhardRank") != nil){
//                    removeRecord(title, "hd8")
//                }
//                if(i.mx4 == 0 && userDefaults.string(forKey: title+"4BmaximumRank") != nil){
//                    removeRecord(title, "mx4")
//                }
//                if(i.mx5 == 0 && userDefaults.string(forKey: title+"5BmaximumRank") != nil){
//                    removeRecord(title, "mx5")
//                }
//                if(i.mx6 == 0 && userDefaults.string(forKey: title+"6BmaximumRank") != nil){
//                    removeRecord(title, "mx6")
//                }
//                if(i.mx8 == 0 && userDefaults.string(forKey: title+"8BmaximumRank") != nil){
//                    removeRecord(title, "mx8")
//                }
//            }
//        }
        
        
        
        
        //클래지콰이 에디션 성과 기록을 위한 공간 만드는 코드
        //드레드노트, 리스펙트 신곡도 추가
        if(version <= 14){
            let songResults = try! Realm().objects(SongInfo.self).filter("series = 'CE'")
            for i in songResults{
                initRecord(i.series, i.title)
                initRecordDifficulty(i.title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
            }
            initRecord("Portable1", "Dreadnought")
            initRecordDifficulty("Dreadnought", 6, 8, 8, 8, 9, 11, 0, 13, 12, 0, 13, 0)
            initRecord("Respect", "Rising The Sonic")
            initRecordDifficulty("Rising The Sonic", 4, 5, 5, 5, 8, 10, 9, 10, 12, 13, 13, 14)
        }
        
        if(version <= 15){
            if(try! Realm().objects(RecordInfo.self).count == 0){
                let songResults = try! Realm().objects(SongInfo.self)
                for i in songResults{
                    let title = i.title
                    initRecord(i.series, title)
                    initRecordDifficulty(title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
                }
            }
            if(try! Realm().objects(RecordInfo.self).filter("series = 'CE'").count == 0){
                let song = try! Realm().objects(SongInfo.self).filter("series = 'CE'")
                for i in song{
                    initRecord(i.series, i.title)
                    initRecordDifficulty(i.title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
                }
                initRecord("Portable1", "Dreadnought")
                initRecordDifficulty("Dreadnought", 6, 8, 8, 8, 9, 11, 0, 13, 12, 0, 13, 0)
                initRecord("Respect", "Rising The Sonic")
                initRecordDifficulty("Rising The Sonic", 4, 5, 5, 5, 8, 10, 9, 10, 12, 13, 13, 14)
            }
        }
        
        if(version <= 17){
            //Blythe 성과기록 옮기기
            var record = try! Realm().objects(RecordInfo.self).filter("title = 'BlythE'").first
            try! realm.write{
                record?.mx8Note = (record?.hd8Note)!
                record?.mx8Rank = (record?.hd8Rank)!
                record?.mx8Rate = (record?.hd8Rate)!
                record?.hd8Note="-"
                record?.hd8Rank="-"
                record?.hd8Rate="-"
            }
            record = try! Realm().objects(RecordInfo.self).filter("title = '" + "Taekwonburi".localized + "'").first
            let songInfo = try! Realm().objects(SongInfo.self).filter("title = '" + "Taekwonburi".localized + "'").first
            try! realm.write{
                record?.mx8Note = (record?.hd8Note)!
                record?.mx8Rank = (record?.hd8Rank)!
                record?.mx8Rate = (record?.hd8Rate)!
                record?.hd8Note="-"
                record?.hd8Rank="-"
                record?.hd8Rate="-"
                songInfo?.mx8 = (songInfo?.hd8)!
                songInfo?.hd8 = 0
            }
        }
        
        //중복 레코드 제거
        if(version <= 17){
            let songInfo = try! Realm().objects(SongInfo.self).filter("series = 'CE'")
            for i in songInfo{
                let record = try! Realm().objects(RecordInfo.self).filter("title = '" + i.title + "'")
                let count = record.count
                try! realm.write{
                    for i in 1..<count{
                        realm.delete(record[i])
                    }
                }
            }
            var record = try! Realm().objects(RecordInfo.self).filter("title = 'Dreadnought'")
            var count = record.count
            try! realm.write{
                for i in 1..<count{
                    realm.delete(record[i])
                }
            }
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Rising The Sonic'")
            count = record.count
            try! realm.write{
                for i in 1..<count{
                    realm.delete(record[i])
                }
            }
            
        }
        
        if(version <= 18){
            var songInfo = try! Realm().objects(RecordInfo.self).filter("title = 'Dreadnought'").first!
            try! realm.write{
                songInfo.nm4 = 6; songInfo.hd4 = 9; songInfo.mx4 = 12; songInfo.nm5 = 8; songInfo.hd5 = 11; songInfo.nm6 = 8; songInfo.mx6 = 13
                songInfo.nm8 = 8; songInfo.hd8 = 13;
                let nm4Point = getSkillPoint(difficulty: songInfo.nm4, rate: songInfo.nm4Rate, note: songInfo.nm4Note)
                let hd4Point = getSkillPoint(difficulty: songInfo.hd4, rate: songInfo.hd4Rate, note: songInfo.hd4Note)
                let mx4Point = getSkillPoint(difficulty: songInfo.mx4, rate: songInfo.mx4Rate, note: songInfo.mx4Note)
                let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
                songInfo.button4SkillPoint = max4Point
                let nm5Point = getSkillPoint(difficulty: songInfo.nm5, rate: songInfo.nm5Rate, note: songInfo.nm5Note)
                let hd5Point = getSkillPoint(difficulty: songInfo.hd5, rate: songInfo.hd5Rate, note: songInfo.hd5Note)
                let mx5Point = getSkillPoint(difficulty: songInfo.mx5, rate: songInfo.mx5Rate, note: songInfo.mx5Note)
                let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
                songInfo.button5SkillPoint = max5Point
                let nm6Point = getSkillPoint(difficulty: songInfo.nm6, rate: songInfo.nm6Rate, note: songInfo.nm6Note)
                let hd6Point = getSkillPoint(difficulty: songInfo.hd6, rate: songInfo.hd6Rate, note: songInfo.hd6Note)
                let mx6Point = getSkillPoint(difficulty: songInfo.mx6, rate: songInfo.mx6Rate, note: songInfo.mx6Note)
                let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
                songInfo.button6SkillPoint = max6Point
                let nm8Point = getSkillPoint(difficulty: songInfo.nm8, rate: songInfo.nm8Rate, note: songInfo.nm8Note)
                let hd8Point = getSkillPoint(difficulty: songInfo.hd8, rate: songInfo.hd8Rate, note: songInfo.hd8Note)
                let mx8Point = getSkillPoint(difficulty: songInfo.mx8, rate: songInfo.mx8Rate, note: songInfo.mx8Note)
                let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
                songInfo.button8SkillPoint = max8Point
            }
            songInfo = try! Realm().objects(RecordInfo.self).filter("title = 'Rising The Sonic'").first!
            try! realm.write{
                songInfo.nm4 = 4; songInfo.hd4 = 8; songInfo.mx4 = 12;
                songInfo.nm5 = 5; songInfo.hd5 = 10; songInfo.mx5 = 13;
                songInfo.nm6 = 5; songInfo.hd6 = 9; songInfo.mx6 = 13;
                songInfo.nm8 = 5; songInfo.hd8 = 10; songInfo.mx8 = 14;
                let nm4Point = getSkillPoint(difficulty: songInfo.nm4, rate: songInfo.nm4Rate, note: songInfo.nm4Note)
                let hd4Point = getSkillPoint(difficulty: songInfo.hd4, rate: songInfo.hd4Rate, note: songInfo.hd4Note)
                let mx4Point = getSkillPoint(difficulty: songInfo.mx4, rate: songInfo.mx4Rate, note: songInfo.mx4Note)
                let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
                songInfo.button4SkillPoint = max4Point
                let nm5Point = getSkillPoint(difficulty: songInfo.nm5, rate: songInfo.nm5Rate, note: songInfo.nm5Note)
                let hd5Point = getSkillPoint(difficulty: songInfo.hd5, rate: songInfo.hd5Rate, note: songInfo.hd5Note)
                let mx5Point = getSkillPoint(difficulty: songInfo.mx5, rate: songInfo.mx5Rate, note: songInfo.mx5Note)
                let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
                songInfo.button5SkillPoint = max5Point
                let nm6Point = getSkillPoint(difficulty: songInfo.nm6, rate: songInfo.nm6Rate, note: songInfo.nm6Note)
                let hd6Point = getSkillPoint(difficulty: songInfo.hd6, rate: songInfo.hd6Rate, note: songInfo.hd6Note)
                let mx6Point = getSkillPoint(difficulty: songInfo.mx6, rate: songInfo.mx6Rate, note: songInfo.mx6Note)
                let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
                songInfo.button6SkillPoint = max6Point
                let nm8Point = getSkillPoint(difficulty: songInfo.nm8, rate: songInfo.nm8Rate, note: songInfo.nm8Note)
                let hd8Point = getSkillPoint(difficulty: songInfo.hd8, rate: songInfo.hd8Rate, note: songInfo.hd8Note)
                let mx8Point = getSkillPoint(difficulty: songInfo.mx8, rate: songInfo.mx8Rate, note: songInfo.mx8Note)
                let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
                songInfo.button8SkillPoint = max8Point
            }
        }
        
        if(version <= 19){
            var record = try! Realm().objects(RecordInfo.self).filter("title = 'BlythE'").first!
            try! realm.write{
                record.mx8 = 14
                record.hd8 = 0
            }
            record = try! Realm().objects(RecordInfo.self).filter("title = '"+"Taekwonburi".localized+"'").first!
            try! realm.write{
                record.mx8 = 12
                record.hd8 = 0
            }
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Shadow Flower'").first!
            try! realm.write{
                record.nm6 = 5
                record.hd8 = 9
            }
            if let bullet = try! Realm().objects(RecordInfo.self).filter("title = 'Bullet Wanted!'").first{
                try! realm.write{
                    bullet.title = "Bullet, Wanted!"
                }
            }
        }
        
        if(version <= 19){
            let songInfo = try! Realm().objects(SongInfo.self).sorted(byKeyPath: "title")
            let recordInfo = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "title")
            for i in 0..<songInfo.count{
                try! realm.write{
                    let lowercase = songInfo[i].title.lowercased()
                    songInfo[i].lowercase = lowercase
                    recordInfo[i].lowercase = lowercase
                }
            }
        }
        
        //한국에서 한글 제목을 맨 위에 표시하게 하는 코드
        if(version <= 19){
            let locale = Locale.current.regionCode
            switch(locale!){
            case "KR":
                let songInfo = try! Realm().objects(SongInfo.self).sorted(byKeyPath: "title")
                let recordInfo = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "title")
                var count=0
                for i in songInfo.count - 11 ..< songInfo.count{
                    try! realm.write{
                        if(count < 10){
                            songInfo[i].lowercase = "00\(count)"
                            recordInfo[i].lowercase = "00\(count)"
                        }
                        else{
                            songInfo[i].lowercase = "0\(count)"
                            recordInfo[i].lowercase = "0\(count)"
                        }
                        
                    }
                    count=count+1
                }
            default:
                break
            }
        }
        
        if(version <= 20){
            var song = try! Realm().objects(SongInfo.self).filter("title = 'Ventilator'").first
            var record = try! Realm().objects(RecordInfo.self).filter("title = 'Ventilator'").first
            try! realm.write{
                song?.nm5 = 9
                record?.nm5 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = '"+"Taekwonburi".localized+"'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = '"+"Taekwonburi".localized+"'").first
            try! realm.write{
                song?.hd8 = 0
                song?.mx8 = 12
                record?.hd8Note="-"
                record?.hd8Rank="-"
                record?.hd8Rate="-"
            }
            song = try! Realm().objects(SongInfo.self).filter("title = '"+"Proposed, Flower, Wolf".localized+"'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = '"+"Proposed, Flower, Wolf".localized+"'").first
            try! realm.write{
                song?.mx6 = 7
                record?.mx6 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Break a Spell'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Break a Spell'").first
            try! realm.write{
                song?.nm6 = 7
                record?.nm6 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Coastal Tempo'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Coastal Tempo'").first
            try! realm.write{
                song?.hd6 = 7
                record?.hd6 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Electronics'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Electronics'").first
            try! realm.write{
                song?.hd8 = 9
                record?.hd8 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'First Kiss'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'First Kiss'").first
            try! realm.write{
                song?.mx5 = 7
                record?.mx5 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Flea'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Flea'").first
            try! realm.write{
                song?.hd4 = 9
                song?.hd5 = 9
                record?.hd4 = 9
                record?.hd5 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Here in the Moment'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Here in the Moment'").first
            try! realm.write{
                song?.hd4 = 7
                record?.hd4 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'In My Heart'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'In My Heart'").first
            try! realm.write{
                song?.hd5 = 7
                record?.hd5 = 7
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Love Mode'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Love Mode'").first
            try! realm.write{
                song?.hd6 = 9
                record?.hd6 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'The Clear Blue Sky'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'The Clear Blue Sky'").first
            try! realm.write{
                song?.hd4 = 9
                song?.hd6 = 9
                song?.hd8 = 9
                record?.hd4 = 9
                record?.hd6 = 9
                record?.hd8 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'A Lie ~Deep Inside Mix~'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'A Lie ~Deep Inside Mix~'").first
            try! realm.write{
                song?.hd4 = 9
                record?.hd4 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Syriana ~Blast Wave Mix~'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Syriana ~Blast Wave Mix~'").first
            try! realm.write{
                song?.mx5 = 12
                record?.mx5 = 12
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Rising The Sonic'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Rising The Sonic'").first
            try! realm.write{
                song?.hd4 = 9
                record?.hd4 = 9
            }
            song = try! Realm().objects(SongInfo.self).filter("title = 'Mess it Up'").first
            record = try! Realm().objects(RecordInfo.self).filter("title = 'Mess it Up'").first
            try! realm.write{
                song?.nm6 = 9
                record?.nm6 = 9
            }
            
        }
        
        if(version <= 20){
            //스킬포인트 계산
            let recordSkill = try! Realm().objects(RecordInfo.self)
            for i in recordSkill{
                try! realm.write{
                    let nm4Point = getSkillPoint(difficulty: i.nm4, rate: i.nm4Rate, note: i.nm4Note)
                    let hd4Point = getSkillPoint(difficulty: i.hd4, rate: i.hd4Rate, note: i.hd4Note)
                    let mx4Point = getSkillPoint(difficulty: i.mx4, rate: i.mx4Rate, note: i.mx4Note)
                    let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
                    i.button4SkillPoint = max4Point
                    switch(max4Point){
                    case nm4Point:
                        i.button4HighestSkillPointRate = i.nm4Rate
                        i.button4HighestSkillPointDifficulty = "NORMAL"
                        i.button4HighestSkillPointNote = i.nm4Note
                    case hd4Point:
                        i.button4HighestSkillPointRate = i.hd4Rate
                        i.button4HighestSkillPointDifficulty = "HARD"
                        i.button4HighestSkillPointNote = i.hd4Note
                    case mx4Point:
                        i.button4HighestSkillPointRate = i.mx4Rate
                        i.button4HighestSkillPointDifficulty = "MAXIMUM"
                        i.button4HighestSkillPointNote = i.mx4Note
                    default:
                        break
                    }
                    let nm5Point = getSkillPoint(difficulty: i.nm5, rate: i.nm5Rate, note: i.nm5Note)
                    let hd5Point = getSkillPoint(difficulty: i.hd5, rate: i.hd5Rate, note: i.hd5Note)
                    let mx5Point = getSkillPoint(difficulty: i.mx5, rate: i.mx5Rate, note: i.mx5Note)
                    let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
                    i.button5SkillPoint = max5Point
                    switch(max5Point){
                    case nm5Point:
                        i.button5HighestSkillPointRate = i.nm5Rate
                        i.button5HighestSkillPointDifficulty = "NORMAL"
                        i.button5HighestSkillPointNote = i.nm5Note
                    case hd5Point:
                        i.button5HighestSkillPointRate = i.hd5Rate
                        i.button5HighestSkillPointDifficulty = "HARD"
                        i.button5HighestSkillPointNote = i.hd5Note
                    case mx5Point:
                        i.button5HighestSkillPointRate = i.mx5Rate
                        i.button5HighestSkillPointDifficulty = "MAXIMUM"
                        i.button5HighestSkillPointNote = i.mx5Note
                    default:
                        break
                    }
                    let nm6Point = getSkillPoint(difficulty: i.nm6, rate: i.nm6Rate, note: i.nm6Note)
                    let hd6Point = getSkillPoint(difficulty: i.hd6, rate: i.hd6Rate, note: i.hd6Note)
                    let mx6Point = getSkillPoint(difficulty: i.mx6, rate: i.mx6Rate, note: i.mx6Note)
                    let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
                    i.button6SkillPoint = max6Point
                    switch(max6Point){
                    case nm6Point:
                        i.button6HighestSkillPointRate = i.nm6Rate
                        i.button6HighestSkillPointDifficulty = "NORMAL"
                        i.button6HighestSkillPointNote = i.nm6Note
                    case hd6Point:
                        i.button6HighestSkillPointRate = i.hd6Rate
                        i.button6HighestSkillPointDifficulty = "HARD"
                        i.button6HighestSkillPointNote = i.hd6Note
                    case mx6Point:
                        i.button6HighestSkillPointRate = i.mx6Rate
                        i.button6HighestSkillPointDifficulty = "MAXIMUM"
                        i.button6HighestSkillPointNote = i.mx6Note
                    default:
                        break
                    }
                    let nm8Point = getSkillPoint(difficulty: i.nm8, rate: i.nm8Rate, note: i.nm8Note)
                    let hd8Point = getSkillPoint(difficulty: i.hd8, rate: i.hd8Rate, note: i.hd8Note)
                    let mx8Point = getSkillPoint(difficulty: i.mx8, rate: i.mx8Rate, note: i.mx8Note)
                    let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
                    i.button8SkillPoint = max8Point
                    switch(max8Point){
                    case nm8Point:
                        i.button8HighestSkillPointRate = i.nm8Rate
                        i.button8HighestSkillPointDifficulty = "NORMAL"
                        i.button8HighestSkillPointNote = i.nm8Note
                    case hd8Point:
                        i.button8HighestSkillPointRate = i.hd8Rate
                        i.button8HighestSkillPointDifficulty = "HARD"
                        i.button8HighestSkillPointNote = i.hd8Note
                    case mx8Point:
                        i.button8HighestSkillPointRate = i.mx8Rate
                        i.button8HighestSkillPointDifficulty = "MAXIMUM"
                        i.button8HighestSkillPointNote = i.mx8Note
                    default:
                        break
                    }
                }
            }
        }
        if(version <= 24){
            if let object = realm.objects(AchievementInfo.self).filter("type = 'MUSIC'").filter("item = 'Triple Joe'").first{
                try! realm.write{
                    object.item = "Triple Zoe"
                }
            }
            //NB is an Open Door 미션 보상 대소문자 변경 코드
            if let nb = realm.objects(MissionInfo.self).filter("title = 'NB is an Open Door'").first{
                try! realm.write{
                    nb.reward = "Music : NB RANGER - Virgin Force"
                }
            }
            //다크엔비 추가 코드
            if(realm.objects(SongInfo.self).filter("title = 'DARK ENVY'").count == 0){
                addSong("CE", "DARK ENVY", "Sugardonut", "195", 6, 11, 14, 6, 10, 14, 7, 10, 13, 6, 9, 14)
                initRecord("CE", "DARK ENVY")
                initRecordDifficulty("DARK ENVY", 6, 6, 7, 6, 11, 10, 10, 9, 14, 14, 13, 14)
            }
            let darkenvySong = realm.objects(SongInfo.self).filter("title = 'DARK ENVY'").first!
            try! realm.write{
                darkenvySong.lowercase = "DARK ENVY".lowercased()
            }
            let darkenvyRecord = realm.objects(RecordInfo.self).filter("title = 'DARK ENVY'").first!
            try! realm.write{
                darkenvyRecord.lowercase = "DARK ENVY".lowercased()
            }
            //드레드노트 라이징더소닉 RecordInfo 난이도 수정
            let dreadnought = realm.objects(RecordInfo.self).filter("title = 'Dreadnought'").first!
            try! realm.write{
                dreadnought.nm4 = 6; dreadnought.nm5 = 8; dreadnought.nm6 = 8; dreadnought.nm8 = 8
                dreadnought.hd4 = 9; dreadnought.hd5 = 11; dreadnought.hd6 = 0; dreadnought.hd8 = 13;
                dreadnought.mx4 = 12; dreadnought.mx5 = 0; dreadnought.mx6 = 13; dreadnought.mx8 = 0;
            }
            let rising = realm.objects(RecordInfo.self).filter("title = 'Rising The Sonic'").first!
            try! realm.write{
                rising.nm4 = 4; rising.nm5 = 5; rising.nm6 = 5; rising.nm8 = 5
                rising.hd4 = 8; rising.hd5 = 10; rising.hd6 = 9; rising.hd8 = 10
                rising.mx4 = 12; rising.mx5 = 13; rising.mx6 = 13; rising.mx8 = 14
            }
            let dark = realm.objects(RecordInfo.self).filter("title = 'DARK ENVY'").first!
            try! realm.write{
                dark.nm4 = 6; dark.nm5 = 6; dark.nm6 = 7; dark.nm8 = 6
                dark.hd4 = 11; dark.hd5 = 10; dark.hd6 = 10; dark.hd8 = 9;
                dark.mx4 = 14; dark.mx5 = 14; dark.mx6 = 13; dark.mx8 = 14
            }
            try! realm.write{
                realm.delete(realm.objects(TipInfo.self))
            }
            addTip("Each music's speed settings are saved separately.")
            addTip("ANALOG NOTE can be played by rotating the stick or holding it to one side.")
            addTip("System Settings can be changed from the main menu by pressing the touch pad button.")
            addTip("In FREESTYLE mode, press the R3 button to add a music to your favorites.")
            addTip("In FREESTYLE mode, combos are cumulative.")
            addTip("Some music have hidden BGAs.")
            addTip("When you achieve MAX COMBO, you can receive the music video for the current music.")
            addTip("While performing, press the touch pad to adjust the BGA brightness.")
            addTip("In FREESTYLE mode, 2 players local play is possible, and each player can play a different mode.")
            addTip("The button used to play can be changed in System Settings.")
            addTip("FREESTYLE mode's combo accumulation can be changed in System Settings.")
            addTip("ARCADE mode's music are chosen randomly according to the set difficulty.")
            addTip("The FEVER gauge increases according to note play accuracy.")
            addTip("You can change the System Settings UI skin.")
            addTip("If the game screen doesn't display completely, check your \"PS4\" Display Area settings.")
            addTip("In FREESTYLE mode, use the L1 button and R1 button to change the category.")
            addTip("In ONLINE mode, you can play music you have not yet acquired.")
            addTip("While FEVER is active, you can receive more points and larger combos.")
            addTip("You can use the L2 button and R2 button to change the speed during play, or from the music selection screen.")
        }
        
        if(version <= 25){
            UserDefaults.standard.set(200, forKey: "version")
        }
    }
}

func getSkillPoint(difficulty: Int, rate: String, note: String) -> Double{
    if(difficulty == 0){
        return 0
    }
    var skillPoint: Double
    let e = 2.71828
    let rateString = rate.split(separator: "%")[0].description
    let accuracy = Double(rateString) ?? 0
    let weight = getWeight(value: difficulty)
    if(accuracy >= 80){
        let temp = pow((accuracy - 80) / 20.0, e) + 1
        skillPoint = weight * 50 * temp
    }
    else{
        skillPoint = Double(weight * accuracy * 5) / 8.0
    }
    if(note == "-"){
        skillPoint = skillPoint * 0.98
    }
    else if(note == "PERFECT PLAY"){
        skillPoint = skillPoint * 1.05
    }
    skillPoint = (skillPoint * 100).rounded() / 100
    return skillPoint
}

func getWeight(value: Int) -> Double{
    var result: Double = 0.0
    switch(value){
    case 1:
        result = 0.4
    case 2:
        result = 0.6
    case 3:
        result = 0.8
    case 4:
        result = 1
    case 5:
        result = 1.14
    case 6:
        result = 1.24
    case 7:
        result = 1.33
    case 8:
        result = 1.42
    case 9:
        result = 1.53
    case 10:
        result = 1.6
    case 11:
        result = 1.68
    case 12:
        result = 1.77
    case 13:
        result = 1.85
    case 14:
        result = 1.94
    case 15:
        result = 2
    default:
        break
    }
    return result
}

