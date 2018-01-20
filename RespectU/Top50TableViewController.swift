//
//  Top50TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 12..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
class Top50TableViewController: UITableViewController {

    let realm = try! Realm()
    var results: Results<RecordInfo>? = nil
    var sender: Int = 0
    let isNight = UserDefaults.standard.bool(forKey: "night")
    let key = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var button: String = ""
        switch(sender){
        case 0:
            button = "4B"
        case 1:
            button = "5B"
        case 2:
            button = "6B"
        case 3:
            button = "8B"
        default:
            break
        }
        navigationItem.titleView = setTitle(title: "TOP 50", subtitle: button)
        tabBarController?.tabBar.barStyle = isNight ? .black: .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        tableView.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let rightButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh(_:)))
    
        self.navigationItem.rightBarButtonItem = rightButton
        switch(sender){
        case 0:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
        case 1:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
        case 2:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
        case 3:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as! Top50TableViewCell
        cell.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.title.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.skillPoint.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let object = results![indexPath.row]
        switch(object.series){
        case "Respect":
            cell.color.backgroundColor=UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Trilogy":
            cell.color.backgroundColor=UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Portable2":
            cell.color.backgroundColor=UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "Portable1":
            cell.color.backgroundColor=UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "CE":
            cell.color.backgroundColor=UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
        }
        cell.title.text = object.title
        switch(sender){
        case 0:
            cell.skillPoint.text = "\(object.button4SkillPoint)"
            cell.difficulty.text = "\(object.button4HighestSkillPointDifficulty)"
            cell.note.text = "\(object.button4HighestSkillPointNote)"
            cell.rate.text = "\(object.button4HighestSkillPointRate)"
        case 1:
            cell.skillPoint.text = "\(object.button5SkillPoint)"
            cell.difficulty.text = "\(object.button5HighestSkillPointDifficulty)"
            cell.note.text = "\(object.button5HighestSkillPointNote)"
            cell.rate.text = "\(object.button5HighestSkillPointRate)"
        case 2:
            cell.skillPoint.text = "\(object.button6SkillPoint)"
            cell.difficulty.text = "\(object.button6HighestSkillPointDifficulty)"
            cell.note.text = "\(object.button6HighestSkillPointNote)"
            cell.rate.text = "\(object.button6HighestSkillPointRate)"
        case 3:
            cell.skillPoint.text = "\(object.button8SkillPoint)"
            cell.difficulty.text = "\(object.button8HighestSkillPointDifficulty)"
            cell.note.text = "\(object.button8HighestSkillPointNote)"
            cell.rate.text = "\(object.button8HighestSkillPointRate)"
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell=tableView.cellForRow(at: indexPath) as! Top50TableViewCell
        let next=self.storyboard?.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
        let query=NSPredicate(format: "title = %@",cell.title.text!)
        let object = try! Realm().objects(SongInfo.self).filter(query).first!
        next.key = self.key
        next.detailBpm=object.bpm
        next.detailTitle = object.title
        next.detailSeries = object.series
        next.is4BNormalExist = object.nm4 != 0
        next.is4BHardExist = object.hd4 != 0
        next.is4BMaximumExist = object.mx4 != 0
        next.is5BNormalExist = object.nm5 != 0
        next.is5BHardExist = object.hd5 != 0
        next.is5BMaximumExist = object.mx5 != 0
        next.is6BNormalExist = object.nm6 != 0
        next.is6BHardExist = object.hd6 != 0
        next.is6BMaximumExist = object.mx6 != 0
        next.is8BNormalExist = object.nm8 != 0
        next.is8BHardExist = object.hd8 != 0
        next.is8BMaximumExist = object.mx8 != 0
        next.nm4 = object.nm4; next.nm5=object.nm5; next.nm6=object.nm6; next.nm8=object.nm8
        next.hd4=object.hd4; next.hd5=object.hd5; next.hd6=object.hd6; next.hd8=object.hd8
        next.mx4=object.mx4; next.mx5=object.mx5; next.mx6=object.mx6; next.mx8=object.mx8
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func refresh(_ sender: UIBarButtonItem) {
        switch(self.sender){
        case 0:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
        case 1:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
        case 2:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
        case 3:
            results = try! Realm().objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
        default:
            break
        }
        tableView.reloadData()
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }

}
