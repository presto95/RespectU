//
//  TipViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

final class TipViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var indexes = [Int]()
  
  var results: Results<TipInfo>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TipInfo.fetch()
    generateRandomNumbers()
    setupTableView()
  }
  
  @IBAction func touchUpCancelButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension TipViewController {
  
  private func generateRandomNumbers() {
    guard let tips = self.results else { return }
    var randomNumber = Int.random(in: 0..<tips.count)
    for _ in 0..<tips.count {
      while indexes.contains(Int(randomNumber)) {
        randomNumber = Int.random(in: 0..<tips.count)
      }
      indexes.append(Int(randomNumber))
    }
  }
  
  private func setupTableView() {
    tableView.layer.borderColor = UIColor.lightGray.cgColor
    tableView.layer.borderWidth = 1
    tableView.layer.cornerRadius = 15
  }
}

extension TipViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell") else { return UITableViewCell() }
    cell.textLabel?.text = self.results?[indexes[indexPath.row]].localizedTitle
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.results?.count ?? 0
  }
}

extension TipViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
