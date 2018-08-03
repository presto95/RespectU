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
   
    var realm: Realm!
    
    init() {
        realm = try! Realm()
        if(!UserDefaults.standard.bool(forKey: "error1")){
            UserDefaults.standard.set(15, forKey: "version")
            UserDefaults.standard.set(true, forKey: "error1")
        }
    
        let version = UserDefaults.standard.integer(forKey: "version")
        print(version)
        
        if(version <= 15){
            try! realm.write{
                realm.delete(realm.objects(SongInfo.self))
                realm.delete(realm.objects(MissionInfo.self))
                realm.delete(realm.objects(TrophyInfo.self))
                realm.delete(realm.objects(AchievementInfo.self))
            }
            // Database - SongInfo
            
            //Link Disk
            SongInfo.add(Series.ce, "Here in the Moment ~Extended Mix~", "Ruby Tuesday", "115", 4, 6, 9, 5, 8, 11, 6, 9, 12, 5, 8, 11)
            SongInfo.add(Series.bs, "Airwave ~Extended Mix~", "ReX", "150", 8, 10, 13, 7, 10, 14, 6, 12, 14, 7, 10, 13)
            SongInfo.add(Series.technika1, "SON OF SUN ~Extended Mix~", "Hosoe Shinji", "200", 7, 10, 14, 7, 10, 15, 7, 11, 14, 8, 11, 15)
            
            //Black Square
            SongInfo.add(Series.bs, "Proposed, Flower, Wolf part.2".localized, "ReX", "160", 3, 8, 0, 4, 10, 0, 4, 8, 11, 5, 10, 0)
            SongInfo.add(Series.bs, "Beat U Down", "makou", "155", 8, 12, 14, 8, 10, 14, 9, 12, 14, 8, 10, 14)
            SongInfo.add(Series.bs, "Colours of Sorrow", "Tsukasa", "143", 4, 0, 11, 6, 9, 12, 5, 9, 12, 6, 9, 13)
            SongInfo.add(Series.bs, "Cypher Gate", "7 Sequence", "150", 5, 8, 0, 7, 10, 0, 7, 10, 13, 7, 10, 13)
            SongInfo.add(Series.bs, "Desperado", "Croove", "130", 5, 9, 11, 7, 11, 0, 5, 8, 11, 7, 12, 0)
            SongInfo.add(Series.bs, "Fermion", "makou", "156", 8, 11, 14, 7, 9, 14, 8, 12, 14, 7, 10, 14)
            SongInfo.add(Series.bs, "Fever Pitch Girl", "Nikacha", "136", 5, 8, 0, 4, 7, 10, 6, 10, 0, 6, 11, 0)
            SongInfo.add(Series.bs, "Get Down", "BJJ", "111", 4, 7, 9, 4, 9, 0, 4, 7, 10, 5, 10, 0)
            SongInfo.add(Series.bs, "Grave Consequence", "Tsukasa", "180", 6, 10, 14, 6, 10, 13, 7, 12, 0, 7, 10, 14)
            SongInfo.add(Series.bs, "Heart of Witch", "ReX", "170", 7, 12, 14, 7, 11, 15, 7, 12, 14, 8, 12, 15)
            SongInfo.add(Series.bs, "In my Dream", "ND Lee", "140", 5, 10, 14, 8, 11, 13, 5, 11, 13, 8, 10, 14)
            SongInfo.add(Series.bs, "Jealousy", "3rd Coast", "125", 3, 7, 0, 3, 7, 9, 4, 0, 9, 3, 9, 10)
            SongInfo.add(Series.bs, "Keys to the World", "Planetboom", "160", 5, 8, 12, 6, 9, 13, 6, 11, 0, 6, 10, 13)
            SongInfo.add(Series.bs, "Lovely hands", "Planetboom", "132", 4, 0, 10, 5, 9, 11, 3, 10, 0, 6, 9, 11)
            SongInfo.add(Series.bs, "Lover (BS Style)", "ND Lee", "145", 5, 7, 12, 5, 10, 0, 4, 8, 11, 5, 8, 10)
            SongInfo.add(Series.bs, "PDM", "Trish", "120", 3, 7, 10, 4, 7, 9, 3, 10, 0, 4, 9, 0)
            SongInfo.add(Series.bs, "Ready Now", "Ruby Tuesday", "135", 4, 8, 0, 4, 7, 9, 4, 7, 10, 5, 0, 9)
            SongInfo.add(Series.bs, "Ruti'n", "BEXTER", "120", 4, 10, 0, 5, 8, 11, 4, 9, 11, 5, 10, 0)
            SongInfo.add(Series.bs, "Secret World", "Sweetune", "110", 4, 7, 10, 3, 8, 0, 4, 7, 10, 4, 0, 9)
            SongInfo.add(Series.bs, "Y (BS Style)", "ND Lee", "130", 5, 8, 11, 4, 7, 0, 4, 8, 12, 4, 8, 11)
            
            //Technika1
            SongInfo.add(Series.technika1, "Access", "Sphazer", "135", 2, 4, 7, 3, 6, 0, 3, 0, 12, 5, 7, 12)
            SongInfo.add(Series.technika1, "Area 7", "Sphazer", "130", 4, 0, 10, 4, 7, 10, 5, 7, 11, 4, 7, 12)
            SongInfo.add(Series.technika1, "Beyond the Future", "7  Sequence", "150", 4, 8, 11, 4, 8, 11, 4, 9, 12, 4, 9, 12)
            SongInfo.add(Series.technika1, "Dear my Lady", "Oriental ST8", "128", 5, 9, 0, 5, 7, 10, 5, 7, 10, 4, 7, 10)
            SongInfo.add(Series.technika1, "DJMAX", "Humming Urban Stereo", "128", 2, 7, 0, 3, 0, 8, 4, 8, 0, 4, 8, 0)
            SongInfo.add(Series.technika1, "Fury", "Sugardonut", "135", 4, 9, 11, 5, 8, 12, 5, 9, 12, 5, 10, 12)
            SongInfo.add(Series.technika1, "HEXAD", "Electronic Boutique", "135", 5, 10, 13, 5, 9, 12, 5, 9, 12, 6, 10, 13)
            SongInfo.add(Series.technika1, "Honeymoon", "Humming Urban Stereo", "150", 3, 5, 8, 4, 0, 8, 4, 8, 0, 3, 9, 0)
            SongInfo.add(Series.technika1, "I want You", "Lin-G", "140", 3, 6, 8, 3, 8, 10, 5, 8, 11, 4, 9, 11)
            SongInfo.add(Series.technika1, "Landscape", "Tsukasa", "140", 6, 9, 0, 6, 8, 11, 5, 9, 12, 7, 9, 13)
            SongInfo.add(Series.technika1, "Melody", "bermei.inazawa", "188", 5, 8, 11, 5, 8, 11, 4, 8, 12, 5, 10, 12)
            SongInfo.add(Series.technika1, "Play the Future", "Urbatronic Chopsticks", "128", 4, 9, 0, 4, 7, 10, 6, 10, 0, 5, 0, 10)
            SongInfo.add(Series.technika1, "Remember", "Lin-G", "150", 3, 8, 10, 4, 7, 10, 4, 7, 11, 5, 0, 11)
            SongInfo.add(Series.technika1, "Shoreline", "Oriental ST8", "135", 4, 8, 10, 6, 11, 0, 6, 11, 0, 6, 8, 12)
            SongInfo.add(Series.technika1, "SON OF SUN", "Hosoe Shinji", "200", 7, 9, 13, 7, 10, 14, 7, 11, 15, 7, 10, 15)
            SongInfo.add(Series.technika1, "SuperSonic", "Planetboom", "156", 4, 7, 11, 5, 8, 12, 6, 9, 12, 6, 10, 13)
            SongInfo.add(Series.technika1, "Sweet Shining Shooting Star", "Croove", "140", 3, 8, 10, 3, 6, 10, 6, 0, 10, 6, 0, 11)
            SongInfo.add(Series.technika1, "The Last Dance", "Urbatronic Chopsticks", "102", 4, 0, 8, 5, 11, 0, 5, 10, 0, 4, 0, 12)
            SongInfo.add(Series.technika1, "Thor", "XeoN", "147", 7, 11, 14, 6, 10, 14, 6, 11, 14, 7, 11, 14)
            SongInfo.add(Series.technika1, "Voyage", "makou", "125", 6, 9, 0, 5, 10, 0, 3, 9, 11, 5, 11, 0)
            
            
            //Clazziquai Edition
            SongInfo.add(Series.ce, "Proposed, Flower, Wolf".localized, "ReX", "80", 1, 3, 6, 1, 6, 0, 1, 4, 7, 1, 3, 7)
            SongInfo.add(Series.ce, "Come to me".localized, "CLAZZIQUAI", "125", 3, 5, 8, 4, 0, 8, 2, 7, 9, 4, 8, 12)
            SongInfo.add(Series.ce, "To You".localized, "Sweetune", "133", 3, 6, 0, 2, 0, 8, 2, 5, 8, 2, 7, 0)
            SongInfo.add(Series.ce, "Forever".localized, "BEXTER", "114", 4, 6, 8, 4, 0, 8, 3, 6, 9, 2, 6, 9)
            SongInfo.add(Series.ce, "Closer", "3rd Coast", "120", 3, 0, 8, 3, 8, 0, 3, 6, 0, 4, 8, 0)
            SongInfo.add(Series.ce, "Coastal Tempo", "3rd Coast", "135", 5, 7, 11 ,3 ,8 ,12, 4, 7, 11, 4, 8, 11)
            SongInfo.add(Series.ce, "Color", "CLAZZIQUAI", "120", 5, 0, 11, 5, 10, 0, 7, 0, 11, 5, 9, 12)
            SongInfo.add(Series.ce, "Creator", "CLAZZIQUAI", "117", 2, 7, 13, 1, 5, 11, 5, 9, 0, 1, 10, 0)
            SongInfo.add(Series.ce, "Electronics", "CLAZZIQUAI", "128", 4, 8, 11, 4, 8,13, 5, 8, 12, 4, 9, 13)
            SongInfo.add(Series.ce, "Fate", "STi", "110", 3, 7, 9, 3, 8, 10, 3, 9, 0, 3, 7, 10)
            SongInfo.add(Series.ce, "First Kiss", "BJJ", "107", 2, 4, 8, 2, 4, 7, 2, 5, 7, 2, 4, 8)
            SongInfo.add(Series.ce, "Flea", "CLAZZIQUAI", "126", 4, 9, 12, 4, 9, 12, 5, 9, 12, 6, 0, 13)
            SongInfo.add(Series.ce, "Freedom", "CLAZZIQUAI", "126", 5, 7, 10, 5, 7, 10, 7, 0, 11, 6, 8, 10)
            SongInfo.add(Series.ce, "Here in the Moment", "Ruby Tuesday", "115", 4, 7, 10, 4, 8, 10, 6, 8, 10, 5, 0, 10)
            SongInfo.add(Series.ce, "In My Heart", "Tsukasa", "123", 3, 7, 10, 4, 7, 10, 4, 8, 10, 3, 7, 11)
            SongInfo.add(Series.ce, "Love Mode", "CLAZZIQUAI", "120", 3, 8, 0, 2, 6, 9, 4, 9, 0, 2, 6, 10)
            SongInfo.add(Series.ce, "Lover (CE Style)", "ND Lee", "145", 5, 8, 10, 5, 10, 0, 5, 8, 11, 4, 8, 10)
            SongInfo.add(Series.ce, "Tell Me", "Lee Geol".localized, "89", 1, 6, 0, 2, 5, 9, 3, 6, 8, 1, 8, 0)
            SongInfo.add(Series.ce, "The Clear Blue Sky", "Tsukasa", "178", 4, 8, 13, 6, 8, 13, 6, 9, 13, 4, 9, 13)
            SongInfo.add(Series.ce, "The Night Stage", "CLAZZIQUAI", "120", 3, 6, 0, 3, 7, 0, 3, 8, 0, 3, 7, 10)
            SongInfo.add(Series.ce, "Urban Night", "hYO", "93", 4, 8, 0, 5, 8, 0, 3, 8, 0, 3, 0, 8)
            SongInfo.add(Series.ce, "Y (CE Style)", "ND Lee", "130", 5, 8, 11, 5, 10, 0, 5, 8, 11, 5, 9, 13)
            SongInfo.add(Series.ce, "DARK ENVY", "Sugardonut", "195", 6, 11, 14, 6, 10, 14, 7, 10, 13, 6, 9, 14)
            
            //Trilogy
            SongInfo.add(Series.trilogy, "Memory of Wind".localized, "Forte Escape", "110", 3, 8, 0, 3, 6, 0, 3, 7, 0, 4, 9, 0)
            SongInfo.add(Series.trilogy, "A Lie ~Deep Inside Mix~", "Electronic Boutique", "110", 4, 9, 0, 6, 0, 11, 4, 11, 0, 6, 10, 0)
            SongInfo.add(Series.trilogy, "Bye Bye Love ~Nu Jazz Mix~", "Electronic Boutique", "130", 5, 8, 11, 6, 10, 0, 6, 8, 11, 6, 9, 11)
            SongInfo.add(Series.trilogy, "Catch You", "Forte Escape", "180", 3, 8, 0, 6, 8, 10, 4, 8, 0, 6, 8, 11)
            SongInfo.add(Series.trilogy, "For Seasons ~Air Guitar Mix~", "Planetboom", "116", 3, 10, 0, 5, 7, 10, 5, 0, 10, 5, 10, 0)
            SongInfo.add(Series.trilogy, "GET OUT ~Hip Noodle Mix~", "DJ EON", "123", 6, 10, 0, 5, 8, 12, 6, 9, 0, 5, 9, 12)
            SongInfo.add(Series.trilogy, "Mind Control", "NieN", "185", 8, 10, 13, 9, 11, 0, 9, 12, 14, 9, 11, 14)
            SongInfo.add(Series.trilogy, "My Jealousy", "3rd Coast", "130", 4, 7, 10, 6, 8, 0, 6, 8, 12, 6, 8, 11)
            SongInfo.add(Series.trilogy, "NB Girls", "NieN", "162", 6, 9, 0, 7, 0, 12, 5, 9, 11, 7, 12, 0)
            SongInfo.add(Series.trilogy, "sO mUCH iN LUV ~Melodic Twisted Mix~", "Forte Escape", "122", 5, 8, 0, 5, 8, 0, 4, 7, 10, 6, 8, 10)
            SongInfo.add(Series.trilogy, "Someday", "NieN", "136", 3, 5, 9, 4, 8, 10, 5, 7, 11, 4, 6, 10)
            SongInfo.add(Series.trilogy, "STOP", "3rd Coast", "90 ~ 162", 6, 10, 0, 8, 0, 12, 7, 9, 11, 6, 9, 12)
            SongInfo.add(Series.trilogy, "Streetlight", "Nauts", "115", 2, 7, 0, 3, 6, 0, 5, 9, 0, 4, 8, 0)
            SongInfo.add(Series.trilogy, "Syriana ~Blast Wave Mix~", "DJ EON", "135", 8, 10, 0, 8, 10, 12, 8, 11, 0, 8, 10, 13)
            SongInfo.add(Series.trilogy, "Talk! Talk!", "xxdbxx", "143", 5, 10, 13, 6, 8, 13, 8, 11, 13, 7, 9, 12)
            SongInfo.add(Series.trilogy, "Ventilator", "Cycle75", "145", 9, 11, 15, 9, 11, 14, 9, 12, 14, 9, 11, 14)
            SongInfo.add(Series.trilogy, "The One", "Paul Bazooka", "125", 5, 10, 0, 5, 9, 11, 7, 10, 12, 6, 9, 12)
            SongInfo.add(Series.trilogy, "Yo Creo Que Si ~Live House Version~", "BEXTER", "135", 7, 9, 12, 7, 9, 0, 6, 8, 12, 7, 9, 11)
            SongInfo.add(Series.trilogy, "Your Own Miracle ~Disco House Mix~", "makou", "130", 4, 8, 10, 5, 11, 0, 6, 0, 11, 3, 8, 0)
            SongInfo.add(Series.trilogy, "ZET", "BEXTER", "125", 7, 10, 0, 7, 10, 0, 7, 9, 13, 8, 11, 13)
            
            //Respect
            SongInfo.add(Series.respect, "Soar ~Stay With Me~".localized, "Mycin.T", "142", 4, 7, 0, 6, 10, 0, 6, 10, 11, 7, 11, 0)
            SongInfo.add(Series.respect, "2Nite", "ND Lee", "110", 4, 6, 0, 4, 9, 0, 3, 8, 0, 4, 8, 0)
            SongInfo.add(Series.respect, "Armored Phantom", "ned", "151", 3, 7, 0, 6, 11, 0, 7, 9, 12, 6, 11, 0)
            SongInfo.add(Series.respect, "Beautiful Day", "ND Lee", "83", 3, 6, 8, 4, 8, 0, 2, 8, 0, 4, 8, 0)
            SongInfo.add(Series.respect, "Beyond Yourself", "Mycin.T", "90", 6, 9, 0, 6, 10, 0, 7, 9, 12, 6, 11, 0)
            SongInfo.add(Series.respect, "Binary World", "Tsukasa", "182", 5, 8, 13, 5, 7, 13, 9, 12, 13, 5, 7, 13)
            SongInfo.add(Series.respect, "BlackCat", "BEXTER", "130", 5, 11, 0, 6, 11, 0, 5, 8, 12, 7, 12, 0)
            SongInfo.add(Series.respect, "Bullet, Wanted!", "Mycin.T", "150", 4, 8, 0, 7, 10, 0, 6, 9, 11, 7, 11, 0)
            SongInfo.add(Series.respect, "Child of Night", "GOTH", "130", 6, 8, 0, 7, 9, 12, 7, 10, 12, 7, 9, 12)
            SongInfo.add(Series.respect, "Don't Die", "Paul Bazooka", "175", 5, 9, 13, 7, 10, 14, 8, 11, 14, 7, 10, 14)
            SongInfo.add(Series.respect, "Enter The Universe", "GOTH", "162", 6, 9, 12, 7, 10, 14, 9, 12, 14, 7, 10, 14)
            SongInfo.add(Series.respect, "Far East Princess", "Nauts", "102", 5, 7, 10, 5, 10, 0, 3, 9, 10, 5, 9, 0)
            SongInfo.add(Series.respect, "glory day", "BEXTER / Mycin.T", "162", 8, 10, 0, 7, 10, 0, 6, 11, 0, 7, 10, 0)
            SongInfo.add(Series.respect, "Groovin Up", "Mycin.T", "120", 3, 6, 0, 5, 9, 0, 5, 8, 11, 5, 9, 0)
            SongInfo.add(Series.respect, "Heavenly", "Makou", "125", 5, 7, 0, 4, 8, 0, 5, 9, 12, 4, 9, 0)
            SongInfo.add(Series.respect, "KILLER BEE", "GOTH", "116 ~ 155", 4, 6, 11, 7, 11, 0, 8, 9, 13, 7, 12, 0)
            SongInfo.add(Series.respect, "Kung Brother", "Paul Bazooka", "145", 6, 9, 0, 6, 11, 0, 8, 10, 13, 6, 11, 0)
            SongInfo.add(Series.respect, "Liar", "zts", "140", 6, 9, 0, 8, 12, 0, 8, 10, 13, 8, 13, 0)
            SongInfo.add(Series.respect, "Lift You Up", "Makou", "88", 2, 5, 0, 4, 7, 0, 3, 7, 0, 4, 7, 0)
            SongInfo.add(Series.respect, "Mulch", "Sampling Masters MEGA", "200", 6, 12, 0, 7, 0, 14, 8, 12, 14, 7, 0, 15)
            SongInfo.add(Series.respect, "NB RANGER - Virgin Force", "NieN", "198", 5, 9, 0, 7, 12, 15, 7, 12, 14, 7, 11, 15)
            SongInfo.add(Series.respect, "Only for you", "NieN", "122", 1, 4, 9, 5, 7, 10, 4, 7, 11, 5, 7, 10)
            SongInfo.add(Series.respect, "OPEN FIRE", "JC", "140", 4, 7, 0, 4, 8, 0, 5, 7, 0, 5, 8, 0)
            SongInfo.add(Series.respect, "quixotic", "bermei.inazawa", "174", 7, 12, 0, 7, 11, 0, 6, 0, 13, 7, 11, 13)
            SongInfo.add(Series.respect, "Remains Of Doom", "NieN", "124", 7, 13, 0, 6, 9, 14, 9, 12, 15, 6, 10, 13)
            SongInfo.add(Series.respect, "Royal Clown", "bermei.inazawa", "143 ~ 164", 6, 9, 14, 7, 11, 0, 7, 10, 13, 7, 10, 14)
            SongInfo.add(Series.respect, "Nevermind", "Paul Bazooka", "142", 7, 10, 13, 7, 11, 0, 7, 10, 13, 6, 10, 15)
            SongInfo.add(Series.respect, "Runaway", "LeeZu", "140", 6, 10, 0, 8, 11, 0, 9, 11, 12, 8, 13, 0)
            SongInfo.add(Series.respect, "Running girl", "Mycin.T", "170", 5, 7, 0, 5, 9, 0, 4, 10, 12, 6, 10, 0)
            SongInfo.add(Series.respect, "Ruti'n (GOTH Wild Electro Remix)", "GOTH", "112", 6, 10, 0, 4, 10, 0, 7, 10, 13, 9, 12, 0)
            SongInfo.add(Series.respect, "Secret Dejavu", "DINY", "160", 4, 6, 10, 5, 10, 0, 6, 8, 11, 5, 10, 0)
            SongInfo.add(Series.respect, "Shadow Flower", "ned", "142", 3, 6, 0, 6, 9, 0, 5, 11, 0, 6, 9, 0)
            SongInfo.add(Series.respect, "The Feelings", "Supbaby", "130", 5, 7, 0, 6, 9, 0, 6, 10, 0, 6, 10, 0)
            SongInfo.add(Series.respect, "The Lost Story", "NEOWIZ Bless Soundteam", "70", 1, 4, 0, 4, 8, 0, 2, 7, 0, 4, 7, 0)
            SongInfo.add(Series.respect, "The Obliterator", "GOTH", "186", 5, 8, 0, 7, 11, 0, 8, 0, 13, 7, 11, 0)
            SongInfo.add(Series.respect, "U.A.D", "HAYAKO", "129", 3, 6, 0, 5, 10, 0, 6, 8, 11, 8, 0, 12)
            SongInfo.add(Series.respect, "v o l d e n u i t", "Cuve", "105", 5, 9, 12, 4, 9, 12, 5, 9, 12, 6, 9, 13)
            SongInfo.add(Series.respect, "waiting for me", "Croove", "150", 3, 8, 0, 4, 8, 0, 4, 9, 0, 5, 9, 0)
            SongInfo.add(Series.respect, "Waiting for you", "Mycin.T", "175", 4, 8, 0, 6, 10, 0, 6, 12, 0, 7, 11, 0)
            SongInfo.add(Series.respect, "We're All Gonna Die", "Paul Bazooka", "180", 8, 12, 14, 8, 12, 0, 11, 13, 15, 8, 12, 15)
            SongInfo.add(Series.respect, "WHY", "Nauts", "84", 3, 7, 0, 5, 10, 0, 2, 7, 10, 4, 7, 0)
            SongInfo.add(Series.respect, "Break a Spell", "Daisuke Ishiwatari", "200", 5, 9, 14, 6, 10, 0, 7, 9, 14, 7, 10, 14)
            SongInfo.add(Series.respect, "Holy Orders (Be Just Or Be Dead)", "Daisuke Ishiwatari", "120", 4, 9, 11, 6, 8, 11, 6, 9, 12, 6, 10, 12)
            SongInfo.add(Series.respect, "Marionette", "Daisuke Ishiwatari", "136", 5, 9, 13, 7, 12, 0, 6, 10, 13, 8, 0, 13)
            SongInfo.add(Series.respect, "Rising The Sonic", "Dayz", "137", 4,9,12,5,10,13,5,9,13,5,10,14)
            SongInfo.add(Series.respect, "Do you want it", "House Rulez", "123", 5, 8, 0, 7, 9, 0, 5, 9, 0, 5, 11, 0)
            SongInfo.add(Series.respect, "Only On", "Dok2", "96", 2, 5, 0, 3, 6, 0, 2, 5, 0, 3, 5, 8)
            //1.14
            SongInfo.add(Series.respect, "ANALYS", "HAYAKO", "170", 7, 11, 14, 7, 11, 0, 7, 11, 14, 8, 11, 14)
            SongInfo.add(Series.respect, "Always", "YUGI / Mool", "135", 4, 7, 0, 6, 9, 0, 5, 10, 0, 6, 10, 0)
            SongInfo.add(Series.respect, "Fly Away", "Xeon", "140", 3, 10, 0, 6, 10, 0, 4, 0, 11, 6, 10, 0)
            
            //Portable 1
            SongInfo.add(Series.portable1, "Ask to Wind".localized, "Forte Escape", "108", 1, 7, 0, 6, 7, 0, 3, 7, 9, 4, 8, 0)
            SongInfo.add(Series.portable1, "Every Morning".localized, "ND Lee", "150", 3, 8, 0, 8, 9, 0, 6, 9, 0, 8, 10, 0)
            SongInfo.add(Series.portable1, "Piano Concerto No.1".localized, "Wav Factory", "156", 5, 10, 0, 7, 11, 0, 7, 11, 0, 7, 11, 0)
            SongInfo.add(Series.portable1, "A.I", "Forte Escape", "138", 4, 9, 0, 8, 12, 0, 7, 11, 13, 8, 10, 0)
            SongInfo.add(Series.portable1, "Astro Fight", "Forte Escape", "183", 8, 13, 0, 8, 11, 0, 7, 13, 14, 8, 12, 0)
            SongInfo.add(Series.portable1, "BlythE", "M2U", "180", 6, 9, 14, 6, 11, 0, 8, 11, 13, 7, 0, 14)
            SongInfo.add(Series.portable1, "Bright Dream", "M2U", "130", 2, 4, 0, 5, 8, 0, 4, 7, 10, 6, 9, 0)
            SongInfo.add(Series.portable1, "Can We Talk", "Forte Escape", "125", 1, 7, 0, 7, 9, 13, 5, 8, 11, 8, 9, 12)
            SongInfo.add(Series.portable1, "Catch Me", "Forte Escape", "145", 3, 6, 0, 6, 0, 0, 7, 8, 0, 8, 12, 0)
            SongInfo.add(Series.portable1, "Chrono Breakers", "NieN", "178", 5, 7, 11, 7, 10, 0, 7, 12, 0, 8, 12, 0)
            SongInfo.add(Series.portable1, "CnP", "CrooFE", "127", 3, 8, 12, 4, 9, 12, 4, 9, 12, 5, 10, 12)
            SongInfo.add(Series.portable1, "Elastic STAR", "Forte Escape", "132", 4, 7, 0, 6, 7, 0, 4, 8, 0, 4, 7, 0)
            SongInfo.add(Series.portable1, "End of the Moonlight", "Forte Escape", "155", 3, 7, 10, 5, 9, 0, 5, 9, 12, 7, 11, 0)
            SongInfo.add(Series.portable1, "Enemy Storm", "Croove", "133", 2, 5, 13, 5, 8, 0, 6, 8, 11, 5, 10, 14)
            SongInfo.add(Series.portable1, "Eternal Memory".localized, "M2U", "125", 2, 6, 0, 3, 8, 0, 2, 7, 0, 5, 7, 0)
            SongInfo.add(Series.portable1, "Extreme Z4", "Forte Escape", "160", 3, 7, 0, 4, 8, 0, 7, 9, 0, 8, 12, 0)
            SongInfo.add(Series.portable1, "FEAR", "Supbaby", "182", 4, 9, 0, 5, 9, 12, 6, 12, 0, 8, 11, 13)
            SongInfo.add(Series.portable1, "Fever GJ", "xxdbxx", "98", 3, 7, 0, 3, 6, 0, 3, 7, 9, 7, 0, 0)
            SongInfo.add(Series.portable1, "FTR", "Supbaby", "140", 6, 10, 0, 5, 10, 0, 8, 11, 0, 7, 11, 0)
            SongInfo.add(Series.portable1, "Funky Chups", "Forte Escape", "127", 4, 8, 0, 5, 10, 0, 4, 6, 0, 7, 0, 0)
            SongInfo.add(Series.portable1, "Futurism", "Forte Escape", "142", 4, 8, 0, 7, 9, 0, 6, 8, 11, 8, 10, 0)
            SongInfo.add(Series.portable1, "HAMSIN", "makou", "150", 9, 0, 15, 6, 9, 13, 9, 12, 14, 6, 9, 14)
            SongInfo.add(Series.portable1, "JBG", "Croove", "102", 7, 11, 0, 7, 11, 0, 7, 10, 12, 11, 0, 0)
            SongInfo.add(Series.portable1, "Jupiter Driving", "xxdbxx", "144", 5, 9, 0, 5, 11, 0, 5, 8, 0, 7, 11, 0)
            SongInfo.add(Series.portable1, "KUDA", "Gonzo", "126", 8, 11, 0, 5, 9, 0, 8, 12, 0, 10, 0, 0)
            SongInfo.add(Series.portable1, "Lemonade", "M2U", "195", 8, 0, 0, 6, 13, 0, 7, 10, 0, 8, 12, 0)
            SongInfo.add(Series.portable1, "Let's Go Baby", "3rd Coast", "108", 2, 5, 0, 6, 8, 0, 3, 7, 10, 9, 0, 0)
            SongInfo.add(Series.portable1, "Light House", "xxdbxx", "162", 4, 9, 0, 4, 11, 0, 6, 8, 11, 7, 12, 0)
            SongInfo.add(Series.portable1, "Long Vacation", "ESTi", "138", 4, 8, 0, 3, 6, 0, 5, 9, 0, 7, 0, 0)
            SongInfo.add(Series.portable1, "Luv Flow", "3rd Coast", "115", 1, 5, 0, 3, 6, 0, 1, 5, 0, 6, 8, 0)
            SongInfo.add(Series.portable1, "MASAI", "Croove", "128", 4, 7, 11, 5, 8, 12, 7, 10, 12, 10, 0, 0)
            SongInfo.add(Series.portable1, "Memory of Beach", "M2U", "130", 6, 11, 0, 7, 12, 0, 6, 9, 12, 8, 0, 13)
            SongInfo.add(Series.portable1, "Minimal Life", "Earbreaker", "145", 5, 7, 0, 7, 9, 0, 8, 12, 0, 8, 10, 14)
            SongInfo.add(Series.portable1, "NB RANGER", "M2U", "140", 8, 12, 0, 7, 12, 0, 7, 10, 13, 9, 13, 0)
            SongInfo.add(Series.portable1, "Never Say", "ND Lee", "90", 3, 6, 0, 6, 7, 0, 2, 7, 12, 8, 0, 0)
            SongInfo.add(Series.portable1, "OBLIVION", "ESTi", "141", 3, 6, 11, 7, 0, 11, 3, 8, 11, 6, 11, 0)
            SongInfo.add(Series.portable1, "OBLIVION ~Rockin' Night Style~", "NieN", "141", 3, 8, 12, 4, 10, 12, 7, 9, 13, 6, 11, 13)
            SongInfo.add(Series.portable1, "ON", "ND Lee", "72", 3, 5, 0, 2, 6, 0, 6, 10, 0, 7, 0, 0)
            SongInfo.add(Series.portable1, "One the Love", "xxdbxx", "125", 2, 5, 0, 6, 8, 0, 3, 6, 11, 7, 8, 0)
            SongInfo.add(Series.portable1, "Out Law", "Croove", "126", 5, 12, 0, 7, 12, 0, 7, 11, 13, 8, 12, 0)
            SongInfo.add(Series.portable1, "Para-Q", "Forte Escape", "160", 3, 10, 0, 6, 8, 0, 7, 10, 0, 10, 0, 0)
            SongInfo.add(Series.portable1, "Ray of Illuminati", "ESTi", "150", 4, 7, 13, 6, 8, 13, 7, 10, 13, 8, 11, 0)
            SongInfo.add(Series.portable1, "RED", "Croove", "107", 4, 6, 0, 5, 13, 0, 6, 9, 12, 8, 13, 0)
            SongInfo.add(Series.portable1, "REVENGE", "ND Lee", "120", 5, 0, 10, 3, 7, 0, 8, 12, 0, 10, 0, 0)
            SongInfo.add(Series.portable1, "Road Of Death", "NieN", "180", 4, 9, 0, 7, 13, 0, 8, 11, 14, 7, 13, 0)
            SongInfo.add(Series.portable1, "Rock Or Die", "NieN", "106", 6, 0, 0, 6, 9, 0, 6, 10, 12, 6, 9, 0)
            SongInfo.add(Series.portable1, "Save My Dream", "Forte Escape", "125", 1, 4, 0, 2, 4, 0, 2, 5, 9, 5, 8, 0)
            SongInfo.add(Series.portable1, "SIN", "ESTi", "190", 3, 6, 11, 7, 10, 0, 7, 10, 14, 9, 12, 15)
            SongInfo.add(Series.portable1, "SIN ~The Last Scene~", "ESTi", "200", 7, 12, 14, 7, 11, 0, 8, 12, 14, 8, 13, 0)
            SongInfo.add(Series.portable1, "Sunny Side", "Croove", "112", 4, 8, 0, 5, 9, 0, 5, 8, 11, 9, 0, 0)
            SongInfo.add(Series.portable1, "Sunny Side ~Deepn' Soul Mix~", "makou", "122", 7, 10, 0, 7, 11, 0, 7, 0, 11, 8, 10, 0)
            SongInfo.add(Series.portable1, "Temptation", "S-TRO", "136", 4, 10, 0, 4, 10, 0, 6, 0, 12, 9, 0, 0)
            SongInfo.add(Series.portable1, "Triple Zoe", "Forte Escape", "150", 4, 11, 0, 6, 11, 0, 8, 12, 0, 10, 12, 0)
            SongInfo.add(Series.portable1, "Ya! Party!", "Forte Escape", "194", 4, 8, 0, 5, 10, 0, 5, 8, 12, 9, 0, 0)
            SongInfo.add(Series.portable1, "Dreadnought", "EarBreaker", "140", 6,9,12,8,11,0,8,0,13,8,13,0)
            SongInfo.add(Series.portable1, "Ask to Wind ~Live Mix~".localized, "Forte Escape", "210", 5, 0, 12, 6, 10, 0, 7, 11, 0, 7, 0, 13)
            
            //Portable 2
            SongInfo.add(Series.portable2, "HeartBeat".localized, "ND Lee", "155", 3, 5, 0, 4, 8, 0, 4, 7, 9, 6, 9, 0)
            SongInfo.add(Series.portable2, "Taekwonburi".localized, "xxdbxx", "162", 5, 7, 0, 6, 0, 12, 6, 10, 14, 7, 0, 12)
            SongInfo.add(Series.portable2, "A Lie", "makou", "100", 2, 5, 0, 5, 9, 0, 4, 6, 12, 7, 9, 0)
            SongInfo.add(Series.portable2, "Another DAY", "Forte Escape", "142", 3, 7, 11, 6, 8, 0, 5, 8, 10, 7, 10, 0)
            SongInfo.add(Series.portable2, "Brain Storm", "Croove", "172", 6, 11, 0, 7, 12, 14, 9, 13, 0, 8, 12, 14)
            SongInfo.add(Series.portable2, "Brandnew Days", "Planetboom", "124", 3, 8, 0, 6, 8, 0, 7, 10, 11, 7, 10, 0)
            SongInfo.add(Series.portable2, "Brave it Out", "BEXTER", "124", 6, 8, 0, 5, 9, 11, 6, 10, 13, 7, 10, 12)
            SongInfo.add(Series.portable2, "Bye Bye Love", "3rd Coast", "120", 2, 8, 0, 6, 7, 0, 6, 9, 11, 6, 8, 0)
            SongInfo.add(Series.portable2, "Chain of Gravity", "Tsukasa", "155", 5, 11, 0, 5, 10, 0, 7, 10, 12, 6, 11, 0)
            SongInfo.add(Series.portable2, "Cherokee", "xxdbxx", "136", 5, 8, 0, 7, 9, 0, 6, 9, 13, 7, 10, 0)
            SongInfo.add(Series.portable2, "DIVINE SERVICE", "Electronic Boutique", "151", 4, 7, 0, 4, 9, 0, 4, 8, 12, 7, 10, 0)
            SongInfo.add(Series.portable2, "Dream of You", "makou", "192", 4, 6, 11, 6, 10, 0, 5, 9, 11, 8, 11, 0)
            SongInfo.add(Series.portable2, "Fallen Angel", "DJ Mocha", "142", 4, 8, 0, 4, 8, 0, 3, 7, 10, 8, 10, 0)
            SongInfo.add(Series.portable2, "Fentanest", "Earbreaker / Eszett", "20 ~ 160", 4, 10, 0, 6, 9, 0, 7, 11, 0, 6, 9, 0)
            SongInfo.add(Series.portable2, "For Seasons", "makou", "116", 1, 6, 0, 6, 9, 0, 4, 7, 11, 5, 10, 0)
            SongInfo.add(Series.portable2, "For the IKARUS", "NieN", "154", 4, 8, 0, 5, 11, 0, 8, 0, 12, 6, 12, 0)
            SongInfo.add(Series.portable2, "Get on Top", "Planetboom", "125", 3, 7, 0, 6, 9, 0, 5, 8, 12, 7, 10, 0)
            SongInfo.add(Series.portable2, "GET OUT", "ND Lee", "112", 5, 8, 0, 4, 9, 0, 4, 8, 13, 7, 10, 0)
            SongInfo.add(Series.portable2, "Good Bye", "Ruby Tuesday", "136", 5, 7, 0, 4, 9, 0, 7, 0, 12, 6, 9, 0)
            SongInfo.add(Series.portable2, "Hello Pinky", "NieN", "141", 5, 8, 0, 5, 10, 0, 7, 11, 0, 6, 11, 0)
            SongInfo.add(Series.portable2, "Higher", "Supbaby", "137", 4, 8, 0, 6, 11, 0, 6, 9, 0, 4, 8, 12)
            SongInfo.add(Series.portable2, "Ladymade Star", "ESTi", "136", 2, 6, 10, 3, 8, 0, 5, 8, 10, 5, 8, 0)
            SongInfo.add(Series.portable2, "Lost n' found", "bermei.inazawa", "165", 3, 7, 0, 6, 8, 0, 5, 9, 0, 7, 9, 0)
            SongInfo.add(Series.portable2, "Memoirs", "M2U", "140", 4, 9, 0, 7, 10, 0, 6, 9, 11, 7, 10, 0)
            SongInfo.add(Series.portable2, "Mess it Up", "Nauts", "140", 5, 9, 0, 4, 9, 0, 9, 12, 0, 6, 10, 0)
            SongInfo.add(Series.portable2, "Midnight Blood", "NieN", "147", 6, 13, 0, 6, 13, 0, 7, 10, 13, 6, 9, 13)
            SongInfo.add(Series.portable2, "Miles", "Electronic Boutique", "130", 4, 10, 0, 5, 10, 13, 4, 9, 13, 4, 11, 13)
            SongInfo.add(Series.portable2, "Minus 3", "Croove", "147", 8, 11, 0, 6, 12, 0, 10, 0, 13, 7, 12, 0)
            SongInfo.add(Series.portable2, "My Alias", "Dayz", "110", 6, 9, 0, 6, 9, 12, 6, 9, 14, 5, 10, 0)
            SongInfo.add(Series.portable2, "NANO RISK", "Dayz", "176", 7, 0, 0, 7, 11, 0, 6, 9, 12, 7, 11, 0)
            SongInfo.add(Series.portable2, "NB POWER", "NieN", "185", 5, 7, 0, 6, 9, 13, 7, 11, 13, 7, 10, 0)
            SongInfo.add(Series.portable2, "NB Rangers -Returns-", "NieN", "145", 5, 9, 0, 7, 11, 0, 9, 11, 13, 7, 12, 0)
            SongInfo.add(Series.portable2, "Negative Nature", "Electronic Boutique", "125 ~ 145", 4, 8, 0, 4, 7, 0, 7, 12, 0, 4, 8, 0)
            SongInfo.add(Series.portable2, "Nightmare", "M2U", "190", 10, 12, 0, 8, 13, 15, 8, 13, 15, 8, 12, 15)
            SongInfo.add(Series.portable2, "Phantom Of Sky", "M2U", "115", 3, 7, 10, 4, 7, 0, 5, 10, 0, 4, 8, 0)
            SongInfo.add(Series.portable2, "plastic method", "zts", "118", 5, 8, 0, 8, 12, 0, 8, 12, 0, 8, 12, 0)
            SongInfo.add(Series.portable2, "Right Now", "makou", "90", 1, 5, 0, 4, 8, 0, 4, 8, 11, 6, 9, 0)
            SongInfo.add(Series.portable2, "Rocka-a-doodle-doo", "makou", "135", 3, 9, 0, 4, 8, 0, 7, 11, 0, 5, 9, 12)
            SongInfo.add(Series.portable2, "Rolling On the Duck", "NieN", "180", 7, 10, 0, 7, 10, 14, 8, 11, 14, 7, 10, 14)
            SongInfo.add(Series.portable2, "Seeker", "M2U", "150", 5, 9, 0, 8, 0, 14, 5, 9, 13, 7, 13, 0)
            SongInfo.add(Series.portable2, "Showtime", "Ruby Tuesday", "138", 6, 10, 0, 6, 9, 0, 8, 12, 0, 6, 10, 0)
            SongInfo.add(Series.portable2, "Smoky Quartz", "makou", "104", 3, 6, 0, 7, 10, 0, 6, 0, 11, 7, 13, 0)
            SongInfo.add(Series.portable2, "sO mUCH iN LUV", "3rd Coast", "130", 1, 6, 0, 3, 6, 0, 4, 7, 11, 7, 0, 0)
            SongInfo.add(Series.portable2, "SQUEEZE", "Oriental ST8", "147", 4, 9, 0, 7, 11, 0, 8, 10, 12, 7, 12, 0)
            SongInfo.add(Series.portable2, "STALKER", "ND Lee", "112", 5, 10, 0, 7, 9, 0, 6, 10, 12, 8, 0, 15)
            SongInfo.add(Series.portable2, "StarFish", "PlanetBoom", "150", 6, 9, 0, 7, 10, 0, 6, 10, 0, 6, 9, 0)
            SongInfo.add(Series.portable2, "Stay with me", "Ruby Tuesday", "140", 2, 4, 0, 4, 7, 0, 3, 7, 0, 7, 9, 0)
            SongInfo.add(Series.portable2, "Sunset Rider", "Nauts", "170", 5, 9, 0, 6, 10, 0, 5, 7, 11, 6, 9, 0)
            SongInfo.add(Series.portable2, "Syriana", "BEXTER", "135", 6, 9, 0, 6, 9, 0, 6, 9, 13, 5, 9, 0)
            SongInfo.add(Series.portable2, "WhiteBlue", "zts", "144", 7, 9, 13, 6, 10, 13, 7, 11, 13, 8, 11, 13)
            SongInfo.add(Series.portable2, "Yellowberry -AJ Mix-", "Forte Escape", "151", 4, 7, 0, 3, 6, 0, 5, 9, 0, 4, 8, 0)
            SongInfo.add(Series.portable2, "Yo Creo Que Si", "makou", "135", 6, 8, 0, 6, 9, 0, 8, 0, 12, 7, 9, 0)
            SongInfo.add(Series.portable2, "Your Own Miracle", "Ruby Tuesday", "136", 3, 9, 0, 3, 6, 10, 6, 10, 12, 7, 10, 13)
            
            //Database - Mission
            
            //Link Disk
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "The Others", "BlythE", Difficulty.hard, Buttons.button4, "Triple Zoe", Difficulty.hard, Buttons.button6, "NB RANGER", Difficulty.maximum, Buttons.button6, "SIN ~The Last Scene~", Difficulty.hard, Buttons.button8, 0, 0, 1500, 97, 20, "Fever-OFF", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "Just 1%", "MASAI", Difficulty.maximum, Buttons.button5, "NB POWER", Difficulty.maximum, Buttons.button5, "Showtime", Difficulty.hard, Buttons.button5, "Rolling On the Duck", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 0, "Fever-OFF / Don't make the MAX 1%", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "The Boss", "Ventilator", Difficulty.hard, Buttons.button8, "Mind Control", Difficulty.hard, Buttons.button8, "HAMSIN", Difficulty.hard, Buttons.button8, "Taekwonburi".localized, Difficulty.maximum, Buttons.button8, "Nevermind", Difficulty.hard, Buttons.button8, "Nightmare", Difficulty.maximum, Buttons.button8, 0, 0, 15100, 96, 0, "Fever-Manual", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "ENVY vs NB", "DARK ENVY", Difficulty.maximum, Buttons.button5, "NB RANGER - Virgin Force", Difficulty.maximum, Buttons.button5, 0, 0, 0, 90, 0, "Fever-OFF / CHAOS REVERSE", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "Challenger", "PDM", Difficulty.maximum, Buttons.button5, "A.I", Difficulty.hard, Buttons.button8, "Proposed, Flower, Wolf part.2".localized, Difficulty.maximum, Buttons.button6, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 99, 5, "Fever-OFF", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "MX Tournament", "ANALYS", Difficulty.maximum, Buttons.button4, "Grave Consequence", Difficulty.maximum, Buttons.button5, "Heart of Witch", Difficulty.maximum, Buttons.button6, "Beat U Down", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 0, "Fever-OFF / vs AI", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Ending Scroll", "Proposed, Flower, Wolf".localized, Difficulty.hard, Buttons.button4, "Proposed, Flower, Wolf part.2".localized, Difficulty.normal, Buttons.button6, 0, 0, 0, 100, 0, "Fever-OFF", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Vitalize", "Ladymade Star", Difficulty.maximum, Buttons.button4, "Royal Clown", Difficulty.maximum, Buttons.button8, "Memory of Beach", Difficulty.hard, Buttons.button5, "quixotic", Difficulty.maximum, Buttons.button8, 1230000, 0, 0, 0, 0, "Fever-Manual", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "SPEED STAR", "Fentanest", Difficulty.hard, Buttons.button6, "STOP", Difficulty.maximum, Buttons.button5, "KILLER BEE", Difficulty.maximum, Buttons.button6, "Negative Nature", Difficulty.hard, Buttons.button6, "Royal Clown", Difficulty.maximum, Buttons.button8, 0, 5, 0, 98, 0, "SPEED 2.00 / Fever-Manual", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Infinity Combo", "NB POWER", Difficulty.maximum, Buttons.button6, "WhiteBlue", Difficulty.maximum, Buttons.button6, "RED", Difficulty.maximum, Buttons.button6, "Sunny Side ~Deepn' Soul Mix~", Difficulty.maximum, Buttons.button6, "Showtime", Difficulty.hard, Buttons.button6, "Mind Control", Difficulty.maximum, Buttons.button6, 0, 0, 38888, 0, 0, "Fever-Auto / FADER FOG", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "End of Metro Project", "In my Dream", Difficulty.special, Buttons.xb, "Beat U Down", Difficulty.special, Buttons.xb, "Grave Consequence", Difficulty.special, Buttons.xb, "Heart of Witch", Difficulty.special, Buttons.xb, "Fermion", Difficulty.special, Buttons.xb, 1600000, 5, 5000, 0, 0, "Fever-Manual", "")
            MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Enter the Rocky Studio", "BlackCat", Difficulty.hard, Buttons.button8, "ANALYS", Difficulty.maximum, Buttons.button8, "Cypher Gate", Difficulty.redesign, Buttons.button8, "STALKER", Difficulty.fx, Buttons.button4, "Ventilator", Difficulty.fx, Buttons.button5, "We're All Gonna Die", Difficulty.special, Buttons.xb, 2000000, 5, 10000, 97, 50, "Fever-Manual", "")
            
            //Black Square
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "NewB Crew", "Get Down", Difficulty.hard, Buttons.button4, "Proposed, Flower, Wolf part.2".localized, Difficulty.hard, Buttons.button4, 600000, 5, 0, 0, 0, "Fever-Manual", "Gallery : " + "Proposed, Flower, Wolf part.2".localized)
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Downtown", "PDM", Difficulty.hard, Buttons.button5, "Jealousy", Difficulty.hard, Buttons.button5, "Secret World", Difficulty.hard, Buttons.button5, 0, 0, 0, 96, 0, "Fever-OFF / FADE OUT", "Gallery : Jealousy")
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "DnB Territory", "Ready Now", Difficulty.hard, Buttons.button6, "Ruti'n", Difficulty.hard, Buttons.button6, "Desperado", Difficulty.hard, Buttons.button6, 0, 4, 0, 0, 15, "Fever-Manual", "Gallery : Ready Now (3)")
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Core System", "Lover (BS Style)", Difficulty.hard, Buttons.button5, "Y (BS Style)", Difficulty.hard, Buttons.button5, "Colours of Sorrow", Difficulty.hard, Buttons.button5, "Cypher Gate", Difficulty.hard, Buttons.button5, 1000000, 0, 1000, 0, 0, "Fever-OFF", "Plate : Get Down")
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Kingdom of Rock", "Lovely hands", Difficulty.hard, Buttons.button6, "Keys to the World", Difficulty.normal, Buttons.button8, "Fever Pitch Girl", Difficulty.hard, Buttons.button6, "Heart of Witch", Difficulty.normal, Buttons.button8, 0, 0, 6000, 94, 0, "Fever-Manual / FADER PIXEL", "Plate : Fever Pitch Girl")
            MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Load of Flame", "Colours of Sorrow", Difficulty.normal, Buttons.button4, "Grave Consequence", Difficulty.normal, Buttons.button5, "Beat U Down", Difficulty.normal, Buttons.button4, "Fermion", Difficulty.normal, Buttons.button8, 0, 0, 0, 80, 0, "Fever-OFF / CHAOS 4D", "Plate : Clear (Get Down ver.)")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "BLACK CUBE", "Get Down", Difficulty.fx, Buttons.button5, 0, 0, 450, 0, 0, "Fever-OFF", "Plate : In my Dream")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "RD Colosseum", "Honeymoon", Difficulty.redesign, Buttons.button4, "Taekwonburi".localized, Difficulty.redesign, Buttons.button5, "I want You", Difficulty.redesign, Buttons.button6, "Cypher Gate", Difficulty.redesign, Buttons.button8, 0, 5, 0, 0, 0, "Fever-Manual", "MV : Glory Day (MUCA Live ver.)")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "BS 24", "Always", Difficulty.hard, Buttons.button4, "Fly Away", Difficulty.special, Buttons.xb, "ANALYS", Difficulty.hard, Buttons.button6, 985000, 0, 6500, 0, 0, "Fever-Manual", "Gallery : EXTRA (11)")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Quatrr4", "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button4, 0, 0, 0, 0, 0, "Fever-OFF / vs AI", "Gallery : Heart of Witch (4)")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Metro Project vol.2", "HEXAD", Difficulty.fx, Buttons.button5, "SuperSonic", Difficulty.fx, Buttons.button5, "Cypher Gate", Difficulty.fx, Buttons.button5, "In my Dream", Difficulty.fx, Buttons.button5, 1230000, 0, 0, 95, 0, "Fever-Auto", "Plate : Fermion")
            MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Illusion", "Nevermind", Difficulty.hard, Buttons.button4, "Rising The Sonic", Difficulty.hard, Buttons.button5, "Do you want it", Difficulty.hard, Buttons.button6, "ANALYS", Difficulty.hard, Buttons.button8, 0, 0, 0, 0, 0, "Fever-Auto / FADER PIXEL / vs AI", "Plate : Heart of Witch")
            
            //Technika1
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Idol Mania", "First Kiss", Difficulty.normal, Buttons.button4, "I want You", Difficulty.normal, Buttons.button4, "Ladymade Star", Difficulty.hard, Buttons.button4, 800000, 0, 0, 0, 0, "Fever-Manual", "Gallery : I want you (3)")
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Metro Drive", "Y (CE Style)", Difficulty.normal, Buttons.button6, "Melody", Difficulty.normal, Buttons.button6, "The Clear Blue Sky", Difficulty.normal, Buttons.button6, 0, 0, 4000, 93, 0, "Fever-Manual", "Plate : Honeymoon")
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Using Effect", "Play the Future", Difficulty.normal, Buttons.button5, "Beyond the Future", Difficulty.normal, Buttons.button5, "Do you want it", Difficulty.normal, Buttons.button5, 0, 0, 0, 0, 20, "Fever-OFF, FADER 2", "Plate : Shoreline")
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Mr.Perfect", "Remember", Difficulty.normal, Buttons.button4, 0, 0, 0, 100, 0, "Fever-OFF", "Plate : Remember")
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "High Technician", "CnP", Difficulty.maximum, Buttons.button5, "Dreadnought", Difficulty.maximum, Buttons.button4, "SIN", Difficulty.maximum, Buttons.button6, 990000, 5, 0, 0, 0, "Fever-Manual", "Gallery : EXTRA (9)")
            MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Sound Storm", "Enemy Storm", Difficulty.maximum, Buttons.button4, "Brain Storm", Difficulty.maximum, Buttons.button5, "Thor", Difficulty.maximum, Buttons.button6, 0, 5, 3900, 95, 25, "Fever-Manual", "Gallery : Thor")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "First Step", "Dear my Lady", Difficulty.normal, Buttons.button4, "Honeymoon", Difficulty.hard, Buttons.button4, "DJMAX", Difficulty.hard, Buttons.button4, "??", Difficulty.special, Buttons.tb, 900000, 0, 0, 0, 0, "Fever-OFF", "Gallery : Honeymoon (3)")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Electro EP", "Access", Difficulty.hard, Buttons.button5, "Your Own Miracle", Difficulty.hard, Buttons.button5, "Area 7", Difficulty.hard, Buttons.button5, "??", Difficulty.special, Buttons.tb, 0, 0, 800, 0, 0, "Fever-OFF", "Plate : SuperSonic")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Core Sound", "Beyond the Future", Difficulty.hard, Buttons.button6, "Voyage", Difficulty.hard, Buttons.button6, "Landscape", Difficulty.hard, Buttons.button6, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 95, 0, "Fever-OFF", "Gallery : Voyage")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "HeartBeat", "Remember", Difficulty.maximum, Buttons.button5, "Play the Future", Difficulty.hard, Buttons.button5, "Melody", Difficulty.maximum, Buttons.button5, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 0, 15, "Fever-OFF", "Plate : Melody")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Customizer", "Sweet Shining Shooting Star", Difficulty.maximum, Buttons.button8, "Fury", Difficulty.maximum, Buttons.button8, "Y (CE Style)", Difficulty.maximum, Buttons.button8, "??", Difficulty.special, Buttons.tb, 1125000, 0, 1750, 98, 0, "Fever-OFF", "Gallery : EXTRA (10)")
            MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Conqueror", "SON OF SUN", Difficulty.hard, Buttons.button4, "SuperSonic", Difficulty.maximum, Buttons.button5, "HEXAD", Difficulty.maximum, Buttons.button6, "!?", Difficulty.special, Buttons.tb, 1150000, 0, 1500, 98, 0, "Fever-OFF", "Plate : Thor")
            
            
            //Clazziquai Edition
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "Club Tour", "Love Mode", Difficulty.normal, Buttons.button4, "Come to me".localized, Difficulty.normal, Buttons.button4, "Freedom", Difficulty.normal, Buttons.button4, 850000,0,0,0,0,"Fever-Manual", "Gallery : Clear (Flea Ver.)")
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "Hunter & Hunter", "Cherokee", Difficulty.normal, Buttons.button4, "The Feelings", Difficulty.normal, Buttons.button5, "Proposed, Flower, Wolf".localized, Difficulty.maximum, Buttons.button6, 0,3,0,0,0,"Fever-Manual","Gallery : "+"Forever".localized+" (3)")
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "BubiBubi", "The Night Stage", Difficulty.hard, Buttons.button4, "Color", Difficulty.maximum, Buttons.button4, "Flea", "FX", Buttons.button4, "Electronics", "FX", Buttons.button4,0,0,0,0,30,"Fever-OFF","Gallery : Freedom (3)")
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "4DmaX", "To You".localized, Difficulty.normal, Buttons.button5, "Fate", Difficulty.normal, Buttons.button5, "Urban Night", Difficulty.normal, Buttons.button5, "Forever".localized, Difficulty.normal, Buttons.button5, 0,0,0,95,0,"Fever-OFF / CHAOS 4D","Gallery : Creator (3)")
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "Catch Me If You Can", "Mess it Up", Difficulty.hard, Buttons.button5, "StarFish", Difficulty.hard, Buttons.button6, "Bullet, Wanted!", Difficulty.hard, Buttons.button4, "In My Heart", Difficulty.maximum, Buttons.button4, 1000000,0,3000,0,0,"Fever-Manual / FOG","Gallery : In My Heart (3)")
            MissionInfo.add(Series.ce, Mission.CE.electronicCity, "CLAZZIQUAI", "Creator", "FX", Buttons.button4, "Come to me".localized, "FX", Buttons.button4, "Flea", Difficulty.maximum, Buttons.button6, 0,0,0,95,0,"Fever-OFF / Gear : CE","Gallery : EXTRA (8)")
            MissionInfo.add(Series.ce, Mission.CE.metropolis, "Heaven's Gate", "Closer", Difficulty.normal, Buttons.button4, "For the IKARUS", Difficulty.normal, Buttons.button5, "The Clear Blue Sky", Difficulty.normal, Buttons.button6, "Ask to Wind".localized, Difficulty.normal, Buttons.button8, 1000000,0,0,0,0,"Fever-Manual / CHAOS REVERSE","Gallery : The Clear Blue Sky (3)")
            MissionInfo.add(Series.ce, Mission.CE.metropolis,"GLASS Field", "sO mUCH iN LUV", Difficulty.hard, Buttons.button4, "Secret Dejavu", Difficulty.hard, Buttons.button4, "Creator", Difficulty.hard, Buttons.button4, 0,3,1500,0,0,"Fever-Manual / FADE IN","Gallery : First Kiss (3)")
            MissionInfo.add(Series.ce, Mission.CE.metropolis,"Metro Project Vol.1", "Coastal Tempo", "FX", Buttons.button4, "Here in the Moment", "FX", Buttons.button4, "In My Heart", "FX", Buttons.button4, "Rising The Sonic", "FX", Buttons.button4, 0,0,0,92,0,"Fever-OFF","Gallery : Here in the Moment (3)")
            MissionInfo.add(Series.ce, Mission.CE.metropolis,"5inary Box", "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.hard, Buttons.button5, "RANDOM", Difficulty.maximum, Buttons.button6, "RANDOM", Difficulty.hard, Buttons.button8, "RANDOM", "FX", Buttons.button4,0,0,0,0,25,"Fever-OFF","Gallery : Fate (3)")
            MissionInfo.add(Series.ce, Mission.CE.metropolis, "DJMAX TOURNAMENT R3", "Dreadnought", Difficulty.maximum, Buttons.button4, "Coastal Tempo", Difficulty.maximum, Buttons.button5, "The Clear Blue Sky", Difficulty.maximum, Buttons.button6, "Y (CE Style)", Difficulty.maximum, Buttons.button8,0,0,0,0,0,"Fever-AUTO / vs AI","Plate : Clear (Flea Ver.) / Trophy : DJ Alpha Resigns")
            MissionInfo.add(Series.ce, Mission.CE.metropolis,"DJMAX TOURNAMENT LIVE", "First Kiss", Difficulty.maximum, Buttons.button6, "Far East Princess", Difficulty.maximum, Buttons.button6, "Proposed, Flower, Wolf".localized, Difficulty.maximum, Buttons.button6, "Coastal Tempo",Difficulty.maximum, Buttons.button6, "Lover (CE Style)",Difficulty.maximum,Buttons.button6,0,0,0,0,10,"Fever-OFF","Gallery : Fail (Flea Ver.) / Trophy : DJMAX ARTIST TEAM")
            
            //Respect
            MissionInfo.add(Series.respect, Mission.Respect.departure, "Restarting Line", "Ask to Wind".localized, Difficulty.normal, Buttons.button4, "Only for you", Difficulty.normal, Buttons.button4, 400000, 0, 0, 0, 0, "Fever-Manual", "Music : Only for you")
            MissionInfo.add(Series.respect, Mission.Respect.departure, "Mighty Fine Morning", "Every Morning".localized, Difficulty.normal, Buttons.button4, "HeartBeat".localized, Difficulty.normal, Buttons.button4, 0, 0, 0, 85, 0, "Fever OFF", "Plate : "+"Every Morning".localized)
            MissionInfo.add(Series.respect, Mission.Respect.departure, "Day Dream", "Eternal Memory".localized, Difficulty.normal, Buttons.button5, "Long Vacation", Difficulty.normal, Buttons.button5, "Lift You Up", Difficulty.normal, Buttons.button5, 0, 0, 0, 0, 15, "Fever OFF", "Comment : "+"Super Rookie".localized)
            MissionInfo.add(Series.respect, Mission.Respect.departure, "SweetCute", "Bright Dream", Difficulty.normal, Buttons.button4, "Catch Me", Difficulty.normal, Buttons.button4, "Beautiful Day", Difficulty.normal, Buttons.button4, 0, 2, 0, 0, 0, "Fever-Manual", "Plate : "+"HeartBeat".localized)
            MissionInfo.add(Series.respect, Mission.Respect.departure, "Lovextreme", "sO mUCH iN LUV", Difficulty.normal, Buttons.button4, "Let's Go Baby", Difficulty.normal, Buttons.button4, "Secret Dejavu", Difficulty.normal, Buttons.button4, 0, 0, 300, 0, 0, "Fever-Manual", "Music : Secret Dejavu")
            MissionInfo.add(Series.respect, Mission.Respect.departure, "Angelic Eyes", "Luv Flow", Difficulty.normal, Buttons.button5, "Save My Dream", Difficulty.hard, Buttons.button5, "Far East Princess", Difficulty.normal, Buttons.button5, 750000, 0, 0, 0, 0, "Fever-Manual", "Plate : Departure")
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "enTRANCE", "Jupiter Driving", Difficulty.normal, Buttons.button4, "Futurism", Difficulty.normal, Buttons.button4, "Binary World", Difficulty.normal, Buttons.button4, 0, 0, 600, 0, 0, "Fever-Manual", "Music : Binary World")
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "Dancing Stage", "Ladymade Star", Difficulty.normal, Buttons.button5, "Good Bye", Difficulty.normal, Buttons.button5, "Groovin Up", Difficulty.normal, Buttons.button5, 0, 0, 0, 0, 10, "Fever OFF / Gear&Note : Ladymade Star", "Comment : "+"Entertainer".localized)
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "Show me the MAX", "Fever GJ", Difficulty.normal, Buttons.button5, "GET OUT", Difficulty.normal, Buttons.button5, "JBG", Difficulty.normal, Buttons.button5, "OPEN FIRE", Difficulty.normal, Buttons.button5, 0, 0, 0, 90, 0, "Fever OFF", "Plate : Binary World")
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "Purple Lounge", "Mess it Up", Difficulty.normal, Buttons.button4, "Dream of You", Difficulty.normal, Buttons.button4, "RED", Difficulty.normal, Buttons.button4, "The Feelings", Difficulty.normal, Buttons.button4, 1000000, 0, 0, 0, 0, "Fever-Manual / FADE OUT", "Gallery : The Feelings (2)")
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "Groove Zet Coaster", "Extreme Z4", Difficulty.normal, Buttons.button4, "Chain of Gravity", Difficulty.normal, Buttons.button4, "For the IKARUS", Difficulty.normal, Buttons.button4, "v o l d e n u i t", Difficulty.normal, Buttons.button4, 0, 0, 0, 0, 15, "Fever OFF / SLIDE UP", "Comment : "+"I Hate Fast Songs!".localized)
            MissionInfo.add(Series.respect, Mission.Respect.clubRoad645, "Live in Summer", "Memory of Beach", Difficulty.normal, Buttons.button6, "Yo Creo Que Si", Difficulty.normal, Buttons.button6, "Your Own Miracle", Difficulty.normal, Buttons.button4, "Waiting for you", Difficulty.normal, Buttons.button6, 1100000, 3, 0, 0, 0, "Fever-Manual", "Plate : CLUB Road645")
            MissionInfo.add(Series.respect, "MAX Theater", "Cosmic Fantasy", "End of the Moonlight", Difficulty.normal, Buttons.button5, "One the Love", Difficulty.normal, Buttons.button5, "Ray of Illuminati", Difficulty.normal, Buttons.button5, "Soar ~Stay With Me~".localized, Difficulty.normal, Buttons.button5, 0, 0, 0, 92, 0, "Fever OFF", "Music : "+"Soar ~Stay With Me~".localized)
            MissionInfo.add(Series.respect, "MAX Theater", "Animal Symphony", "For Seasons", Difficulty.hard, Buttons.button4, "Light House", Difficulty.normal, Buttons.button4, "Showtime", Difficulty.normal, Buttons.button4, 830000, 0, 0, 0, 0, "Fever-Manual / Gear&Note : Chicken&Egg", "Note : Egg")
            MissionInfo.add(Series.respect, "MAX Theater", "Emotion Pulse", "DIVINE SERVICE", Difficulty.normal, Buttons.button6, "Stay with me", Difficulty.hard, Buttons.button6, "Brandnew Days", Difficulty.normal, Buttons.button6, "waiting for me", Difficulty.hard, Buttons.button6, 0, 0, 0, 93, 0, "Fever OFF", "Plate : Brandnew Days")
            MissionInfo.add(Series.respect, "MAX Theater", "The Decisive Moment", "MASAI", Difficulty.hard, Buttons.button4, "OBLIVION", Difficulty.hard, Buttons.button4, "Minus 3", Difficulty.normal, Buttons.button4, "The Obliterator", Difficulty.hard, Buttons.button4, 0, 0, 1200, 0, 0, "Speed : 1.00 / Fever-Manual / FADE IN", "Music : The Obliterator")
            MissionInfo.add(Series.respect, "MAX Theater", "Virtual Reality", "Lost n' found", Difficulty.normal, Buttons.button6, "Beyond Yourself", Difficulty.normal, Buttons.button6, "FEAR", Difficulty.normal, Buttons.button6, "U.A.D", Difficulty.normal, Buttons.button6, 0, 0, 0, 0, 30, "Fever OFF / CHAOS W", "Plate : MAX Theater")
            MissionInfo.add(Series.respect, "MAX Theater", "NB is an Open Door", "NB RANGER", Difficulty.normal, Buttons.button5, "NB Rangers -Returns-", Difficulty.normal, Buttons.button5, "NB POWER", Difficulty.hard, Buttons.button5, "NB RANGER - Virgin Force", Difficulty.normal, Buttons.button5, 0, 0, 3000, 0, 0, "Fever-Manual / Gear&Note : NB RANGER", "Music : NB RANGER - Virgin Force")
            MissionInfo.add(Series.respect, "Another WORLD", "Girl Crush", "StarFish", Difficulty.normal, Buttons.button6, "Out Law", Difficulty.normal, Buttons.button6, "GET OUT", Difficulty.hard, Buttons.button6, "Runaway", Difficulty.normal, Buttons.button6, 1150000, 0, 0, 0, 0, "Fever-Manual", "Gallery : Runaway (2)")
            MissionInfo.add(Series.respect, "Another WORLD", "Resurrection", "Fallen Angel", Difficulty.hard, Buttons.button6, "Seeker", Difficulty.hard, Buttons.button6, "SIN", Difficulty.normal, Buttons.button6, "Don't Die", Difficulty.normal, Buttons.button6, 0, 3, 0, 0, 0, "Fever-Manual / Gear&Note : SIN", "Comment : "+"Night Owl".localized)
            MissionInfo.add(Series.respect, "Another WORLD", "Deadly Poison", "The Feelings", Difficulty.normal, Buttons.button5, "Piano Concerto No.1".localized, Difficulty.normal, Buttons.button5, "Midnight Blood", Difficulty.normal, Buttons.button5, "Funky Chups", Difficulty.normal, Buttons.button5, 1050000, 0, 0, 0, 10, "Fever OFF", "Gear : NB Ranger")
            MissionInfo.add(Series.respect, "Another WORLD", "Metal Kombat", "plastic method", Difficulty.normal, Buttons.button6, "Rocka-a-doodle-doo", Difficulty.normal, Buttons.button6, "Get on Top", Difficulty.hard, Buttons.button6, "Armored Phantom", Difficulty.hard, Buttons.button6, 0, 3, 0, 92, 0, "Fever-Manual", "Comment : "+"Don't Be Careless!".localized)
            MissionInfo.add(Series.respect, "Another WORLD", "Fairy Tales", "Phantom Of Sky", Difficulty.hard, Buttons.button5, "Memoirs", Difficulty.normal, Buttons.button5, "Sunny Side ~Deepn' Soul Mix~", Difficulty.normal, Buttons.button5, "quixotic", Difficulty.normal, Buttons.button5, 0, 0, 1000, 93, 0, "Fever OFF / FOG", "Gallery : Open Fire (2)")
            MissionInfo.add(Series.respect, "Another WORLD", "Global Sensation", "Triple Zoe", Difficulty.normal, Buttons.button6, "Another DAY", Difficulty.hard, Buttons.button6, "KUDA", Difficulty.normal, Buttons.button6, "Mulch", Difficulty.normal, Buttons.button6, 1280000, 0, 0, 0, 0, "Fever OFF / Gear&Note : Mulch", "Plate : Another World")
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "Emotional Sense", "Every Morning".localized, Difficulty.normal, Buttons.button5, "Memory of Beach", Difficulty.normal, Buttons.button5, "Sunny Side", Difficulty.hard, Buttons.button5, "End of the Moonlight", Difficulty.hard, Buttons.button5, "SIN", Difficulty.hard, Buttons.button5, 0, 0, 0, 95, 20, "Fever OFF / Gear&Note : Portable 1&Classic", "Gear : Portable 1")
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "Sound Miracle", "Your Own Miracle", Difficulty.normal, Buttons.button8, "Brandnew Days", Difficulty.normal, Buttons.button8, "Ladymade Star", Difficulty.hard, Buttons.button8, "Syriana", Difficulty.hard, Buttons.button8, "WhiteBlue", Difficulty.hard, Buttons.button8, 1400000, 3, 0, 0, 0, "Fever-Manual / Gear&Note : Portable 2&Classic", "Plate : Portable 2")
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "Nauts", "WHY", Difficulty.hard, Buttons.button4, "Far East Princess", Difficulty.hard, Buttons.button4, "Mess it Up", Difficulty.hard, Buttons.button4, "Sunset Rider", Difficulty.hard, Buttons.button4, 0, 0, 5500, 0, 0, "Fever-Manual / FADE OUT", "Comment : "+"Diet Starts Tomorrow".localized)
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "Makou Syndrome", "Lift You Up", Difficulty.hard, Buttons.button8, "Heavenly", Difficulty.hard, Buttons.button8, "A Lie", Difficulty.hard, Buttons.button8, "HAMSIN", Difficulty.normal, Buttons.button8, 1270000, 0, 0, 96, 0, "Fever-Manual", "Gallery : HAMSIN (2)")
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "NieNova", "Only for you", Difficulty.hard, Buttons.button6, "Chrono Breakers", Difficulty.normal, Buttons.button6, "For the IKARUS", Difficulty.normal, Buttons.button6, "Remains Of Doom", Difficulty.normal, Buttons.button6, 0, 4, 7000, 0, 0, "Fever-Manual / FOG / Gear&Note : Only for you", "Plate : Only for you")
            MissionInfo.add(Series.respect, Mission.Respect.backStage, "ND Lee", "Beautiful Day", Difficulty.hard, Buttons.button8, "ON", Difficulty.normal, Buttons.button8, "STALKER", Difficulty.normal, Buttons.button8, "2Nite", Difficulty.hard, Buttons.button8, 0, 0, 0, 0, 30, "Fever OFF / BLINK", "Plate : Back STAGE")
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "Formula 1", "Chain of Gravity", Difficulty.hard, Buttons.button6, "Jupiter Driving", Difficulty.hard, Buttons.button6, "Runaway", Difficulty.hard, Buttons.button6, "Bullet, Wanted!", Difficulty.hard, Buttons.button6, 1250000, 0, 0, 95, 0, "Fever-Manual / SLIDE UP", "Comment : "+"New Type".localized)
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "Randomelody", "RANDOM", Difficulty.normal, Buttons.button4, "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button4, 920000, 0, 0, 0, 0, "Fever-Manual", "Music : BlythE")
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "MAX It Up", "RANDOM", Difficulty.normal, Buttons.button5, "RANDOM", Difficulty.hard, Buttons.button5, "RANDOM", Difficulty.maximum, Buttons.button5, 0, 0, 7000, 0, 0, "Fever-Manual", "Comment : "+"Versatile".localized)
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "Russian Roulette", "RANDOM", Difficulty.normal, Buttons.button6, "RANDOM", Difficulty.hard, Buttons.button6, "RANDOM", Difficulty.maximum, Buttons.button6, 0, 4, 0, 97, 0, "Fever-Manual", "Comment : "+"Born to Jam".localized)
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "The Genius", "RANDOM", Difficulty.normal, Buttons.button8, "RANDOM", Difficulty.hard, Buttons.button8, "RANDOM", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 15, "Fever OFF", "Plate : Chaos theory")
            MissionInfo.add(Series.respect, Mission.Respect.chaosTheory, "Bigbang Theory", "NANO RISK", Difficulty.normal, Buttons.button4, "Brain Storm", Difficulty.normal, Buttons.button8, "Para-Q", Difficulty.hard, Buttons.button5, "Royal Clown", Difficulty.hard, Buttons.button6, 880000, 0, 0, 0, 0, "Fever OFF / CHAOS W", "Music : Brain Storm")
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "Beat Generation", "OBLIVION ~Rockin' Night Style~", Difficulty.hard, Buttons.button6, "Sunny Side ~Deepn' Soul Mix~", Difficulty.maximum, Buttons.button6, "Ruti'n (GOTH Wild Electro Remix)", Difficulty.hard, Buttons.button6, "SIN ~The Last Scene~", Difficulty.hard, Buttons.button6, 0, 5, 3000, 0, 0, "Fever-Manual", "Gallery : Lift You Up (3)")
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "R.O.D", "Rock Or Die", Difficulty.hard, Buttons.button6, "Road Of Death", Difficulty.hard, Buttons.button6, "Rolling On the Duck", Difficulty.hard, Buttons.button8, "Remains Of Doom", Difficulty.hard, Buttons.button8, 1250000, 5, 0, 0, 0, "Fever-Manual", "Plate : Remains Of Doom")
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "ned", "Running girl", Difficulty.hard, Buttons.button4, "Shadow Flower", Difficulty.hard, Buttons.button4, "The Obliterator", Difficulty.hard, Buttons.button4, "Armored Phantom", Difficulty.hard, Buttons.button4, 0, 0, 2000, 98, 0, "Speed : 1.50 / Fever OFF", "Note : Don't Die")
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "Mycin.Test", "Beyond Yourself", Difficulty.hard, Buttons.button5, "Waiting for you", Difficulty.hard, Buttons.button5, "Groovin Up", Difficulty.hard, Buttons.button5, "Bullet, Wanted!", Difficulty.hard, Buttons.button5, 1300000, 4, 0, 0, 0, "Fever-Manual", "Plate : Running girl")
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "7 SEQUENCE", "Extreme Z4", Difficulty.hard, Buttons.button8, "Catch Me", Difficulty.hard, Buttons.button8, "Brave it Out", Difficulty.maximum, Buttons.button8, "Higher", Difficulty.maximum, Buttons.button8, 0, 0, 7777, 97, 0, "Fever-Manual", "Comment : "+"Guru".localized)
            MissionInfo.add(Series.respect, Mission.Respect.soundLab, "GOTHic+orpheus", "Enter The Universe", Difficulty.hard, Buttons.button6, "Child of Night", Difficulty.maximum, Buttons.button6, "Ruti'n (GOTH Wild Electro Remix)", Difficulty.maximum, Buttons.button6, "The Obliterator", Difficulty.maximum, Buttons.button6, "KILLER BEE", Difficulty.maximum, Buttons.button6, 0, 0, 0, 0, 30, "Fever OFF / Gear&Note : OBLIVION", "Plate : Sound Lab")
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "TARIta", "Lemonade", Difficulty.normal, Buttons.button4, "Hello Pinky", Difficulty.hard, Buttons.button5, "FTR", Difficulty.normal, Buttons.button8, "Shadow Flower", Difficulty.hard, Buttons.button6, 0, 5, 0, 98, 0, "Fever-Manual", "Note : OBLIVION")
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "ECOmotion", "Astro Fight", Difficulty.normal, Buttons.button5, "Kung Brother", Difficulty.hard, Buttons.button5, "Taekwonburi".localized, Difficulty.maximum, Buttons.button5, "Liar", Difficulty.hard, Buttons.button5, 1350000, 0, 6000, 0, 0, "Fever-Manual", "Plate : Mulch")
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "BJ STUDIO", "Miles", Difficulty.hard, Buttons.button4, "2Nite", Difficulty.hard, Buttons.button5, "Brandnew Days", Difficulty.hard, Buttons.button6, "WHY", Difficulty.hard, Buttons.button8, 0, 0, 3950, 0, 0, "Fever OFF", "Comment : "+"Grandpa Gamer".localized)
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "Type B.Person", "Fentanest", Difficulty.hard, Buttons.button6, "U.A.D", Difficulty.hard, Buttons.button5, "Negative Nature", Difficulty.hard, Buttons.button6, "Royal Clown", Difficulty.hard, Buttons.button5, 0, 0, 0, 0, 5, "Fever OFF", "Gallery : EXTRA (4)")
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "Dumping Life", "glory day", Difficulty.hard, Buttons.button4, "Binary World", Difficulty.hard, Buttons.button4, "NB RANGER - Virgin Force", Difficulty.hard, Buttons.button4, "BlackCat", Difficulty.hard, Buttons.button4, 0, 0, 8000, 98, 0, "Fever-Manual", "Comment : "+"Left Hand Only".localized)
            MissionInfo.add(Series.respect, Mission.Respect.visualizer, "Just 100%", "RANDOM", Difficulty.normal, Buttons.button4, 0, 0, 0, 100, 0, "Fever OFF", "Plate : Visualizer")
            MissionInfo.add(Series.respect, Mission.Respect.developers, "Light Water", "sO mUCH iN LUV", Difficulty.maximum, Buttons.button6, "Right Now", Difficulty.maximum, Buttons.button6, "Ya! Party!", Difficulty.maximum, Buttons.button6, "Running girl", Difficulty.maximum, Buttons.button6, 1300000, 0, 0, 0, 0, "Fever-Manual", "Plate : Lift You Up")
            MissionInfo.add(Series.respect, Mission.Respect.developers, "juking must die", "One the Love", Difficulty.hard, Buttons.button4, "WhiteBlue", Difficulty.normal, Buttons.button4, 0, 0, 0, 97, 1, "Fever OFF / SLIDE DOWN", "Comment : "+"Classic Game Fanatic".localized)
            MissionInfo.add(Series.respect, Mission.Respect.developers, "c12Lover", "OBLIVION ~Rockin' Night Style~", Difficulty.hard, Buttons.button5, "Secret Dejavu", Difficulty.hard, Buttons.button5, "NB RANGER - Virgin Force", Difficulty.hard, Buttons.button5, "Rolling On the Duck", Difficulty.hard, Buttons.button5, 0, 0, 8500, 97, 10, "Fever AUTO / CHAOS REVERSE", "Plate : quixotic")
            MissionInfo.add(Series.respect, Mission.Respect.developers, "BEXTER", "KUDA", Difficulty.hard, Buttons.button6, "Syriana", Difficulty.hard, Buttons.button8, "glory day", Difficulty.hard, Buttons.button6, "BlackCat", Difficulty.maximum, Buttons.button6, 1350000, 0, 0, 0, 5, "Fever-Manual / Gear&Note : glory day", "Plate : Syriana")
            MissionInfo.add(Series.respect, Mission.Respect.developers, "NKO", "Heavenly", Difficulty.hard, Buttons.button4, "Chrono Breakers", Difficulty.hard, Buttons.button4, "Ray of Illuminati", Difficulty.hard, Buttons.button6, "KILLER BEE", Difficulty.hard, Buttons.button6, 982410, 4, 2010, 90, 23, "Fever-Manual", "Comment : "+"Doting Father".localized)
            MissionInfo.add(Series.respect, Mission.Respect.developers, "SSS", "A.I", Difficulty.hard, Buttons.button4, "Brain Storm", Difficulty.hard, Buttons.button5, "We're All Gonna Die", Difficulty.hard, Buttons.button6, "Don't Die", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 0, "Fever AUTO / vs AI", "Plate : D-VELOPERS / Trophy : DJ Alpha Resigns")
            MissionInfo.add(Series.respect, Mission.Respect.destination, "Bloody MANIcure", "Nightmare", Difficulty.hard, Buttons.button8, "quixotic", Difficulty.maximum, Buttons.button6, "Midnight Blood", Difficulty.hard, Buttons.button5, "SIN ~The Last Scene~", Difficulty.hard, Buttons.button4, 1230000, 0, 0, 0, 0, "Fever-Manual / FOG", "Music : SIN ~The Last Scene~")
            MissionInfo.add(Series.respect, Mission.Respect.destination, "GIGA BREAK", "Miles", Difficulty.maximum, Buttons.button8, "v o l d e n u i t", Difficulty.maximum, Buttons.button8, "STALKER", Difficulty.maximum, Buttons.button8, "Minimal Life", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 35, "Fever OFF", "Comment : "+"Genius".localized)
            MissionInfo.add(Series.respect, Mission.Respect.destination, "MAXimum Impact", "RANDOM", Difficulty.maximum, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button5, "RANDOM", Difficulty.maximum, Buttons.button6, "RANDOM", Difficulty.maximum, Buttons.button8, 0, 5, 9999, 0, 0, "Fever-Manual", "Plate : Nightmare")
            MissionInfo.add(Series.respect, Mission.Respect.destination, "HeLLord", "Rock Or Die", Difficulty.maximum, Buttons.button6, "Don't Die", Difficulty.maximum, Buttons.button5, "We're All Gonna Die", Difficulty.maximum, Buttons.button4, 0, 5, 0, 98, 0, "Fever-Manual", "Comment : "+"Super Master".localized)
            MissionInfo.add(Series.respect, Mission.Respect.destination, "Skyscraper", "waiting for me", Difficulty.special, Buttons.xb, "Sunny Side", Difficulty.special, Buttons.xb, "Out Law", Difficulty.special, Buttons.xb, "Minus 3", Difficulty.special, Buttons.xb, "Enemy Storm", Difficulty.special, Buttons.xb, 1600000, 0, 4500, 96, 0, "Fever-Manual", "Plate : Destination")
            MissionInfo.add(Series.respect, Mission.Respect.destination, "RESPECT FOR PLAYERS", "BlythE", Difficulty.maximum, Buttons.button4, "Seeker", Difficulty.maximum, Buttons.button5, "Remains Of Doom", Difficulty.maximum, Buttons.button6, "HAMSIN", Difficulty.maximum, Buttons.button8, "Nightmare", Difficulty.maximum, Buttons.button8, "We're All Gonna Die", Difficulty.special, Buttons.xb, 2000000, 5, 10000, 97, 50, "Fever-Manual", "Plate : BlackCat")
            
            //Trilogy
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "Over Your Dream", "Catch You", Difficulty.hard, Buttons.button4, "Memory of Wind".localized, Difficulty.hard, Buttons.button4, 500000, 0, 0, 0, 0, "Fever-Manual / Gear&Note : Trilogy&Classic", "Plate : Catch You")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "Missing You", "My Jealousy", Difficulty.normal, Buttons.button6, "Streetlight", Difficulty.normal, Buttons.button6, "Someday", Difficulty.hard, Buttons.button6, 0, 0, 0, 0, 10, "Fever OFF", "Plate : Someday")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "5! Ducks", "OBLIVION", Difficulty.normal, Buttons.button5, "Ladymade Star", Difficulty.normal, Buttons.button5, "Taekwonburi".localized, Difficulty.normal, Buttons.button5, 0, 0, 500, 0, 0, "Fever-Manual", "Plate : Talk! Talk!")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "Electronic License", "ZET", Difficulty.normal, Buttons.button4, "Syriana ~Blast Wave Mix~", Difficulty.normal, Buttons.button5, "Nevermind", Difficulty.normal, Buttons.button6, 0, 0, 0, 0, 0, "Fever OFF / vs AI prototype", "Plate : My Jealousy / Trophy : DJ Alpha Resigns")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "Max Boy", "Your Own Miracle ~Disco House Mix~", Difficulty.normal, Buttons.button6, "sO mUCH iN LUV ~Melodic Twisted Mix~", Difficulty.normal, Buttons.button5, "A Lie ~Deep Inside Mix~", Difficulty.normal, Buttons.button4, 0, 3, 0, 90, 0, "Speed : 1.50 / Fever-Manual / FADER PIXEL 2", "Plate : Streetlight")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.tSide, "DJMAX RESPECT U", "Only for you", Difficulty.maximum, Buttons.button4, "Someday", Difficulty.maximum, Buttons.button4, "Waiting for you", Difficulty.hard, Buttons.button4, "Running girl", Difficulty.hard, Buttons.button4, "KILLER BEE", Difficulty.maximum, Buttons.button4, 0, 0, 0, 0, 30, "Fever OFF / Gear&Note : glory day", "Gallery : DJMAX RESPECT U / Trophy : "+"다음 이벤트도 기대해주세요".localized)
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "2nd Impression", "GET OUT ~Hip Noodle Mix~", Difficulty.hard, Buttons.button4, "For Seasons ~Air Guitar Mix~", Difficulty.maximum, Buttons.button6, "STOP", Difficulty.hard, Buttons.button4, "NB Girls", Difficulty.hard, Buttons.button6, 0, 0, 0, 95, 0, "Fever OFF / FADE OUT", "")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "Beat Phobia", "The One", Difficulty.hard, Buttons.button5, "Yo Creo Que Si ~Live House Version~", Difficulty.hard, Buttons.button5, "Nevermind", Difficulty.hard, Buttons.button5, "ZET", Difficulty.hard, Buttons.button5, 0, 4, 0, 85, 0, "Fever-Manual / FOG", "Plate : ZET")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "Critical Period", "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.hard, Buttons.button5, "RANDOM", Difficulty.hard, Buttons.button6, "RANDOM", Difficulty.hard, Buttons.button8, 0, 0, 0, 0, 25, "Fever OFF / FADER PIXEL 2", "Plate : STOP")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "Under Control", "Talk! Talk!", Difficulty.hard, Buttons.button6, "My Alias", Difficulty.hard, Buttons.button6, "Ventilator", Difficulty.hard, Buttons.button6, "Mind Control", Difficulty.hard, Buttons.button6, 1150000, 5, 0, 0, 0, "Fever-Manual", "")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "Boss Match", "SIN ~The Last Scene~", Difficulty.maximum, Buttons.button4, "HAMSIN", Difficulty.maximum, Buttons.button5, "Seeker", Difficulty.maximum, Buttons.button6, "Don't Die", Difficulty.maximum, Buttons.button8, 1353924, 0, 0, 93, 13, "Fever AUTO", "Gallery : DJMAX RESPECT U (2)")
            MissionInfo.add(Series.trilogy, Mission.Trilogy.rSide, "In My Dream", "CnP", Difficulty.hard, Buttons.button4, "Sunset Rider", Difficulty.hard, Buttons.button5, "glory day", Difficulty.hard, Buttons.button6, 0, 5, 0, 97, 0, "Fever-Manual", "Plate : "+"Memory of Wind".localized)
            
            //Datebase - Trophy Info
            TrophyInfo.add(Series.respect, "RESPECT You", "모든 트로피를 획득했다.", "RESPECT You", "Collected all DJMAX RESPECT Trophies.", "PLATINUM")
            TrophyInfo.add(Series.respect, "디맥 그랜드 마스터", "레벨 99를 달성했다.", "DJMAX GRAND MASTER", "You have reached Level 99.", TrophyGrade.gold)
            TrophyInfo.add(Series.respect, "비트 마에스트로", "미션 50개를 클리어했다.", "BEAT MAESTRO", "Cleared 50 missions.", TrophyGrade.gold)
            TrophyInfo.add(Series.respect, "한계 돌파", "500개의 패턴을 MAX COMBO로 클리어했다.", "Break the Limit", "Cleared 500 patterns in MAX COMBO.", TrophyGrade.gold)
            TrophyInfo.add(Series.respect, "완벽 그 자체", "누적 점수가 300,000,000점을 돌파했다.", "Perfect Perfectionist", "Accumulated 300,000,000 points.", TrophyGrade.gold)
            TrophyInfo.add(Series.respect, "절반의 성공", "레벨 50을 달성했다.", "Half Empty? Half Full!", "You have reached Level 50.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "프로다운 실력", "미션 30개를 클리어했다.", "You Must Be a Pro", "Cleared 30 missions.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "열심히 해야지 방법이 없습니다", "누적 점수가 200,000,000점을 돌파했다.", "Diligence Will Pay Off One Day", "Accumulated 200,000,000 points.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "S랭크 마스터", "S랭크로 50회 클리어했다.", "S Rank Master", "Acquired S Rank for 50 times.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "콤보를 위해 판정은 포기!", "300개의 패턴을 MAX COMBO로 클리어했다.", "Combos First!", "Cleared 300 patterns in MAX COMBO.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "THE LORD OF COMBO", "999999 콤보를 달성했다.", "THE LORD OF COMBO", "Accomplished 999999 combos.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "JUST 100%", "RESPECT 곡을 PERFECT로 클리어했다.", "JUST 100%", "Cleared a pattern from RESPECT category with PERFECT.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "아 너무 무섭다", "5000 콤보 이상으로 클리어했다.", "Jaw Dropping Performance", "Cleared with 5000 or more combos.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "이 게임은 내가 지배한다", "모든 곡을 클리어했다.", "I Will Rule This Game", "Cleared all songs.", TrophyGrade.silver)
            TrophyInfo.add(Series.respect, "ARCADE KID", "ARCADE 모드를 4버튼으로 클리어했다.", "ARCADE KID", "Cleared ARCADE Mode with 4 Buttons.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "The 5th Wave", "ARCADE 모드를 5버튼으로 클리어했다. ", "The 5th Wave", "Cleared ARCADE Mode with 5 Buttons.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "Awesome MIX!", "ARCADE 모드를 6버튼으로 클리어했다.", "Awesome MIX!", "Cleared ARCADE Mode with 6 Buttons.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "Try your ability. Do it!!", "ARCADE 모드를 8버튼으로 클리어했다.", "Try your ability. Do it!!", "Cleared ARCADE Mode with 8 Buttons.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "대신귀여운트로피를드리겠습니다", "처음으로 클리어에 실패했다.", "Hopefully This Trophy Will Help You Keep Calm", "Failed a stage for the first time.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "나만 운없어..", "BREAK 1개로 클리어했다.", "Maybe Next Time..", "Cleared with a single BREAK.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "슈퍼 루키", "레벨 10을 달성했다.", "Super Rookie", "You have reached Level 10.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "순탄한 여행", "미션 10개를 클리어했다.", "A Smooth Ride", "Cleared 10 missions.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "숨겨왔던 재능", "100개의 패턴을 MAX COMBO로 클리어했다.", "Hidden Talent", "Cleared 100 patterns in MAX COMBO.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "점수를 모아야 이득인 부분", "누적 점수가 100,000,000점을 돌파했다.", "Each Single Point Counts", "Accumulated 100,000,000 points.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "하고싶은거 다 해", "A랭크로 100회 클리어했다.", "YOLO", "Acquired A Rank for 100 times.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "콤보 마이스터", "100000 콤보를 달성했다.", "Combo Meister", "Accomplished 100000 combos.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "럭키 해피 데이", "정확하게 777 콤보로 클리어했다.", "Happy Lucky Day", "Cleared with 777 combos.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "Ask to Wind".localized, "ARCADE 모드에서 DMP1 곡으로만 클리어했다.", "Ask to Wind".localized, "Cleared only with \"Portable 1\" songs in ARCADE Mode.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "Your Own Miracle", "ARCADE 모드에서 DMP2 곡으로만 클리어했다.", "Your Own Miracle", "Cleared only with \"Portable 2\" songs in ARCADE Mode.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "플레이트 콜렉터", "플레이트를 30개 획득했다.", "Plate Collector", "Acquired 30 plates.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "기어중의 기어", "기어를 15개 획득했다.", "The Gear of All Gears", "Acquired 15 gears.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "노트의 형태", "노트를 10개 획득했다.", "Everything about Notes", "Acquired 10 notes.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "마이 리틀 갤러리", "이미지를 100장 획득했다.", "My Little Gallery", "Acquired 100 images.",TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "아무 말 대잔치", "코멘트를 50개 획득했다.", "Slang Festival", "Acquired 50 comments.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "실력 검증", "난이도 10 이상의 패턴 30개를 MAX COMBO로 클리어했다.", "Testing Your Skills", "Cleared 30 patterns with difficulty level 10 or higher in MAX COMBO.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "푹 빠졌구나", "4버튼 마스터 스코어의 달성률이 70%에 도달했다.", "You're So Into This", "Accomplished 70% success rate of 4 Button Master Score.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "고고학자", "처음으로 숨겨진 BGA를 발견했다.", "Archeologist", "Found a hidden BGA for the first time.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "내 마음속에 저장", "모든 숨겨진 BGA를 발견했다.", "Saved in My Heart", "Found all the hidden BGA.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "DJ Alpha Resigns", "미션에서 A.I를 상대로 승리했다.", "DJ Alpha Resigns", "Beat the mission against A.I.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "엔비레인저가 되고싶어", "콜렉션에서 NB RANGER 시리즈의 모든 뮤직 비디오를 감상했다.", "Become an NB RANGER", "Watched all NB RANGER videos in Collection.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "지기 싫다고 생각하고 있어", "온라인 매치를 10번 플레이했다.", "No One Likes to Lose", "Played Online Match 10 times.", TrophyGrade.bronze)
            TrophyInfo.add(Series.respect, "언제나 감사합니다", "처음으로 CREDIT을 감상했다.", "This is for You", "Watched CREDITS for the first time.", TrophyGrade.bronze)
            
            TrophyInfo.add(Series.trilogy, "당신은 대체...", "TRILOGY 곡을 모두 S랭크로 클리어했다.", "Where Did You Come From...?", "Cleared all TRILOGY songs in S Rank.", TrophyGrade.gold)
            TrophyInfo.add(Series.trilogy, "제 여자친구가 확실합니다!", "\"Someday\"를 MAX COMBO로 클리어했다.", "That's Gotta be My Girlfriend!", "Cleared \"Someday\" in MAX COMBO.", TrophyGrade.silver)
            TrophyInfo.add(Series.trilogy, "트릴로지 메타", "ARCADE를 TRILOGY 곡으로만 클리어했다.", "TRILOGY Metaplay", "Cleared ARCADE Mode playing only TRILOGY songs.", TrophyGrade.bronze)
            TrophyInfo.add(Series.trilogy, "뉴 스킨 작렬...!", "TRILOGY UI 스킨을 적용했다.", "Here Comes a New Skin...!", "Used TRILOGY UI Skin.", TrophyGrade.bronze)
            TrophyInfo.add(Series.trilogy, "다음 이벤트도 기대해주세요", "DJMAX RESPECT U 미션을 클리어했다.", "Don't Miss Out On Upcoming Events!", "Cleared mission \"DJMAX RESPECT U\".", TrophyGrade.bronze)
            TrophyInfo.add(Series.trilogy, "대신푸우른USB를드리겠습니다", "10장의 TRILOGY 곡 이미지를 획득했다.", "And Now You Deserve This Handmade Trophy!", "Acquired 10 TRILOGY Song Images.", TrophyGrade.bronze)
            TrophyInfo.add(Series.trilogy, "나올수도 있고 안나올수도 있습니다", "TRILOGY 곡 중 숨겨진 BGA를 발견했다.", "Pikaboo!", "Found a Hidden BGA from a TRILOGY song.", TrophyGrade.bronze)
            
            TrophyInfo.add(Series.ce, "클리어 위주로 갑시다", "Clazziquai Edition 곡을 모두 S랭크로 클리어했다", "Let ME Be \"Clear\" On These", "Cleared all Clazziquai Edition songs in S Rank.", TrophyGrade.gold)
            TrophyInfo.add(Series.ce, "클럽 투어에 오신것을 환영합니다", "Electronic City를 클리어했다.","Welcome to the CLUB TOUR","Cleared \"Electronic City\".",TrophyGrade.silver)
            TrophyInfo.add(Series.ce,"이제와서 족자를 다 모을수도 없고","First Kiss 기어의 모든 캐릭터를 보았다.", "Is it too late to start collecting these?","Watched all characters of the Gear : First Kiss.",TrophyGrade.bronze)
            TrophyInfo.add(Series.ce,"역시 프로 리듬게이머는 달라","Clazziquai Edition 곡으로만 100000 콤보를 달성했다.", "What Makes A Professional Rhythm Gamer","Achieved 100000 Combos with songs only from the Clazziquai Edition.",TrophyGrade.bronze)
            TrophyInfo.add(Series.ce, "DJMAX ARTIST TEAM", "DJMAX TOURNAMENT LIVE 미션을 클리어했다.","DJMAX ARTIST TEAM","Cleared mission \"DJMAX TOURNAMENT LIVE\".",TrophyGrade.bronze)
            TrophyInfo.add(Series.ce, "METROTRONICS", "ARCADE를 Clazziquai Edition 곡으로만 클리어했다.","METROTRONICS","Cleared Arcade mode playing only Clazziquai Edition Songs.",TrophyGrade.bronze)
            TrophyInfo.add(Series.ce, "Go Back From the Top", "Clazziquai Edition 곡 중 숨겨진 BGA를 발견했다.", "Go Back From the Top","Found a Hidden BGA from a Clazziquai Edition Song.",TrophyGrade.bronze)
            
            TrophyInfo.add(Series.technika1, "플래티넘 크루", "TECHNIKA 곡을 모두 S랭크로 클리어했다.", "PLATINUM CREW", "Cleared all TECHNIKA songs in S rank.", TrophyGrade.silver)
            TrophyInfo.add(Series.technika1, "Rolling On the Screen", "Technical Mixing에서 할 수 있는 모든 패턴을 플레이했다.", "Rolling On the Screen", "Played all the patterns you can play in \"Technical Mixing\".", TrophyGrade.silver)
            TrophyInfo.add(Series.technika1, "테크니카의 10번째 생일을 축하해", "숨겨진 패턴을 MAX COMBO로 클리어했다.", "Happy 10th Birthday for TECHNIKA", "Cleared the hidden pattern in MAX COMBO", TrophyGrade.silver)
            TrophyInfo.add(Series.technika1, "First Step Set 졸업", "First Step 미션에서 플레이 할 수 있는 모든 곡을 클리어했다.", "First Step Set Complete", "Cleared all the songs in the First Step mission.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "ONLY FOR ARCADE", "ARCADE를 TECHNIKA 곡으로만 클리어했다.", "ONLY FOR ARCADE", "Cleared ARCADE mode only with TECHNIKA songs.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "Stylish eSper Shooting Sports", "COLLECTION 모드에서 SuperSonic의 뮤직 비디오를 감상했다.", "Stylish eSper Shooting Sports", "Watched a SuperSonic video in Collection.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "앗 깜짝이야", "Mr.Perfect 미션을 플레이했다.", "What a Surprise", "Played \"Mr.Perfect\" mission.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "너희집엔 이런거 없지?", "5가지의 TECHNIKA 전용 플레이트를 획득했다.", "I Bet You Don't Have This at Home", "Acquired 5 TECHNIKA Plates.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "댓글댓글단다 댓글댓글단다", "추장의 장비를 갖추고 SON OF SUN을 MAX COMBO로 클리어했다.", "SON OF SUN", "Cleared \"SON OF SUN\" in MAX COMBO with \"SON OF SUN\" GEAR and NOTE Skins.", TrophyGrade.bronze)
            TrophyInfo.add(Series.technika1, "암튼 레어 카드", "TECHNIKA 곡 중 숨겨진 BGA를 발견했다.", "Rare Card Anyways", "Found a Hidden BGA from a TECHNIKA Song.", TrophyGrade.bronze)
            
            TrophyInfo.add(Series.bs, "BLACK SQUARE에 도전하시겠습니까?", "BLACK SQUARE 곡에서 100개의 패턴을 MAX COMBO로 클리어했다.", "Do you want to try BLACK SQUARE?", "Cleared a 100 pattern BLACK SQUARE song with MAX COMBO", TrophyGrade.gold)
            TrophyInfo.add(Series.bs, "다시 한번 클럽 투어에 오신것을 환영합니다", "BLACK SQUARE 곡을 모두 S랭크로 클리어했다.", "Welcome back to the CLUB TOUR!", "Cleared all the BLACK SQUARE songs with S Rank.", TrophyGrade.silver)
            TrophyInfo.add(Series.bs, "Fermion으로 하겠어요", "Fermion 기어와 노트를 장착한 상태로 Fermion을 플레이했다.", "I'll go with Fermion", "Played \"Fermion\" using \"Fermion\" GEAR and NOTE Skins.", TrophyGrade.bronze)
            TrophyInfo.add(Series.bs, "REDESIGN?!", "RD Colosseum 미션을 클리어했다.", "REDESIGN?!", "Cleared the \"RD Colosseum\" mission.", TrophyGrade.bronze)
            TrophyInfo.add(Series.bs, "DJMAX 시리즈 중에서 최강 난이도", "BLACK SQUARE 곡에서 MAXIMUM 패턴을 MAX COMBO로 클리어했다.", "The toughest difficulty in the DJMAX series", "Cleared a BLACK SQUARE song at MAXIMUM difficulty level with MAX COMBO.", TrophyGrade.bronze)
            TrophyInfo.add(Series.bs, "정말 BLACK SQUARE 곡으로 할거야?", "ARCADE를 BLACK SQUARE 곡으로만 클리어했다.", "Are you sure you want a BLACK SQUARE song?", "Cleared ARCADE mode only with BLACK SQUARE songs.", TrophyGrade.bronze)
            TrophyInfo.add(Series.bs, "빨리 틀어요", "BLACK SQUARE 수록곡 중 한 곡을 연속으로 10회 클리어했다.", "Play it NOW!", "Cleared a BLACK SQUARE song 10 times in a row.", TrophyGrade.bronze)
            
            TrophyInfo.add(Series.linkDisk, "디스크 조각", "링크 디스크를 통해 획득할 수 있는 모든 곡을 MAX COMBO로 클리어했다.", "Disk Fragment", "Cleared all songs you can obtain through LINK DISK with MAX COMBO.", TrophyGrade.bronze)
            TrophyInfo.add(Series.linkDisk, "이제 최종 단계에 들어선거야", "The Others를 클리어했다.", "We're in the endgame now", "Cleared \"The Others\" mission.", TrophyGrade.bronze)
            TrophyInfo.add(Series.linkDisk, "디맥은 돌아온다", "METRO PROJECT 플레이트를 장착했다.", "DJMAX will Return", "Equipped \"METRO PROJECT\" plate.", TrophyGrade.bronze)
            
            //Database - AchievementInfo
            AchievementInfo.add(Achievement.playCount, 1, Achievement.music, "Syriana")
            AchievementInfo.add(Achievement.playCount, 2, Achievement.music, "OPEN FIRE")
            AchievementInfo.add(Achievement.playCount, 3, Achievement.music, "Don't Die")
            AchievementInfo.add(Achievement.playCount, 4, Achievement.noteSkin, "Mulch")
            AchievementInfo.add(Achievement.playCount, 5, Achievement.music, "OBLIVION ~Rockin' Night Style~")
            AchievementInfo.add(Achievement.playCount, 6, Achievement.comment, "GLHF".localized) //즐겜해요 祝你好運！
            AchievementInfo.add(Achievement.playCount, 7, Achievement.plate, "NB RED")
            AchievementInfo.add(Achievement.playCount, 8, Achievement.gallery, "Binary World (2)")
            AchievementInfo.add(Achievement.playCount, 9, Achievement.comment, "Rhythm Game Maniac".localized) //리듬게임 매니아 音樂游戲愛好者
            AchievementInfo.add(Achievement.playCount, 10, Achievement.plate, "Out Law")
            AchievementInfo.add(Achievement.playerLevel, 1, Achievement.music, "Waiting for you")
            AchievementInfo.add(Achievement.playerLevel, 2, Achievement.gearSkin, "Only for you")
            AchievementInfo.add(Achievement.playerLevel, 3, Achievement.music, "NB POWER")
            AchievementInfo.add(Achievement.playerLevel, 4, Achievement.music, "Royal Clown")
            AchievementInfo.add(Achievement.playerLevel, 5, Achievement.music, "BlackCat")
            AchievementInfo.add(Achievement.playerLevel, 6, Achievement.gearSkin, "PORTABLE 3")
            AchievementInfo.add(Achievement.playerLevel, 7, Achievement.plate, "SIN")
            AchievementInfo.add(Achievement.playerLevel, 8, Achievement.plate, "Seeker")
            AchievementInfo.add(Achievement.playerLevel, 9, Achievement.gearSkin, "TECHNIKA 3")
            AchievementInfo.add(Achievement.playerLevel, 10, Achievement.plate, "HAMSIN")
            AchievementInfo.add(Achievement.arcadeModeCleared, 1, Achievement.gearSkin, "TECHNIKA 1")
            AchievementInfo.add(Achievement.arcadeModeCleared, 2, Achievement.music, "FTR")
            AchievementInfo.add(Achievement.arcadeModeCleared, 3, Achievement.music, "Beyond Yourself")
            AchievementInfo.add(Achievement.arcadeModeCleared, 4, Achievement.gallery, "Royal Clown (2)")
            AchievementInfo.add(Achievement.arcadeModeCleared, 5, Achievement.gallery, "Far East Princess (3)")
            AchievementInfo.add(Achievement.arcadeModeCleared, 6, Achievement.comment, "Eager Beaver".localized) //들어올 땐 마음대로 已經上癮了吧？
            AchievementInfo.add(Achievement.arcadeModeCleared, 7, Achievement.plate, "Light House")
            AchievementInfo.add(Achievement.arcadeModeCleared, 8, Achievement.gallery, "2NITE (2)")
            AchievementInfo.add(Achievement.arcadeModeCleared, 9, Achievement.comment, "Always On Duty".localized)   //평생 현역 終身值班
            AchievementInfo.add(Achievement.arcadeModeCleared, 10, Achievement.plate, "DIVINE SERVICE")
            AchievementInfo.add(Achievement.button4TunesCleared, 1, Achievement.music, "Running girl")
            AchievementInfo.add(Achievement.button4TunesCleared, 2, Achievement.music, "The Feelings")
            AchievementInfo.add(Achievement.button4TunesCleared, 3, Achievement.music, "Eternal Memory".localized)
            AchievementInfo.add(Achievement.button4TunesCleared, 4, Achievement.plate, "Hello Pinky")
            AchievementInfo.add(Achievement.button4TunesCleared, 5, Achievement.comment, "Every Morning".localized)
            AchievementInfo.add(Achievement.button4TunesCleared, 6, Achievement.music, "Sunny Side ~Deepn' Soul Mix~")
            AchievementInfo.add(Achievement.button4TunesCleared, 7, Achievement.gallery, "One The Love (2)")
            AchievementInfo.add(Achievement.button4TunesCleared, 8, Achievement.plate, "OBLIVION")
            AchievementInfo.add(Achievement.button4TunesCleared, 9, Achievement.gallery, "Groovin Up (2)")
            AchievementInfo.add(Achievement.button4TunesCleared, 10, Achievement.comment, "4B TUNES Love".localized)    //4버튼이 좋아요 贊美4鍵模式
            AchievementInfo.add(Achievement.button5TunesCleared, 1, Achievement.music, "Seeker")
            AchievementInfo.add(Achievement.button5TunesCleared, 2, Achievement.gearSkin, "TECHNIKA 2")
            AchievementInfo.add(Achievement.button5TunesCleared, 3, Achievement.music, "JBG")
            AchievementInfo.add(Achievement.button5TunesCleared, 4, Achievement.comment, "I Love Dogs!".localized)    //강아지 좋아요! 我愛狗！
            AchievementInfo.add(Achievement.button5TunesCleared, 5, Achievement.music, "Funky Chups")
            AchievementInfo.add(Achievement.button5TunesCleared, 6, Achievement.plate, "For The IKARUS")
            AchievementInfo.add(Achievement.button5TunesCleared, 7, Achievement.gallery, "Only for you (2)")
            AchievementInfo.add(Achievement.button5TunesCleared, 8, Achievement.plate, "CHICKEN")
            AchievementInfo.add(Achievement.button5TunesCleared, 9, Achievement.gallery, "KILLER BEE (3)")
            AchievementInfo.add(Achievement.button5TunesCleared, 10, Achievement.comment, "5B TUNES Love".localized)  //5버튼이 좋아요 贊美5鍵模式
            AchievementInfo.add(Achievement.button6TunesCleared, 1, Achievement.music, "A.I")
            AchievementInfo.add(Achievement.button6TunesCleared, 2, Achievement.comment, "Waiting for Weekend".localized)   //주말반 모집 중 注意力不夠
            AchievementInfo.add(Achievement.button6TunesCleared, 3, Achievement.music, "KUDA")
            AchievementInfo.add(Achievement.button6TunesCleared, 4, Achievement.music, "Negative Nature")
            AchievementInfo.add(Achievement.button6TunesCleared, 5, Achievement.comment, "Stud".localized)  //미소년 美少年
            AchievementInfo.add(Achievement.button6TunesCleared, 6, Achievement.music, "Ya! Party!")
            AchievementInfo.add(Achievement.button6TunesCleared, 7, Achievement.plate, "TAP SONIC")
            AchievementInfo.add(Achievement.button6TunesCleared, 8, Achievement.plate, "Sunny Side")
            AchievementInfo.add(Achievement.button6TunesCleared, 9, Achievement.gallery, "quixotic (3)")
            AchievementInfo.add(Achievement.button6TunesCleared, 10, Achievement.comment, "6B TUNES Love".localized)    //6버튼이 좋아요 贊美6鍵模式
            AchievementInfo.add(Achievement.button8TunesCleared, 1, Achievement.gearSkin, "PORTABLE 2")
            AchievementInfo.add(Achievement.button8TunesCleared, 2, Achievement.music, "Minimal Life")
            AchievementInfo.add(Achievement.button8TunesCleared, 3, Achievement.comment, "Mr. Perfect")
            AchievementInfo.add(Achievement.button8TunesCleared, 4, Achievement.music, "Piano Concerto No.1".localized)
            AchievementInfo.add(Achievement.button8TunesCleared, 5, Achievement.comment, "NB RANGER".localized) //엔비 레인져 NB RANGER
            AchievementInfo.add(Achievement.button8TunesCleared, 6, Achievement.music, "STALKER")
            AchievementInfo.add(Achievement.button8TunesCleared, 7, Achievement.gallery, "EXTRA (3)")
            AchievementInfo.add(Achievement.button8TunesCleared, 8, Achievement.plate, "Taekwonburi".localized)
            AchievementInfo.add(Achievement.button8TunesCleared, 9, Achievement.gallery, "The Obliterator (2)")
            AchievementInfo.add(Achievement.button8TunesCleared, 10, Achievement.comment, "8B TUNES Love".localized)    //8버튼이 좋아요 贊美8鍵模式
            AchievementInfo.add(Achievement.freeStyleCombo, 1, Achievement.music, "WHY")
            AchievementInfo.add(Achievement.freeStyleCombo, 2, Achievement.gearSkin, "TAP SONIC")
            AchievementInfo.add(Achievement.freeStyleCombo, 3, Achievement.music, "Mulch")
            AchievementInfo.add(Achievement.freeStyleCombo, 4, Achievement.music, "Rolling On the Duck")
            AchievementInfo.add(Achievement.freeStyleCombo, 5, Achievement.music, "Nightmare")
            AchievementInfo.add(Achievement.freeStyleCombo, 6, Achievement.comment, "Sheepish".localized)  //굽신굽신 卑躬屈膝
            AchievementInfo.add(Achievement.freeStyleCombo, 7, Achievement.gallery, "End of the Moonlight (3)")
            AchievementInfo.add(Achievement.freeStyleCombo, 8, Achievement.comment, "FEVER Free Zone".localized)   //피버 안써욧 FEVER FREE ZONE
            AchievementInfo.add(Achievement.freeStyleCombo, 9, Achievement.gallery, "quixotic (7)")
            AchievementInfo.add(Achievement.freeStyleCombo, 10, Achievement.plate, "BlythE")
            AchievementInfo.add("MISSION Cleared", 1, Achievement.plate, "NB BLUE")
            AchievementInfo.add("MISSION Cleared", 2, Achievement.plate, "NB GREEN")
            AchievementInfo.add("MISSION Cleared", 3, Achievement.plate, "NB BLACK")
            AchievementInfo.add("MISSION Cleared", 4, Achievement.plate, "NB YELLOW")
            AchievementInfo.add("MISSION Cleared", 5, Achievement.plate, "NB RANGER")
            AchievementInfo.add("MISSION Cleared", 6, Achievement.gearSkin, "glory day")
            AchievementInfo.add(Achievement.totalBreak, 1, Achievement.comment, "Can't Focus".localized)    //집중력 부족 注意力不夠
            AchievementInfo.add(Achievement.totalBreak, 2, Achievement.plate, "Memoy of Beach")
            AchievementInfo.add(Achievement.totalBreak, 3, Achievement.music, "GET OUT")
            AchievementInfo.add(Achievement.totalBreak, 4, Achievement.comment, "Lefty".localized)  //왼손잡이 左撇子
            AchievementInfo.add(Achievement.totalBreak, 5, Achievement.gearSkin, "Mulch")
            AchievementInfo.add(Achievement.totalBreak, 6, Achievement.gallery, "Miles (2)")
            AchievementInfo.add(Achievement.totalBreak, 7, Achievement.comment, "Novice Here".localized)    //초보입니다 新手來了
            AchievementInfo.add(Achievement.totalBreak, 8, Achievement.gallery, "NB RANGER (3)")
            AchievementInfo.add(Achievement.totalBreak, 9, Achievement.gallery, "Brain Storm (2)")
            AchievementInfo.add(Achievement.totalBreak, 10, Achievement.comment, "High Class".localized)    //오늘따라 잘 안되네 不可忽視的才能
            AchievementInfo.add(Achievement.maximumMaxCombo, 1, Achievement.music, "Far East Princess")
            AchievementInfo.add(Achievement.maximumMaxCombo, 2, Achievement.gallery, "Running girl (2)")
            AchievementInfo.add(Achievement.maximumMaxCombo, 3, Achievement.plate, "Ruti'n (GOTH Wild Electro Remix)")
            AchievementInfo.add(Achievement.maximumMaxCombo, 4, Achievement.music, "Chrono Breakers")
            AchievementInfo.add(Achievement.maximumMaxCombo, 5, Achievement.comment, "Hawk Eye".localized) //엄청난 동체시력 鷹眼
            AchievementInfo.add(Achievement.maximumMaxCombo, 6, Achievement.plate, "Ladymade Star")
            AchievementInfo.add(Achievement.maximumMaxCombo, 7, Achievement.gallery, "glory day (3)")
            AchievementInfo.add(Achievement.maximumMaxCombo, 8, Achievement.comment, "HAXXOR".localized)   //킹갓엠페러제네럴 超越者
            AchievementInfo.add(Achievement.maxComboCleared, 1, Achievement.music, "Out Law")
            AchievementInfo.add(Achievement.maxComboCleared, 2, Achievement.noteSkin, "Only for you")
            AchievementInfo.add(Achievement.maxComboCleared, 3, Achievement.music, "WhiteBlue")
            AchievementInfo.add(Achievement.maxComboCleared, 4, Achievement.gearSkin, "CE")
            AchievementInfo.add(Achievement.maxComboCleared, 5, Achievement.noteSkin, "TECHNIKA 3")
            AchievementInfo.add(Achievement.maxComboCleared, 6, Achievement.gallery, "Child of Night (2)")
            AchievementInfo.add(Achievement.maxComboCleared, 7, Achievement.comment, "Jack of All Trades".localized)   //올라운더 靈丹妙藥
            AchievementInfo.add(Achievement.maxComboCleared, 8, Achievement.gallery, "Brandnew Days (4)")
            AchievementInfo.add(Achievement.maxComboCleared, 9, Achievement.gallery, "We're All Gonna Die (2)")
            AchievementInfo.add(Achievement.maxComboCleared, 10, Achievement.plate, "The Obliterator")
            AchievementInfo.add(Achievement.sRankCleared, 1, Achievement.music, "Midnight Blood")
            AchievementInfo.add(Achievement.sRankCleared, 2, Achievement.comment, "Come at Me".localized)    //도전하시겠습니까? 想挑戰嗎？
            AchievementInfo.add(Achievement.sRankCleared, 3, Achievement.noteSkin, "TAP SONIC")
            AchievementInfo.add(Achievement.sRankCleared, 4, Achievement.music, "Road Of Death")
            AchievementInfo.add(Achievement.sRankCleared, 5, Achievement.plate, "Good Bye")
            AchievementInfo.add(Achievement.sRankCleared, 6, Achievement.gallery, "NB RANGER - Virgin Force (2)")
            AchievementInfo.add(Achievement.sRankCleared, 7, Achievement.gallery, "Showtime (2)")
            AchievementInfo.add(Achievement.sRankCleared, 8, Achievement.comment, "Unforgettable".localized)   //늘 기억되고 싶은 사람 勿忘我
            AchievementInfo.add(Achievement.sRankCleared, 9, Achievement.comment, "Most Popular".localized)    //인기만점 超級紅人
            AchievementInfo.add(Achievement.sRankCleared, 10, Achievement.plate, "Midnight Blood")
            AchievementInfo.add(Achievement.aRankCleared, 1, Achievement.music, "DIVINE SERVICE")
            AchievementInfo.add(Achievement.aRankCleared, 2, Achievement.music, "Yo Creo Que Si")
            AchievementInfo.add(Achievement.aRankCleared, 3, Achievement.gallery, "Far East Princess (4)")
            AchievementInfo.add(Achievement.aRankCleared, 4, Achievement.comment, "I Love Cats!".localized)    //고양이 좋아요! 我愛貓！
            AchievementInfo.add(Achievement.aRankCleared, 5, Achievement.gallery, "Armored Phantom (2)")
            AchievementInfo.add(Achievement.aRankCleared, 6, Achievement.gallery, "Bullet, Wanted! (2)")
            AchievementInfo.add(Achievement.aRankCleared, 7, Achievement.gallery, "Beyond Yourself (3)")
            AchievementInfo.add(Achievement.aRankCleared, 8, Achievement.comment, "Clear All Songs!".localized)    //목표는 전곡 클리어! 目標是全曲闖闗
            AchievementInfo.add(Achievement.aRankCleared, 9, Achievement.gallery, "Sunny Side (2)")
            AchievementInfo.add(Achievement.aRankCleared, 10, Achievement.plate, "Memoirs")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 1, Achievement.comment, "I Want You.".localized) //친추 환영 添加好友大歡迎
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 2, Achievement.music, "Shadow Flower")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 3, Achievement.gearSkin, "CHICKEN")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 4, Achievement.music, "Showtime")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 5, Achievement.comment, "Holy Land".localized)   //성지순례 聖地巡禮
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 6, Achievement.gallery, "OBLIVION (2)")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 7, Achievement.music, "RED")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 8, Achievement.gallery, "Runaway (3)")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 9, Achievement.plate, "TECHNIKA 2")
            AchievementInfo.add(Achievement.normalDifficultyModeCleared, 10, Achievement.comment, "Only Study".localized) //이젠 정말 공부뿐이야 學習第一！
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 1, Achievement.music, "quixotic")
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 2, Achievement.gallery, "Every Morning (3)".localized) //아침형 인간 (3) Every Morning (3)
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 3, Achievement.music, "Taekwonburi".localized)
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 4, Achievement.music, "SQUEEZE")
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 5, Achievement.comment, "Most Improved".localized) //일취월장 日新月異
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 6, Achievement.music, "Chain of Gravity")
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 7, Achievement.gallery, "Secret Dejavu (2)")
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 8, Achievement.music, "Enter The Universe")
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 9, Achievement.comment, "Sprint".localized)    //전력질주 全力奔跑
            AchievementInfo.add(Achievement.hardDifficultyModeCleared, 10, Achievement.plate, "PORTABLE 3")
            AchievementInfo.add(Achievement.maximumDifficultyModeCleared, 1, Achievement.music, "Remains Of Doom")
            AchievementInfo.add(Achievement.maximumDifficultyModeCleared, 2, Achievement.gallery, "U.A.D (2)")
            AchievementInfo.add(Achievement.maximumDifficultyModeCleared, 3, Achievement.music, "HAMSIN")
            AchievementInfo.add(Achievement.maximumDifficultyModeCleared, 4, Achievement.gallery, "Remains Of Doom (2)")
            AchievementInfo.add(Achievement.maximumDifficultyModeCleared, 5, Achievement.comment, "Rhythm Power".localized)   //리듬! 파워! 집중력! 節奏！力量！集中！
            AchievementInfo.add(Achievement.x2FeverActivated, 1, Achievement.music, "End of the Moonlight")
            AchievementInfo.add(Achievement.x2FeverActivated, 2, Achievement.noteSkin, "CAT")
            AchievementInfo.add(Achievement.x2FeverActivated, 3, Achievement.music, "Yellowberry -AJ Mix-")
            AchievementInfo.add(Achievement.x2FeverActivated, 4, Achievement.gallery, "Only for you (3)")
            AchievementInfo.add(Achievement.x2FeverActivated, 5, Achievement.music, "Mess it Up")
            AchievementInfo.add(Achievement.x2FeverActivated, 6, Achievement.gearSkin, "SIN")
            AchievementInfo.add(Achievement.x2FeverActivated, 7, Achievement.gallery, "NB RANGER - Virgin Force (3)")
            AchievementInfo.add(Achievement.x2FeverActivated, 8, Achievement.comment, "Shut In".localized) //은둔형 외톨이 隱蔽青年
            AchievementInfo.add(Achievement.x2FeverActivated, 9, Achievement.gallery, "Binary World (3)")
            AchievementInfo.add(Achievement.x2FeverActivated, 10, Achievement.comment, "I'm the Boss".localized)   //대장님 我就是老大
            AchievementInfo.add(Achievement.x3FeverActivated, 1, Achievement.music, "Rocka-a-doodle-doo")
            AchievementInfo.add(Achievement.x3FeverActivated, 2, Achievement.music, "Bye Bye Love")
            AchievementInfo.add(Achievement.x3FeverActivated, 3, Achievement.gallery, "glory day (4)")
            AchievementInfo.add(Achievement.x3FeverActivated, 4, Achievement.music, "ON")
            AchievementInfo.add(Achievement.x3FeverActivated, 5, Achievement.comment, "DMP Lover".localized)   //포터블 경험자 DMP經曆者
            AchievementInfo.add(Achievement.x3FeverActivated, 6, Achievement.music, "Fentanest")
            AchievementInfo.add(Achievement.x3FeverActivated, 7, Achievement.gallery, "Memory of Beach (3)")
            AchievementInfo.add(Achievement.x3FeverActivated, 8, Achievement.plate, "Secret Dejavu")
            AchievementInfo.add(Achievement.x3FeverActivated, 9, Achievement.gallery, "Brandnew Days (3)")
            AchievementInfo.add(Achievement.x3FeverActivated, 10, Achievement.comment, "What a Bookworm".localized)    //문과생이 또 文科小子！
            AchievementInfo.add(Achievement.x4FeverActivated, 1, Achievement.music, "StarFish")
            AchievementInfo.add(Achievement.x4FeverActivated, 2, Achievement.music, "For The IKARUS")
            AchievementInfo.add(Achievement.x4FeverActivated, 3, Achievement.comment, "DMO Lover".localized)   //온라인 경험자 DMO經曆者
            AchievementInfo.add(Achievement.x4FeverActivated, 4, Achievement.music, "Runaway")
            AchievementInfo.add(Achievement.x4FeverActivated, 5, Achievement.gallery, "sO mUCH iN LUV (2)")
            AchievementInfo.add(Achievement.x4FeverActivated, 6, Achievement.music, "Dream of You")
            AchievementInfo.add(Achievement.x4FeverActivated, 7, Achievement.gallery, "Chrono Breakers (2)")
            AchievementInfo.add(Achievement.x4FeverActivated, 8, Achievement.comment, "Go Easy On Me.".localized)  //제발 살살 좀 請手下留情
            AchievementInfo.add(Achievement.x4FeverActivated, 9, Achievement.comment, "Condition Disorder".localized)  //컨디션 난조 狀態不佳
            AchievementInfo.add(Achievement.x4FeverActivated, 10, Achievement.gallery, "Enemy Storm (2)")
            AchievementInfo.add(Achievement.x5FeverActivated, 1, Achievement.music, "FEAR")
            AchievementInfo.add(Achievement.x5FeverActivated, 2, Achievement.music, "Sunset Rider")
            AchievementInfo.add(Achievement.x5FeverActivated, 3, Achievement.comment, "Cute".localized)    //귀여워 可愛
            AchievementInfo.add(Achievement.x5FeverActivated, 4, Achievement.gallery, "Out Law (2)")
            AchievementInfo.add(Achievement.x5FeverActivated, 5, Achievement.music, "v o l d e n u i t")
            AchievementInfo.add(Achievement.x5FeverActivated, 6, Achievement.gallery, "BlackCat (2)")
            AchievementInfo.add(Achievement.x5FeverActivated, 7, Achievement.gallery, "Save My Dream (2)")
            AchievementInfo.add(Achievement.x5FeverActivated, 8, Achievement.music, "Triple Zoe")
            AchievementInfo.add(Achievement.x5FeverActivated, 9, Achievement.comment, "No Comment")
            AchievementInfo.add(Achievement.x5FeverActivated, 10, Achievement.plate, "Sunset Rider")
            AchievementInfo.add(Achievement.effector, 1, Achievement.music, "Para-Q")
            AchievementInfo.add(Achievement.effector, 2, Achievement.comment, "You See That?".localized) //그게 보여요? 那也能看得到嗎？
            AchievementInfo.add(Achievement.effector, 3, Achievement.gallery, "Enter The Universe (2)")
            AchievementInfo.add(Achievement.effector, 4, Achievement.music, "Fever GJ")
            AchievementInfo.add(Achievement.effector, 5, Achievement.gallery, "Ruti'n (GOTH Wild Electro Remix) (2)")
            AchievementInfo.add(Achievement.effector, 6, Achievement.comment, "Craving Technika".localized)  //테크니카 하고싶다 TECHNIKA渴望中
            AchievementInfo.add(Achievement.totalScore, 1, Achievement.music, "KILLER BEE")
            AchievementInfo.add(Achievement.totalScore, 2, Achievement.music, "Minus 3")
            AchievementInfo.add(Achievement.totalScore, 3, Achievement.comment, "Yes Sir!".localized)   //충성충성 絕對忠誠
            AchievementInfo.add(Achievement.totalScore, 4, Achievement.gallery, "Don't Die (3)")
            AchievementInfo.add(Achievement.totalScore, 5, Achievement.comment, "!?")
            AchievementInfo.add(Achievement.totalScore, 6, Achievement.noteSkin, "glory day")
            AchievementInfo.add(Achievement.totalScore, 7, Achievement.gallery, "Road Of Death (2)")
            AchievementInfo.add(Achievement.totalScore, 8, Achievement.gallery, "glory day (2)")
            AchievementInfo.add(Achievement.totalScore, 9, Achievement.gallery, "WHY (3)")
            AchievementInfo.add(Achievement.totalScore, 10, Achievement.comment, "Hard Worker".localized)   //노력형 플레이어 努力家
            AchievementInfo.add(Achievement.onlineModePlaycount, 1, Achievement.music, "MASAI")
            AchievementInfo.add(Achievement.onlineModePlaycount, 2, Achievement.comment, "Let's Be Friends".localized) //친해지고 싶어요 想親近
            AchievementInfo.add(Achievement.onlineModePlaycount, 3, Achievement.comment, "Lurker".localized)   //온라인 서식중 網絡潛伏者
            AchievementInfo.add(Achievement.onlineModePlaycount, 4, Achievement.gallery, "Heavenly (2)")
            AchievementInfo.add(Achievement.onlineModePlaycount, 5, Achievement.comment, "DJMAX Missionary".localized) //디맥 전도사 DJMAX 傳教士
            AchievementInfo.add(Achievement.onlineModePlaycount, 6, Achievement.gallery, "Lift You Up (2)")
            AchievementInfo.add(Achievement.onlineModePlaycount, 7, Achievement.gallery, "Long Vacation (2)")
            AchievementInfo.add(Achievement.onlineModePlaycount, 8, Achievement.comment, "Test your Might".localized)  //누구든지 덤벼 放馬過來吧
            AchievementInfo.add(Achievement.onlineModePlaycount, 9, Achievement.gallery, "Brandnew Days (2)")
            AchievementInfo.add(Achievement.onlineModePlaycount, 10, Achievement.plate, "KILLER BEE")
        }
        
        //클래지콰이 에디션 성과 기록을 위한 공간 만드는 코드
        //드레드노트, 리스펙트 신곡도 추가
        if(version <= 14){
            let songResults = try! Realm().objects(SongInfo.self).filter("series = 'CE'")
            for i in songResults{
                RecordInfo.initialize(i.series, i.title)
                RecordInfo.initializeDifficulty(i.title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
            }
            RecordInfo.initialize(Series.portable1, "Dreadnought")
            RecordInfo.initializeDifficulty("Dreadnought", 6, 8, 8, 8, 9, 11, 0, 13, 12, 0, 13, 0)
            RecordInfo.initialize(Series.respect, "Rising The Sonic")
            RecordInfo.initializeDifficulty("Rising The Sonic", 4, 5, 5, 5, 8, 10, 9, 10, 12, 13, 13, 14)
        }
        
        if(version <= 15){
            if(try! Realm().objects(RecordInfo.self).count == 0){
                let songResults = try! Realm().objects(SongInfo.self)
                for i in songResults{
                    let title = i.title
                    RecordInfo.initialize(i.series, title)
                    RecordInfo.initializeDifficulty(title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
                }
            }
            if(try! Realm().objects(RecordInfo.self).filter("series = 'CE'").count == 0){
                let song = try! Realm().objects(SongInfo.self).filter("series = 'CE'")
                for i in song{
                    RecordInfo.initialize(i.series, i.title)
                    RecordInfo.initializeDifficulty(i.title, i.nm4, i.nm5, i.nm6, i.nm8, i.hd4, i.hd5, i.hd6, i.hd8, i.mx4, i.mx5, i.mx6, i.mx8)
                }
                RecordInfo.initialize(Series.portable1, "Dreadnought")
                RecordInfo.initializeDifficulty("Dreadnought", 6, 8, 8, 8, 9, 11, 0, 13, 12, 0, 13, 0)
                RecordInfo.initialize(Series.respect, "Rising The Sonic")
                RecordInfo.initializeDifficulty("Rising The Sonic", 4, 5, 5, 5, 8, 10, 9, 10, 12, 13, 13, 14)
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
                SongInfo.add(Series.ce, "DARK ENVY", "Sugardonut", "195", 6, 11, 14, 6, 10, 14, 7, 10, 13, 6, 9, 14)
                RecordInfo.initialize(Series.ce, "DARK ENVY")
                RecordInfo.initializeDifficulty("DARK ENVY", 6, 6, 7, 6, 11, 10, 10, 9, 14, 14, 13, 14)
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
            TipInfo.add("Each music's speed settings are saved separately.")
            TipInfo.add("ANALOG NOTE can be played by rotating the stick or holding it to one side.")
            TipInfo.add("System Settings can be changed from the main menu by pressing the touch pad button.")
            TipInfo.add("In FREESTYLE mode, press the R3 button to add a music to your favorites.")
            TipInfo.add("In FREESTYLE mode, combos are cumulative.")
            TipInfo.add("Some music have hidden BGAs.")
            TipInfo.add("When you achieve MAX COMBO, you can receive the music video for the current music.")
            TipInfo.add("While performing, press the touch pad to adjust the BGA brightness.")
            TipInfo.add("In FREESTYLE mode, 2 players local play is possible, and each player can play a different mode.")
            TipInfo.add("The button used to play can be changed in System Settings.")
            TipInfo.add("FREESTYLE mode's combo accumulation can be changed in System Settings.")
            TipInfo.add("ARCADE mode's music are chosen randomly according to the set difficulty.")
            TipInfo.add("The FEVER gauge increases according to note play accuracy.")
            TipInfo.add("You can change the System Settings UI skin.")
            TipInfo.add("If the game screen doesn't display completely, check your \"PS4\" Display Area settings.")
            TipInfo.add("In FREESTYLE mode, use the L1 button and R1 button to change the category.")
            TipInfo.add("In ONLINE mode, you can play music you have not yet acquired.")
            TipInfo.add("While FEVER is active, you can receive more points and larger combos.")
            TipInfo.add("You can use the L2 button and R2 button to change the speed during play, or from the music selection screen.")
        }
        
        if(version <= 25){
            if(UserDefaults.standard.integer(forKey: "bpm") == 0){
                UserDefaults.standard.set(450, forKey: "bpm")
            }
        }
        
        if(version <= 25){
            //2.00
            UserDefaults.standard.set(200, forKey: "version")
        }
        
        if(version <= 200){
            //2.01
            UserDefaults.standard.set(201, forKey: "version")
        }
        
        if(version <= 201){
            //2.02
            let sin = realm.objects(RecordInfo.self).filter("title = 'SIN'").first!
            try! realm.write{
                sin.mx6 = 14
                sin.mx8 = 15
            }
            if(realm.objects(SongInfo.self).filter("series = 'Technika1'").count == 0) {
                SongInfo.add(Series.technika1, "Access", "Sphazer", "135", 2, 4, 7, 3, 6, 0, 3, 0, 12, 5, 7, 12)
                SongInfo.add(Series.technika1, "Area 7", "Sphazer", "130", 4, 0, 10, 4, 7, 10, 5, 7, 11, 4, 7, 12)
                SongInfo.add(Series.technika1, "Beyond the Future", "7 Sequence", "150", 4, 8, 11, 4, 8, 11, 4, 9, 12, 4, 9, 12)
                SongInfo.add(Series.technika1, "Dear my Lady", "Oriental ST8", "128", 5, 9, 0, 5, 7, 10, 5, 7, 11, 4, 7, 10)
                SongInfo.add(Series.technika1, "DJMAX", "Humming Urban Stereo", "128", 2, 7, 0, 3, 0, 8, 4, 8, 0, 4, 8, 0)
                SongInfo.add(Series.technika1, "Fury", "Sugardonut", "135", 4, 9, 11, 5, 8, 12, 5, 9, 12, 5, 10, 12)
                SongInfo.add(Series.technika1, "HEXAD", "Electronic Boutique", "135", 5, 10, 13, 5, 9, 12, 5, 9, 12, 6, 10, 13)
                SongInfo.add(Series.technika1, "Honeymoon", "Humming Urban Stereo", "150", 3, 5, 8, 4, 0, 8, 4, 8, 0, 3, 9, 0)
                SongInfo.add(Series.technika1, "I want You", "Lin-G", "140", 3, 6, 8, 3, 8, 10, 5, 8, 11, 4, 9, 11)
                SongInfo.add(Series.technika1, "Landscape", "Tsukasa", "140", 6, 9, 0, 6, 8, 11, 5, 9, 12, 7, 9, 13)
                SongInfo.add(Series.technika1, "Melody", "bermei.inazawa", "188", 5, 8, 11, 5, 8, 11, 4, 8, 12, 5, 10, 12)
                SongInfo.add(Series.technika1, "Play the Future", "Urbatronic Chopsticks", "128", 4, 9, 0, 4, 7, 10, 6, 10, 0, 5, 0, 10)
                SongInfo.add(Series.technika1, "Remember", "Lin-G", "150", 3, 8, 10, 4, 7, 10, 4, 7, 11, 5, 0, 11)
                SongInfo.add(Series.technika1, "Shoreline", "Oriental ST8", "135", 4, 8, 10, 6, 11, 0, 6, 11, 0, 6, 8, 12)
                SongInfo.add(Series.technika1, "SON OF SUN", "Hosoe Shinji", "200", 7, 9, 14, 7, 10, 14, 7, 11, 14, 7, 10, 15)
                SongInfo.add(Series.technika1, "SuperSonic", "Planetboom", "156", 4, 7, 11, 5, 8, 12, 6, 9, 12, 6, 10, 13)
                SongInfo.add(Series.technika1, "Sweet Shining Shooting Star", "Croove", "140", 3, 8, 10, 3, 6, 10, 6, 0, 10, 6, 0, 11)
                SongInfo.add(Series.technika1, "The Last Dance", "Urbatronic Chopsticks", "102", 4, 0, 8, 5, 11, 0, 5, 10, 0, 4, 0, 12)
                SongInfo.add(Series.technika1, "Thor", "XeoN", "147", 7, 11, 14, 6, 10, 14, 6, 11, 14, 7, 11, 14)
                SongInfo.add(Series.technika1, "Voyage", "makou", "125", 6, 9, 0, 5, 10, 0, 3, 9, 11, 5, 11, 0)
                
            }
            if(realm.objects(SongInfo.self).filter("title = 'Do you want it'").first == nil){
                SongInfo.add(Series.respect, "Do you want it", "House Rulez", "123", 5, 8, 0, 7, 9, 0, 5, 9, 0, 5, 11, 0)
            }
            if(realm.objects(SongInfo.self).filter("title = 'Only On'").first == nil){
                SongInfo.add(Series.respect, "Only On", "Dok2", "96", 2, 5, 0, 3, 6, 0, 2, 5, 0, 3, 5, 8)
            }
            //lowercase 만들어줌
            for result in realm.objects(SongInfo.self).filter("series = 'Technika1'") {
                try! realm.write{
                    result.lowercase = result.title.lowercased()
                }
            }
            let doyouwantit = realm.objects(SongInfo.self).filter("title = 'Do you want it'").first!
            try! realm.write{
                doyouwantit.lowercase = doyouwantit.title.lowercased()
            }
            let onlyon = realm.objects(SongInfo.self).filter("title = 'Only On'").first!
            try! realm.write{
                onlyon.lowercase = onlyon.title.lowercased()
            }
            //RecordInfo 초기화
            if(realm.objects(RecordInfo.self).filter("series = 'Technika1'").count == 0){
                let songInfo = realm.objects(SongInfo.self).filter("series = 'Technika1'")
                for result in songInfo{
                    RecordInfo.initialize(Series.technika1, result.title)
                    RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
                } 
            }
            if(realm.objects(RecordInfo.self).filter("title = 'Do you want it'").first == nil){
                RecordInfo.initialize(Series.respect, doyouwantit.title)
                RecordInfo.initializeDifficulty(doyouwantit.title, doyouwantit.nm4, doyouwantit.nm5, doyouwantit.nm6, doyouwantit.nm8, doyouwantit.hd4, doyouwantit.hd5, doyouwantit.hd6, doyouwantit.hd8, doyouwantit.mx4, doyouwantit.mx5, doyouwantit.mx6, doyouwantit.mx8)
            }
            if(realm.objects(RecordInfo.self).filter("title = 'Only On'").first == nil){
                RecordInfo.initialize(Series.respect, onlyon.title)
                RecordInfo.initializeDifficulty(onlyon.title, onlyon.nm4, onlyon.nm5, onlyon.nm6, onlyon.nm8, onlyon.hd4, onlyon.hd5, onlyon.hd6, onlyon.hd8, onlyon.mx4, onlyon.mx5, onlyon.mx6, onlyon.mx8)
            }
            for result in realm.objects(RecordInfo.self).filter("series = 'Technika1'"){
                try! realm.write{
                    result.lowercase = result.title.lowercased()
                }
            }
            let doyouwantitRecord = realm.objects(RecordInfo.self).filter("title = 'Do you want it'").first!
            let onlyonRecord = realm.objects(RecordInfo.self).filter("title = 'Only On'").first!
            try! realm.write{
                doyouwantitRecord.lowercase = doyouwantit.title.lowercased()
                onlyonRecord.lowercase = onlyon.title.lowercased()
            }
            if(realm.objects(MissionInfo.self).filter("type = 'Technika1'").count == 0){
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Idol Mania", "First Kiss", Difficulty.normal, Buttons.button4, "I want You", Difficulty.normal, Buttons.button4, "Ladymade Star", Difficulty.hard, Buttons.button4, 800000, 0, 0, 0, 0, "Fever-Manual", "Gallery : I want you (3)")
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Metro Drive", "Y (CE Style)", Difficulty.normal, Buttons.button6, "Melody", Difficulty.normal, Buttons.button6, "The Clear Blue Sky", Difficulty.normal, Buttons.button6, 0, 0, 4000, 93, 0, "Fever-Manual", "Plate : Honeymoon")
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Using Effect", "Play the Future", Difficulty.normal, Buttons.button5, "Beyond the Future", Difficulty.normal, Buttons.button5, "Do you want it", Difficulty.normal, Buttons.button5, 0, 0, 0, 0, 20, "Fever-OFF, FADER 2", "Plate : Shoreline")
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Mr.Perfect", "Remember", Difficulty.normal, Buttons.button4, 0, 0, 0, 100, 0, "Fever-OFF", "Plate : Remember")
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "High Technician", "CnP", Difficulty.maximum, Buttons.button5, "Dreadnought", Difficulty.maximum, Buttons.button4, "SIN", Difficulty.maximum, Buttons.button6, 990000, 5, 0, 0, 0, "Fever-Manual", "Gallery : EXTRA (9)")
                MissionInfo.add(Series.technika1, Mission.Technika1.platinumMixing, "Sound Storm", "Enemy Storm", Difficulty.maximum, Buttons.button4, "Brain Storm", Difficulty.maximum, Buttons.button5, "Thor", Difficulty.maximum, Buttons.button6, 0, 5, 3900, 95, 25, "Fever-Manual", "Gallery : Thor")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "First Step", "Dear my Lady", Difficulty.normal, Buttons.button4, "Honeymoon", Difficulty.hard, Buttons.button4, "DJMAX", Difficulty.hard, Buttons.button4, "??", Difficulty.special, Buttons.tb, 900000, 0, 0, 0, 0, "Fever-OFF", "Gallery : Honeymoon (3)")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Electro EP", "Access", Difficulty.hard, Buttons.button5, "Your Own Miracle", Difficulty.hard, Buttons.button5, "Area 7", Difficulty.hard, Buttons.button5, "??", Difficulty.special, Buttons.tb, 0, 0, 800, 0, 0, "Fever-OFF", "Plate : SuperSonic")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Core Sound", "Beyond the Future", Difficulty.hard, Buttons.button6, "Voyage", Difficulty.hard, Buttons.button6, "Landscape", Difficulty.hard, Buttons.button6, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 95, 0, "Fever-OFF", "Gallery : Voyage")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "HeartBeat", "Remember", Difficulty.maximum, Buttons.button5, "Play the Future", Difficulty.hard, Buttons.button5, "Melody", Difficulty.maximum, Buttons.button5, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 0, 15, "Fever-OFF", "Plate : Melody")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Customizer", "Sweet Shining Shooting Star", Difficulty.maximum, Buttons.button8, "Fury", Difficulty.maximum, Buttons.button8, "Y (CE Style)", Difficulty.maximum, Buttons.button8, "??", Difficulty.special, Buttons.tb, 1125000, 0, 1750, 98, 0, "Fever-OFF", "Gallery : EXTRA (10)")
                MissionInfo.add(Series.technika1, Mission.Technika1.technicalMixing, "Conqueror", "SON OF SUN", Difficulty.hard, Buttons.button4, "SuperSonic", Difficulty.maximum, Buttons.button5, "HEXAD", Difficulty.maximum, Buttons.button6, "!?", Difficulty.special, Buttons.tb, 1150000, 0, 1500, 98, 0, "Fever-OFF", "Plate : Thor")
            }
            if(realm.objects(TrophyInfo.self).filter("series = 'Technika1'").count == 0){
                TrophyInfo.add(Series.technika1, "플래티넘 크루", "TECHNIKA 곡을 모두 S랭크로 클리어했다.", "PLATINUM CREW", "Cleared all TECHNIKA songs in S rank.", TrophyGrade.silver)
                TrophyInfo.add(Series.technika1, "Rolling On the Screen", "Technical Mixing에서 할 수 있는 모든 패턴을 플레이했다.", "Rolling On the Screen", "Played all the patterns you can play in \"Technical Mixing\".", TrophyGrade.silver)
                TrophyInfo.add(Series.technika1, "테크니카의 10번째 생일을 축하해", "숨겨진 패턴을 MAX COMBO로 클리어했다.", "Happy 10th Birthday for TECHNIKA", "Cleared the hidden pattern in MAX COMBO", TrophyGrade.silver)
                TrophyInfo.add(Series.technika1, "First Step Set 졸업", "First Step 미션에서 플레이 할 수 있는 모든 곡을 클리어했다.", "First Step Set Complete", "Cleared all the songs in the First Step mission.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "ONLY FOR ARCADE", "ARCADE를 TECHNIKA 곡으로만 클리어했다.", "ONLY FOR ARCADE", "Cleared ARCADE mode only with TECHNIKA songs.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "Stylish eSper Shooting Sports", "COLLECTION 모드에서 SuperSonic의 뮤직 비디오를 감상했다.", "Stylish eSper Shooting Sports", "Watched a SuperSonic video in Collection.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "앗 깜짝이야", "Mr.Perfect 미션을 플레이했다.", "What a Surprise", "Played \"Mr.Perfect\" mission.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "너희집엔 이런거 없지?", "5가지의 TECHNIKA 전용 플레이트를 획득했다.", "I Bet You Don't Have This at Home", "Acquired 5 TECHNIKA Plates.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "댓글댓글단다 댓글댓글단다", "추장의 장비를 갖추고 SON OF SUN을 MAX COMBO로 클리어했다.", "SON OF SUN", "Cleared \"SON OF SUN\" in MAX COMBO with \"SON OF SUN\" GEAR and NOTE Skins.", TrophyGrade.bronze)
                TrophyInfo.add(Series.technika1, "암튼 레어 카드", "TECHNIKA 곡 중 숨겨진 BGA를 발견했다.", "Rare Card Anyways", "Found a Hidden BGA from a TECHNIKA Song.", TrophyGrade.bronze)
            }
            UserDefaults.standard.set(202, forKey: "version")
        }
        
        if(version <= 202){
            let songResults = realm.objects(SongInfo.self)
            let recordResults = realm.objects(RecordInfo.self)
            var title = "Chrono Breakers"
            var song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            var record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd8 = 12
                record.hd8 = 12
            }
            title = "Fever GJ"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx6 = 9
                record.mx6 = 9
            }
            title = "OBLIVION ~Rockin' Night Style~"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx8 = 13
                record.mx8 = 13
            }
            title = "Sunny Side"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.nm8 = 9
                record.nm8 = 9
            }
            title = "Another DAY"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd8 = 10
                record.hd8 = 10
            }
            title = "Brain Storm"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd4 = 11
                song.hd5 = 12
                record.hd4 = 11
                record.hd5 = 12
            }
            title = "For Seasons"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd8 = 10
                record.hd8 = 10
            }
            title = "Miles"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.nm4 = 4
                record.nm4 = 4
            }
            title = "NANO RISK"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.nm4 = 7
                record.nm4 = 7
            }
            title = "Right Now"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd8 = 9
                record.hd8 = 9
            }
            title = "Showtime"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd4 = 10
                record.hd4 = 10
            }
            title = "STALKER"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx8 = 15
                record.mx8 = 15
            }
            title = "Stay with me"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.nm8 = 7
                record.nm8 = 7
            }
            title = "SQUEEZE"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd5 = 11
                song.hd8 = 12
                record.hd5 = 11
                record.hd8 = 12
            }
            title = "Taekwonburi".localized
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx5 = 12
                record.mx5 = 12
            }
            title = "Bullet, Wanted!"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd8 = 11
                record.hd8 = 11
            }
            title = "Far East Princess"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd4 = 7
                song.mx6 = 10
                record.hd4 = 7
                record.mx6 = 10
            }
            title = "We're All Gonna Die"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.nm4 = 8
                record.nm4 = 8
            }
            title = "Freedom"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx8 = 10
                record.mx8 = 10
            }
            title = "Lover (CE Style)"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.hd5 = 10
                record.hd5 = 10
            }
            title = "Dear my Lady"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx6 = 11
                record.mx6 = 11
            }
            title = "SON OF SUN"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                song.mx4 = 14
                song.mx6 = 14
                record.mx4 = 14
                record.mx6 = 14
            }
            reloadSkillPoint(realm: realm)
            UserDefaults.standard.set(203, forKey: "version")
        }
        
        if(version <= 203){
            UserDefaults.standard.set(204, forKey: "version")
        }
        
        if(version <= 204) {
            var title = "c12Lover"
            let object = realm.objects(MissionInfo.self)
            var effector = object.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                effector.more = "Fever AUTO / CHAOS REVERSE"
            }
            title = "Max Boy"
            effector = object.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write{
                effector.more = "Speed : 1.50 / Fever-Manual / FADER PIXEL 2"
            }
            title = "Critical Period"
            effector = object.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                effector.more = "Fever OFF / FADER PIXEL 2"
            }
            title = "4DmaX"
            effector = object.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                effector.more = "Fever-OFF / CHAOS 4D"
            }
            title = "Heaven's Gate"
            effector = object.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                effector.more = "Fever-Manual / CHAOS REVERSE"
            }
            UserDefaults.standard.set(205, forKey: "version")
        }
        
        if version <= 205 {
            //블랙스퀘어 곡 추가, 성과공간
            if realm.objects(SongInfo.self).filter("series = 'BS'").count == 0 {
                SongInfo.add(Series.bs, "Proposed, Flower, Wolf part.2".localized, "ReX", "160", 3, 8, 0, 4, 10, 0, 4, 8, 11, 5, 10, 0)
                SongInfo.add(Series.bs, "Beat U Down", "makou", "155", 8, 12, 14, 8, 10, 14, 9, 12, 15, 8, 10, 14)
                SongInfo.add(Series.bs, "Colours of Sorrow", "Tsukasa", "143", 4, 0, 11, 6, 9, 12, 5, 9, 13, 6, 9, 13)
                SongInfo.add(Series.bs, "Cypher Gate", "7 Sequence", "150", 5, 8, 0, 7, 10, 0, 7, 10, 13, 7, 10, 13)
                SongInfo.add(Series.bs, "Desperado", "Croove", "130", 5, 9, 11, 7, 11, 0, 5, 8, 11, 7, 12, 0)
                SongInfo.add(Series.bs, "Fermion", "makou", "156", 8, 11, 14, 7, 9, 14, 8, 12, 14, 7, 10, 14)
                SongInfo.add(Series.bs, "Fever Pitch Girl", "Nikacha", "136", 5, 8, 0, 4, 7, 10, 6, 10, 0, 6, 11, 0)
                SongInfo.add(Series.bs, "Get Down", "BJJ", "111", 4, 7, 9, 4, 9, 0, 4, 7, 10, 5, 10, 0)
                SongInfo.add(Series.bs, "Grave Consequence", "Tsukasa", "180", 6, 10, 14, 6, 10, 13, 7, 12, 0, 7, 10, 14)
                SongInfo.add(Series.bs, "Heart of Witch", "ReX", "170", 7, 12, 14, 7, 11, 15, 7, 12, 14, 8, 12, 15)
                SongInfo.add(Series.bs, "In my Dream", "ND Lee", "140", 5, 10, 15, 8, 11, 13, 5, 11, 13, 8, 10, 14)
                SongInfo.add(Series.bs, "Jealousy", "3rd Coast", "125", 3, 7, 0, 3, 7, 9, 4, 0, 9, 3, 8, 10)
                SongInfo.add(Series.bs, "Keys to the World", "Planetboom", "160", 5, 8, 12, 6, 9, 13, 6, 11, 0, 6, 10, 13)
                SongInfo.add(Series.bs, "Lovely hands", "Planetboom", "132", 4, 0, 10, 5, 9, 11, 3, 10, 0, 6, 9, 11)
                SongInfo.add(Series.bs, "Lover (Series.bs Style)", "ND Lee", "145", 5, 7, 12, 5, 10, 0, 4, 8, 11, 5, 8, 10)
                SongInfo.add(Series.bs, "PDM", "Trish", "120", 3, 7, 10, 4, 7, 9, 3, 10, 0, 4, 9, 0)
                SongInfo.add(Series.bs, "Ready Now", "Ruby Tuesday", "135", 4, 8, 0, 4, 7, 9, 4, 7, 10, 5, 0, 9)
                SongInfo.add(Series.bs, "Ruti'n", "BEXTER", "120", 4, 10, 0, 5, 8, 11, 4, 9, 11, 5, 10, 0)
                SongInfo.add(Series.bs, "Secret World", "Sweetune", "110", 4, 7, 10, 3, 8, 0, 4, 7, 10, 4, 0, 9)
                SongInfo.add(Series.bs, "Y (BS Style)", "ND Lee", "130", 5, 8, 11, 4, 7, 0, 4, 8, 12, 4, 8, 11)
            }
            //리스펙트 곡 추가
            if realm.objects(SongInfo.self).filter("title = 'ANALYS'").count == 0 {
                SongInfo.add(Series.respect, "ANALYS", "HAYAKO", "170", 7, 11, 14, 7, 11, 0, 7, 11, 13, 8, 10, 14)
            }
            if realm.objects(SongInfo.self).filter("title = 'Always'").count == 0 {
                SongInfo.add(Series.respect, "Always", "YUGI / Mool", "135", 4, 7, 0, 6, 9, 0, 5, 10, 0, 6, 10, 0)
            }
            if realm.objects(SongInfo.self).filter("title = 'Fly Away'").count == 0 {
                SongInfo.add(Series.respect, "Fly Away", "Xeon", "140", 3, 10, 0, 6, 10, 0, 4, 0, 11, 6, 10, 0)
            }
            //링크디스크 곡 추가
            if realm.objects(SongInfo.self).filter("title = 'Here in the Moment ~Extended Mix~'").count == 0 {
                SongInfo.add(Series.ce, "Here in the Moment ~Extended Mix~", "Ruby Tuesday", "115", 4, 6, 9, 5, 8, 11, 6, 9, 12, 5, 8, 11)
            }
            if realm.objects(SongInfo.self).filter("title = 'Airwave ~Extended Mix~'").count == 0 {
                SongInfo.add(Series.bs, "Airwave ~Extended Mix~", "ReX", "150", 8, 10, 13, 7, 10, 14, 6, 12, 14, 7, 10, 13)
            }
            if realm.objects(SongInfo.self).filter("title = 'SON OF SUN ~Extended Mix~'").count == 0 {
                SongInfo.add(Series.technika1, "SON OF SUN ~Extended Mix~", "Hosoe Shinji", "200", 7, 10, 14, 7, 10, 15, 7, 11, 14, 8, 11, 15)
            }
            //RecordInfo 초기화
            if realm.objects(RecordInfo.self).filter("title = 'Here in the Moment ~Extended Mix~'").count == 0 {
                let result = realm.objects(SongInfo.self).filter("title = 'Here in the Moment ~Extended Mix~'").first!
                RecordInfo.initialize(Series.ce, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            if realm.objects(RecordInfo.self).filter("title = 'Airwave ~Extended Mix~'").count == 0 {
                let result = realm.objects(SongInfo.self).filter("title = 'Airwave ~Extended Mix~'").first!
                RecordInfo.initialize(Series.ce, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            if realm.objects(RecordInfo.self).filter("title = 'SON OF SUN ~Extended Mix~'").count == 0 {
                let result = realm.objects(SongInfo.self).filter("title = 'SON OF SUN ~Extended Mix~'").first!
                RecordInfo.initialize(Series.ce, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            if realm.objects(RecordInfo.self).filter("series = 'BS'").count == 0 {
                let songInfo = realm.objects(SongInfo.self).filter("series = 'BS'")
                for result in songInfo {
                    RecordInfo.initialize(Series.bs, result.title)
                    RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
                }
            }
            if realm.objects(RecordInfo.self).filter("title = 'ANALYS'").first == nil {
                let result = realm.objects(SongInfo.self).filter("title = 'ANALYS'").first!
                RecordInfo.initialize(Series.respect, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            if realm.objects(RecordInfo.self).filter("title = 'Always'").first == nil {
                let result = realm.objects(SongInfo.self).filter("title = 'Always'").first!
                RecordInfo.initialize(Series.respect, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            if realm.objects(RecordInfo.self).filter("title = 'Fly Away'").first == nil {
                let result = realm.objects(SongInfo.self).filter("title = 'Fly Away'").first!
                RecordInfo.initialize(Series.respect, result.title)
                RecordInfo.initializeDifficulty(result.title, result.nm4, result.nm5, result.nm6, result.nm8, result.hd4, result.hd5, result.hd6, result.hd8, result.mx4, result.mx5, result.mx6, result.mx8)
            }
            //블랙스퀘어 미션 추가
            if realm.objects(MissionInfo.self).filter("type = 'BS'").count == 0 {
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "NewB Crew", "Get Down", Difficulty.hard, Buttons.button4, "Proposed, Flower, Wolf part.2".localized, Difficulty.hard, Buttons.button4, 600000, 5, 0, 0, 0, "Fever-Manual", "")
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Downtown", "PDM", Difficulty.hard, Buttons.button5, "Jealousy", Difficulty.hard, Buttons.button5, "Secret World", Difficulty.hard, Buttons.button5, 0, 0, 0, 96, 0, "Fever-OFF / FADE OUT", "")
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "DnB Territory", "Ready Now", Difficulty.hard, Buttons.button6, "Ruti'n", Difficulty.hard, Buttons.button6, "Desperado", Difficulty.hard, Buttons.button6, 0, 4, 0, 0, 15, "Fever-Manual", "")
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Core System", "Lover (BS Style)", Difficulty.hard, Buttons.button5, "Y (BS Style)", Difficulty.hard, Buttons.button5, "Colours of Sorrow", Difficulty.hard, Buttons.button5, "Cypher Gate", Difficulty.hard, Buttons.button5, 1000000, 0, 1000, 0, 0, "Fever-OFF", "")
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Kingdom of Rock", "Lovely hands", Difficulty.hard, Buttons.button6, "Keys to the World", Difficulty.normal, Buttons.button8, "Fever Pitch Girl", Difficulty.hard, Buttons.button6, "Heart of Witch", Difficulty.normal, Buttons.button8, 0, 0, 6000, 94, 0, "Fever-Manual / FADER PIXEL", "")
                MissionInfo.add(Series.bs, Mission.BS.stylishPerformance, "Load of Flame", "Colours of Sorrow", Difficulty.normal, Buttons.button4, "Grave Consequence", Difficulty.normal, Buttons.button5, "Beat U Down", Difficulty.normal, Buttons.button4, "Fermion", Difficulty.normal, Buttons.button8, 0, 0, 0, 80, 0, "Fever-OFF / CHAOS 4D", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "BLACK CUBE", "Get Down", Difficulty.fx, Buttons.button5, 0, 0, 450, 0, 0, "Fever-OFF", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "RD Colosseum", "Honeymoon", Difficulty.redesign, Buttons.button4, "Taekwonburi".localized, Difficulty.redesign, Buttons.button5, "I want You", Difficulty.redesign, Buttons.button6, "Cypher Gate", Difficulty.redesign, Buttons.button8, 0, 5, 0, 0, 0, "Fever-Manual", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "BS 24", "Always", Difficulty.hard, Buttons.button4, "Fly Away", Difficulty.special, Buttons.xb, "ANALYS", Difficulty.hard, Buttons.button6, 985000, 0, 6500, 0, 0, "Fever-Manual", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Quatrr4", "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.hard, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button4, "RANDOM", Difficulty.maximum, Buttons.button4, 0, 0, 0, 0, 0, "Fever-OFF / vs AI", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Metro Project vol.2", "HEXAD", Difficulty.fx, Buttons.button5, "SuperSonic", Difficulty.fx, Buttons.button5, "Cypher Gate", Difficulty.fx, Buttons.button5, "In my Dream", Difficulty.fx, Buttons.button5, 1230000, 0, 0, 95, 0, "Fever-Auto", "")
                MissionInfo.add(Series.bs, Mission.BS.absoluteSound, "Illusion", "Nevermind", Difficulty.hard, Buttons.button4, "Rising The Sonic", Difficulty.hard, Buttons.button5, "Do you want it", Difficulty.hard, Buttons.button6, "ANALYS", Difficulty.hard, Buttons.button8, 0, 0, 0, 0, 0, "Fever-Auto / FADER PIXEL / vs AI", "")
            }
            //링크 디스크 미션 추가
            if realm.objects(MissionInfo.self).filter("type = 'Link Disk'").count == 0 {
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "The Others", "BlythE", Difficulty.hard, Buttons.button4, "Triple Zoe", Difficulty.hard, Buttons.button6, "NB RANGER", Difficulty.maximum, Buttons.button6, "SIN ~The Last Scene~", Difficulty.hard, Buttons.button8, 0, 0, 1500, 97, 20, "Fever-OFF", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "Just 1%", "MASAI", Difficulty.maximum, Buttons.button5, "NB POWER", Difficulty.maximum, Buttons.button5, "Showtime", Difficulty.hard, Buttons.button5, "Rolling On the Duck", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 0, "Fever-OFF / Don't make the MAX 1%", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "The Boss", "Ventilator", Difficulty.hard, Buttons.button8, "Mind Control", Difficulty.hard, Buttons.button8, "HAMSIN", Difficulty.hard, Buttons.button8, "Taekwonburi".localized, Difficulty.maximum, Buttons.button8, "Nevermind", Difficulty.hard, Buttons.button8, "Nightmare", Difficulty.maximum, Buttons.button8, 0, 0, 15100, 96, 0, "Fever-Manual", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "ENVY vs NB", "DARK ENVY", Difficulty.maximum, Buttons.button5, "NB RANGER - Virgin Force", Difficulty.maximum, Buttons.button5, 0, 0, 0, 90, 0, "Fever-OFF / CHAOS REVERSE", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "Challenger", "PDM", Difficulty.maximum, Buttons.button5, "A.I", Difficulty.hard, Buttons.button8, "Proposed, Flower, Wolf part.2".localized, Difficulty.maximum, Buttons.button6, "??", Difficulty.special, Buttons.tb, 0, 0, 0, 99, 5, "Fever-OFF", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.whiteDisk, "MX Tournament", "ANALYS", Difficulty.maximum, Buttons.button4, "Grave Consequence", Difficulty.maximum, Buttons.button5, "Heart of Witch", Difficulty.maximum, Buttons.button6, "Beat U Down", Difficulty.maximum, Buttons.button8, 0, 0, 0, 0, 0, "Fever-OFF / vs AI", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Ending Scroll", "Proposed, Flower, Wolf".localized, Difficulty.hard, Buttons.button4, "Proposed, Flower, Wolf part.2".localized, Difficulty.normal, Buttons.button6, 0, 0, 0, 100, 0, "Fever-OFF", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Vitalize", "Ladymade Star", Difficulty.maximum, Buttons.button4, "Royal Clown", Difficulty.maximum, Buttons.button8, "Memory of Beach", Difficulty.hard, Buttons.button5, "quixotic", Difficulty.maximum, Buttons.button8, 1230000, 0, 0, 0, 0, "Fever-Manual", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "SPEED STAR", "Fentanest", Difficulty.hard, Buttons.button6, "STOP", Difficulty.maximum, Buttons.button5, "KILLER BEE", Difficulty.maximum, Buttons.button6, "Negative Nature", Difficulty.hard, Buttons.button6, "Royal Clown", Difficulty.maximum, Buttons.button8, 0, 5, 0, 98, 0, "SPEED 2.00 / Fever-Manual", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Infinity Combo", "NB POWER", Difficulty.maximum, Buttons.button6, "WhiteBlue", Difficulty.maximum, Buttons.button6, "RED", Difficulty.maximum, Buttons.button6, "Sunny Side ~Deepn' Soul Mix~", Difficulty.maximum, Buttons.button6, "Showtime", Difficulty.hard, Buttons.button6, "Mind Control", Difficulty.maximum, Buttons.button6, 0, 0, 38888, 0, 0, "Fever-Auto / FADER FOG", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "End of Metro Project", "In my Dream", Difficulty.special, Buttons.xb, "Beat U Down", Difficulty.special, Buttons.xb, "Grave Consequence", Difficulty.special, Buttons.xb, "Heart of Witch", Difficulty.special, Buttons.xb, "Fermion", Difficulty.special, Buttons.xb, 1600000, 5, 5000, 0, 0, "Fever-Manual", "")
                MissionInfo.add(Series.linkDisk, Mission.LinkDisk.blackDisk, "Enter the Rocky Studio", "BlackCat", Difficulty.hard, Buttons.button8, "ANALYS", Difficulty.maximum, Buttons.button8, "Cypher Gate", Difficulty.redesign, Buttons.button8, "STALKER", Difficulty.fx, Buttons.button4, "Ventilator", Difficulty.fx, Buttons.button5, "We're All Gonna Die", Difficulty.special, Buttons.xb, 2000000, 5, 10000, 97, 50, "Fever-Manual", "")
            }
            //블랙스퀘어 트로피 추가
            if realm.objects(TrophyInfo.self).filter("series = 'BS'").count == 0 {
                TrophyInfo.add(Series.bs, "BLACK SQUARE에 도전하시겠습니까?", "BLACK SQUARE 곡에서 100개의 패턴을 MAX COMBO로 클리어했다.", "Do you want to try BLACK SQUARE?", "Cleared a 100 pattern BLACK SQUARE song with MAX COMBO", TrophyGrade.gold)
                TrophyInfo.add(Series.bs, "다시 한번 클럽 투어에 오신것을 환영합니다", "BLACK SQUARE 곡을 모두 S랭크로 클리어했다.", "Welcome back to the CLUB TOUR!", "Cleared all the BLACK SQUARE songs with S Rank.", TrophyGrade.silver)
                TrophyInfo.add(Series.bs, "Fermion으로 하겠어요", "Fermion 기어와 노트를 장착한 상태로 Fermion을 플레이했다.", "I'll go with Fermion", "Played \"Fermion\" using \"Fermion\" GEAR and NOTE Skins.", TrophyGrade.bronze)
                TrophyInfo.add(Series.bs, "REDESIGN?!", "RD Colosseum 미션을 클리어했다.", "REDESIGN?!", "Cleared the \"RD Colosseum\" mission.", TrophyGrade.bronze)
                TrophyInfo.add(Series.bs, "DJMAX 시리즈 중에서 최강 난이도", "BLACK SQUARE 곡에서 MAXIMUM 패턴을 MAX COMBO로 클리어했다.", "The toughest difficulty in the DJMAX series", "Cleared a BLACK SQUARE song at MAXIMUM difficulty level with MAX COMBO.", TrophyGrade.bronze)
                TrophyInfo.add(Series.bs, "정말 BLACK SQUARE 곡으로 할거야?", "ARCADE를 BLACK SQUARE 곡으로만 클리어했다.", "Are you sure you want a BLACK SQUARE song?", "Cleared ARCADE mode only with BLACK SQUARE songs.", TrophyGrade.bronze)
                TrophyInfo.add(Series.bs, "빨리 틀어요", "BLACK SQUARE 수록곡 중 한 곡을 연속으로 10회 클리어했다.", "Play it NOW!", "Cleared a BLACK SQUARE song 10 times in a row.", TrophyGrade.bronze)
            }
            //링크디스크 트로피 추가
            if realm.objects(TrophyInfo.self).filter("series = 'Link Disk'").count == 0 {
                TrophyInfo.add(Series.linkDisk, "디스크 조각", "링크 디스크를 통해 획득할 수 있는 모든 곡을 MAX COMBO로 클리어했다.", "Disk Fragment", "Cleared all songs you can obtain through LINK DISK with MAX COMBO.", TrophyGrade.bronze)
                TrophyInfo.add(Series.linkDisk, "이제 최종 단계에 들어선거야", "The Others를 클리어했다.", "We're in the endgame now", "Cleared \"The Others\" mission.", TrophyGrade.bronze)
                TrophyInfo.add(Series.linkDisk, "디맥은 돌아온다", "METRO PROJECT 플레이트를 장착했다.", "DJMAX will Return", "Equipped \"METRO PROJECT\" plate.", TrophyGrade.bronze)
            }
            //패턴 추가
            let songResults = realm.objects(SongInfo.self).sorted(byKeyPath: "title")
            let recordResults = realm.objects(RecordInfo.self).sorted(byKeyPath: "title")
            var title = "Eternal Memory".localized
            var song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            var record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.hd5 = 8
                record.hd5 = 8
            }
            title = "Funky Chups"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.hd4 = 8
                record.hd4 = 8
            }
            title = "Ladymade Star"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx4 = 10
                record.mx4 = 10
            }
            title = "MASAI"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx4 = 11
                song.mx5 = 12
                record.mx4 = 11
                record.mx5 = 12
            }
            title = "Memory of Beach"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.hd4 = 11
                song.hd5 = 12
                song.mx8 = 13
                record.hd4 = 11
                record.hd5 = 12
                record.mx8 = 13
            }
            title = "quixotic"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx8 = 13
                record.mx8 = 13
            }
            title = "Rocka-a-doodle-doo"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx8 = 12
                record.mx8 = 12
            }
            title = "Royal Clown"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx4 = 14
                song.mx8 = 14
                record.mx4 = 14
                record.mx8 = 14
            }
            title = "Sunny Side ~Deepn' Soul Mix~"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            record = recordResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.hd5 = 11
                record.hd5 = 11
            }
            //SIN 예전에 패턴 추가할 때 song에는 추가 안해서 추가 해줘야함
            title = "SIN"
            song = songResults.filter(NSPredicate(format: "title = %@", title)).first!
            try! realm.write {
                song.mx6 = 14
                song.mx8 = 15
            }
            //lowercase 초기화
            for index in 0..<songResults.count {
                let title = songResults[index].title.lowercased()
                try! realm.write {
                    songResults[index].lowercase = title
                    recordResults[index].lowercase = title
                }
            }
            //1. 모든 곡에 그냥 lowercase 처리
            //2. 한국일 경우 한국 이름 곡 개수 세서(12개) 글자 순서대로 숫자로 lowercase 임의 처리
            if Locale.current.regionCode! == "KR" {
                let songInfo = realm.objects(SongInfo.self).sorted(byKeyPath: "title")
                let recordInfo = realm.objects(RecordInfo.self).sorted(byKeyPath: "title")
                var count = 0
                for index in songInfo.count - 12  ..< songInfo.count {
                    try! realm.write {
                        if count < 10 {
                            songInfo[index].lowercase = "00\(count)"
                            recordInfo[index].lowercase = "00\(count)"
                        } else {
                            songInfo[index].lowercase = "0\(count)"
                            recordInfo[index].lowercase = "0\(count)"
                        }
                    }
                    count += 1
                }
            }
            UserDefaults.standard.set(206, forKey: "version")
        }
        
        if version <= 206 {
            let bs = realm.objects(MissionInfo.self).filter("type = 'BS'")
            try! realm.write {
                for index in 0..<bs.count {
                    switch index {
                    case 0:
                        bs[index].reward = "Gallery : " + "Proposed, Flower, Wolf part.2".localized + " (3)"
                    case 1:
                        bs[index].reward = "Gallery : Jealousy"
                    case 2:
                        bs[index].reward = "Gallery : Ready Now (3)"
                    case 3:
                        bs[index].reward = "Plate : Get Down"
                    case 4:
                        bs[index].reward = "Plate : Fever Pitch Girl"
                    case 5:
                        bs[index].reward = "Plate : Clear (Get Down ver.)"
                    case 6:
                        bs[index].reward = "Plate : In my Dream"
                    case 7:
                        bs[index].reward = "MV : Glory Day (MUCA Live ver.)"
                    case 8:
                        bs[index].reward = "Gallery : EXTRA (11)"
                    case 9:
                        bs[index].reward = "Gallery : Heart of Witch (4)"
                    case 10:
                        bs[index].reward = "Plate : Fermion"
                    case 11:
                        bs[index].reward = "Plate : Heart of Witch"
                    default:
                        break
                    }
                }
            }
            var title = "Jealousy"
            var song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            var record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.hd6 = 0
                song.mx6 = 9
                record.hd6 = 0
                record.mx6 = 9
            }
            title = "ANALYS"
            song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.mx6 = 14
                record.mx6 = 14
                song.hd8 = 11
                record.hd8 = 11
            }
            title = "In my Dream"
            song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.mx4 = 14
                record.mx4 = 14
            }
            title = "Beat U Down"
            song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.mx6 = 14
                record.mx6 = 14
            }
            title = "Colours of Sorrow"
            song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.mx6 = 12
                record.mx6 = 12
            }
            title = "Jealousy"
            song = realm.objects(SongInfo.self).filter("title = '\(title)'").first!
            record = realm.objects(RecordInfo.self).filter("title = '\(title)'").first!
            try! realm.write {
                song.mx8 = 9
                record.mx8 = 9
            }
            reloadSkillPoint(realm: realm)
            UserDefaults.standard.set(207, forKey: "version")
        }
        if version <= 207 {
            //바람에게 부탁해 Live 업데이트
            let title = "Ask to Wind ~Live Mix~".localized
            if realm.objects(SongInfo.self).filter("title = '\(title)'").isEmpty {
                SongInfo.add(Series.portable1, "Ask to Wind ~Live Mix~".localized, "Forte Escape", "210", 5, 0, 12, 6, 10, 0, 7, 11, 0, 7, 0, 13)
            }
            RecordInfo.initialize(Series.portable1, "Ask to Wind ~Live Mix~".localized)
            RecordInfo.initializeDifficulty("Ask to Wind ~Live Mix~".localized, 5, 6, 7, 7, 0, 10, 11, 0, 12, 0, 0, 13)
            //lowercase 초기화
            let songResults = realm.objects(SongInfo.self)
            let recordResults = realm.objects(RecordInfo.self)
            for index in 0..<songResults.count {
                let title = songResults[index].title.lowercased()
                try! realm.write {
                    songResults[index].lowercase = title
                    recordResults[index].lowercase = title
                }
            }
            //1. 모든 곡에 그냥 lowercase 처리
            //2. 한국일 경우 한국 이름 곡 개수 세서(13개) 글자 순서대로 숫자로 lowercase 임의 처리
            if Locale.current.regionCode! == "KR" {
                let songInfo = realm.objects(SongInfo.self).sorted(byKeyPath: "title")
                let recordInfo = realm.objects(RecordInfo.self).sorted(byKeyPath: "title")
                var count = 0
                for index in songInfo.count - 13  ..< songInfo.count {
                    try! realm.write {
                        if count < 10 {
                            songInfo[index].lowercase = "00\(count)"
                            recordInfo[index].lowercase = "00\(count)"
                        } else {
                            songInfo[index].lowercase = "0\(count)"
                            recordInfo[index].lowercase = "0\(count)"
                        }
                    }
                    count += 1
                }
            }
            
            UserDefaults.standard.set(208, forKey: "version")
        }
        print("DATABASE INITIALIZE FINISHED!!")
    }
}
