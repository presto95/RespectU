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
import Firebase
import GoogleSignIn
import NotificationBannerSwift

class GradeViewController: UIViewController {

    let button4GradeArray = ["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
    let button5GradeArray=["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 4", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
    let button6And8GradeArray=["BEGINNER", "AMATEUR 4", "AMATEUR 3", "AMATEUR 2", "AMATEUR 1", "SUB DJ 4", "SUB DJ 3", "SUB DJ 2", "SUB DJ 1", "MAIN DJ 4", "MAIN DJ 3", "MAIN DJ 2", "MAIN DJ 1", "POP DJ 4", "POP DJ 3", "POP DJ 2", "POP DJ 1", "PROFESSIONAL 4", "PROFESSIONAL 3", "PROFESSIONAL 2", "PROFESSIONAL 1", "MIX MASTER 3", "MIX MASTER 2", "MIX MASTER 1", "SUPERSTAR 3", "SUPERSTAR 2", "SUPERSTAR 1", "DJMAX GRAND MASTER", "THE DJMAX"]
    var button4SkillLevel: String=""
    var button4SkillPoint: Double=0.0
    var button4FirstSkillPoint: Double=0.0
    var button4FirstSong: String=""
    var button4LastSkillPoint: Double=0.0
    var button4LastSong: String=""
    var button5SkillLevel: String=""
    var button5SkillPoint: Double=0.0
    var button5FirstSkillPoint: Double=0.0
    var button5FirstSong: String=""
    var button5LastSkillPoint: Double=0.0
    var button5LastSong: String=""
    var button6SkillLevel: String=""
    var button6SkillPoint: Double=0.0
    var button6FirstSkillPoint: Double=0.0
    var button6FirstSong: String=""
    var button6LastSkillPoint: Double=0.0
    var button6LastSong: String=""
    var button8SkillLevel: String=""
    var button8SkillPoint: Double=0.0
    var button8FirstSkillPoint: Double=0.0
    var button8FirstSong: String=""
    var button8LastSkillPoint: Double=0.0
    var button8LastSong: String=""
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
    @IBOutlet var gaugeFirst: Gauge!
    @IBOutlet var gaugeLast: Gauge!
    @IBOutlet weak var labelFirstSkillPoint: UILabel!
    @IBOutlet weak var labelFirstSkillPointValue: UILabel!
    @IBOutlet weak var labelLastSkillPoint: UILabel!
    @IBOutlet weak var labelLastSkillPointValue: UILabel!
    @IBOutlet weak var labelFirstSong: UILabel!
    @IBOutlet weak var labelLastSong: UILabel!
    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var buttonUpload: UIButton!
    @IBOutlet weak var buttonRanking: UIButton!
    @IBOutlet weak var buttonNickname: UIButton!
    
    let isNight = UserDefaults.standard.bool(forKey: "night")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Skill Level".localized
        labelFirstSkillPoint.text = "1st".localized
        labelLastSkillPoint.text = "50th".localized
        tabBarController?.tabBar.barStyle = isNight ? .black: .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        labelSkillLevel.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFirstSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFirstSkillPointValue.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFirstSong.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelLastSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelLastSkillPointValue.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelLastSong.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNext.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPercent.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPercent.layer.zPosition = 1
        buttonUpload.setTitle("Upload β".localized, for: .normal)
        buttonRanking.setTitle("Ranking β".localized, for: .normal)
        buttonNickname.setTitle("Nickname Setting β".localized, for: .normal)
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
            button4FirstSkillPoint = result.1
            button4FirstSong = result.2
            button4LastSkillPoint = result.3
            button4LastSong = result.4
            showInfo(sender: 0)
        case 1:
            let result = getButton5Grade()
            button5SkillLevel = getGradeButton5(value: result.0)
            button5SkillPoint = result.0
            button5FirstSkillPoint = result.1
            button5FirstSong = result.2
            button5LastSkillPoint = result.3
            button5LastSong = result.4
            showInfo(sender: 1)
        case 2:
            let result = getButton6Grade()
            button6SkillLevel = getGradeButton6And8(value: result.0)
            button6SkillPoint = result.0
            button6FirstSkillPoint = result.1
            button6FirstSong = result.2
            button6LastSkillPoint = result.3
            button6LastSong = result.4
            showInfo(sender: 2)
        case 3:
            let result = getButton8Grade()
            button8SkillLevel = getGradeButton6And8(value: result.0)
            button8SkillPoint = result.0
            button8FirstSkillPoint = result.1
            button8FirstSong = result.2
            button8LastSkillPoint = result.3
            button8LastSong = result.4
            showInfo(sender: 3)
        default:
            break
        }
    }
    
    @IBAction func calculate(_ sender: UIBarButtonItem) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SkillPointCalculatorViewController") as! SkillPointCalculatorViewController
        self.navigationController?.pushViewController(next, animated: true)
        
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
    
    @IBAction func upload(_ sender: UIButton) {
        if(!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "Error".localized, message: "Please check the network status.".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else{
            if(Auth.auth().currentUser == nil){
                let alert = UIAlertController(title: "Error".localized, message: "Please login first.".localized, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true)
            }
            else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                ERProgressHud.show()
                Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).setValue([
                    "userId": UserDefaults.standard.string(forKey: "nickname") ?? Auth.auth().currentUser?.email,
                    "button4SkillPoint": (UserDefaults.standard.double(forKey: "button4SkillPoint") * 100).rounded() / 100,
                    "button5SkillPoint": (UserDefaults.standard.double(forKey: "button5SkillPoint") * 100).rounded() / 100,
                    "button6SkillPoint": (UserDefaults.standard.double(forKey: "button6SkillPoint") * 100).rounded() / 100,
                    "button8SkillPoint": (UserDefaults.standard.double(forKey: "button8SkillPoint") * 100).rounded() / 100,
                    "countPerfectPlay": UserDefaults.standard.integer(forKey: "countPerfectPlay"),
                    "uid": Auth.auth().currentUser?.uid
                    
                    ])
                ERProgressHud.hide()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    @IBAction func ranking(_ sender: UIButton) {
        if(!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "Error".localized, message: "Please check the network status.".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else{
            if(Auth.auth().currentUser == nil){
                let alert = UIAlertController(title: "Error".localized, message: "Please login first.".localized, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true)
            }
            else{
                var arrayUserId: [String] = []
                var arrayButton4SkillPoint: [Double] = []
                var arrayButton5SkillPoint: [Double] = []
                var arrayButton6SkillPoint: [Double] = []
                var arrayButton8SkillPoint: [Double] = []
                var arrayPerfectPlay: [Int] = []
                ERProgressHud.show()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                let ref = Database.database().reference()
                ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
                    for child in snapshot.children{
                        let snap = child as! DataSnapshot
                        for i in snap.children{
                            let a = i as! DataSnapshot
                            if(a.key == "button4SkillPoint"){
                                arrayButton4SkillPoint.append(a.value! as! Double)
                            }
                            if(a.key == "button5SkillPoint"){
                                arrayButton5SkillPoint.append(a.value! as! Double)
                            }
                            if(a.key == "button6SkillPoint"){
                                arrayButton6SkillPoint.append(a.value! as! Double)
                            }
                            if(a.key == "button8SkillPoint"){
                                arrayButton8SkillPoint.append(a.value! as! Double)
                            }
                            if(a.key == "countPerfectPlay"){
                                arrayPerfectPlay.append(a.value! as! Int)
                            }
                            if(a.key == "userId"){
                                arrayUserId.append(a.value! as! String)
                            }
                        }
                    }
                    var button4Dic: [String: Double] = [:]
                    var button5Dic: [String: Double] = [:]
                    var button6Dic: [String: Double] = [:]
                    var button8Dic: [String: Double] = [:]
                    var perfectPlayDic: [String: Int] = [:]
                    for i in 0..<arrayUserId.count{
                        button4Dic[arrayUserId[i]] = arrayButton4SkillPoint[i]
                        button5Dic[arrayUserId[i]] = arrayButton5SkillPoint[i]
                        button6Dic[arrayUserId[i]] = arrayButton6SkillPoint[i]
                        button8Dic[arrayUserId[i]] = arrayButton8SkillPoint[i]
                        perfectPlayDic[arrayUserId[i]] = arrayPerfectPlay[i]
                    }
                    let next=self.storyboard?.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
                    next.resultButton4 = button4Dic
                    next.resultButton5 = button5Dic
                    next.resultButton6 = button6Dic
                    next.resultButton8 = button8Dic
                    next.resultPerfectPlay = perfectPlayDic
                    next.nickname = UserDefaults.standard.string(forKey: "nickname") ?? (Auth.auth().currentUser?.email)!
                    self.navigationController?.pushViewController(next, animated: true)
                    ERProgressHud.hide()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        
    }

    @IBAction func clickNicknameSetting(_ sender: UIButton) {
        if(!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "Error".localized, message: "Please check the network status.".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else{
            if(Auth.auth().currentUser == nil){
                let alert = UIAlertController(title: "Error".localized, message: "Please login first.".localized, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Nickname Setting β".localized, message: "Please enter your nickname.".localized, preferredStyle: .alert)
                alert.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = "Nickname".localized
                })
                let yesAction = UIAlertAction(title: "OK".localized, style: .default) { (action) -> Void in
                    if let input = alert.textFields![0].text{
                        /*Database.database().reference().child("users").observeSingleEvent(of: .value){ (snapshot) in
                            for child in snapshot.children{
                                let snap = child as! DataSnapshot
                                if(snap.key == input){
                                    NotificationBanner(title: "Fail".localized, subtitle: "Duplicate nickname".localized, leftView: UIImageView(image: #imageLiteral(resourceName: "fail")), style: .danger).show()
                                }
                            }
                        }*/
                        if(input.count == 0){
                            NotificationBanner(title: "Fail".localized, leftView: UIImageView(image: #imageLiteral(resourceName: "fail")), style: .danger).show()
                            return
                        }
                        UserDefaults.standard.set(input, forKey: "nickname")
                        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).setValue([
                            "userId": input,
                            "button4SkillPoint": (UserDefaults.standard.double(forKey: "button4SkillPoint") * 100).rounded() / 100,
                            "button5SkillPoint": (UserDefaults.standard.double(forKey: "button5SkillPoint") * 100).rounded() / 100,
                            "button6SkillPoint": (UserDefaults.standard.double(forKey: "button6SkillPoint") * 100).rounded() / 100,
                            "button8SkillPoint": (UserDefaults.standard.double(forKey: "button8SkillPoint") * 100).rounded() / 100,
                            "countPerfectPlay": UserDefaults.standard.integer(forKey: "countPerfectPlay"),
                            "uid": Auth.auth().currentUser?.uid
                            ])
                        NotificationBanner(title: "Success".localized, leftView: UIImageView(image: #imageLiteral(resourceName: "success")), style: .success).show()
                    }
                    else{
                        NotificationBanner(title: "Fail".localized, leftView: UIImageView(image: #imageLiteral(resourceName: "fail")), style: .danger).show()
                    }
                }
                let noAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
                alert.addAction(yesAction)
                alert.addAction(noAction)
                present(alert, animated: true)
            }
        }
        
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
            labelFirstSkillPointValue.text = String(button4FirstSkillPoint)
            labelFirstSong.text = button4FirstSong
            labelLastSkillPointValue.text = String(button4LastSkillPoint)
            labelLastSong.text = button4LastSong
            labelNext.text = getNextString(string: button4SkillLevel, sender: 0)
            labelPercent.text = "\(((button4SkillPoint / button4Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button4FirstSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let firstSeries = (results?.series)!
            query = NSPredicate(format: "title = %@", button4LastSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let lastSeries = (results?.series)!
            viewGauge.startColor = getColor(series: firstSeries)
            viewGauge.bgColor = getColor(series: firstSeries)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button4Max)
            //viewGauge.rate = CGFloat(button4SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button4SkillPoint)){_ in }
            gaugeFirst.startColor = getColor(series: firstSeries)
            gaugeFirst.endColor = getColor(series: lastSeries)
            gaugeLast.startColor = getColor(series: lastSeries)
            gaugeLast.endColor = getColor(series: firstSeries)
            gaugeFirst.animateRate(1, newValue: CGFloat(button4FirstSkillPoint)){_ in }
            gaugeLast.animateRate(1, newValue: CGFloat(button4LastSkillPoint)){_ in }
        case 1:
            segmentedControl.selectedSegmentIndex = 1
            labelSkillLevel.text = button5SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button5SkillPoint * 100.0).rounded() / 100.0)
            labelFirstSkillPointValue.text = String(button5FirstSkillPoint)
            labelFirstSong.text = button5FirstSong
            labelLastSkillPointValue.text = String(button5LastSkillPoint)
            labelLastSong.text = button5LastSong
            labelNext.text = getNextString(string: button5SkillLevel, sender: 1)
            labelPercent.text = "\(((button5SkillPoint / button5Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button5FirstSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let firstSeries = (results?.series)!
            query = NSPredicate(format: "title = %@", button5LastSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let lastSeries = (results?.series)!
            viewGauge.startColor = getColor(series: firstSeries)
            viewGauge.bgColor = getColor(series: firstSeries)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button5Max)
            //viewGauge.rate = CGFloat(button5SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button5SkillPoint)){_ in }
            gaugeFirst.startColor = getColor(series: firstSeries)
            gaugeFirst.endColor = getColor(series: lastSeries)
            gaugeLast.startColor = getColor(series: lastSeries)
            gaugeLast.endColor = getColor(series: firstSeries)
            gaugeFirst.animateRate(1, newValue: CGFloat(button5FirstSkillPoint)){_ in }
            gaugeLast.animateRate(1, newValue: CGFloat(button5LastSkillPoint)){_ in }
        case 2:
            segmentedControl.selectedSegmentIndex = 2
            labelSkillLevel.text = button6SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button6SkillPoint * 100.0).rounded() / 100.0)
            labelFirstSkillPointValue.text = String(button6FirstSkillPoint)
            labelFirstSong.text = button6FirstSong
            labelLastSkillPointValue.text = String(button6LastSkillPoint)
            labelLastSong.text = button6LastSong
            labelNext.text = getNextString(string: button6SkillLevel, sender: 2)
            labelPercent.text = "\(((button6SkillPoint / button6Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button6FirstSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let firstSeries = (results?.series)!
            query = NSPredicate(format: "title = %@", button6LastSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let lastSeries = (results?.series)!
            viewGauge.startColor = getColor(series: firstSeries)
            viewGauge.bgColor = getColor(series: firstSeries)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button6Max)
            //viewGauge.rate = CGFloat(button6SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button6SkillPoint)){_ in }
            gaugeFirst.startColor = getColor(series: firstSeries)
            gaugeFirst.endColor = getColor(series: lastSeries)
            gaugeLast.startColor = getColor(series: lastSeries)
            gaugeLast.endColor = getColor(series: firstSeries)
            gaugeFirst.animateRate(1, newValue: CGFloat(button6FirstSkillPoint)){_ in }
            gaugeLast.animateRate(1, newValue: CGFloat(button6LastSkillPoint)){_ in }
        case 3:
            segmentedControl.selectedSegmentIndex = 3
            labelSkillLevel.text = button8SkillLevel
            labelSkillPoint.text = "Skill Point".localized + " : " + String((button8SkillPoint * 100.0).rounded() / 100.0)
            labelFirstSkillPointValue.text = String(button8FirstSkillPoint)
            labelFirstSong.text = button8FirstSong
            labelLastSkillPointValue.text = String(button8LastSkillPoint)
            labelLastSong.text = button8LastSong
            labelNext.text = getNextString(string: button8SkillLevel, sender: 3)
            labelPercent.text = "\(((button8SkillPoint / button8Max) * 10000.0).rounded() / 100.0)%"
            query = NSPredicate(format: "title = %@", button8FirstSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let firstSeries = (results?.series)!
            query = NSPredicate(format: "title = %@", button8LastSong)
            results = try! Realm().objects(SongInfo.self).filter(query!).first!
            let lastSeries = (results?.series)!
            viewGauge.startColor = getColor(series: firstSeries)
            viewGauge.bgColor = getColor(series: firstSeries)
            viewGauge.bgAlpha = 0.5
            viewGauge.maxValue = CGFloat(button8Max)
            //viewGauge.rate = CGFloat(button8SkillPoint)
            viewGauge.animateRate(1, newValue: CGFloat(button8SkillPoint)){_ in }
            gaugeFirst.startColor = getColor(series: firstSeries)
            gaugeFirst.endColor = getColor(series: lastSeries)
            gaugeLast.startColor = getColor(series: lastSeries)
            gaugeLast.endColor = getColor(series: firstSeries)
            gaugeFirst.animateRate(1, newValue: CGFloat(button8FirstSkillPoint)){_ in }
            gaugeLast.animateRate(1, newValue: CGFloat(button8LastSkillPoint)){_ in }
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
    
    func getButton4Grade() -> (Double, Double, String, Double, String){
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
        UserDefaults.standard.set(sum, forKey: "button4SkillPoint")
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "", upto50[49], sortedTempDic[49].0)
    }
    
    func getButton5Grade() -> (Double, Double, String, Double, String){
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
        UserDefaults.standard.set(sum, forKey: "button5SkillPoint")
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "", upto50[49], sortedTempDic[49].0)
    }
    
    func getButton6Grade() -> (Double, Double, String, Double, String){
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
        UserDefaults.standard.set(sum, forKey: "button6SkillPoint")
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "", upto50[49], sortedTempDic[49].0)
    }
    
    func getButton8Grade() -> (Double, Double, String, Double, String){
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
        UserDefaults.standard.set(sum, forKey: "button8SkillPoint")
        return (sum, upto50[0], sortedTempDic.first?.0 ?? "", upto50[49], sortedTempDic[49].0)
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
