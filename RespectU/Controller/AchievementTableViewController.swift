//
//  AchievementTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 11. 10..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import ActionSheetPicker_3_0

class AchievementTableViewController: UITableViewController {

    @IBOutlet weak var searchButton: UIBarButtonItem!
    let isNight=UserDefaults.standard.bool(forKey: "night")
    var realm: Realm? = nil
    var results: Results<AchievementInfo>? = nil
    var type: String = ""
    var index = 0
    var stageCount: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = try! Realm().objects(AchievementInfo.self)
        var count = 0
        var tempTitle = ""
        var isFirst = true
        for item in results!{
            if(tempTitle != item.title){
                tempTitle = item.title
                if(isFirst){
                    isFirst = false
                } else {
                    stageCount.append(count)
                    count = 0
                }
            }
            count+=1
        }
        stageCount.append(count)
        
        searchButton.title = "Search".localized
        navigationItem.title = "ACHIEVEMENT".localized
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return stageCount.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stageCount[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var index = 0
        for i in 0...section{
            index += stageCount[i]
        }
        return results![index - 1].title.localized
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell", for: indexPath) as! AchievementTableViewCell
        
        var rowIndex=0
        if(indexPath.section > 0){
            for i in 1...indexPath.section{
                rowIndex=rowIndex + stageCount[i-1]
            }
        }
        rowIndex=rowIndex+indexPath.row
        let object = results![rowIndex]
        cell.stage.text = String(object.level)
        cell.item.text = object.item
        cell.type.text = object.type
        cell.backgroundColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.item.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func search(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(withTitle: "Search".localized, rows: [
            ["All", "MUSIC", "GEAR SKIN", "NOTE SKIN", "GALLERY", "COMMENT"]], initialSelection: [index], doneBlock: {
                picker, indexes, values in
                self.index=indexes![0] as! Int
                var filterString = ""
                switch(indexes![0] as! Int){
                case 0:
                    filterString = "type LIKE '*'"
                case 1:
                    filterString = "type = 'MUSIC'"
                case 2:
                    filterString = "type = 'GEAR SKIN'"
                case 3:
                    filterString = "type = 'NOTE SKIN'"
                case 4:
                    filterString = "type = 'GALLERY'"
                case 5:
                    filterString = "type = 'COMMENT'"
                default:
                    break
                }
                self.stageCount.removeAll()
                self.results=try! Realm().objects(AchievementInfo.self).filter(filterString)
                var count = 0
                var tempTitle = ""
                var isFirst = true
                for item in self.results!{
                    if(tempTitle != item.title){
                        tempTitle = item.title
                        if(isFirst){
                            isFirst = false
                        } else {
                            self.stageCount.append(count)
                            count = 0
                        }
                    }
                    count+=1
                }
                self.stageCount.append(count)
                
                self.tableView.reloadData()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
}
