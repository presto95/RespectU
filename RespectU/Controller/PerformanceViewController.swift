//
//  PerformanceViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import PMAlertController
import RealmSwift

class PerformanceViewController: UIViewController {

    
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nickname: UIButton!
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Init()
        tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "summaryCell")
        tableView.register(UINib(nibName: "SkillLevelCell", bundle: nil), forCellReuseIdentifier: "skillLevelCell")
        tableView.register(UINib(nibName: "GraphCell", bundle: nil), forCellReuseIdentifier: "graphCell")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if(Auth.auth().currentUser == nil){
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(controller, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        tableView.reloadData()
        //뷰 업데이트는 didload 말고 여기에
        nickname.setTitle(UserDefaults.standard.string(forKey: "nickname") ?? "닉네임을 설정해 주세요.".localized, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickNickname(_ sender: UIButton) {
        let alert = PMAlertController(title: "Nickname Setting".localized, description: "Enter your nickname.".localized, image: nil, style: .alert)
        alert.addTextField { (textField) in
            textField?.placeholder = "Nickname".localized
        }
        let noAction = PMAlertAction(title: "Cancel".localized, style: .cancel)
        let yesAction = PMAlertAction(title: "OK".localized, style: .default) {
            if let input = alert.textFields.first?.text {
                if(!input.isEmpty){
                    UserDefaults.standard.set(input.trimmingCharacters(in: .whitespaces), forKey: "nickname")
                    self.nickname.setTitle(UserDefaults.standard.string(forKey: "nickname")!, for: .normal)
                }
            }
        }
        designAlertController(alert: alert, actions: noAction, yesAction)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true)
    }
    @IBAction func goToNext(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GuideViewController") as! GuideViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func recordPerformance(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
        present(controller, animated: true, completion: nil)
    }
}

extension PerformanceViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section){
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillLevelCell") as! SkillLevelCell
            switch(favoriteButton){
            case "4B":
                let maxSkillPoint = getMaxSkillPoint(button: "4B")
                let mySkillPoint = getMySkillPoint(button: "4B")
                let mySkillPointSum = mySkillPoint.sum
                let myHighestSeries = mySkillPoint.highestSeries
                cell.gauge.maxValue = CGFloat(maxSkillPoint)
                cell.gauge.rate = CGFloat(mySkillPointSum)
                cell.gauge.startColor = { () -> UIColor in
                    switch(myHighestSeries){
                    case "Portable1":
                        return UIColor.portable1
                    case "Portable2":
                        return UIColor.portable2
                    case "Respect":
                        return UIColor.respect
                    case "Trilogy":
                        return UIColor.trilogy
                    case "CE":
                        return UIColor.ce
                    default:
                        return UIColor()
                    }
                }()
                cell.gauge.bgColor = cell.gauge.startColor
                cell.skillLevel.text = getSkillLevelButton4(value: mySkillPointSum)
                cell.skillPoint.text = "\(mySkillPointSum) " + "Point".localized
                cell.nextLevel.text = getNextString(string: cell.skillLevel.text!, button: "4B")
                cell.percent.text = String(format: "%05.2f%%", mySkillPointSum * 100 / maxSkillPoint)
            case "5B":
                let maxSkillPoint = getMaxSkillPoint(button: "5B")
                let mySkillPoint = getMySkillPoint(button: "5B")
                let mySkillPointSum = mySkillPoint.sum
                let myHighestSeries = mySkillPoint.highestSeries
                cell.gauge.maxValue = CGFloat(maxSkillPoint)
                cell.gauge.rate = CGFloat(mySkillPointSum)
                cell.gauge.startColor = { () -> UIColor in
                    switch(myHighestSeries){
                    case "Portable1":
                        return UIColor.portable1
                    case "Portable2":
                        return UIColor.portable2
                    case "Respect":
                        return UIColor.respect
                    case "Trilogy":
                        return UIColor.trilogy
                    case "CE":
                        return UIColor.ce
                    default:
                        return UIColor()
                    }
                }()
                cell.gauge.bgColor = cell.gauge.startColor
                cell.skillLevel.text = getSkillLevelButton5(value: mySkillPointSum)
                cell.skillPoint.text = "\(mySkillPointSum) " + "Point".localized
                cell.nextLevel.text = getNextString(string: cell.skillLevel.text!, button: "5B")
                cell.percent.text = String(format: "%05.2f%%", mySkillPointSum * 100 / maxSkillPoint)
            case "6B":
                let maxSkillPoint = getMaxSkillPoint(button: "6B")
                let mySkillPoint = getMySkillPoint(button: "6B")
                let mySkillPointSum = mySkillPoint.sum
                let myHighestSeries = mySkillPoint.highestSeries
                cell.gauge.maxValue = CGFloat(maxSkillPoint)
                cell.gauge.rate = CGFloat(mySkillPointSum)
                cell.gauge.startColor = { () -> UIColor in
                    switch(myHighestSeries){
                    case "Portable1":
                        return UIColor.portable1
                    case "Portable2":
                        return UIColor.portable2
                    case "Respect":
                        return UIColor.respect
                    case "Trilogy":
                        return UIColor.trilogy
                    case "CE":
                        return UIColor.ce
                    default:
                        return UIColor()
                    }
                }()
                cell.gauge.bgColor = cell.gauge.startColor
                cell.skillLevel.text = getSkillLevelButton6And8(value: mySkillPointSum)
                cell.skillPoint.text = "\(mySkillPointSum) " + "Point".localized
                cell.nextLevel.text = getNextString(string: cell.skillLevel.text!, button: "6B")
                cell.percent.text = String(format: "%05.2f%%", mySkillPointSum * 100 / maxSkillPoint)
            case "8B":
                let maxSkillPoint = getMaxSkillPoint(button: "8B")
                let mySkillPoint = getMySkillPoint(button: "8B")
                let mySkillPointSum = mySkillPoint.sum
                let myHighestSeries = mySkillPoint.highestSeries
                cell.gauge.maxValue = CGFloat(maxSkillPoint)
                cell.gauge.rate = CGFloat(mySkillPointSum)
                cell.gauge.startColor = { () -> UIColor in
                    switch(myHighestSeries){
                    case "Portable1":
                        return UIColor.portable1
                    case "Portable2":
                        return UIColor.portable2
                    case "Respect":
                        return UIColor.respect
                    case "Trilogy":
                        return UIColor.trilogy
                    case "CE":
                        return UIColor.ce
                    default:
                        return UIColor()
                    }
                }()
                cell.gauge.bgColor = cell.gauge.startColor
                cell.skillLevel.text = getSkillLevelButton6And8(value: mySkillPointSum)
                cell.skillPoint.text = "\(mySkillPointSum) " + "Point".localized
                cell.nextLevel.text = getNextString(string: cell.skillLevel.text!, button: "8B")
                cell.percent.text = String(format: "%05.2f%%", mySkillPointSum * 100 / maxSkillPoint)
            default:
                break
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as! SummaryCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell") as! GraphCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        header.backgroundView?.backgroundColor = UIColor.mainColor
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "Skill Level".localized
        case 1:
            return "Summary".localized
        case 2:
            return "Graph".localized
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section){
        case 0:
            return 150
        case 1:
            return 40
        case 2:
            return 40
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
extension PerformanceViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.section){
        case 0:
            let storyboard = UIStoryboard(name: "Performance", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SkillLevelDetailViewController")
            present(controller, animated: true, completion: nil)
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
}

func getMaxSkillPoint(button: String) -> Double {
    let songInfo = try! Realm().objects(SongInfo.self)
    var max = 0.0
    var top50 = [Int]()
    switch(button){
    case "4B":
        for i in songInfo{
            let array = [i.nm4, i.hd4, i.mx4]
            let value = array.sorted().last!
            top50.append(value)
        }
    case "5B":
        for i in songInfo{
            let array = [i.nm5, i.hd5, i.mx5]
            let value = array.sorted().last!
            top50.append(value)
        }
    case "6B":
        for i in songInfo{
            let array = [i.nm6, i.hd6, i.mx6]
            let value = array.sorted().last!
            top50.append(value)
        }
    case "8B":
        for i in songInfo{
            let array = [i.nm8, i.hd8, i.mx8]
            let value = array.sorted().last!
            top50.append(value)
        }
    default:
        break
    }
    top50 = top50.sorted() { $0 > $1 }
    for i in 0...49{
        max += getWeight(value: top50[i]) * 105
    }
    return max
}

func getMySkillPoint(button: String) -> (sum: Double, highestSeries: String){
    let record: Results<RecordInfo>!
    switch(button){
    case "4B":
        record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
    case "5B":
        record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
    case "6B":
        record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
    case "8B":
        record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
    default:
        record = nil
    }
    var sum: Double = 0
    switch(button){
    case "4B":
        for i in 0..<50{
            sum += record[i].button4SkillPoint
        }
        UserDefaults.standard.set(sum, forKey: "button4SkillPoint")
    case "5B":
        for i in 0..<50{
            sum += record[i].button5SkillPoint
        }
        UserDefaults.standard.set(sum, forKey: "button5SkillPoint")
    case "6B":
        for i in 0..<50{
            sum += record[i].button6SkillPoint
        }
        UserDefaults.standard.set(sum, forKey: "button6SkillPoint")
    case "8B":
        for i in 0..<50{
            sum += record[i].button8SkillPoint
        }
        UserDefaults.standard.set(sum, forKey: "button8SkillPoint")
    default:
        break
    }
    let highestSeries = (record.first?.series)!
    return (sum, highestSeries)
}

func getSkillLevelButton4(value: Double) -> String{
    switch(value){
    case 0..<1000:
        return"BEGINNER"
    case 1000..<1500:
        return "AMATEUR 4"
    case 1500..<2000:
        return "AMATEUR 3"
    case 2000..<2300:
        return "AMATEUR 2"
    case 2300..<2600:
        return "AMATEUR 1"
    case 2600..<3000:
        return "SUB DJ 4"
    case 3000..<3300:
        return "SUB DJ 3"
    case 3300..<3600:
        return "SUB DJ 2"
    case 3600..<4000:
        return "SUB DJ 1"
    case 4000..<4300:
        return "MAIN DJ 4"
    case 4300..<4600:
        return "MAIN DJ 3"
    case 4600..<5000:
        return "MAIN DJ 2"
    case 5000..<5300:
        return "MAIN DJ 1"
    case 5300..<5600:
        return "POP DJ 4"
    case 5600..<6000:
        return "POP DJ 3"
    case 6000..<6300:
        return "POP DJ 2"
    case 6300..<6600:
        return "POP DJ 1"
    case 6600..<7000:
        return "PROFESSIONAL 3"
    case 7000..<7200:
        return "PROFESSIONAL 2"
    case 7200..<7400:
        return "PROFESSIONAL 1"
    case 7400..<7600:
        return "MIX MASTER 3"
    case 7600..<7800:
        return "MIX MASTER 2"
    case 7800..<8000:
        return "MIX MASTER 1"
    case 8000..<8200:
        return "SUPERSTAR 3"
    case 8200..<8400:
        return "SUPERSTAR 2"
    case 8400..<8600:
        return "SUPERSTAR 1"
    case 8600..<8800:
        return "DJMAX GRAND MASTER"
    case 8800...:
        return "THE DJMAX"
    default:
        return ""
    }
}

func getSkillLevelButton5(value: Double) -> String{
    switch(value){
    case 0..<1000:
        return "BEGINNER"
    case 1000..<1500:
        return "AMATEUR 4"
    case 1500..<2000:
        return "AMATEUR 3"
    case 2000..<2300:
        return "AMATEUR 2"
    case 2300..<2600:
        return "AMATEUR 1"
    case 2600..<3000:
        return "SUB DJ 4"
    case 3000..<3300:
        return "SUB DJ 3"
    case 3300..<3600:
        return "SUB DJ 2"
    case 3600..<4000:
        return "SUB DJ 1"
    case 4000..<4300:
        return "MAIN DJ 4"
    case 4300..<4600:
        return "MAIN DJ 3"
    case 4600..<5000:
        return "MAIN DJ 2"
    case 5000..<5300:
        return "MAIN DJ 1"
    case 5300..<5600:
        return "POP DJ 4"
    case 5600..<6000:
        return "POP DJ 3"
    case 6000..<6300:
        return "POP DJ 2"
    case 6300..<6600:
        return "POP DJ 1"
    case 6600..<7000:
        return "PROFESSIONAL 4"
    case 7000..<7200:
        return "PROFESSIONAL 3"
    case 7200..<7400:
        return "PROFESSIONAL 2"
    case 7400..<7600:
        return "PROFESSIONAL 1"
    case 7600..<7800:
        return "MIX MASTER 3"
    case 7800..<8000:
        return "MIX MASTER 2"
    case 8000..<8200:
        return "MIX MASTER 1"
    case 8200..<8400:
        return "SUPERSTAR 3"
    case 8400..<8600:
        return "SUPERSTAR 2"
    case 8600..<8800:
        return "SUPERSTAR 1"
    case 8800..<9000:
        return "DJMAX GRAND MASTER"
    case 9000...:
        return "THE DJMAX"
    default:
        return ""
    }
}

func getSkillLevelButton6And8(value: Double) -> String{
    switch(value){
    case 0..<1500:
        return "BEGINNER"
    case 1500..<2000:
        return "AMATEUR 4"
    case 2000..<2300:
        return "AMATEUR 3"
    case 2300..<2600:
        return "AMATEUR 2"
    case 2600..<3000:
        return "AMATEUR 1"
    case 3000..<3300:
        return "SUB DJ 4"
    case 3300..<3600:
        return "SUB DJ 3"
    case 3600..<4000:
        return "SUB DJ 2"
    case 4000..<4300:
        return "SUB DJ 1"
    case 4300..<4600:
        return "MAIN DJ 4"
    case 4600..<5000:
        return "MAIN DJ 3"
    case 5000..<5300:
        return "MAIN DJ 2"
    case 5300..<5600:
        return "MAIN DJ 1"
    case 5600..<6000:
        return "POP DJ 4"
    case 6000..<6300:
        return "POP DJ 3"
    case 6300..<6600:
        return "POP DJ 2"
    case 6600..<7000:
        return "POP DJ 1"
    case 7000..<7200:
        return "PROFESSIONAL 4"
    case 7200..<7400:
        return "PROFESSIONAL 3"
    case 7400..<7600:
        return "PROFESSIONAL 2"
    case 7600..<7800:
        return "PROFESSIONAL 1"
    case 7800..<8000:
        return "MIX MASTER 3"
    case 8000..<8200:
        return "MIX MASTER 2"
    case 8200..<8400:
        return "MIX MASTER 1"
    case 8400..<8600:
        return "SUPERSTAR 3"
    case 8600..<8800:
        return "SUPERSTAR 2"
    case 8800..<9000:
        return "SUPERSTAR 1"
    case 9000..<9200:
        return "DJMAX GRAND MASTER"
    case 9200...:
        return "THE DJMAX"
    default:
        return ""
    }
}

func getNextString(string: String, button: String) -> String{
    var index: Int=0
    var nextString = "Next".localized + " : "
    switch(button){
    case "4B":
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
    case "5B":
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
    case "6B", "8B":
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
