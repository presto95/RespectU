//
//  PlaylistTableViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 15..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import ActionSheetPicker_3_0

class PlaylistTableViewController: UITableViewController {

    var realm: Realm?=nil
    var results: Results<PlaylistInfo>?=nil
    var index=0
    var indexSort=0
    @IBOutlet weak var buttonSort: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm=try! Realm()
        results = realm?.objects(PlaylistInfo.self).sorted(byKeyPath: "id", ascending: false)
        buttonSort.title = "Sort".localized
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
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as! PlaylistTableViewCell
        let object=results![indexPath.row]
        cell.title.text=object.title
        cell.composer.text=object.composer
        cell.bpm.text="BPM " + object.bpm
        switch(object.series){
        case "Respect":
            cell.series.backgroundColor=UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Trilogy":
            cell.series.backgroundColor=UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Portable2":
            cell.series.backgroundColor=UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "Portable1":
            cell.series.backgroundColor=UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "CE":
            cell.series.backgroundColor=UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
            
        }
        cell.backgroundColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.title.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        cell.bpm.textColor = UserDefaults.standard.bool(forKey: "night") ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell=tableView.cellForRow(at: indexPath) as! PlaylistTableViewCell
        
        let standardBpm=UserDefaults.standard.double(forKey: "bpm")
        var recommend: String=""
        var recommendTransform: String="\n"+"(SPEED Variation)".localized
        var bpm: Double=0.0
        let bpmCell=cell.bpm.text!
        var strArr=bpmCell.split(separator: " ")
        if(strArr.contains("~")){
            bpm=Double(strArr[3])!
        }
        else{
            bpm=Double(strArr[1])!
            recommendTransform=""
        }
        let speed = standardBpm/bpm
        recommend=decideSpeed(speed: speed)
        
        let alert=UIAlertController(title: cell.title.text!, message: "SPEED Recommendation".localized+"\n\(recommend)\(recommendTransform)", preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true)
        
        //위의 행 삭제 부분을 AlertController에 싸기 (OK / Remove), AlertController는 배속 추천을 함.
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let object=results![indexPath.row]
        let buttonPerformance=UITableViewRowAction(style: .normal, title: "Performance".localized){action, index in
            let next=self.storyboard?.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
            next.key = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
            next.detailBpm=object.bpm
            next.detailTitle = object.title
            next.detailSeries = object.series
            next.is4BNormalExist = object.nm4 == 0 ? false : true
            next.is4BHardExist = object.hd4 == 0 ? false : true
            next.is4BMaximumExist = object.mx4 == 0 ? false : true
            next.is5BNormalExist = object.nm5 == 0 ? false : true
            next.is5BHardExist = object.hd5 == 0 ? false : true
            next.is5BMaximumExist = object.mx5 == 0 ? false : true
            next.is6BNormalExist = object.nm6 == 0 ? false : true
            next.is6BHardExist = object.hd6 == 0 ? false : true
            next.is6BMaximumExist = object.mx6 == 0 ? false : true
            next.is8BNormalExist = object.nm8 == 0 ? false : true
            next.is8BHardExist = object.hd8 == 0 ? false : true
            next.is8BMaximumExist = object.mx8 == 0 ? false : true
            next.nm4 = object.nm4; next.nm5=object.nm5; next.nm6=object.nm6; next.nm8=object.nm8
            next.hd4=object.hd4; next.hd5=object.hd5; next.hd6=object.hd6; next.hd8=object.hd8
            next.mx4=object.mx4; next.mx5=object.mx5; next.mx6=object.mx6; next.mx8=object.mx8
            self.navigationController?.pushViewController(next, animated: true)
        }
        let buttonRemovePlaylist=UITableViewRowAction(style: .default, title: "Remove".localized){action, index in
            let view = UIImageView(image: #imageLiteral(resourceName: "success"))
            let query=NSPredicate(format: "title = %@", object.title)
            let deleteRow=self.results!.filter(query)[0]
            try! self.realm!.write{
                self.realm!.delete(deleteRow)
                tableView.reloadData()
            }
            
            
        }
        switch(object.series){
        case "Trilogy":
            buttonPerformance.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Respect":
            buttonPerformance.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Portable1":
            buttonPerformance.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "Portable2":
            buttonPerformance.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "CE":
            buttonPerformance.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
        }
        return [buttonPerformance, buttonRemovePlaylist]
    }

    @IBAction func sort(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(withTitle: "Sort".localized, rows: [
            ["Recently Added".localized, "Series".localized, "Alphabetical".localized]
            ], initialSelection: [indexSort], doneBlock: {
                picker, indexes, values in
                self.indexSort = indexes![0] as! Int
                switch(self.indexSort){
                case 0:
                    self.results = try! Realm().objects(PlaylistInfo.self).sorted(byKeyPath: "id", ascending: false)
                case 1:
                    self.results = try! Realm().objects(PlaylistInfo.self).sorted(byKeyPath: "series")
                case 2:
                    self.results = try! Realm().objects(PlaylistInfo.self).sorted(byKeyPath: "title")
                default:
                    break
                }
                self.tableView.reloadData()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    func decideSpeed(speed: Double)->String{
        var recommend: String=""
        switch(speed){
        case ..<0.50:
            recommend="0.50"
        case 0.50..<0.75:
            recommend="0.50 ~ 0.75"
        case 0.75..<1.00:
            recommend="0.75 ~ 1.00"
        case 1.00..<1.25:
            recommend="1.00 ~ 1.25"
        case 1.25..<1.50:
            recommend="1.25 ~ 1.50"
        case 1.50..<1.75:
            recommend="1.50 ~ 1.75"
        case 1.75..<2.00:
            recommend="1.75 ~ 2.00"
        case 2.00..<2.25:
            recommend="2.00 ~ 2.25"
        case 2.25..<2.50:
            recommend="2.25 ~ 2.50"
        case 2.50..<2.75:
            recommend="2.50 ~ 2.75"
        case 2.75..<3.00:
            recommend="2.75 ~ 3.00"
        case 3.00..<3.25:
            recommend="3.00 ~ 3.25"
        case 3.25..<3.50:
            recommend="3.25 ~ 3.50"
        case 3.50..<3.75:
            recommend="3.50 ~ 3.75"
        case 3.75..<4.00:
            recommend="3.75 ~ 4.00"
        case 4.00..<4.25:
            recommend="4.00 ~ 4.25"
        case 4.25..<4.50:
            recommend="4.25 ~ 4.50"
        case 4.50..<4.75:
            recommend="4.50 ~ 4.75"
        case 4.75..<5.00:
            recommend="4.75 ~ 5.00"
        case 5.00...:
            recommend="5.00"
        default:
            break
        }
        return recommend
    }

}
