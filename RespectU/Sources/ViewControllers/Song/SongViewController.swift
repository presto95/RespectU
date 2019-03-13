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

/// The song view controller.
final class SongViewController: BaseViewController {
  
  /// The label representing the selected button.
  @IBOutlet weak var selectedButtonLabel: UILabel!
  
  /// The table view controller representing the all series.
  private lazy var allTableViewController = SongAllTableViewController()
  
  /// The table view controller representing the PORTABLE 1 series.
  private lazy var portable1TableViewController = SongPortable1TableViewController()
  
  /// The table view controller representing the PORTABLE 2 series.
  private lazy var portable2TableViewController = SongPortable2TableViewController()
  
  /// The table view controller representing the RESPECT series.
  private lazy var respectTableViewController = SongRespectTableViewController()
  
  /// The table view controller representing the TRILOGY series.
  private lazy var trilogyTableViewController = SongTrilogyTableViewController()
  
  /// The table view controller representing the CLAZZIQUAI EDITION series.
  private lazy var ceTableViewController = SongCETableViewController()
  
  /// The table view controller representing the TECHNIKA 1 series.
  private lazy var technika1TableViewController = SongTechnika1TableViewController()
  
  /// The table view controller representing the BLACK SQUARE series.
  private lazy var bsTableViewController = SongBSTableViewController()
  
  /// The table view controller representing the TECHNIKA 2 series.
  private lazy var technika2TableViewController = SongTechnika2TableViewController()
  
  /// The table view controller representing the TECHNIKA 3 series.
  private lazy var technika3TableViewController = SongTechnika3TableViewController()
  
  private var favoriteButton = Persistence.favoriteButton
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectedButtonLabel.text = Persistence.favoriteButton.rawValue.uppercased()
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
      technika2TableViewController,
      technika3TableViewController
    ]
  }
  
  /// Tells the `sender` that the search button is tapped.
  @IBAction private func searchButtonDidTap(_ sender: UIButton) {
    UIAlertController
      .alert(title: L10n.search, message: L10n.selectTheButtonType)
      .action(title: Button.button4.rawValue.uppercased()) { [weak self] _ in
        self?.favoriteButton = .button4
        self?.reloadAllTableView()
      }
      .action(title: Button.button5.rawValue.uppercased()) { [weak self] _ in
        self?.favoriteButton = .button5
        self?.reloadAllTableView()
      }
      .action(title: Button.button6.rawValue.uppercased()) { [weak self] _ in
        self?.favoriteButton = .button6
        self?.reloadAllTableView()
      }
      .action(title: Button.button8.rawValue.uppercased()) { [weak self] _ in
        self?.favoriteButton = .button8
        self?.reloadAllTableView()
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  /// Tells the `sender` that the sort button is tapped.
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
  
  /// Tells the `sender` that the random button is tapped.
  @IBAction private func randomButtonDidTap(_ sender: UIButton) {
    guard let results = allTableViewController.songResults else { return }
    let random = Int(arc4random_uniform(UInt32(results.count - 1)))
    let object = results[random]
    let myBPM = Persistence.bpm
    let speed = Utils.convertToRecommendedSpeed(by: myBPM / Double(object.bpm)) ?? ""
    var message = "\(object.series.uppercased())\n\n\(L10n.speedRecommendation)\n\(speed)"
    if object.subBPM.value != nil {
      message += "\n\(L10n.speedVariation)"
    }
    UIAlertController
      .alert(title: object.localizedTitle, message: message)
      .action(title: L10n.ok)
      .present(to: self)
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Private Method

private extension SongViewController {
  
  /// Sorts songs by `difficulty`, in `ascending` order.
  ///
  /// - Parameters:
  ///   - difficulty: The specific difficulty.
  ///   - ascending:  The boolean value indicating whether sorting in ascending order.
  func sort(byDifficulty difficulty: Difficulty, ascending: Bool) {
    if let songViewControllers = viewControllers as? [SongBaseTableViewController] {
      for viewController in songViewControllers {
        viewController.songResults?.sort { first, second in
          guard let button = Persistence.favoriteButton.expansion else { return false }
          guard let firstValue
            = first.value(forKeyPath: "\(button).\(difficulty.rawValue)") as? Int
            else { return false }
          guard let secondValue
            = second.value(forKeyPath: "\(button).\(difficulty.rawValue)") as? Int
            else { return false }
          return ascending ? firstValue < secondValue : firstValue > secondValue
        }
      }
      reloadAllTableView()
    }
  }
  
  /// Reloads all table views.
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
}
