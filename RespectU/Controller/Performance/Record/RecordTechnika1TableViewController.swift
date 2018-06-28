//
//  RecordTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class RecordTechnika1TableViewController: UITableViewController {
    
    let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    var realm: Realm! = nil
    var results: Results<RecordInfo>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(RecordInfo.self).filter("series = 'Technika1'").sorted(byKeyPath: "lowercase")
        view.backgroundColor = UIColor.mainColor
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "recordCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let parentViewController = self.parent as? RecordViewController{
            if(parentViewController.view.subviews.last is RecordView){
                parentViewController.scrollView.frame.size.height += 200
                parentViewController.view.subviews.last?.removeFromSuperview()
            }
            if let selectedRow = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedRow, animated: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell") as! RecordCell
        let object = results[indexPath.row]
        cell.title.text = object.title
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
        case Series.technika1.rawValue:
            cell.color.backgroundColor = UIColor.technika1
        case Series.bs.rawValue:
            cell.color.backgroundColor = UIColor.bs
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecordCell
        let parent = self.parent as! RecordViewController
        let title = cell.title.text!
        if(parent.view.subviews.last is RecordView){
            parent.view.subviews.last?.removeFromSuperview()
        } else {
            parent.scrollView.frame.size = CGSize(width: parent.view.frame.width, height: parent.scrollView.frame.height - 200)
        }
        let recordView = RecordView.instanceFromXib(title: title, tableViewController: self) as! RecordView
        recordView.frame = CGRect(x: 0, y: parent.view.frame.height - 210, width: parent.view.frame.width, height: 200)
        parent.view.addSubview(recordView)
    }
}

extension RecordTechnika1TableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 1")
    }
}
