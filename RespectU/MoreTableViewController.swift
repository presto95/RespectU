//
//  MoreTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 1..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI
import NotificationBannerSwift



class MoreTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var cellAchievement: UITableViewCell!
    @IBOutlet weak var cellRateCalculator: UITableViewCell!
    @IBOutlet weak var cellFavoriteButton: UITableViewCell!
    @IBOutlet weak var cellSynchronization: UITableViewCell!
    
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
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        cellAchievement.textLabel?.text = "ACHIEVEMENT".localized
        cellRateCalculator.textLabel?.text = "RATE Calculator".localized
        cellFavoriteButton.textLabel?.text = "My Favorite Button".localized
        cell5.textLabel?.text="Night Mode".localized
        cell5.textLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 15)
        cell2.detailTextLabel?.text="\(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM"
        cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        showRecords()
        if(UserDefaults.standard.bool(forKey: "night")){
            nightSwitch.setOn(true, animated: false)
            view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellRateCalculator.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell1.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell5.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell6.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell7.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellRateCalculator.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
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
            cellFavoriteButton.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellRateCalculator.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell1.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell6.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell7.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellRateCalculator.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row){
        case 2:
            let alert=UIAlertController(title: "Change BPM Default".localized, message: "Current".localized+" : \(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM\n\n"+"You can get SPEED Recommendation by touching Song list.".localized, preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let yesAction=UIAlertAction(title: "OK".localized, style: .default)
            {(action: UIAlertAction)->Void in
                let tempBpm=UserDefaults.standard.double(forKey: "bpm")
                if let input=alert.textFields![0].text{
                    if let _ = Int(input){
                        UserDefaults.standard.set(input, forKey: "bpm")
                        self.cell2.detailTextLabel?.text="\(Int(UserDefaults.standard.double(forKey: "bpm"))) BPM"
                        let view=UIImageView(image: #imageLiteral(resourceName: "success"))
                        NotificationBanner(title: "Changed".localized, subtitle: "BPM "+input, leftView: view, style: .success).show()
                        return
                    }
                    else{
                        let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
                        UserDefaults.standard.set(tempBpm, forKey: "bpm")
                        NotificationBanner(title: "Not Changed".localized, subtitle: "Please enter a valid value.".localized, leftView: view, style: .danger).show()
                    }
                }
                else{
                    let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
                    NotificationBanner(title: "Not Changed".localized, subtitle: "Please enter a valid value.".localized, leftView: view, style: .danger).show()
                    return
                }
            }
            let noAction=UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
            alert.addAction(noAction)
            alert.addAction(yesAction)
            self.present(alert, animated: true, completion: nil)
        case 3:
            let view=UIImageView(image: #imageLiteral(resourceName: "success"))
            let favorite = UserDefaults.standard.string(forKey: "favoriteButton")
            let alert = UIAlertController(title: "My Favorite Button".localized, message: "Current".localized+" : \(favorite ?? "None".localized)\n\n"+"The information displayed on the first run screen depends on the setting value.".localized, preferredStyle: .alert)
            let button4 = UIAlertAction(title: "4B", style: .default){(alert) in
                UserDefaults.standard.set("4B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
                NotificationBanner(title: "Changed".localized, subtitle: UserDefaults.standard.string(forKey: "favoriteButton"), leftView: view, style: .success).show()
            }
            let button5 = UIAlertAction(title: "5B", style: .default){ (alert) in
                UserDefaults.standard.set("5B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
                NotificationBanner(title: "Changed".localized, subtitle: UserDefaults.standard.string(forKey: "favoriteButton"), leftView: view, style: .success).show()
            }
            let button6 = UIAlertAction(title: "6B", style: .default){ (alert) in
                UserDefaults.standard.set("6B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
                NotificationBanner(title: "Changed".localized, subtitle: UserDefaults.standard.string(forKey: "favoriteButton"), leftView: view, style: .success).show()
            }
            let button8 = UIAlertAction(title: "8B", style: .default){ (alert) in
                UserDefaults.standard.set("8B", forKey: "favoriteButton")
                self.cellFavoriteButton.detailTextLabel?.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "None".localized
                NotificationBanner(title: "Changed".localized, subtitle: UserDefaults.standard.string(forKey: "favoriteButton"), leftView: view, style: .success).show()
            }
            let buttonCancel = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
            alert.addAction(button4); alert.addAction(button5); alert.addAction(button6); alert.addAction(button8); alert.addAction(buttonCancel)
            self.present(alert, animated: true, completion: nil)
        case 5:
            sendEmail()
        case 6:
            let alert=UIAlertController(title: "Notification".localized, message: "Recommended to restart for correct operation.".localized, preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized,style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        case 8:
            let tipCount: UInt32 = 6
            let rand=arc4random() % tipCount
            switch(rand){
            case 0:
                self.alertTip(message: "Why don't you choose 'Good Bye' on the final stage of online match?".localized)
            case 1:
                self.alertTip(message: "You do not need to turn the stick when you enter an analog note.".localized)
            case 2:
                self.alertTip(message: "If you play with your face oil on your thumb, you can handle the cascading notes well :)".localized)
            case 3:
                self.alertTip(message: "You can change the keys by pressing the touch pad on the menu selection screen.".localized)
            case 4:
                self.alertTip(message: "In freestyle mode, you can keep your combos by restarting it during playback and then returning to the music selection screen.".localized)
            case 5:
                self.alertTip(message: "You can darken the BGA by pressing the touch pad during play.".localized)
            default:
                break
            }
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
            cellFavoriteButton.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellRateCalculator.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell1.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell2.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell3.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell4.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell5.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell6.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell7.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellRateCalculator.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
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
            cellFavoriteButton.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellRateCalculator.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellAchievement.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell1.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell2.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell3.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell4.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell5.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell6.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell7.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cellRateCalculator.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellAchievement.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cellFavoriteButton.textLabel?.textColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
        } else {
            showSendEmailErrorAlert()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result{
        case .cancelled:
            let view=UIImageView(image: #imageLiteral(resourceName: "info"))
            NotificationBanner(title: "Email has not been sent.".localized, subtitle: "Feel free to give feedback!".localized, leftView: view, style: .info).show()
        case .sent:
            let view=UIImageView(image: #imageLiteral(resourceName: "success"))
            NotificationBanner(title: "Email has been sent.".localized, subtitle: "Thank you for your feedback!".localized, leftView: view, style: .success).show()
        case .saved:
            let view=UIImageView(image: #imageLiteral(resourceName: "info"))
            NotificationBanner(title: "Email has been saved.".localized, subtitle: "Feel free to give feedback!".localized, leftView: view, style: .info).show()
        default:
            let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
            NotificationBanner(title: "Email has not been sent.".localized, subtitle: "".localized, leftView: view, style: .danger).show()
        }
        controller.dismiss(animated: true)
    }
    func showSendEmailErrorAlert(){
        let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
        NotificationBanner(title: "Unable to write email.".localized, subtitle: "Please check the relevant settings.".localized, leftView: view, style: .danger).show()
    }

    
    func alertTip(message: String){
        let alert=UIAlertController(title: "TIP".localized, message: message.localized, preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
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
    }
    
    
}

