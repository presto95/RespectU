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
    private lazy var favoriteTableViewController = SongFavoriteTableViewController()
    lazy var songViewControllers: [SongBaseTableViewController] = {
        return [allTableViewController, portable1TableViewController, portable2TableViewController, respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, favoriteTableViewController]
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
            .defaultAction(title: Buttons.button4) { [unowned self] action in
                self.setFavoriteButton(Buttons.button4)
                self.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button5) { [unowned self] action in
                self.setFavoriteButton(Buttons.button5)
                self.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button6) { [unowned self] action in
                self.setFavoriteButton(Buttons.button6)
                self.reloadAllTableViews()
            }
            .defaultAction(title: Buttons.button8) { [unowned self] action in
                self.setFavoriteButton(Buttons.button8)
                self.reloadAllTableViews()
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpSortButton(_ sender: UIButton) {
        UIAlertController
            .alert(title: "Sort".localized, message: "Select the sort method".localized)
            .defaultAction(title: "\(Difficulty.normal) / ASC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.normal, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.normal) / DESC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.normal, isAscending: false)
            }
            .defaultAction(title: "\(Difficulty.hard) / ASC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.hard, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.hard) / ASC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.hard, isAscending: false)
            }
            .defaultAction(title: "\(Difficulty.maximum) / ASC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.maximum, isAscending: true)
            }
            .defaultAction(title: "\(Difficulty.maximum) / ASC".localized) { [unowned self] action in
                self.sort(difficulty: Difficulty.maximum, isAscending: false)
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpRandomButton(_ sender: UIButton) {
        let results = SongInfo.get()
        let myBPM = UserDefaults.standard.double(forKey: "bpm")
        let random = Int(arc4random_uniform(UInt32(results.count - 1)))
        let object = results[random]
        let recommendedSpeed = getRecommendedSpeed(speed: myBPM / object.bpm.bpmToDouble)
        let message = "\(object.series)\n\n" + "SPEED Recommendation".localized + "\n\(recommendedSpeed)"
        UIAlertController
            .alert(title: object.title, message: message)
            .defaultAction(title: "OK".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SongViewController {
    private func sort(difficulty: String, isAscending: Bool) {
        let tempViewControllers = [allTableViewController, portable1TableViewController, portable2TableViewController, respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController]
        let serieses = ["", Series.portable1, Series.portable2, Series.respect, Series.trilogy, Series.ce, Series.technika1, Series.bs]
        var keyPath: String = ""
        switch favoriteButton {
        case Buttons.button4:
            keyPath = {
                switch difficulty {
                case Difficulty.normal:
                    return "nm4"
                case Difficulty.hard:
                    return "hd4"
                case Difficulty.maximum:
                    return "mx4"
                default:
                    return ""
                }
            }()
        case Buttons.button5:
            keyPath = {
                switch difficulty {
                case Difficulty.normal:
                    return "nm5"
                case Difficulty.hard:
                    return "hd5"
                case Difficulty.maximum:
                    return "mx5"
                default:
                    return ""
                }
            }()
        case Buttons.button6:
            keyPath = {
                switch difficulty {
                case Difficulty.normal:
                    return "nm6"
                case Difficulty.hard:
                    return "hd6"
                case Difficulty.maximum:
                    return "mx6"
                default:
                    return ""
                }
            }()
        case Buttons.button8:
            keyPath = {
                switch difficulty {
                case Difficulty.normal:
                    return "nm8"
                case Difficulty.hard:
                    return "hd8"
                case Difficulty.maximum:
                    return "mx8"
                default:
                    return ""
                }
            }()
        default:
            break
        }
        let sortDescriptor = [SortDescriptor(keyPath: keyPath, ascending: isAscending), SortDescriptor(keyPath: "lowercase", ascending: true)]
        let results = SongInfo.get()
        let count = tempViewControllers.count
        for index in 0..<count {
            let viewController = tempViewControllers[index]
            let series = serieses[index]
            if series.isEmpty {
                viewController.songResults = results.sorted(by: sortDescriptor)
            } else {
                viewController.songResults = results.filter("series = '\(series)'").sorted(by: sortDescriptor)
            }
        }
        reloadAllTableViews()
    }
    
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
