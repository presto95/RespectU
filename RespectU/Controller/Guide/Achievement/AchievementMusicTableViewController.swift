//
//  AchievementMusicTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class AchievementMusicTableViewController: UITableViewController {

    var realm: Realm! = nil
    var results: Results<AchievementInfo>! = nil
    var stageCount = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(AchievementInfo.self).filter("type LIKE 'MUSIC'")
        var count = 0
        var tempTitle = ""
        var isFirst = true
        for item in results{
            if(tempTitle != item.title){
                tempTitle = item.title
                if(isFirst){
                    isFirst = false
                } else{
                    stageCount.append(count)
                    count = 0
                }
            }
            count += 1
        }
        stageCount.append(count)
        
        view.backgroundColor = UIColor.mainColor
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: "achievementCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell") as! AchievementCell
        var rowIndex = 0
        if(indexPath.section > 0){
            for i in 1...indexPath.section{
                rowIndex += stageCount[i-1]
            }
        }
        rowIndex += indexPath.row
        let object = results[rowIndex]
        cell.stage.text = String(object.level)
        cell.item.text = object.item
        cell.type.text = ""
        return cell
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
        return results[index-1].title.localized
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = UIColor.mainColor
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AchievementMusicTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MUSIC")
    }
}

