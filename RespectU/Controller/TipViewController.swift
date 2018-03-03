//
//  TipViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class TipViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var realm: Realm! = nil
    var results: Results<TipInfo>! = nil
    var indexArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        
        realm = try! Realm()
        results = realm?.objects(TipInfo.self)
        var randomNo = arc4random_uniform(UInt32((results.count)))
        for _ in 0..<results.count{
            while(indexArray.contains(Int(randomNo))){
                randomNo = arc4random_uniform(UInt32((results.count)))
            }
            indexArray.append(Int(randomNo))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension TipViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell")!
        cell.textLabel?.text = results[indexArray[indexPath.row]].tip.localized
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
}

extension TipViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
