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

class SongViewController: GuideBaseViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realm = try! Realm()
        self.selectedButtonLabel.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
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
        let alert = UIAlertController.showSort(all: all, portable1: portable1, portable2: portable2, respect: respect, trilogy: trilogy, ce: ce, technika1: technika1, bs: bs)
        present(alert, animated: true)
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
    private func setFavoriteButton(_ button: String) {
        self.all.favoriteButton = button
        self.portable1.favoriteButton = button
        self.portable2.favoriteButton = button
        self.respect.favoriteButton = button
        self.trilogy.favoriteButton = button
        self.ce.favoriteButton = button
        self.technika1.favoriteButton = button
        self.bs.favoriteButton = button
        self.favorite.favoriteButton = button
        self.selectedButtonLabel.text = button
    }
    
    private func reloadAllTableViews() {
        self.all.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.portable1.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.portable2.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.respect.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.trilogy.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.ce.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.technika1.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.bs.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        self.favorite.tableView.reloadSections(IndexSet(0...0), with: .automatic)
    }
}
