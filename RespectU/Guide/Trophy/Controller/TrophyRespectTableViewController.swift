//
//  TrophyRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class TrophyRespectTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(TrophyInfo.self).filter("series = 'Respect'")
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
        let imageName = "respect\(indexPath.row + 1)"
        cell.imageTrophy.image = UIImage(named: imageName)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let alert: UIAlertController
        if(row == 36 || row == 37){
            alert = UIAlertController.showOKButton(title: "Hidden BGAs".localized, message: "A Lie\nEnemy Storm\nNB RANGER - Virgin Force\nNever Say\nWhiteBlue\nOut Law")
            present(alert, animated: true)
        }
        else if(row == 26){
            alert = UIAlertController.showOKButton(title: "777 Combos".localized, message: "5B NORMAL [Seeker]\n47 Combos -> BREAK -> Full Combo -> Trophy Earned".localized)
            present(alert, animated: true)
        }
        else if(row == 41){
            alert = UIAlertController.showOKButton(title: "CREDITS".localized, message: "CREDITS will appear when the average accuracy of three stages are greater than 98%.".localized)
            present(alert, animated: true)
        }
    }
}

extension TrophyRespectTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
