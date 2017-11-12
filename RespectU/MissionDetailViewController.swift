//
//  MissionDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 11..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import NotificationBannerSwift

class MissionDetailViewController: UIViewController {

    var realm: Realm? = nil
    //var results: Results<SongInfo>? = nil
    var section: String=""
    var titleDetail: String=""
    var more: String=""
    var scoreLimit: Int=0
    var feverLimit: Int=0
    var comboLimit: Int=0
    var rateLimit: Int=0
    var breakLimit: Int=0
    var song1key: String=""
    var song1level: String=""
    var song1title: String=""
    var song2key: String=""
    var song2level: String=""
    var song2title: String=""
    var song3key: String=""
    var song3level: String=""
    var song3title: String=""
    var song4key: String=""
    var song4level: String=""
    var song4title: String=""
    var song5key: String=""
    var song5level: String=""
    var song5title: String=""
    var song6key: String=""
    var song6level: String=""
    var song6title: String=""
    var reward: String=""
    
    var song1Bpm=""
    var song1Difficulty=""
    var song2Bpm=""
    var song2Difficulty=""
    var song3Bpm=""
    var song3Difficulty=""
    var song4Bpm=""
    var song4Difficulty=""
    var song5Bpm=""
    var song5Difficulty=""
    var song6Bpm=""
    var song6Difficulty=""
    let standardBpm=UserDefaults.standard.double(forKey: "bpm")
    
    @IBOutlet weak var song1Button: UIButton!
    @IBOutlet weak var song2Button: UIButton!
    @IBOutlet weak var song3Button: UIButton!
    @IBOutlet weak var song4Button: UIButton!
    @IBOutlet weak var song5Button: UIButton!
    @IBOutlet weak var song6Button: UIButton!
    
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelMore: UILabel!
    @IBOutlet weak var labelScoreLimit: UILabel!
    @IBOutlet weak var labelFeverLimit: UILabel!
    @IBOutlet weak var labelComboLimit: UILabel!
    @IBOutlet weak var labelRateLimit: UILabel!
    @IBOutlet weak var labelBreakLimit: UILabel!
    @IBOutlet weak var labelSong1key: UILabel!
    @IBOutlet weak var labelSong1level: UILabel!
    @IBOutlet weak var labelSong1title: UILabel!
    @IBOutlet weak var labelSong2key: UILabel!
    @IBOutlet weak var labelSong2level: UILabel!
    @IBOutlet weak var labelSong2title: UILabel!
    @IBOutlet weak var labelSong3key: UILabel!
    @IBOutlet weak var labelSong3level: UILabel!
    @IBOutlet weak var labelSong3title: UILabel!
    @IBOutlet weak var labelSong4key: UILabel!
    @IBOutlet weak var labelSong4level: UILabel!
    @IBOutlet weak var labelSong4title: UILabel!
    @IBOutlet weak var labelSong5key: UILabel!
    @IBOutlet weak var labelSong5level: UILabel!
    @IBOutlet weak var labelSong5title: UILabel!
    @IBOutlet weak var labelSong6key: UILabel!
    @IBOutlet weak var labelSong6level: UILabel!
    @IBOutlet weak var labelSong6title: UILabel!
    @IBOutlet weak var labelReward: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        //results = try! Realm().objects(SongInfo.self)
        
        self.navigationItem.title = section
        labelTitle.text=titleDetail
        labelMore.text=more.localized
        labelScoreLimit.text=scoreLimit==0 ? "-" : String(scoreLimit)
        labelFeverLimit.text=feverLimit==0 ? "-" : "X"+String(feverLimit)
        labelComboLimit.text=comboLimit==0 ? "-" : String(comboLimit)
        labelRateLimit.text=rateLimit==0 ? "-" : String(rateLimit)+"%"
        labelBreakLimit.text=breakLimit==0 ? "-" : String(breakLimit)
        labelSong1key.text=song1key
        labelSong1level.text=song1level
        labelSong1title.text=song1title
        labelSong2key.text=song2key
        labelSong2level.text=song2level
        labelSong2title.text=song2title
        labelSong3key.text=song3key
        labelSong3level.text=song3level
        labelSong3title.text=song3title
        labelSong4key.text=song4key
        labelSong4level.text=song4level
        labelSong4title.text=song4title
        labelSong5key.text=song5key
        labelSong5level.text=song5level
        labelSong5title.text=song5title
        labelSong6key.text=song6key
        labelSong6level.text=song6level
        labelSong6title.text=song6title
        labelReward.text=reward.localized
        
        if(song1title != "" && song1title != "RANDOM"){
            song1Button.isHidden=false
            let song1Query=NSPredicate(format: "title = %@",song1title)
            let song1Object=realm!.objects(SongInfo.self).filter(song1Query)[0]
            song1Bpm=song1Object.bpm
            if(song1key == "4B"){
                if(song1level == "NORMAL"){
                    song1Difficulty=String(song1Object.nm4)
                }
                else if(song1level == "HARD"){
                    song1Difficulty=String(song1Object.hd4)
                }
                else if(song1level == "MAXIMUM"){
                    song1Difficulty=String(song1Object.mx4)
                }
            }
            else if(song1key == "5B"){
                if(song1level == "NORMAL"){
                    song1Difficulty=String(song1Object.nm5)
                }
                else if(song1level == "HARD"){
                    song1Difficulty=String(song1Object.hd5)
                }
                else if(song1level == "MAXIMUM"){
                    song1Difficulty=String(song1Object.mx5)
                }
            }
            else if(song1key == "6B"){
                if(song1level == "NORMAL"){
                    song1Difficulty=String(song1Object.nm6)
                }
                else if(song1level == "HARD"){
                    song1Difficulty=String(song1Object.hd6)
                }
                else if(song1level == "MAXIMUM"){
                    song1Difficulty=String(song1Object.mx6)
                }
            }
            else if(song1key == "8B"){
                if(song1level == "NORMAL"){
                    song1Difficulty=String(song1Object.nm8)
                }
                else if(song1level == "HARD"){
                    song1Difficulty=String(song1Object.hd8)
                }
                else if(song1level == "MAXIMUM"){
                    song1Difficulty=String(song1Object.mx8)
                }
            }
            else if(song1key == "XB"){
                song1Difficulty="??"
            }
        }
        else if(song1title == "RANDOM"){
            song1Bpm="??"
            song1Difficulty="??"
        }
        if(song2title != "" && song2title != "RANDOM"){
            song2Button.isHidden=false
            let song2Query=NSPredicate(format: "title = %@",song2title)
            let song2Object=realm!.objects(SongInfo.self).filter(song2Query)[0]
            song2Bpm=song2Object.bpm
            if(song2key == "4B"){
                if(song2level == "NORMAL"){
                    song2Difficulty=String(song2Object.nm4)
                }
                else if(song2level == "HARD"){
                    song2Difficulty=String(song2Object.hd4)
                }
                else if(song2level == "MAXIMUM"){
                    song2Difficulty=String(song2Object.mx4)
                }
            }
            else if(song2key == "5B"){
                if(song2level == "NORMAL"){
                    song2Difficulty=String(song2Object.nm5)
                }
                else if(song2level == "HARD"){
                    song2Difficulty=String(song2Object.hd5)
                }
                else if(song2level == "MAXIMUM"){
                    song2Difficulty=String(song2Object.mx5)
                }
            }
            else if(song2key == "6B"){
                if(song2level == "NORMAL"){
                    song2Difficulty=String(song2Object.nm6)
                }
                else if(song2level == "HARD"){
                    song2Difficulty=String(song2Object.hd6)
                }
                else if(song2level == "MAXIMUM"){
                    song2Difficulty=String(song2Object.mx6)
                }
            }
            else if(song2key == "8B"){
                if(song2level == "NORMAL"){
                    song2Difficulty=String(song2Object.nm8)
                }
                else if(song2level == "HARD"){
                    song2Difficulty=String(song2Object.hd8)
                }
                else if(song2level == "MAXIMUM"){
                    song2Difficulty=String(song2Object.mx8)
                }
            }
            else if(song2key == "XB"){
                song2Difficulty="??"
            }
        }
        else if(song2title == "RANDOM"){
            song2Bpm="??"
            song2Difficulty="??"
        }
        if(song3title != "" && song3title != "RANDOM"){
            song3Button.isHidden=false
            let song3Query=NSPredicate(format: "title = %@",song3title)
            let song3Object=realm!.objects(SongInfo.self).filter(song3Query)[0]
            song3Bpm=song3Object.bpm
            if(song3key == "4B"){
                if(song3level == "NORMAL"){
                    song3Difficulty=String(song3Object.nm4)
                }
                else if(song3level == "HARD"){
                    song3Difficulty=String(song3Object.hd4)
                }
                else if(song3level == "MAXIMUM"){
                    song3Difficulty=String(song3Object.mx4)
                }
            }
            else if(song3key == "5B"){
                if(song3level == "NORMAL"){
                    song3Difficulty=String(song3Object.nm5)
                }
                else if(song3level == "HARD"){
                    song3Difficulty=String(song3Object.hd5)
                }
                else if(song3level == "MAXIMUM"){
                    song3Difficulty=String(song3Object.mx5)
                }
            }
            else if(song3key == "6B"){
                if(song3level == "NORMAL"){
                    song3Difficulty=String(song3Object.nm6)
                }
                else if(song3level == "HARD"){
                    song3Difficulty=String(song3Object.hd6)
                }
                else if(song3level == "MAXIMUM"){
                    song3Difficulty=String(song3Object.mx6)
                }
            }
            else if(song3key == "8B"){
                if(song3level == "NORMAL"){
                    song3Difficulty=String(song3Object.nm8)
                }
                else if(song3level == "HARD"){
                    song3Difficulty=String(song3Object.hd8)
                }
                else if(song3level == "MAXIMUM"){
                    song3Difficulty=String(song3Object.mx8)
                }
            }
            else if(song3key == "XB"){
                song3Difficulty="??"
            }
        }
        else if(song3title == "RANDOM"){
            song3Bpm="??"
            song3Difficulty="??"
        }
        if(song4title != "" && song4title != "RANDOM"){
            song4Button.isHidden=false
            let song4Query=NSPredicate(format: "title = %@",song4title)
            let song4Object=realm!.objects(SongInfo.self).filter(song4Query)[0]
            song4Bpm=song4Object.bpm
            if(song4key == "4B"){
                if(song4level == "NORMAL"){
                    song4Difficulty=String(song4Object.nm4)
                }
                else if(song4level == "HARD"){
                    song4Difficulty=String(song4Object.hd4)
                }
                else if(song4level == "MAXIMUM"){
                    song4Difficulty=String(song4Object.mx4)
                }
            }
            else if(song4key == "5B"){
                if(song4level == "NORMAL"){
                    song4Difficulty=String(song4Object.nm5)
                }
                else if(song4level == "HARD"){
                    song4Difficulty=String(song4Object.hd5)
                }
                else if(song4level == "MAXIMUM"){
                    song4Difficulty=String(song4Object.mx5)
                }
            }
            else if(song4key == "6B"){
                if(song4level == "NORMAL"){
                    song4Difficulty=String(song4Object.nm6)
                }
                else if(song4level == "HARD"){
                    song4Difficulty=String(song4Object.hd6)
                }
                else if(song4level == "MAXIMUM"){
                    song4Difficulty=String(song4Object.mx6)
                }
            }
            else if(song4key == "8B"){
                if(song4level == "NORMAL"){
                    song4Difficulty=String(song4Object.nm8)
                }
                else if(song4level == "HARD"){
                    song4Difficulty=String(song4Object.hd8)
                }
                else if(song4level == "MAXIMUM"){
                    song4Difficulty=String(song4Object.mx8)
                }
            }
            else if(song4key == "XB"){
                song4Difficulty="??"
            }
        }
        else if(song4title == "RANDOM"){
            song4Bpm="??"
            song4Difficulty="??"
        }
        if(song5title != "" && song5title != "RANDOM"){
            song5Button.isHidden=false
            let song5Query=NSPredicate(format: "title = %@",song5title)
            let song5Object=realm!.objects(SongInfo.self).filter(song5Query)[0]
            song5Bpm=song5Object.bpm
            if(song5key == "4B"){
                if(song5level == "NORMAL"){
                    song5Difficulty=String(song5Object.nm4)
                }
                else if(song5level == "HARD"){
                    song5Difficulty=String(song5Object.hd4)
                }
                else if(song5level == "MAXIMUM"){
                    song5Difficulty=String(song5Object.mx4)
                }
            }
            else if(song5key == "5B"){
                if(song5level == "NORMAL"){
                    song5Difficulty=String(song5Object.nm5)
                }
                else if(song5level == "HARD"){
                    song5Difficulty=String(song5Object.hd5)
                }
                else if(song5level == "MAXIMUM"){
                    song5Difficulty=String(song5Object.mx5)
                }
            }
            else if(song5key == "6B"){
                if(song5level == "NORMAL"){
                    song5Difficulty=String(song5Object.nm6)
                }
                else if(song5level == "HARD"){
                    song5Difficulty=String(song5Object.hd6)
                }
                else if(song5level == "MAXIMUM"){
                    song5Difficulty=String(song5Object.mx6)
                }
            }
            else if(song5key == "8B"){
                if(song5level == "NORMAL"){
                    song5Difficulty=String(song5Object.nm8)
                }
                else if(song5level == "HARD"){
                    song5Difficulty=String(song5Object.hd8)
                }
                else if(song5level == "MAXIMUM"){
                    song5Difficulty=String(song5Object.mx8)
                }
            }
            else if(song5key == "XB"){
                song5Difficulty="??"
            }
        }
        else if(song5title == "RANDOM"){
            song5Bpm="??"
            song5Difficulty="??"
        }
        if(song6title != "" && song6title != "RANDOM"){
            song6Button.isHidden=false
            let song6Query=NSPredicate(format: "title = %@",song6title)
            let song6Object=realm!.objects(SongInfo.self).filter(song6Query)[0]
            song6Bpm=song6Object.bpm
            if(song6key == "4B"){
                if(song6level == "NORMAL"){
                    song6Difficulty=String(song6Object.nm4)
                }
                else if(song6level == "HARD"){
                    song6Difficulty=String(song6Object.hd4)
                }
                else if(song6level == "MAXIMUM"){
                    song6Difficulty=String(song6Object.mx4)
                }
            }
            else if(song6key == "5B"){
                if(song6level == "NORMAL"){
                    song6Difficulty=String(song6Object.nm5)
                }
                else if(song6level == "HARD"){
                    song6Difficulty=String(song6Object.hd5)
                }
                else if(song6level == "MAXIMUM"){
                    song6Difficulty=String(song6Object.mx5)
                }
            }
            else if(song6key == "6B"){
                if(song6level == "NORMAL"){
                    song6Difficulty=String(song6Object.nm6)
                }
                else if(song6level == "HARD"){
                    song6Difficulty=String(song6Object.hd6)
                }
                else if(song6level == "MAXIMUM"){
                    song6Difficulty=String(song6Object.mx6)
                }
            }
            else if(song6key == "8B"){
                if(song6level == "NORMAL"){
                    song6Difficulty=String(song6Object.nm8)
                }
                else if(song6level == "HARD"){
                    song6Difficulty=String(song6Object.hd8)
                }
                else if(song6level == "MAXIMUM"){
                    song6Difficulty=String(song6Object.mx8)
                }
            }
            else if(song6key == "XB"){
                song6Difficulty="??"
            }
        }
        else if(song6title == "RANDOM"){
            song6Bpm="??"
            song6Difficulty="??"
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isNight=UserDefaults.standard.bool(forKey: "night")
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        labelTitle.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelMore.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelScoreLimit.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFeverLimit.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelComboLimit.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelRateLimit.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelBreakLimit.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong1title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong1level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong1key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong2title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong2level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong2key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong3title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong3level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong3key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong4title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong4level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong4key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong5title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong5level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong5key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong6title.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong6level.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong6key.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelReward.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        reloadInputViews()
        
        
    }
    
    @IBAction func song1More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song1Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song1Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song1Difficulty)
        let alert=UIAlertController(title: song1title, message: "\(song1key) \(song1level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func song2More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song2Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song2Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song2Difficulty)
        let alert=UIAlertController(title: song2title, message: "\(song2key) \(song2level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func song3More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song3Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song3Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song3Difficulty)
        let alert=UIAlertController(title: song3title, message: "\(song3key) \(song3level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func song4More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song4Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song4Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song4Difficulty)
        let alert=UIAlertController(title: song4title, message: "\(song4key) \(song4level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func song5More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song5Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song5Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song5Difficulty)
        let alert=UIAlertController(title: song5title, message: "\(song5key) \(song5level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    @IBAction func song6More(_ sender: UIButton) {
        var recommend=""
        if let tempSpeed=Double(song6Bpm){
            recommend=decideSpeed(speed: standardBpm/tempSpeed)
        }
        else{
            var strArr=song6Bpm.split(separator: "~")
            let change=Double(strArr[1].trimmingCharacters(in: .whitespaces))!
            recommend=decideSpeed(speed: standardBpm/change)+"\n"+"(SPEED Variation)".localized
        }
        let char=getDifficulty(difficulty: song6Difficulty)
        let alert=UIAlertController(title: song6title, message: "\(song6key) \(song6level)\n\n"+"Difficulty".localized+"\n\(char)\n\n"+"SPEED Recommendation".localized+"\n\(recommend)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    func decideSpeed(speed: Double)->String{
        var recommend: String=""
        switch(speed){
        case ..<0.50:
            recommend="0.50"
        case 0.50..<0.75:
            recommend="0.50 ~ 0.75"
        case 0.75..<1.00:
            recommend="0.75 ~ 1.00"
        case 1.00..<1.25:
            recommend="1.00 ~ 1.25"
        case 1.25..<1.50:
            recommend="1.25 ~ 1.50"
        case 1.50..<1.75:
            recommend="1.50 ~ 1.75"
        case 1.75..<2.00:
            recommend="1.75 ~ 2.00"
        case 2.00..<2.25:
            recommend="2.00 ~ 2.25"
        case 2.25..<2.50:
            recommend="2.25 ~ 2.50"
        case 2.50..<2.75:
            recommend="2.50 ~ 2.75"
        case 2.75..<3.00:
            recommend="2.75 ~ 3.00"
        case 3.00..<3.25:
            recommend="3.00 ~ 3.25"
        case 3.25..<3.50:
            recommend="3.25 ~ 3.50"
        case 3.50..<3.75:
            recommend="3.50 ~ 3.75"
        case 3.75..<4.00:
            recommend="3.75 ~ 4.00"
        case 4.00..<4.25:
            recommend="4.00 ~ 4.25"
        case 4.25..<4.50:
            recommend="4.25 ~ 4.50"
        case 4.50..<4.75:
            recommend="4.50 ~ 4.75"
        case 4.75..<5.00:
            recommend="4.75 ~ 5.00"
        case 5.00...:
            recommend="5.00"
        default:
            break
        }
        return recommend
    }
    
    func getDifficulty(difficulty: String)->String{
        var char: String=""
        if let intDifficulty=Int(difficulty){
            switch(intDifficulty){
            case 1...5:
                for _ in 1...intDifficulty{
                    char=char+"★"
                }
            case 6...10:
                char="☆☆☆☆☆"
                for _ in 6...intDifficulty{
                    char=char+"★"
                }
            case 11...15:
                char="☆☆☆☆☆☆☆☆☆☆"
                for _ in 11...intDifficulty{
                    char=char+"★"
                }
            default:
                break
            }
        }
        else{
            char="??"
        }
        return char
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
