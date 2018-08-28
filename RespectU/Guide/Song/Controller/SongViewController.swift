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

class SongViewController: BaseViewController {
    
    @IBOutlet weak var selectedButtonLabel: UILabel!
    private lazy var allTableViewController = SongAllTableViewController()
    private lazy var portable1TableViewController = SongPortable1TableViewController()
    private lazy var portable2TableViewController = SongPortable2TableViewController()
    private lazy var respectTableViewController = SongRespectTableViewController()
    private lazy var trilogyTableViewController = SongTrilogyTableViewController()
    private lazy var ceTableViewController = SongCETableViewController()
    private lazy var technika1TableViewController = SongTechnika1TableViewController()
    private lazy var bsTableViewController = SongBSTableViewController()
    lazy var songViewControllers: [SongBaseTableViewController] = {
        return [allTableViewController, portable1TableViewController, portable2TableViewController, respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController]
    }()
    var favoriteButton: String {
        return selectedButtonLabel.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedButtonLabel.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return songViewControllers
    }
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        UIAlertController
            .alert(title: "Search".localized, message: "Select the button type.".localized)
            .defaultAction(title: Buttons.button4) { [weak self] action in
                self?.setFavoriteButton(Buttons.button4)
                self?.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button5) { [weak self] action in
                self?.setFavoriteButton(Buttons.button5)
                self?.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button6) { [weak self] action in
                self?.setFavoriteButton(Buttons.button6)
                self?.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button8) { [weak self] action in
                self?.setFavoriteButton(Buttons.button8)
                self?.reloadAllTableViews()
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpSortButton(_ sender: UIButton) {
        UIAlertController
            .alert(title: "Sort".localized, message: "Select the sort method".localized)
            .defaultAction(title: "\(Difficulty.normal) / ASC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.normal, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.normal) / DESC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.normal, isAscending: false)
            }
            .defaultAction(title: "\(Difficulty.hard) / ASC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.hard, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.hard) / DESC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.hard, isAscending: false)
            }
            .defaultAction(title: "\(Difficulty.maximum) / ASC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.maximum, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.maximum) / DESC".localized) { [weak self] action in
                self?.sort(difficulty: Difficulty.maximum, isAscending: false)
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpRandomButton(_ sender: UIButton) {
        guard let results = allTableViewController.songResults else { return }
        let random = Int(arc4random_uniform(UInt32(results.count - 1)))
        let object = results[random]
        let myBpm = UserDefaults.standard.double(forKey: "bpm")
        let speed = recommendedSpeed(by: myBpm / Double(object.bpm))
        var message = "\(object.series.uppercased())\n\n" + "SPEED Recommendation".localized + "\n\(speed)"
        if let _ = object.subBpm {
            message += "\n" + "(SPEED Variation)".localized
        }
        UIAlertController
            .alert(title: object.localizedTitle, message: message)
            .defaultAction(title: "OK".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SongViewController {
    private func sort(difficulty: String, isAscending: Bool) {
        for viewController in songViewControllers {
            switch favoriteButton {
            case Buttons.button4:
                switch difficulty {
                case Difficulty.normal:
                    if isAscending {
                        viewController.songResults?.sort { $0.button4.normal < $1.button4.normal }
                    } else {
                        viewController.songResults?.sort { $0.button4.normal > $1.button4.normal }
                    }
                case Difficulty.hard:
                    if isAscending {
                        viewController.songResults?.sort { $0.button4.hard < $1.button4.hard }
                    } else {
                        viewController.songResults?.sort { $0.button4.hard > $1.button4.hard }
                    }
                case Difficulty.maximum:
                    if isAscending {
                        viewController.songResults?.sort { $0.button4.maximum < $1.button4.maximum }
                    } else {
                        viewController.songResults?.sort { $0.button4.maximum > $1.button4.maximum }
                    }
                default:
                    break
                }
            case Buttons.button5:
                switch difficulty {
                case Difficulty.normal:
                    if isAscending {
                        viewController.songResults?.sort { $0.button5.normal < $1.button5.normal }
                    } else {
                        viewController.songResults?.sort { $0.button5.normal > $1.button5.normal }
                    }
                case Difficulty.hard:
                    if isAscending {
                        viewController.songResults?.sort { $0.button5.hard < $1.button5.hard }
                    } else {
                        viewController.songResults?.sort { $0.button5.hard > $1.button5.hard }
                    }
                case Difficulty.maximum:
                    if isAscending {
                        viewController.songResults?.sort { $0.button5.maximum < $1.button5.maximum }
                    } else {
                        viewController.songResults?.sort { $0.button5.maximum > $1.button5.maximum }
                    }
                default:
                    break
                }
            case Buttons.button6:
                switch difficulty {
                case Difficulty.normal:
                    if isAscending {
                        viewController.songResults?.sort { $0.button6.normal < $1.button6.normal }
                    } else {
                        viewController.songResults?.sort { $0.button6.normal > $1.button6.normal }
                    }
                case Difficulty.hard:
                    if isAscending {
                        viewController.songResults?.sort { $0.button6.hard < $1.button6.hard }
                    } else {
                        viewController.songResults?.sort { $0.button6.hard > $1.button6.hard }
                    }
                case Difficulty.maximum:
                    if isAscending {
                        viewController.songResults?.sort { $0.button6.maximum < $1.button6.maximum }
                    } else {
                        viewController.songResults?.sort { $0.button6.maximum > $1.button6.maximum }
                    }
                default:
                    break
                }
            case Buttons.button8:
                switch difficulty {
                case Difficulty.normal:
                    if isAscending {
                        viewController.songResults?.sort { $0.button8.normal < $1.button8.normal }
                    } else {
                        viewController.songResults?.sort { $0.button8.normal > $1.button8.normal }
                    }
                case Difficulty.hard:
                    if isAscending {
                        viewController.songResults?.sort { $0.button8.hard < $1.button8.hard }
                    } else {
                        viewController.songResults?.sort { $0.button8.hard > $1.button8.hard }
                    }
                case Difficulty.maximum:
                    if isAscending {
                        viewController.songResults?.sort { $0.button8.maximum < $1.button8.maximum }
                    } else {
                        viewController.songResults?.sort { $0.button8.maximum > $1.button8.maximum }
                    }
                default:
                    break
                }
            default:
                break
            }
        }
        reloadAllTableViews()
    }
}

extension SongViewController {
    private func setFavoriteButton(_ button: String) {
        for viewController in songViewControllers {
            viewController.favoriteButton = button
        }
        self.selectedButtonLabel.text = button
    }
    
    private func reloadAllTableViews() {
        for viewController in songViewControllers {
            viewController.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
}
