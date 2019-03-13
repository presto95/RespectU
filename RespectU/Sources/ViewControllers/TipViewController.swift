//
//  TipViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The tip view controller.
final class TipViewController: UIViewController {
  
  /// The generated indexes.
  private var indexes = [Int]()
  
  /// The fetched tips.
  private var results: Results<TipInfo>?
  
  /// The cell identifier.
  private let cellIdentifier = "tipCell"
  
  /// The table view.
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    results = TipInfo.fetch()
    generateRandomNumbers()
    setupTableView()
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Conforming UITableViewDataSource

extension TipViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = results?[indexes[indexPath.row]].localizedTitle
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results?.count ?? 0
  }
}

// MARK: - Conforming UITableViewDelegate

extension TipViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - Private Method

private extension TipViewController {
  
  func generateRandomNumbers() {
    guard let tips = self.results else { return }
    var randomNumber = Int.random(in: 0..<tips.count)
    for _ in 0..<tips.count {
      while indexes.contains(randomNumber) {
        randomNumber = Int.random(in: 0..<tips.count)
      }
      indexes.append(randomNumber)
    }
  }
  
  func setupTableView() {
    tableView.layer.do {
      $0.borderColor = UIColor.lightGray.cgColor
      $0.borderWidth = 1
      $0.cornerRadius = 15
    }
  }
}
