//
//  RankingPPTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class RankingPPTableViewController: UITableViewController {

    var sortedDic = [(String, Int)]()
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? (Auth.auth().currentUser?.email)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ERProgressHud.show()
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 40
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: "rankingCell")
        
        var arrayUserId = [String]()
        var arraySkillPoint = [Int]()
        let ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
            var dic = [String: Int]()
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                for i in snap.children{
                    let a = i as! DataSnapshot
                    if(a.key == "userId"){
                        arrayUserId.append(a.value! as! String)
                    }
                    if(a.key == "countPerfectPlay"){
                        arraySkillPoint.append(a.value! as! Int)
                    }
                }
            }
            for i in 0..<arrayUserId.count{
                dic[arrayUserId[i]] = arraySkillPoint[i]
            }
            self.sortedDic = dic.sorted(by: { (first, second) -> Bool in
                return first.value > second.value
            })
            self.tableView.reloadData()
            ERProgressHud.hide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedDic.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell") as! RankingCell
        cell.ranking.text = "\(indexPath.row + 1)"
        cell.nickname.text = sortedDic[indexPath.row].0
        cell.skillPoint.text = String(sortedDic[indexPath.row].1)
        return cell
    }
}

extension RankingPPTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PP")
    }
}
