//
//  MissionTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 30..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import ActionSheetPicker_3_0
import NotificationBannerSwift

class MissionTableViewController: UITableViewController {
    
    var type:String = "Respect"
    var realm: Realm? = nil
    var results: Results<MissionInfo>? = nil
    var index=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm=try! Realm()
        results=try! Realm().objects(MissionInfo.self).filter("type = 'Respect'")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "night")){
            view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            tabBarController?.tabBar.barStyle = .black
            navigationController?.navigationBar.barStyle = .black
        }
        else{
            view.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            navigationController?.navigationBar.barStyle = .default
            tabBarController?.tabBar.barStyle = .default
        }
        tableView.reloadInputViews()
    }

    // MARK: - Table view data source

    @IBAction func search(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(withTitle: "Search".localized, rows: [
            ["Respect", "Trilogy", "Clazziquai Edition"]], initialSelection: [index], doneBlock: {
                picker, indexes, values in
                self.index=indexes![0] as! Int
                switch(indexes![0] as! Int){
                case 0:
                    self.type="Respect"
                case 1:
                    self.type="Trilogy"
                case 2:
                    self.type="CE"
                default:
                    break
                }
                self.results=try! Realm().objects(MissionInfo.self).filter("type = '"+self.type+"'")
                self.tableView.reloadData()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return results!.count/6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "missionCell", for: indexPath) as! MissionTableViewCell
        let object=results![indexPath.row+(indexPath.section*6)]
        cell.title.text=object.title
        cell.reward.text = object.reward == "" ? "None".localized : object.reward
        if(type == "Respect"){
            switch(indexPath.section){
            case 0:
                cell.color.backgroundColor=UIColor(red: 78/255.0, green: 231/255.0, blue: 190/255.0, alpha: 1)
            case 1:
                cell.color.backgroundColor=UIColor(red: 86/255.0, green: 216/255.0, blue: 244/255.0, alpha: 1)
            case 2:
                cell.color.backgroundColor=UIColor(red: 79/255.0, green: 178/255.0, blue: 232/255.0, alpha: 1)
            case 3:
                cell.color.backgroundColor=UIColor(red: 113/255.0, green: 150/255.0, blue: 222/255.0, alpha: 1)
            case 4:
                cell.color.backgroundColor=UIColor(red: 180/255.0, green: 160/255.0, blue: 235/255.0, alpha: 1)
            case 5:
                cell.color.backgroundColor=UIColor(red: 179/255.0, green: 140/255.0, blue: 229/255.0, alpha: 1)
            case 6:
                cell.color.backgroundColor=UIColor(red: 212/255.0, green: 120/255.0, blue: 239/255.0, alpha: 1)
            case 7:
                cell.color.backgroundColor=UIColor(red: 228/255.0, green: 121/255.0, blue: 230/255.0, alpha: 1)
            case 8:
                cell.color.backgroundColor=UIColor(red: 245/255.0, green: 85/255.0, blue: 167/255.0, alpha: 1)
            case 9:
                cell.color.backgroundColor=UIColor(red: 203/255.0, green: 73/255.0, blue: 99/255.0, alpha: 1)
            default:
                break
            }
        }
        else if(type == "Trilogy"){
            switch(indexPath.section){
            case 0:
                cell.color.backgroundColor=UIColor(red: 143/255.0, green: 173/255.0, blue: 212/255.0, alpha: 1)
            case 1:
                cell.color.backgroundColor=UIColor(red: 169/255.0, green: 148/255.0, blue: 222/255.0, alpha: 1)
            default:
                break
            }
        }
        else if(type == "CE"){
            switch(indexPath.section){
            case 0:
                cell.color.backgroundColor=UIColor(red: 226/255.0, green: 223/255.0, blue: 113/255.0, alpha: 1)
            case 1:
                cell.color.backgroundColor=UIColor(red: 182/255.0, green: 161/255.0, blue: 205/255.0, alpha: 1)
            default:
                break
            }
        }
        cell.backgroundColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.title.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        // Configure the cell...
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object=results![indexPath.row+(indexPath.section*6)]
        let nextView=storyboard?.instantiateViewController(withIdentifier: "MissionDetailViewController") as! MissionDetailViewController
        nextView.section=object.section
        nextView.titleDetail=object.title; nextView.more=object.more; nextView.scoreLimit=object.scoreLim
        nextView.feverLimit=object.feverLim; nextView.comboLimit=object.comboLim
        nextView.rateLimit=object.rateLim; nextView.breakLimit=object.breakLim
        nextView.song1key=object.song1key; nextView.song1level=object.song1level; nextView.song1title=object.song1title
        nextView.song2key=object.song2key; nextView.song2level=object.song2level; nextView.song2title=object.song2title;
        nextView.song3key=object.song3key; nextView.song3level=object.song3level; nextView.song3title=object.song3title;
        nextView.song4key=object.song4key; nextView.song4level=object.song4level; nextView.song4title=object.song4title;
        nextView.song5key=object.song5key; nextView.song5level=object.song5level; nextView.song5title=object.song5title;
        nextView.song6key=object.song6key; nextView.song6level=object.song6level; nextView.song6title=object.song6title;
        nextView.reward=object.reward=="" ? "None" : object.reward;
        navigationController?.pushViewController(nextView, animated: true)
        //각 곡 난이도 표시되게
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return results![section*6].section
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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

