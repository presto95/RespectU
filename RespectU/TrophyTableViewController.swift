//
//  TrophyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 4..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import ActionSheetPicker_3_0
import NotificationBannerSwift

class TrophyTableViewController: UITableViewController {

    var series: String="Respect"
    var realm: Realm? = nil
    var results: Results<TrophyInfo>? = nil
    var index=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm=try! Realm()
        results=try! Realm().objects(TrophyInfo.self).filter("series = 'Respect'")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "night")){
            view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            navigationController?.navigationBar.barStyle = .black
            tabBarController?.tabBar.barStyle = .black
        }else{
            view.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            navigationController?.navigationBar.barStyle = .default
            tabBarController?.tabBar.barStyle = .default
        }
    }

    // MARK: - Table view data source

    @IBAction func search(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(withTitle: "Search".localized, rows: [
            ["Respect", "Trilogy", "Clazziquai Edition"]], initialSelection: [index], doneBlock: {
                picker, indexes, values in
                self.index=indexes![0] as! Int
                switch(indexes![0] as! Int){
                case 0:
                    self.series="Respect"
                case 1:
                    self.series="Trilogy"
                case 2:
                    self.series="CE"
                default:
                    break
                }
                self.results=try! Realm().objects(TrophyInfo.self).filter("series = '"+self.series+"'")
                self.tableView.reloadData()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trophyCell", for: indexPath) as! TrophyTableViewCell
        let object=results![indexPath.row]
        //let locale = Locale.current
        let pre = Locale.preferredLanguages[0]
        switch(pre){
        case "ko-KR":
            cell.titleKor.text=object.titleKor
            cell.contentKor.text=object.contentKor
        default:
            cell.titleKor.text=object.titleEng.localized
            cell.contentKor.text=object.contentEng.localized
        }
        switch(object.rating){
        case "PLATINUM":
            cell.ratingColor.backgroundColor=UIColor(red: 229/255.0, green: 228/255.0, blue: 226/255.0, alpha: 1)
        case "GOLD":
            cell.ratingColor.backgroundColor=UIColor(red: 212/255.0, green: 175/255.0, blue: 55/255.0, alpha: 1)
        case "SILVER":
            cell.ratingColor.backgroundColor=UIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 1)
        case "BRONZE":
            cell.ratingColor.backgroundColor=UIColor(red: 205/255.0, green: 127/255.0, blue: 50/255.0, alpha: 1)
        default:
            break
        }
        cell.titleKor.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.contentKor.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.backgroundColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        // Configure the cell...
        var imageName = ""
        switch(object.series){
        case "Respect":
            imageName = "respect\(indexPath.row + 1).png"
        case "Trilogy":
            imageName = "trilogy\(indexPath.row + 1).png"
        case "CE":
            imageName = "ce\(indexPath.row + 1).png"
        default:
            break
        }
        cell.trophyImage.image = UIImage(named: imageName)
        /*let string = object.titleKor
        if(string == "내 마음속에 저장" || string == "고고학자" || string == "럭키 해피 데이" || string == "나올수도 있고 안나올수도 있습니다" || string == "언제나 감사합니다" || string == "Go Back From the Top"){
            cell.accessoryType = .detailButton
        }
        else{
            cell.accessoryType = .none
        }*/
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object=results![indexPath.row]
        let string=object.titleKor
        if(string == "내 마음속에 저장" || string == "고고학자"){
            let alert=UIAlertController(title: "Hidden BGAs".localized, message: "A Lie\nEnemy Storm\nNB RANGER - Virgin Force\nNever Say\nWhiteBlue\nOut Law", preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        if(string == "럭키 해피 데이"){
            let alert=UIAlertController(title: "777 Combos".localized, message: "5B NORMAL [Seeker]\n47 Combos -> BREAK -> Full Combo -> Trophy Earned".localized, preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        if(string == "나올수도 있고 안나올수도 있습니다"){
            let alert=UIAlertController(title: "Hidden BGA".localized, message: "STOP", preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        if(string == "언제나 감사합니다"){
            let alert=UIAlertController(title: "CREDITS".localized, message: "CREDITS will appear when the average accuracy of three stages are greater than 98%.".localized, preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        if(string == "Go Back From the Top"){
            let alert=UIAlertController(title: "Hidden BGA".localized.localized, message: "First Kiss", preferredStyle: .alert)
            let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    @IBAction func question(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Tap the list to see information that will help you win trophies.".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
