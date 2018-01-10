//
//  TipTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class TipTableViewController: UITableViewController {

    let isNight = UserDefaults.standard.bool(forKey: "night")
    var realm: Realm? = nil
    var results: Results<TipInfo>? = nil
    var indexArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TIP"
        tabBarController?.tabBar.barStyle = isNight ? .black: .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        tableView.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        realm = try! Realm()
        results = try! Realm().objects(TipInfo.self)
        var randomNo = arc4random_uniform(UInt32((results?.count)!));
        for _ in 0..<(results?.count)!{
            while(indexArray.contains(Int(randomNo))){
                randomNo = arc4random_uniform(UInt32((results?.count)!));
                
            }
            indexArray.append(Int(randomNo))
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
        return (results?.count)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell")
        cell?.textLabel?.text = results![indexArray[indexPath.row]].tip.localized
        cell?.textLabel?.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell?.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return cell!
    }
    @IBAction func tipButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Do you have any other useful information to help you play?\nPlease let me know by using 'Send Email to Developer'.\nWe will add it for the next update.".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    

}
