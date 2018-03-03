//
//  MoreTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 1..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import MessageUI
import GoogleSignIn



class MoreTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, GIDSignInUIDelegate {
    

    @IBOutlet weak var cellLogin: UITableViewCell!
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var cellAchievement: UITableViewCell!
    @IBOutlet weak var cellFavoriteButton: UITableViewCell!
    @IBOutlet weak var cellTip: UITableViewCell!
    @IBOutlet weak var cellGrade: UITableViewCell!
    
    @IBOutlet weak var labelS: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelScount: UILabel!
    @IBOutlet weak var labelAcount: UILabel!
    @IBOutlet weak var labelBcount: UILabel!
    @IBOutlet weak var labelCcount: UILabel!
    @IBOutlet weak var labelClearedPatterns: UILabel!
    @IBOutlet weak var labelClearedPatternsCount: UILabel!
    @IBOutlet weak var labelMaxCombo: UILabel!
    @IBOutlet weak var labelMaxComboCount: UILabel!
    @IBOutlet weak var labelPerfectPlay: UILabel!
    @IBOutlet weak var labelPerfectPlayCount: UILabel!
    
    var realm: Realm? = nil
    var results: Results<RecordInfo>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil){
                ERProgressHud.hide()
                self.cellLogin.textLabel?.text = "Logout".localized
                self.cellLogin.detailTextLabel?.text = Auth.auth().currentUser?.email
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            else{
                ERProgressHud.hide()
                self.cellLogin.textLabel?.text = "Login".localized
                self.cellLogin.detailTextLabel?.text = ""
                self.tableView.reloadData()
            }
        }
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        cellGrade.textLabel?.text = "Skill Level".localized
        cellAchievement.textLabel?.text = "ACHIEVEMENT".localized
        cellFavoriteButton.textLabel?.text = "My Favorite Button".localized
        cell5.textLabel?.text="Night Mode".localized
        cell5.textLabel?.font = UIFont(name: "NotoSansCJKkr-Medium", size: 15)
        cell2.detailTextLabel?.text="\(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM"
        cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        showRecords()
        let button4Grade = getGrade(sender: .button4).0
        let button5Grade = getGrade(sender: .button5).0
        let button6Grade = getGrade(sender: .button6).0
        let button8Grade = getGrade(sender: .button8).0
        let gradeArray = [button4Grade, button5Grade, button6Grade, button8Grade]
        let grade = gradeArray.sorted()[3]
        switch(grade){
        case button4Grade:
            cellGrade.detailTextLabel?.text = getGradeButton4(value: grade) + "(\(grade))"
        case button5Grade:
            cellGrade.detailTextLabel?.text = getGradeButton5(value: grade) + "(\(grade))"
        case button6Grade:
            cellGrade.detailTextLabel?.text = getGradeButton6And8(value: grade) + "(\(grade))"
        case button8Grade:
            cellGrade.detailTextLabel?.text = getGradeButton6And8(value: grade) + "(\(grade))"
        default:
            break
        }
        if(UserDefaults.standard.bool(forKey: "night")){
            nightSwitch.setOn(true, animated: false)
            view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellLogin.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellTip.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellGrade.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell1.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell5.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell6.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell7.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellLogin.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellTip.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellGrade.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelS.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelA.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelB.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelC.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelScount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelAcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelBcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelCcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelClearedPatterns.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelClearedPatternsCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelMaxCombo.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelMaxComboCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelPerfectPlay.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelPerfectPlayCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            tabBarController?.tabBar.barStyle = .black
            navigationController?.navigationBar.barStyle = .black
        }
        else{
            nightSwitch.setOn(false, animated: false)
            view.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            navigationController?.navigationBar.barStyle = .default
            tabBarController?.tabBar.barStyle = .default
            cellLogin.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellTip.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellGrade.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell1.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell6.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell7.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellLogin.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cellTip.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cellGrade.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cell2.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            cell3.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 0, alpha: 1)
            cell4.textLabel?.textColor=UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelS.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelA.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelB.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelC.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelScount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelAcount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelBcount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelCcount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelClearedPatterns.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelClearedPatternsCount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelMaxCombo.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelMaxComboCount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelPerfectPlay.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
            labelPerfectPlayCount.textColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row){
        case 1:
            if(!Reachability.isConnectedToNetwork()){
                let alert = UIAlertController(title: "Error".localized, message: "Please check the network status.".localized, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            else{
                if(cellLogin.textLabel?.text == "Login".localized){
                    //로그인
                    let alert = UIAlertController(title: "Login".localized, message: "", preferredStyle: .alert)
                    let actionGoogle = UIAlertAction(title: "Google 로그인", style: .default){_ in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                        ERProgressHud.show()
                        GIDSignIn.sharedInstance().signIn()
                    }
                    let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
                    alert.addAction(actionCancel)
                    alert.addAction(actionGoogle)
                    self.present(alert, animated: true)
                }
                else if(cellLogin.textLabel?.text == "Logout".localized){
                    //로그아웃
                    let alert = UIAlertController(title: "Logout".localized, message: "", preferredStyle: .alert)
                    let actionLogout = UIAlertAction(title: "Logout".localized, style: .destructive){_ in
                        do {
                            try Auth.auth().signOut()
                        } catch { }
                    }
                    let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
                    alert.addAction(actionCancel)
                    alert.addAction(actionLogout)
                    self.present(alert, animated: true)
                }
            }
        case 2:
            let next=self.storyboard?.instantiateViewController(withIdentifier: "GradeViewController") as! GradeViewController
            let button4 = getGrade(sender: .button4)
            let button5 = getGrade(sender: .button5)
            let button6 = getGrade(sender: .button6)
            let button8 = getGrade(sender: .button8)
            next.button4SkillLevel = getGradeButton4(value: button4.0)
            next.button4SkillPoint = button4.0
            next.button5SkillLevel = getGradeButton5(value: button5.0)
            next.button5SkillPoint = button5.0
            next.button6SkillLevel = getGradeButton6And8(value: button6.0)
            next.button6SkillPoint = button6.0
            next.button8SkillLevel = getGradeButton6And8(value: button8.0)
            next.button8SkillPoint = button8.0
            next.button4FirstSkillPoint = button4.1
            next.button5FirstSkillPoint = button5.1
            next.button6FirstSkillPoint = button6.1
            next.button8FirstSkillPoint = button8.1
            next.button4FirstSong = button4.2
            next.button5FirstSong = button5.2
            next.button6FirstSong = button6.2
            next.button8FirstSong = button8.2
            next.button4LastSkillPoint = button4.3
            next.button5LastSkillPoint = button5.3
            next.button6LastSkillPoint = button6.3
            next.button8LastSkillPoint = button8.3
            next.button4LastSong = button4.4
            next.button5LastSong = button5.4
            next.button6LastSong = button6.4
            next.button8LastSong = button8.4
            self.navigationController?.pushViewController(next, animated: true)
        case 4:
            let alert=UIAlertController(title: "Change BPM Default".localized, message: "Current".localized+" : \(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM\n\n"+"You can get SPEED Recommendation by touching Song list.".localized, preferredStyle: .alert)
            alert.addTextField{ (textField) -> Void in
                textField.keyboardType = UIKeyboardType.numberPad
                textField.placeholder = "BPM"
            }
            let yesAction=UIAlertAction(title: "OK".localized, style: .default)
            {(action: UIAlertAction)->Void in
                let tempBpm=UserDefaults.standard.double(forKey: "bpm")
                if let input=alert.textFields![0].text{
                    if let _ = Int(input){
                        UserDefaults.standard.set(input, forKey: "bpm")
                        self.cell2.detailTextLabel?.text="\(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM"
                        return
                    }
                    else{
                        UserDefaults.standard.set(tempBpm, forKey: "bpm")
                    }
                }
                else{
                    return
                }
            }
            let noAction=UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
            alert.addAction(noAction)
            alert.addAction(yesAction)
            self.present(alert, animated: true, completion: nil)
        case 5:
            let favorite = UserDefaults.standard.string(forKey: "favoriteButton")
            let alert = UIAlertController(title: "My Favorite Button".localized, message: "Current".localized+" : \(favorite ?? "None".localized)\n\n"+"The information displayed on the first run screen depends on the setting value.".localized, preferredStyle: .alert)
            let button4 = UIAlertAction(title: "4B", style: .default){(alert) in
                UserDefaults.standard.set("4B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
            }
            let button5 = UIAlertAction(title: "5B", style: .default){ (alert) in
                UserDefaults.standard.set("5B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
            }
            let button6 = UIAlertAction(title: "6B", style: .default){ (alert) in
                UserDefaults.standard.set("6B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
            }
            let button8 = UIAlertAction(title: "8B", style: .default){ (alert) in
                UserDefaults.standard.set("8B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
            }
            let buttonCancel = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
            alert.addAction(button4); alert.addAction(button5); alert.addAction(button6); alert.addAction(button8); alert.addAction(buttonCancel)
            self.present(alert, animated: true, completion: nil)
        case 7:
            sendEmail()
        case 8:
            let alert=UIAlertController(title: "Notification".localized, message: "Recommended to restart for correct operation.".localized, preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized,style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        default:
            break
        }
    }

    @IBAction func switchToNight(_ sender: UISwitch) {
        if(sender.isOn){
            UserDefaults.standard.set(true, forKey: "night")
        }else{
            UserDefaults.standard.set(false, forKey: "night")
        }
        if(UserDefaults.standard.bool(forKey: "night")){
            nightSwitch.setOn(true, animated: false)
            view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellLogin.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellTip.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellGrade.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell1.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell5.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell6.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell7.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellLogin.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellTip.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellGrade.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelS.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelA.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelB.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelC.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelScount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelAcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelBcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelCcount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelClearedPatterns.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelClearedPatternsCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelMaxCombo.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelMaxComboCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelPerfectPlay.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            labelPerfectPlayCount.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            tabBarController?.tabBar.barStyle = .black
            navigationController?.navigationBar.barStyle = .black
        }
        else{
            nightSwitch.setOn(false, animated: false)
            view.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            navigationController?.navigationBar.barStyle = .default
            tabBarController?.tabBar.barStyle = .default
            cellLogin.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellTip.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellGrade.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell1.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell6.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell7.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellLogin.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellTip.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellGrade.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell5.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelS.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelA.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelB.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelC.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelScount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelAcount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelBcount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelCcount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelClearedPatterns.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelClearedPatternsCount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelMaxCombo.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelMaxComboCount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelPerfectPlay.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelPerfectPlayCount.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        reloadInputViews()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yoohan95@gmail.com"])
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showRecords(){
        realm = try! Realm()
        results = try! Realm().objects(RecordInfo.self)
        var countS=0
        var countA=0
        var countB=0
        var countC=0
        var countClearedPatterns=0
        var countMaxCombo=0
        var countPerfectPlay=0
        for i in results!{
            if(i.nm4Rank == "S") { countS+=1 }; if(i.nm5Rank == "S") { countS+=1 }; if(i.nm6Rank == "S") { countS+=1 }; if(i.nm8Rank == "S") { countS+=1 }; if(i.hd4Rank == "S") { countS+=1 }; if(i.hd5Rank == "S") { countS+=1 }; if(i.hd6Rank == "S") { countS+=1 }; if(i.hd8Rank == "S") { countS+=1 }; if(i.mx4Rank == "S") { countS+=1 }; if(i.mx5Rank == "S") { countS+=1 }; if(i.mx6Rank == "S") { countS+=1 }; if(i.mx8Rank == "S") { countS+=1 }
            if(i.nm4Rank == "A") { countA+=1 }; if(i.nm5Rank == "A") { countA+=1 }; if(i.nm6Rank == "A") { countA+=1 }; if(i.nm8Rank == "A") { countA+=1 }; if(i.hd4Rank == "A") { countA+=1 }; if(i.hd5Rank == "A") { countA+=1 }; if(i.hd6Rank == "A") { countA+=1 }; if(i.hd8Rank == "A") { countA+=1 }; if(i.mx4Rank == "A") { countA+=1 }; if(i.mx5Rank == "A") { countA+=1 }; if(i.mx6Rank == "A") { countA+=1 }; if(i.mx8Rank == "A") { countA+=1 }
            if(i.nm4Rank == "B") { countB+=1 }; if(i.nm5Rank == "B") { countB+=1 }; if(i.nm6Rank == "B") { countB+=1 }; if(i.nm8Rank == "B") { countB+=1 }; if(i.hd4Rank == "B") { countB+=1 }; if(i.hd5Rank == "B") { countB+=1 }; if(i.hd6Rank == "B") { countB+=1 }; if(i.hd8Rank == "B") { countB+=1 }; if(i.mx4Rank == "B") { countB+=1 }; if(i.mx5Rank == "B") { countB+=1 }; if(i.mx6Rank == "B") { countB+=1 }; if(i.mx8Rank == "B") { countB+=1 };
            if(i.nm4Rank == "C") { countC+=1 }; if(i.nm5Rank == "C") { countC+=1 }; if(i.nm6Rank == "C") { countC+=1 }; if(i.nm8Rank == "C") { countC+=1 }; if(i.hd4Rank == "C") { countC+=1 }; if(i.hd5Rank == "C") { countC+=1 }; if(i.hd6Rank == "C") { countC+=1 }; if(i.hd8Rank == "C") { countC+=1 }; if(i.mx4Rank == "C") { countC+=1 }; if(i.mx5Rank == "C") { countC+=1 }; if(i.mx6Rank == "C") { countC+=1 }; if(i.mx8Rank == "C") { countC+=1 };
            countClearedPatterns = countS + countA + countB + countC
            if(i.nm4Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.nm5Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.nm6Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.nm8Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.hd4Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.hd5Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.hd6Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.hd8Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.mx4Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.mx5Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.mx6Note == "MAX COMBO") { countMaxCombo+=1 }; if(i.mx8Note == "MAX COMBO") { countMaxCombo+=1 };
            if(i.nm4Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.nm5Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.nm6Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.nm8Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.hd4Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.hd5Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.hd6Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.hd8Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.mx4Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.mx5Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.mx6Note == "PERFECT PLAY") { countPerfectPlay+=1 }; if(i.mx8Note == "PERFECT PLAY") { countPerfectPlay+=1 };
        }
        labelScount.text = String(countS)
        labelAcount.text = String(countA)
        labelBcount.text = String(countB)
        labelCcount.text = String(countC)
        labelClearedPatternsCount.text = String(countClearedPatterns)
        labelMaxComboCount.text = String(countMaxCombo)
        labelPerfectPlayCount.text = String(countPerfectPlay)
        UserDefaults.standard.set(countPerfectPlay, forKey: "countPerfectPlay")
    }
    
    func getGrade(sender: Button) -> (sum: Double, firstSongSkillPoint: Double, firstSong: String, lastSongSkillPoint: Double, lastSong: String){
        var record: Results<RecordInfo>
        switch(sender){
        case .button4:
            record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
        case .button5:
            record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
        case .button6:
            record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
        case .button8:
            record = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
        }
        let firstRecord = record.first!
        let lastRecord = record[49]
        var sum: Double = 0
        switch(sender){
        case .button4:
            for i in 0..<50{
                sum += record[i].button4SkillPoint
            }
            UserDefaults.standard.set(sum, forKey: "button4SkillPoint")
            return (sum, firstRecord.button4SkillPoint, firstRecord.title, lastRecord.button4SkillPoint, lastRecord.title)
        case .button5:
            for i in 0..<50{
                sum += record[i].button5SkillPoint
            }
            UserDefaults.standard.set(sum, forKey: "button5SkillPoint")
            return (sum, firstRecord.button5SkillPoint, firstRecord.title, lastRecord.button5SkillPoint, lastRecord.title)
        case .button6:
            for i in 0..<50{
                sum += record[i].button6SkillPoint
            }
            UserDefaults.standard.set(sum, forKey: "button6SkillPoint")
            return (sum, firstRecord.button6SkillPoint, firstRecord.title, lastRecord.button6SkillPoint, lastRecord.title)
        case .button8:
            for i in 0..<50{
                sum += record[i].button8SkillPoint
            }
            UserDefaults.standard.set(sum, forKey: "button8SkillPoint")
            return (sum, firstRecord.button8SkillPoint, firstRecord.title, lastRecord.button8SkillPoint, lastRecord.title)
        }
    }
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

