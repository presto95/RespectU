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

class SongViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var selectedButtonLabel: UILabel!
    let all = SongAllTableViewController()
    let portable1 = SongPortable1TableViewController()
    let portable2 = SongPortable2TableViewController()
    let respect = SongRespectTableViewController()
    let trilogy = SongTrilogyTableViewController()
    let ce = SongCETableViewController()
    let technika = SongTechnika1TableViewController()
    let bs = SongBSTableViewController()
    let favorite = SongFavoriteTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedButtonLabel.text = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        settings.style.buttonBarBackgroundColor = UIColor.subColor
        settings.style.buttonBarItemBackgroundColor = UIColor.subColor
        settings.style.selectedBarBackgroundColor = UIColor.mainColor
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    static func instantiate() -> SongViewController? {
        guard let viewController = UIStoryboard(name: "Song", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? SongViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [all, portable1, portable2, respect, trilogy, ce, technika, bs, favorite]
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let alert = UIAlertController.showSearch(all: all, portable1: portable1, portable2: portable2, respect: respect, trilogy: trilogy, ce: ce, technika1: technika, bs: bs, favorite: favorite, selectedButtonLabel: self.selectedButtonLabel)
        present(alert, animated: true)
    }
    
    @IBAction func sortButton(_ sender: UIButton) {
        let alert = UIAlertController.showSort(all: all, portable1: portable1, portable2: portable2, respect: respect, trilogy: trilogy, ce: ce, technika1: technika, bs: bs)
        present(alert, animated: true)
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        let realm = try! Realm()
        let results = realm.objects(SongInfo.self)
        let myBpm = UserDefaults.standard.double(forKey: "bpm")
        let random = Int(arc4random_uniform(UInt32(results.count - 1)))
        let object = results[random]
        let recommendedSpeed = String.decideSpeed(speed: myBpm / Double.convertBpmToDouble(string: object.bpm))
        let message = "\(object.series)\n\n" + "SPEED Recommendation".localized + "\n\(recommendedSpeed)"
        let alert = UIAlertController.showOKButton(title: object.title, message: message)
        present(alert, animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
