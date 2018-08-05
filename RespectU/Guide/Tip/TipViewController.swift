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
    var indexArray = [Int]()
    var results: Results<TipInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = TipInfo.get()
        var randomNo = arc4random_uniform(UInt32((results.count)))
        for _ in 0..<results.count {
            while indexArray.contains(Int(randomNo)) {
                randomNo = arc4random_uniform(UInt32((results.count)))
            }
            indexArray.append(Int(randomNo))
        }
        self.tableView.layer.borderColor = UIColor.main.cgColor
        self.tableView.layer.borderWidth = 3
        self.tableView.layer.cornerRadius = 10
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TipViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell") else { return UITableViewCell() }
        cell.textLabel?.text = results[indexArray[indexPath.row]].tip.localized
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
}

extension TipViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
