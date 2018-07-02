//
//  MissionDetail2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class MissionDetailViewController: UIViewController {

    let myBpm = UserDefaults.standard.double(forKey: "bpm")
    var missionTitle: String = ""
    var realm: Realm! = nil
    var results: MissionInfo! = nil
    
    var isSong1Visible = true
    var isSong2Visible = true
    var isSong3Visible = true
    var isSong4Visible = true
    var isSong5Visible = true
    var isSong6Visible = true
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelFever: UILabel!
    @IBOutlet weak var labelCombo: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelBreak: UILabel!
    @IBOutlet weak var labelSong1Button: UILabel!
    @IBOutlet weak var labelSong2Button: UILabel!
    @IBOutlet weak var labelSong3Button: UILabel!
    @IBOutlet weak var labelSong4Button: UILabel!
    @IBOutlet weak var labelSong5Button: UILabel!
    @IBOutlet weak var labelSong6Button: UILabel!
    @IBOutlet weak var labelSong1Difficulty: UILabel!
    @IBOutlet weak var labelSong2Difficulty: UILabel!
    @IBOutlet weak var labelSong3Difficulty: UILabel!
    @IBOutlet weak var labelSong4Difficulty: UILabel!
    @IBOutlet weak var labelSong5Difficulty: UILabel!
    @IBOutlet weak var labelSong6Difficulty: UILabel!
    @IBOutlet weak var labelSong1Title: UILabel!
    @IBOutlet weak var labelSong2Title: UILabel!
    @IBOutlet weak var labelSong3Title: UILabel!
    @IBOutlet weak var labelSong4Title: UILabel!
    @IBOutlet weak var labelSong5Title: UILabel!
    @IBOutlet weak var labelSong6Title: UILabel!
    @IBOutlet weak var buttonSong1: UIButton!
    @IBOutlet weak var buttonSong2: UIButton!
    @IBOutlet weak var buttonSong3: UIButton!
    @IBOutlet weak var buttonSong4: UIButton!
    @IBOutlet weak var buttonSong5: UIButton!
    @IBOutlet weak var buttonSong6: UIButton!
    @IBOutlet weak var labelEffector: UILabel!
    @IBOutlet weak var labelReward: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        let query = NSPredicate(format: "title = %@", missionTitle)
        results = realm.objects(MissionInfo.self).filter(query).first!
        setVisibilityOfViews(object: results)
        labelTitle.text = results.title
        labelScore.text = results.scoreLim == 0 ? "-" : String(results.scoreLim)
        labelFever.text = results.feverLim == 0 ? "-" : "X\(results.feverLim)"
        labelCombo.text = results.comboLim == 0 ? "-" : String(results.comboLim)
        labelRate.text = results.rateLim == 0 ? "-" : "\(results.rateLim)%"
        labelBreak.text = results.breakLim == 0 ? "-" : String(results.breakLim)
        labelEffector.text = results.more
        labelReward.text = results.reward.isEmpty ? "None".localized : results.reward
        if(isSong1Visible){
            labelSong1Button.text = results.song1key
            labelSong1Difficulty.text = results.song1level
            labelSong1Title.text = results.song1title
        }
        if(isSong2Visible){
            labelSong2Button.text = results.song2key
            labelSong2Difficulty.text = results.song2level
            labelSong2Title.text = results.song2title
        }
        if(isSong3Visible){
            labelSong3Button.text = results.song3key
            labelSong3Difficulty.text = results.song3level
            labelSong3Title.text = results.song3title
        }
        if(isSong4Visible){
            labelSong4Button.text = results.song4key
            labelSong4Difficulty.text = results.song4level
            labelSong4Title.text = results.song4title
        }
        if(isSong5Visible){
            labelSong5Button.text = results.song5key
            labelSong5Difficulty.text = results.song5level
            labelSong5Title.text = results.song5title
        }
        if(isSong6Visible){
            labelSong6Button.text = results.song6key
            labelSong6Difficulty.text = results.song6level
            labelSong6Title.text = results.song6title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickMoreButton(_ sender: UIButton) {
        switch(sender.tag){
        case 0:
            getInfoForMoreButton(title: labelSong1Title.text!, button: labelSong1Button.text!, pattern: labelSong1Difficulty.text!)
        case 1:
            getInfoForMoreButton(title: labelSong2Title.text!, button: labelSong2Button.text!, pattern: labelSong2Difficulty.text!)
        case 2:
            getInfoForMoreButton(title: labelSong3Title.text!, button: labelSong3Button.text!, pattern: labelSong3Difficulty.text!)
        case 3:
            getInfoForMoreButton(title: labelSong4Title.text!, button: labelSong4Button.text!, pattern: labelSong4Difficulty.text!)
        case 4:
            getInfoForMoreButton(title: labelSong5Title.text!, button: labelSong5Button.text!, pattern: labelSong5Difficulty.text!)
        case 5:
            getInfoForMoreButton(title: labelSong6Title.text!, button: labelSong6Button.text!, pattern: labelSong6Difficulty.text!)
        default:
            break
        }
    }
    
    func getInfoForMoreButton(title: String, button: String, pattern: String){
        var difficulty: Int = 0
        var bpm: Double = 0
        let query = NSPredicate(format: "title = %@", title)
        if let object = realm.objects(SongInfo.self).filter(query).first {
            bpm = Double.convertBpmToDouble(string: object.bpm)
            switch(button){
            case "4B":
                switch(pattern){
                case "NORMAL":
                    difficulty = object.nm4
                case "HARD":
                    difficulty = object.hd4
                case "MAXIMUM":
                    difficulty = object.mx4
                case "FX":
                    difficulty = 0
                default:
                    break
                }
            case "5B":
                switch(pattern){
                case "NORMAL":
                    difficulty = object.nm5
                case "HARD":
                    difficulty = object.hd5
                case "MAXIMUM":
                    difficulty = object.mx5
                default:
                    break
                }
            case "6B":
                switch(pattern){
                case "NORMAL":
                    difficulty = object.nm6
                case "HARD":
                    difficulty = object.hd6
                case "MAXIMUM":
                    difficulty = object.mx6
                default:
                    break
                }
            case "8B":
                switch(pattern){
                case "NORMAL":
                    difficulty = object.nm8
                case "HARD":
                    difficulty = object.hd8
                case "MAXIMUM":
                    difficulty = object.mx8
                default:
                    break
                }
            case "XB":
                difficulty = 0
            default:
                break
            }
        } else {
            difficulty = 0
            bpm = 0
        }
        
        let recommendedSpeed: String = { () -> String in
            if(bpm != 0){
                return String.decideSpeed(speed: myBpm / bpm)//decideSpeed(speed: myBpm / bpm)
            } else {
                return "??"
            }
        }()
        let difficultyString = difficulty == 0 ? "??" : String(difficulty)
        let message = button + " " + pattern + "\n\n" + "Difficulty".localized + "\n" + difficultyString + "\n\n" + "SPEED Recommendation".localized + "\n" + recommendedSpeed
        let alert = UIAlertController.showOKButton(title: title, message: message)
        present(alert, animated: true)
    }

    func setVisibilityOfViews(object: MissionInfo){
        if(object.song1title.isEmpty){
            labelSong1Button.isHidden = true
            labelSong1Difficulty.isHidden = true
            labelSong1Title.isHidden = true
            buttonSong1.isHidden = true
            isSong1Visible = false
        } else if(object.song1title == "RANDOM") {
            buttonSong1.isHidden = true
        }
        if(object.song2title.isEmpty){
            labelSong2Button.isHidden = true
            labelSong2Difficulty.isHidden = true
            labelSong2Title.isHidden = true
            buttonSong2.isHidden = true
            isSong2Visible = false
        } else if(object.song2title == "RANDOM"){
            buttonSong2.isHidden = true
        }
        if(object.song3title.isEmpty){
            labelSong3Button.isHidden = true
            labelSong3Difficulty.isHidden = true
            labelSong3Title.isHidden = true
            buttonSong3.isHidden = true
            isSong3Visible = false
        } else if(object.song3title == "RANDOM"){
            buttonSong3.isHidden = true
        }
        if(object.song4title.isEmpty){
            labelSong4Button.isHidden = true
            labelSong4Difficulty.isHidden = true
            labelSong4Title.isHidden = true
            buttonSong4.isHidden = true
            isSong4Visible = false
        } else if(object.song4title == "RANDOM"){
            buttonSong4.isHidden = true
        }
        if(object.song5title.isEmpty){
            labelSong5Button.isHidden = true
            labelSong5Difficulty.isHidden = true
            labelSong5Title.isHidden = true
            buttonSong5.isHidden = true
            isSong5Visible = false
        } else if(object.song5title == "RANDOM"){
            buttonSong5.isHidden = true
        }
        if(object.song6title.isEmpty){
            labelSong6Button.isHidden = true
            labelSong6Difficulty.isHidden = true
            labelSong6Title.isHidden = true
            buttonSong6.isHidden = true
            isSong6Visible = false
        } else if(object.song6title == "RANDOM"){
            buttonSong6.isHidden = true
        }
    }
}
