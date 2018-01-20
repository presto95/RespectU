//
//  RankingViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 20..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let isNight = UserDefaults.standard.bool(forKey: "night")
    let key = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var resultButton4: [String: Double] = [:]
    var resultButton5: [String: Double] = [:]
    var resultButton6: [String: Double] = [:]
    var resultButton8: [String: Double] = [:]
    var resultPerfectPlay: [String: Int] = [:]
    var button4: [(String, Double)] = []
    var button5: [(String, Double)] = []
    var button6: [(String, Double)] = []
    var button8: [(String, Double)] = []
    var perfectPlay: [(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ranking".localized
        tabBarController?.tabBar.barStyle = isNight ? .black: .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        tableView.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button4 = resultButton4.sorted { $0.value > $1.value }
        button5 = resultButton5.sorted { $0.value > $1.value }
        button6 = resultButton6.sorted { $0.value > $1.value }
        button8 = resultButton8.sorted { $0.value > $1.value }
        perfectPlay = resultPerfectPlay.sorted { $0.value > $1.value }
        switch(key){
        case "4B":
            segmentedControl.selectedSegmentIndex = 0
        case "5B":
            segmentedControl.selectedSegmentIndex = 1
        case "6B":
            segmentedControl.selectedSegmentIndex = 2
        case "8B":
            segmentedControl.selectedSegmentIndex = 3
        default:
            break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            return button4.count
        case 1:
            return button5.count
        case 2:
            return button6.count
        case 3:
            return button8.count
        case 4:
            return perfectPlay.count
        default:
            return -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell") as! RankingTableViewCell
        cell.ranking.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.nickname.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.point.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.ranking.text = "\(indexPath.row + 1)"
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            cell.nickname.text = button4[indexPath.row].0
            cell.point.text = "\(button4[indexPath.row].1)"
        case 1:
            cell.nickname.text = button5[indexPath.row].0
            cell.point.text = "\(button5[indexPath.row].1)"
        case 2:
            cell.nickname.text = button6[indexPath.row].0
            cell.point.text = "\(button6[indexPath.row].1)"
        case 3:
            cell.nickname.text = button8[indexPath.row].0
            cell.point.text = "\(button8[indexPath.row].1)"
        case 4:
            cell.nickname.text = perfectPlay[indexPath.row].0
            cell.point.text = "\(perfectPlay[indexPath.row].1)"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func clickSegmentedControl(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
