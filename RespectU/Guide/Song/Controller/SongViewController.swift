//
//  SongViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class SongViewController: GuideRecordBaseViewController {
    
    @IBOutlet weak var selectedButtonLabel: UILabel!
    var realm: Realm!
    lazy var all = SongAllTableViewController()
    lazy var portable1 = SongPortable1TableViewController()
    lazy var portable2 = SongPortable2TableViewController()
    lazy var respect = SongRespectTableViewController()
    lazy var trilogy = SongTrilogyTableViewController()
    lazy var ce = SongCETableViewController()
    lazy var technika1 = SongTechnika1TableViewController()
    lazy var bs = SongBSTableViewController()
    lazy var favorite = SongFavoriteTableViewController()
    var favoriteButton: String {
        return selectedButtonLabel.text ?? ""
    }
    var songViewControllers = [SongBaseTableViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realm = try! Realm()
        self.selectedButtonLabel.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        self.songViewControllers = [all, portable1, portable2, respect, trilogy, ce, technika1, bs, favorite]
    }

    static func instantiate() -> SongViewController? {
        guard let viewController = UIStoryboard(name: "Song", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? SongViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [all, portable1, portable2, respect, trilogy, ce, technika1, bs, favorite]
    }
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        UIAlertController
            .alert(title: "Search".localized, message: "Select the button type.".localized)
            .defaultAction(title: "4B") { [unowned self] action in
                self.setFavoriteButton("4B")
                self.reloadAllTableViews()
            }
            .defaultAction(title: "5B") { [unowned self] action in
                self.setFavoriteButton("5B")
                self.reloadAllTableViews()
            }
            .defaultAction(title: "6B") { [unowned self] action in
                self.setFavoriteButton("6B")
                self.reloadAllTableViews()
            }
            .defaultAction(title: "8B") { [unowned self] action in
                self.setFavoriteButton("8B")
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
        let results = self.realm.objects(SongInfo.self)
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
        let viewControllers = [all, portable1, portable2, respect, trilogy, ce, technika1, bs]
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
        let results = realm.objects(SongInfo.self)
        let count = viewControllers.count
        for index in 0..<count {
            let viewController = viewControllers[index]
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
