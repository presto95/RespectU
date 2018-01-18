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

    let button4GradeArray = ["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
    let button5GradeArray=["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 4", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
    let button6And8GradeArray=["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 4", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
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
            showInfo(sender: 0)
        case "5B":
            showInfo(sender: 1)
        case "6B":
            showInfo(sender: 2)
        case "8B":
            showInfo(sender: 3)
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
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            let result = getButton4Grade()
            button4SkillLevel = getGradeButton4(value: result.0)
            button4SkillPoint = result.0
            button4HighestSkillPoint = result.1
            button4HighestSong = result.2
            showInfo(sender: 0)
        case 1:
            let result = getButton5Grade()
            button5SkillLevel = getGradeButton5(value: result.0)
            button5SkillPoint = result.0
            button5HighestSkillPoint = result.1
            button5HighestSong = result.2
            showInfo(sender: 1)
        case 2:
            let result = getButton6Grade()
            button6SkillLevel = getGradeButton6And8(value: result.0)
            button6SkillPoint = result.0
            button6HighestSkillPoint = result.1
            button6HighestSong = result.2
            showInfo(sender: 2)
        case 3:
            let result = getButton8Grade()
            button8SkillLevel = getGradeButton6And8(value: result.0)
            button8SkillPoint = result.0
            button8HighestSkillPoint = result.1
            button8HighestSong = result.2
            showInfo(sender: 3)
        default:
            break
        }
    }
    
    
    @IBAction func pressSegmentedControl(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            showInfo(sender: 0)
        case 1:
            showInfo(sender: 1)
        case 2:
            showInfo(sender: 2)
        case 3:
            showInfo(sender: 3)
        default:
            break
        }
    }
    
    @IBAction func showTop50(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Top50TableViewController") as! Top50TableViewController
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            next.sender = 0
        case 1:
            next.sender = 1
        case 2:
            next.sender = 2
        case 3:
            next.sender = 3
        default:
            break
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func getNextString(string: String, sender: Int) -> String{
        var index: Int=0
        var nextString = "Next".localized + " : "
        switch(sender){
        case 0:
            for i in button4GradeArray{
                if(i == string){
                    break
                }
                index = index + 1
            }
            if(index + 1 == button4GradeArray.count){
                nextString = nextString + "None".localized
            }
            else{
                nextString = nextString + button4GradeArray[index+1]
            }
        case 1:
            for i in button5GradeArray{
                if(i == string){
                    break
                }
                index = index + 1
            }
            if(index + 1 == button5GradeArray.count){
                nextString = nextString + "None".localized
            }
            else{
                nextString = nextString + button5GradeArray[index+1]
            }
        case 2...3:
            for i in button6And8GradeArray{
                if(i == string){
                    break
                }
                index = index + 1
            }
            if(index + 1 == button6And8GradeArray.count){
                nextString = nextString + "None".localized
            }
            else{
                nextString = nextString + button6And8GradeArray[index+1]
            }
        default:
            break
        }
        return nextString
    }
    
    func showInfo(sender: Int){
        switch(sender){
        case 0:
            segmentedControl.selectedSegmentIndex = 0
            labelSkillLevel.text = button4SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button4SkillPoint * 100.0).rounded() / 100.0)
            labelHighestSkillPointValue.text = String(button4HighestSkillPoint)
            labelSong.text = button4HighestSong
            labelNext.text = getNextString(string: button4SkillLevel, sender: 0)
            labelPercent.text = "\(((button4SkillPoint / button4Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button4HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.bgColor = getColor(series: series)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button4Max)
            //viewGauge.rate = CGFloat(button4SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button4SkillPoint)){_ in }
        case 1:
            segmentedControl.selectedSegmentIndex = 1
            labelSkillLevel.text = button5SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button5SkillPoint * 100.0).rounded() / 100.0)
            labelHighestSkillPointValue.text = String(button5HighestSkillPoint)
            labelSong.text = button5HighestSong
            labelNext.text = getNextString(string: button5SkillLevel, sender: 1)
            labelPercent.text = "\(((button5SkillPoint / button5Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button5HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.bgColor = getColor(series: series)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button5Max)
            //viewGauge.rate = CGFloat(button5SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button5SkillPoint)){_ in }
        case 2:
            segmentedControl.selectedSegmentIndex = 2
            labelSkillLevel.text = button6SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button6SkillPoint * 100.0).rounded() / 100.0)
            labelHighestSkillPointValue.text = String(button6HighestSkillPoint)
            labelSong.text = button6HighestSong
            labelNext.text = getNextString(string: button6SkillLevel, sender: 2)
            labelPercent.text = "\(((button6SkillPoint / button6Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button6HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.bgColor = getColor(series: series)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button6Max)
            //viewGauge.rate = CGFloat(button6SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button6SkillPoint)){_ in }
        case 3:
            segmentedControl.selectedSegmentIndex = 3
            labelSkillLevel.text = button8SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button8SkillPoint * 100.0).rounded() / 100.0)
            labelHighestSkillPointValue.text = String(button8HighestSkillPoint)
            labelSong.text = button8HighestSong
            labelNext.text = getNextString(string: button8SkillLevel, sender: 3)
            labelPercent.text = "\(((button8SkillPoint / button8Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button8HighestSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let series = (results?.series)!
            setColor(series: series)
            viewGauge.startColor = getColor(series: series)
            viewGauge.bgColor = getColor(series: series)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button8Max)
            //viewGauge.rate = CGFloat(button8SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button8SkillPoint)){_ in }
        default:
            break
        }
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
    
    func getButton4Grade() -> (Double, Double, String){
        let record = try! Realm().objects(RecordInfo.self)
        var tempDic = [String: Double]()
        var upto50 = [Double]()
        for i in record{
            tempDic[i.title] = i.button4SkillPoint
        }
        let sortedTempDic = tempDic.sorted { $0.value > $1.value }
        for i in 0...49{
            upto50.append(sortedTempDic[i].1)
        }
        let sum = upto50.reduce(0) { $0 + $1 }
        
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "")
    }
    
    func getButton5Grade() -> (Double, Double, String){
        let record = try! Realm().objects(RecordInfo.self)
        var tempDic = [String: Double]()
        var upto50 = [Double]()
        for i in record{
            tempDic[i.title] = i.button5SkillPoint
        }
        let sortedTempDic = tempDic.sorted { $0.value > $1.value }
        for i in 0...49{
            upto50.append(sortedTempDic[i].1)
        }
        let sum = upto50.reduce(0) { $0 + $1 }
        
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "")
    }
    
    func getButton6Grade() -> (Double, Double, String){
        let record = try! Realm().objects(RecordInfo.self)
        var tempDic = [String: Double]()
        var upto50 = [Double]()
        for i in record{
            tempDic[i.title] = i.button6SkillPoint
        }
        let sortedTempDic = tempDic.sorted { $0.value > $1.value }
        for i in 0...49{
            upto50.append(sortedTempDic[i].1)
        }
        let sum = upto50.reduce(0) { $0 + $1 }
        
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "")
    }
    
    func getButton8Grade() -> (Double, Double, String){
        let record = try! Realm().objects(RecordInfo.self)
        var tempDic = [String: Double]()
        var upto50 = [Double]()
        for i in record{
            tempDic[i.title] = i.button8SkillPoint
        }
        let sortedTempDic = tempDic.sorted { $0.value > $1.value }
        for i in 0...49{
            upto50.append(sortedTempDic[i].1)
        }
        let sum = upto50.reduce(0) { $0 + $1 }
        
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "")
    }
    
    func getGradeButton4(value: Double) -> String{
        var returnString = ""
        switch(value){
        case 0..<1000:
            returnString = "BEGINNER"
        case 1000..<1500:
            returnString = "AMATEUR 4"
        case 1500..<2000:
            returnString = "AMATEUR 3"
        case 2000..<2300:
            returnString = "AMATEUR 2"
        case 2300..<2600:
            returnString = "AMATEUR 1"
        case 2600..<3000:
            returnString = "SUB DJ 4"
        case 3000..<3300:
            returnString = "SUB DJ 3"
        case 3300..<3600:
            returnString = "SUB DJ 2"
        case 3600..<4000:
            returnString = "SUB DJ 1"
        case 4000..<4300:
            returnString = "MAIN DJ 4"
        case 4300..<4600:
            returnString = "MAIN DJ 3"
        case 4600..<5000:
            returnString = "MAIN DJ 2"
        case 5000..<5300:
            returnString = "MAIN DJ 1"
        case 5300..<5600:
            returnString = "POP DJ 4"
        case 5600..<6000:
            returnString = "POP DJ 3"
        case 6000..<6300:
            returnString = "POP DJ 2"
        case 6300..<6600:
            returnString = "POP DJ 1"
        case 6600..<7000:
            returnString = "PROFESSIONAL 3"
        case 7000..<7200:
            returnString = "PROFESSIONAL 2"
        case 7200..<7400:
            returnString = "PROFESSIONAL 1"
        case 7400..<7600:
            returnString = "MIX MASTER 3"
        case 7600..<7800:
            returnString = "MIX MASTER 2"
        case 7800..<8000:
            returnString = "MIX MASTER 1"
        case 8000..<8200:
            returnString = "SUPERSTAR 3"
        case 8200..<8400:
            returnString = "SUPERSTAR 2"
        case 8400..<8600:
            returnString = "SUPERSTAR 1"
        case 8600..<8800:
            returnString = "DJMAX GRAND MASTER"
        case 8800...:
            returnString = "THE DJMAX"
        default:
            break
        }
        return returnString
    }
    
    func getGradeButton5(value: Double) -> String{
        var returnString = ""
        switch(value){
        case 0..<1000:
            returnString = "BEGINNER"
        case 1000..<1500:
            returnString = "AMATEUR 4"
        case 1500..<2000:
            returnString = "AMATEUR 3"
        case 2000..<2300:
            returnString = "AMATEUR 2"
        case 2300..<2600:
            returnString = "AMATEUR 1"
        case 2600..<3000:
            returnString = "SUB DJ 4"
        case 3000..<3300:
            returnString = "SUB DJ 3"
        case 3300..<3600:
            returnString = "SUB DJ 2"
        case 3600..<4000:
            returnString = "SUB DJ 1"
        case 4000..<4300:
            returnString = "MAIN DJ 4"
        case 4300..<4600:
            returnString = "MAIN DJ 3"
        case 4600..<5000:
            returnString = "MAIN DJ 2"
        case 5000..<5300:
            returnString = "MAIN DJ 1"
        case 5300..<5600:
            returnString = "POP DJ 4"
        case 5600..<6000:
            returnString = "POP DJ 3"
        case 6000..<6300:
            returnString = "POP DJ 2"
        case 6300..<6600:
            returnString = "POP DJ 1"
        case 6600..<7000:
            returnString = "PROFESSIONAL 4"
        case 7000..<7200:
            returnString = "PROFESSIONAL 3"
        case 7200..<7400:
            returnString = "PROFESSIONAL 2"
        case 7400..<7600:
            returnString = "PROFESSIONAL 1"
        case 7600..<7800:
            returnString = "MIX MASTER 3"
        case 7800..<8000:
            returnString = "MIX MASTER 2"
        case 8000..<8200:
            returnString = "MIX MASTER 1"
        case 8200..<8400:
            returnString = "SUPERSTAR 3"
        case 8400..<8600:
            returnString = "SUPERSTAR 2"
        case 8600..<8800:
            returnString = "SUPERSTAR 1"
        case 8800..<9000:
            returnString = "DJMAX GRAND MASTER"
        case 9000...:
            returnString = "THE DJMAX"
        default:
            break
        }
        return returnString
    }
    
    func getGradeButton6And8(value: Double) -> String{
        var returnString = ""
        switch(value){
        case 0..<1500:
            returnString = "BEGINNER"
        case 1500..<2000:
            returnString = "AMATEUR 4"
        case 2000..<2300:
            returnString = "AMATEUR 3"
        case 2300..<2600:
            returnString = "AMATEUR 2"
        case 2600..<3000:
            returnString = "AMATEUR 1"
        case 3000..<3300:
            returnString = "SUB DJ 4"
        case 3300..<3600:
            returnString = "SUB DJ 3"
        case 3600..<4000:
            returnString = "SUB DJ 2"
        case 4000..<4300:
            returnString = "SUB DJ 1"
        case 4300..<4600:
            returnString = "MAIN DJ 4"
        case 4600..<5000:
            returnString = "MAIN DJ 3"
        case 5000..<5300:
            returnString = "MAIN DJ 2"
        case 5300..<5600:
            returnString = "MAIN DJ 1"
        case 5600..<6000:
            returnString = "POP DJ 4"
        case 6000..<6300:
            returnString = "POP DJ 3"
        case 6300..<6600:
            returnString = "POP DJ 2"
        case 6600..<7000:
            returnString = "POP DJ 1"
        case 7000..<7200:
            returnString = "PROFESSIONAL 4"
        case 7200..<7400:
            returnString = "PROFESSIONAL 3"
        case 7400..<7600:
            returnString = "PROFESSIONAL 2"
        case 7600..<7800:
            returnString = "PROFESSIONAL 1"
        case 7800..<8000:
            returnString = "MIX MASTER 3"
        case 8000..<8200:
            returnString = "MIX MASTER 2"
        case 8200..<8400:
            returnString = "MIX MASTER 1"
        case 8400..<8600:
            returnString = "SUPERSTAR 3"
        case 8600..<8800:
            returnString = "SUPERSTAR 2"
        case 8800..<9000:
            returnString = "SUPERSTAR 1"
        case 9000..<9200:
            returnString = "DJMAX GRAND MASTER"
        case 9200...:
            returnString = "THE DJMAX"
        default:
            break
        }
        return returnString
    }
}
