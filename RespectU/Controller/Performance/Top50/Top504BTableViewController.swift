//
//  Top504BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class Top504BTableViewController: UITableViewController {

    var realm: Realm! = nil
    var results: Results<RecordInfo>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "Top50Cell", bundle: nil), forCellReuseIdentifier: "top50Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "top50Cell") as! Top50Cell
        let object = results[indexPath.row]
        switch(object.series){
        case Series.portable1.rawValue:
            cell.color.backgroundColor = UIColor.portable1
        case Series.portable2.rawValue:
            cell.color.backgroundColor = UIColor.portable2
        case Series.respect.rawValue:
            cell.color.backgroundColor = UIColor.respect
        case Series.trilogy.rawValue:
            cell.color.backgroundColor = UIColor.trilogy
        case Series.ce.rawValue:
            cell.color.backgroundColor = UIColor.ce
        default:
            break
        }
        cell.title.text = object.title
        cell.difficulty.text = object.button4HighestSkillPointDifficulty
        cell.note.text = object.button4HighestSkillPointNote
        cell.rate.text = object.button4HighestSkillPointRate
        cell.skillPoint.text = String(object.button4SkillPoint)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
}

extension Top504BTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "4B")
    }
}
