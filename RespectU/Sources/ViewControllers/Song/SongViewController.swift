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
  
  lazy var songViewControllers: [SongBaseTableViewController] = {
    return [allTableViewController, portable1TableViewController, portable2TableViewController, respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, technika2TableViewController]
  }()
  
  var favoriteButton: String {
    return selectedButtonLabel.text ?? "4b"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.selectedButtonLabel.text = (UserDefaults.standard.string(forKey: "favoriteButton") ?? "4b").uppercased()
  }
  
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    return songViewControllers
  }
  
  @IBAction func touchUpSearchButton(_ sender: UIButton) {
    UIAlertController
      .alert(title: "Search".localized, message: "Select the button type.".localized)
      .action(title: Button.button4.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(Button.button4)
        self?.reloadAllTableViews()
      }
      .action(title: Button.button5.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(Button.button5)
        self?.reloadAllTableViews()
      }
      .action(title: Button.button6.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(Button.button6)
        self?.reloadAllTableViews()
      }
      .action(title: Button.button8.uppercased()) { [weak self] _ in
        self?.setFavoriteButton(Button.button8)
        self?.reloadAllTableViews()
      }
      .action(.cancel, title: "Cancel".localized)
      .present(to: self)
  }
  
  @IBAction func touchUpSortButton(_ sender: UIButton) {
    UIAlertController
      .alert(title: "Sort".localized, message: "Select the sort method.".localized)
      .action(title: "\(Difficulty.normal.uppercased()) / ASC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.normal, isAscending: true)
      }
      .action(title: "\(Difficulty.normal.uppercased()) / DESC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.normal, isAscending: false)
      }
      .action(title: "\(Difficulty.hard.uppercased()) / ASC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.hard, isAscending: true)
      }
      .action(title: "\(Difficulty.hard.uppercased()) / DESC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.hard, isAscending: false)
      }
      .action(title: "\(Difficulty.maximum.uppercased()) / ASC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.maximum, isAscending: true)
      }
      .action(title: "\(Difficulty.maximum.uppercased()) / DESC".localized) { [weak self] _ in
        self?.sort(difficulty: Difficulty.maximum, isAscending: false)
      }
      .action(.cancel, title: "Cancel".localized)
      .present(to: self)
  }
  
  @IBAction func touchUpRandomButton(_ sender: UIButton) {
    guard let results = allTableViewController.songResults else { return }
    let random = Int(arc4random_uniform(UInt32(results.count - 1)))
    let object = results[random]
    let myBpm = UserDefaults.standard.double(forKey: "bpm")
    let speed = recommendedSpeed(by: myBpm / Double(object.bpm))
    var message = "\(object.series.uppercased())\n\n" + "SPEED Recommendation".localized + "\n\(speed)"
    if object.subBPM.value != nil {
      message += "\n" + "(SPEED Variation)".localized
    }
    UIAlertController
      .alert(title: object.localizedTitle, message: message)
      .action(title: "OK".localized)
      .present(to: self)
  }
  
  @IBAction func touchUpCancelButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension SongViewController {
  
  private func sort(difficulty: String, isAscending: Bool) {
    for viewController in songViewControllers {
      viewController.songResults?.sort(by: { (first, second) -> Bool in
        guard let button = favoriteButton.lowercased().buttonExpansion else { return false }
        guard let firstValue = first.value(forKeyPath: "\(button).\(difficulty)") as? Int else { return false }
        guard let secondValue = second.value(forKeyPath: "\(button).\(difficulty)") as? Int else { return false }
        if isAscending {
          return firstValue < secondValue
        } else {
          return firstValue > secondValue
        }
      })
      reloadAllTableViews()
    }
  }
}

extension SongViewController {
  
  private func setFavoriteButton(_ button: String) {
    for viewController in songViewControllers {
      viewController.favoriteButton = button
    }
    self.selectedButtonLabel.text = button.uppercased()
  }
  
  private func reloadAllTableViews() {
    DispatchQueue.main.async { [weak self] in
      guard let viewControllers = self?.songViewControllers else { return }
      for viewController in viewControllers {
        viewController.tableView.reloadSections(IndexSet(0...0), with: .automatic)
      }
    }
  }
}
