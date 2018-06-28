//
//  TrophyTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift
import PMAlertController

class TrophyTrilogyTableViewController: UITableViewController {

    var realm: Realm! = nil
    var results: Results<TrophyInfo>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(TrophyInfo.self).filter("series = 'Trilogy'")
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "TrophyCell", bundle: nil), forCellReuseIdentifier: "trophyCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trophyCell") as! TrophyCell
        let object = results[indexPath.row]
        switch(Locale.preferredLanguages[0]){
        case "ko-KR":
            cell.title.text = object.titleKor
            cell.content.text = object.contentKor
        default:
            cell.title.text = object.titleEng
            cell.content.text = object.contentEng
        }
        switch(object.rating){
        case Trophy.platinum.rawValue:
            cell.color.backgroundColor = UIColor.platinum
        case Trophy.gold.rawValue:
            cell.color.backgroundColor = UIColor.gold
        case Trophy.silver.rawValue:
            cell.color.backgroundColor = UIColor.silver
        case Trophy.bronze.rawValue:
            cell.color.backgroundColor = UIColor.bronze
        default:
            break
        }
        let imageName = "trilogy\(indexPath.row + 1)"
        cell.imageTrophy.image = UIImage(named: imageName)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if(row == 6){
            let alert = UIAlertController.showOKButton(title: "Hidden BGA".localized, message: "STOP")
            present(alert, animated: true)
        }
    }
}

extension TrophyTrilogyTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
