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
    var indexes = [Int]()
    var tips: TipResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchTips()
        showIndicator()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTips), name: .didReceiveTips, object: nil)
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let tips = notification.userInfo?["tips"] as? TipResponse else { return }
        self.tips = tips
        generateRandomNumbers()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.hideIndicator()
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TipViewController {
    private func generateRandomNumbers() {
        guard let tips = self.tips else { return }
        var randomNumber = arc4random_uniform(UInt32((tips.count)))
        for _ in 0..<tips.count {
            while indexes.contains(Int(randomNumber)) {
                randomNumber = arc4random_uniform(UInt32((tips.count)))
            }
            indexes.append(Int(randomNumber))
        }
    }
    
    private func setupTableView() {
        self.tableView.layer.borderColor = UIColor.main.cgColor
        self.tableView.layer.borderWidth = 3
        self.tableView.layer.cornerRadius = 10
    }
}

extension TipViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell") else { return UITableViewCell() }
        let title = self.tips?[indexes[indexPath.row]].title
        cell.textLabel?.text = regionCode == "KR" ? title?.korean : title?.english
        return cell    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tips?.count ?? 0
    }
}

extension TipViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
