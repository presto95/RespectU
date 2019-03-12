//
//  SongViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift
import XLPagerTabStrip

final class SongViewController: BaseViewController {
  
  @IBOutlet weak var selectedButtonLabel: UILabel!
  
  private lazy var allTableViewController = SongAllTableViewController()
  
  private lazy var portable1TableViewController = SongPortable1TableViewController()
  
  private lazy var portable2TableViewController = SongPortable2TableViewController()
  
  private lazy var respectTableViewController = SongRespectTableViewController()
  
  private lazy var trilogyTableViewController = SongTrilogyTableViewController()
  
  private lazy var ceTableViewController = SongCETableViewController()
  
  private lazy var technika1TableViewController = SongTechnika1TableViewController()
  
  private lazy var bsTableViewController = SongBSTableViewController()
  
  private lazy var technika2TableViewController = SongTechnika2TableViewController()
  
  var favoriteButton: Button {
    return Button(rawValue: selectedButtonLabel.text ?? "") ?? .button4
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectedButtonLabel.text
      = (UserDefaults.standard.string(forKey: "favoriteButton") ?? "4b").uppercased()
  }
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
    ) -> [UIViewController] {
    return [
      allTableViewController,
      portable1TableViewController,
      portable2TableViewController,
      respectTableViewController,
      trilogyTableViewController,
      ceTableViewController,
      technika1TableViewController,
      bsTableViewController,
      technika2TableViewController
    ]
  }
  
  @IBAction private func searchButtonDidTap(_ sender: UIButton) {
    UIAlertController
      .alert(title: L10n.search, message: L10n.selectTheButtonType)
      .action(title: Button.button4.rawValue.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(.button4)
        self?.reloadAllTableView()
      }
      .action(title: Button.button5.rawValue.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(.button5)
        self?.reloadAllTableView()
      }
      .action(title: Button.button6.rawValue.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(.button6)
        self?.reloadAllTableView()
      }
      .action(title: Button.button8.rawValue.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(.button8)
        self?.reloadAllTableView()
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  @IBAction private func sortButtonDidTap(_ sender: UIButton) {
    UIAlertController
      .alert(title: L10n.sort, message: L10n.selectTheSortMethod)
      .action(title: L10n.normalAsc) { [weak self] _ in
        self?.sort(byDifficulty: .normal, ascending: true)
      }
      .action(title: L10n.normalDesc) { [weak self] _ in
        self?.sort(byDifficulty: .normal, ascending: false)
      }
      .action(title: L10n.hardAsc) { [weak self] _ in
        self?.sort(byDifficulty: .hard, ascending: true)
      }
      .action(title: L10n.hardDesc) { [weak self] _ in
        self?.sort(byDifficulty: .hard, ascending: false)
      }
      .action(title: L10n.maximumAsc) { [weak self] _ in
        self?.sort(byDifficulty: .maximum, ascending: true)
      }
      .action(title: L10n.maximumDesc) { [weak self] _ in
        self?.sort(byDifficulty: .maximum, ascending: false)
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  @IBAction private func randomButtonDidTap(_ sender: UIButton) {
    guard let results = allTableViewController.songResults else { return }
    let random = Int(arc4random_uniform(UInt32(results.count - 1)))
    let object = results[random]
    let myBpm = UserDefaults.standard.double(forKey: "bpm")
    let speed = Utils.convertToRecommendedSpeed(by: myBpm / Double(object.bpm)) ?? ""
    var message = "\(object.series.uppercased())\n\n" + "SPEED Recommendation".localized + "\n\(speed)"
    if object.subBPM.value != nil {
      message += "\n" + "(SPEED Variation)".localized
    }
    UIAlertController
      .alert(title: object.localizedTitle, message: message)
      .action(title: L10n.ok)
      .present(to: self)
  }
  
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Private Method

private extension SongViewController {
  
  func sort(byDifficulty difficulty: Difficulty, ascending isAscending: Bool) {
    if let songViewControllers = viewControllers as? [SongBaseTableViewController] {
      for viewController in songViewControllers {
        viewController.songResults?.sort { first, second in
          guard let button = favoriteButton.expansion else { return false }
          guard let firstValue = first.value(forKeyPath: "\(button).\(difficulty.rawValue)") as? Int
            else { return false }
          guard let secondValue = second.value(forKeyPath: "\(button).\(difficulty.rawValue)") as? Int
            else { return false }
          return isAscending ? firstValue < secondValue : firstValue > secondValue
        }
      }
      reloadAllTableView()
    }
  }
  
  func setFavoriteButton(_ button: Button) {
    if let songViewControllers = viewControllers as? [SongBaseTableViewController] {
      for viewController in songViewControllers {
        viewController.favoriteButton = button.rawValue
      }
    }
    selectedButtonLabel.text = button.rawValue.uppercased()
  }
  
//  func setFavoriteButton(_ button: String) {
//    for viewController in songViewControllers {
//      viewController.favoriteButton = button
//    }
//    self.selectedButtonLabel.text = button.uppercased()
//  }
  
  func reloadAllTableView() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      if let songViewControllers = self.viewControllers as? [SongBaseTableViewController] {
        for viewController in songViewControllers {
          viewController.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
      }
    }
  }
  
//  func reloadAllTableViews() {
//    DispatchQueue.main.async { [weak self] in
//      guard let viewControllers = self?.songViewControllers else { return }
//      for viewController in viewControllers {
//        viewController.tableView.reloadSections(IndexSet(0...0), with: .automatic)
//      }
//    }
//  }
}
