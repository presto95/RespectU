//
//  MissionRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class MissionRespectTableViewController: UITableViewController {

    var realm: Realm! = nil
    var results: Results<MissionInfo>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(MissionInfo.self).filter("type = 'Respect'")
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "MissionCell", bundle: nil), forCellReuseIdentifier: "missionCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "missionCell") as! MissionCell
        let object = results[indexPath.row + (indexPath.section * 6)]
        cell.title.text = object.title
        cell.reward.text = object.reward.isEmpty ? "None".localized : object.reward
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
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return results.count / 6
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return results[section * 6].section
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = UIColor.mainColor
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MissionCell
        let storyboard = UIStoryboard(name: "Mission", bundle: nil)
        if let next = storyboard.instantiateViewController(withIdentifier: "MissionDetailViewController") as? MissionDetailViewController {
            next.modalTransitionStyle = .crossDissolve
            next.missionTitle = cell.title.text!
            present(next, animated: true, completion: nil)
        } else{
            print("Fail")
        }
        
    }
}

extension MissionRespectTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
