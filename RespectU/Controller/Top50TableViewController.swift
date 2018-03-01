//
//  Top50TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 12..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import NotificationBannerSwift

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
        let right2Button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
        self.navigationItem.rightBarButtonItems = [rightButton, right2Button]
    
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
        cell.title.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        cell.skillPoint.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
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
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.cellForRow(at: indexPath) as! Top50TableViewCell
        let query=NSPredicate(format: "title = %@",cell.title.text!)
        let object = try! Realm().objects(SongInfo.self).filter(query).first!
        let buttonPerformance = UITableViewRowAction(style: .normal, title: "Performance".localized) { (action, index) in
            let next=self.storyboard?.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
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
        let buttonAddPlaylist=UITableViewRowAction(style: .normal, title: "Add to Playlist".localized){action, index in
            if(NotificationBannerQueue.default.numberOfBanners > 0){
                NotificationBannerQueue.default.removeAll()
            }
            let query=NSPredicate(format: "title = %@",object.title)
            if(try! Realm().objects(PlaylistInfo.self).filter(query).count == 0){
                let view=UIImageView(image: #imageLiteral(resourceName: "success"))
                self.addPlaylist(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
                NotificationBanner(title: "Added to Playlist".localized, subtitle: object.title, leftView: view, style: .success).show()
            }
            else{
                let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
                NotificationBanner(title: "Not Added to Playlist".localized, subtitle: "Check for duplication.".localized, leftView: view, style: .danger).show()
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
        return [buttonPerformance, buttonAddPlaylist]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    
    @objc func share(_ sender: UIBarButtonItem){
        var image = UIImage();
        UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, false, UIScreen.main.scale)
        
        // save initial values
        let savedContentOffset = self.tableView.contentOffset
        let savedFrame = self.tableView.frame
        let savedBackgroundColor = self.tableView.backgroundColor
        
        // reset offset to top left point
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        // set frame to content size
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.tableView.contentSize.width, height: self.tableView.contentSize.height)
        // remove background
        self.tableView.backgroundColor = UIColor.clear
        
        // make temp view with scroll view content size
        // a workaround for issue when image on ipad was drawn incorrectly
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.contentSize.width, height: self.tableView.contentSize.height))
        
        // save superview
        let tempSuperView = self.tableView.superview
        // remove scrollView from old superview
        self.tableView.removeFromSuperview()
        // and add to tempView
        tempView.addSubview(self.tableView)
        
        // render view
        // drawViewHierarchyInRect not working correctly
        tempView.layer.render(in: UIGraphicsGetCurrentContext()!)
        // and get image
        image = UIGraphicsGetImageFromCurrentImageContext()!
        
        // and return everything back
        tempView.subviews[0].removeFromSuperview()
        tempSuperView?.addSubview(self.tableView)
        
        // restore saved settings
        self.tableView.contentOffset = savedContentOffset
        self.tableView.frame = savedFrame
        self.tableView.backgroundColor = savedBackgroundColor
        
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
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

    func addPlaylist(series: String, title: String, composer: String, bpm: String, nm4: Int, hd4: Int, mx4: Int, nm5: Int, hd5: Int, mx5: Int, nm6: Int, hd6: Int, mx6: Int, nm8: Int, hd8: Int, mx8: Int){
        let playlist=PlaylistInfo()
        playlist.series=series; playlist.title=title; playlist.composer=composer; playlist.bpm=bpm
        playlist.nm4=nm4; playlist.nm5=nm5; playlist.nm6=nm6; playlist.nm8=nm8
        playlist.hd4=hd4; playlist.hd5=hd5; playlist.hd6=hd6; playlist.hd8=hd8
        playlist.mx4=mx4; playlist.mx5=mx5; playlist.mx6=mx6; playlist.mx8=mx8
        
        let realm=try! Realm()
        playlist.id = (realm.objects(PlaylistInfo.self).max(ofProperty: "id") as Int? ?? 0) + 1
        try! realm.write{
            realm.add(playlist)
        }
    }
    
}
