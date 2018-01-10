//
//  GradeViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import GaugeKit
import RealmSwift

class GradeViewController: UIViewController {

    let gradeArray = ["BEGINNER 1", "BEGINNER 2", "BEGINNER 3", "BEGINNER 4", "TRAINEE 1", "TRAINEE 2", "TRAINEE 3", "TRAINEE 4", "AMATEUR 1", "AMATEUR 2", "AMATEUR 3", "AMATEUR 4", "ROOKIE 1", "ROOKIE 2", "SUB DJ", "MIDDLEMAN", "MAIN DJ", "POP DJ", "HIGH CLASS", "PROFESSIONAL", "MIX MASTER", "TREND SETTER", "HIT MAKER", "SHOW STOPPER", "SUPERSTAR", "WORLD FAMOUS", "DJMAX GRAND MASTER", "VANQUISHER", "BEAT MAESTRO", "THE DJMAX"]
    var button4SkillLevel: String=""
    var button4SkillPoint: Double=0.0
    var button4HighestSkillPoint: Double=0.0
    var button4HighestSong: String=""
    var button5SkillLevel: String=""
    var button5SkillPoint: Double=0.0
    var button5HighestSkillPoint: Double=0.0
    var button5HighestSong: String=""
    var button6SkillLevel: String=""
    var button6SkillPoint: Double=0.0
    var button6HighestSkillPoint: Double=0.0
    var button6HighestSong: String=""
    var button8SkillLevel: String=""
    var button8SkillPoint: Double=0.0
    var button8HighestSkillPoint: Double=0.0
    var button8HighestSong: String=""
    var button4Max: Double=0.0
    var button5Max: Double=0.0
    var button6Max: Double=0.0
    var button8Max: Double=0.0
    
    let realm = try! Realm()
    var results: SongInfo? = nil
    var query: NSPredicate? = nil
    
    let key: String = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelSkillLevel: UILabel!
    @IBOutlet weak var labelSkillPoint: UILabel!
    @IBOutlet var viewGauge: Gauge!
    @IBOutlet weak var labelHighestSkillPoint: UILabel!
    @IBOutlet weak var labelHighestSkillPointValue: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelSong: UILabel!
    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    
    let isNight = UserDefaults.standard.bool(forKey: "night")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Skill Level".localized
        labelHighestSkillPoint.text = "Highest Skill Point".localized
        tabBarController?.tabBar.barStyle = isNight ? .black: .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        labelSkillLevel.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHighestSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHighestSkillPointValue.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSong.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNext.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPercent.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPercent.layer.zPosition = 1
        let songInfo = try! Realm().objects(SongInfo.self)
        var button4Top50 = [Int]()
        var button5Top50 = [Int]()
        var button6Top50 = [Int]()
        var button8Top50 = [Int]()
        for i in songInfo{
            let button4Array = [i.nm4, i.hd4, i.mx4]
            let button5Array = [i.nm5, i.hd5, i.mx5]
            let button6Array = [i.nm6, i.hd6, i.mx6]
            let button8Array = [i.nm8, i.hd8, i.mx8]
            let button4 = button4Array.sorted()[2]
            let button5 = button5Array.sorted()[2]
            let button6 = button6Array.sorted()[2]
            let button8 = button8Array.sorted()[2]
            button4Top50.append(button4)
            button5Top50.append(button5)
            button6Top50.append(button6)
            button8Top50.append(button8)
        }
        button4Top50 = button4Top50.sorted() { $0 > $1 }
        button5Top50 = button5Top50.sorted() { $0 > $1 }
        button6Top50 = button6Top50.sorted() { $0 > $1 }
        button8Top50 = button8Top50.sorted() { $0 > $1 }
        for i in 0...49{
            button4Max = button4Max + getWeight(value: button4Top50[i]) * 105
            button5Max = button5Max + getWeight(value: button5Top50[i]) * 105
            button6Max = button6Max + getWeight(value: button6Top50[i]) * 105
            button8Max = button8Max + getWeight(value: button8Top50[i]) * 105
        }
        
        switch(key){
        case "4B":
            segmentedControl.selectedSegmentIndex = 0
            labelSkillLevel.text = button4SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button4SkillPoint)
            labelHighestSkillPointValue.text = String(button4HighestSkillPoint)
            labelSong.text = button4HighestSong
            labelNext.text = getNextString(string: button4SkillLevel)
            labelPercent.text = "\(((button4SkillPoint / button4Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button4HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.endColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            viewGauge.maxValue = CGFloat(button4Max)
            viewGauge.rate = CGFloat(button4SkillPoint)
        case "5B":
            segmentedControl.selectedSegmentIndex = 1
            labelSkillLevel.text = button5SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button5SkillPoint)
            labelHighestSkillPointValue.text = String(button5HighestSkillPoint)
            labelSong.text = button5HighestSong
            labelNext.text = getNextString(string: button5SkillLevel)
            labelPercent.text = "\(((button5SkillPoint / button5Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button5HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button5Max)
            viewGauge.rate = CGFloat(button5SkillPoint)
        case "6B":
            segmentedControl.selectedSegmentIndex = 2
            labelSkillLevel.text = button6SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button6SkillPoint)
            labelHighestSkillPointValue.text = String(button6HighestSkillPoint)
            labelSong.text = button6HighestSong
            labelNext.text = getNextString(string: button6SkillLevel)
            labelPercent.text = "\(((button6SkillPoint / button6Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button6HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button6Max)
            viewGauge.rate = CGFloat(button6SkillPoint)
        case "8B":
            segmentedControl.selectedSegmentIndex = 3
            labelSkillLevel.text = button8SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button8SkillPoint)
            labelHighestSkillPointValue.text = String(button8HighestSkillPoint)
            labelSong.text = button8HighestSong
            labelNext.text = getNextString(string: button8SkillLevel)
            labelPercent.text = "\(((button8SkillPoint / button8Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button8HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button8Max)
            viewGauge.rate = CGFloat(button8SkillPoint)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setColor(series: String){
        switch(series){
        case "Trilogy":
            labelColor.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Respect":
            labelColor.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Portable1":
            labelColor.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "Portable2":
            labelColor.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "CE":
            labelColor.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
        }
    }
    
    func getColor(series: String) -> UIColor{
        switch(series){
        case "Trilogy":
            return UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Respect":
            return UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Portable1":
            return UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "Portable2":
            return UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "CE":
            return UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
        }
        return UIColor()
    }
    
    @IBAction func pressButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Skill Level".localized, message: "We provide a rough measure of performance by calculating the performance you have entered.".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func pressSegmentedControl(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            segmentedControl.selectedSegmentIndex = 0
            labelSkillLevel.text = button4SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button4SkillPoint)
            labelHighestSkillPointValue.text = String(button4HighestSkillPoint)
            labelSong.text = button4HighestSong
            labelNext.text = getNextString(string: button4SkillLevel)
            labelPercent.text = "\(((button4SkillPoint / button4Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button4HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button4Max)
            viewGauge.rate = CGFloat(button4SkillPoint)
        case 1:
            segmentedControl.selectedSegmentIndex = 1
            labelSkillLevel.text = button5SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button5SkillPoint)
            labelHighestSkillPointValue.text = String(button5HighestSkillPoint)
            labelSong.text = button5HighestSong
            labelNext.text = getNextString(string: button5SkillLevel)
            labelPercent.text = "\(((button5SkillPoint / button5Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button5HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button5Max)
            viewGauge.rate = CGFloat(button5SkillPoint)
        case 2:
            segmentedControl.selectedSegmentIndex = 2
            labelSkillLevel.text = button6SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button6SkillPoint)
            labelHighestSkillPointValue.text = String(button6HighestSkillPoint)
            labelSong.text = button6HighestSong
            labelNext.text = getNextString(string: button6SkillLevel)
            labelPercent.text = "\(((button6SkillPoint / button6Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button6HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button6Max)
            viewGauge.rate = CGFloat(button6SkillPoint)
        case 3:
            segmentedControl.selectedSegmentIndex = 3
            labelSkillLevel.text = button8SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String(button8SkillPoint)
            labelHighestSkillPointValue.text = String(button8HighestSkillPoint)
            labelSong.text = button8HighestSong
            labelNext.text = getNextString(string: button8SkillLevel)
            labelPercent.text = "\(((button8SkillPoint / button8Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button8HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.maxValue = CGFloat(button8Max)
            viewGauge.rate = CGFloat(button8SkillPoint)
        default:
            break
        }
    }
    
    func getNextString(string: String) -> String{
        var index: Int=0
        var nextString = "Next".localized + " : "
        for i in gradeArray{
            if(i == string){
                break
            }
            index = index + 1
        }
        if(index == gradeArray.count){
            nextString = nextString + "None".localized
        }
        else{
            nextString = nextString + gradeArray[index+1]
        }
        return nextString
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
}
