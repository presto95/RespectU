//
//  SongViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import PMAlertController
import RealmSwift

class SongViewController: ButtonBarPagerTabStripViewController {
    
    let all = SongAllTableViewController()
    let portable1 = SongPortable1TableViewController()
    let portable2 = SongPortable2TableViewController()
    let respect = SongRespectTableViewController()
    let trilogy = SongTrilogyTableViewController()
    let ce = SongCETableViewController()
    let technika = SongTechnikaTableViewController()
    let favorite = SongFavoriteTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.style.buttonBarBackgroundColor = UIColor.subColor
        settings.style.buttonBarItemBackgroundColor = UIColor.subColor
        settings.style.selectedBarBackgroundColor = UIColor.mainColor
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont(name: "NotoSansCJKkr-Medium", size: 14)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [all, portable1, portable2, respect, trilogy, ce, technika, favorite]
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let alert = PMAlertController.showSearch(all: all, portable1: portable1, portable2: portable2, respect: respect, trilogy: trilogy, ce: ce, technika: technika, favorite: favorite)
        present(alert, animated: true)
    }
    
    @IBAction func sortButton(_ sender: UIButton) {
        let alert = PMAlertController.showSort(all: all, portable1: portable1, portable2: portable2, respect: respect, trilogy: trilogy, ce: ce, technika: technika)
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
        let alert = PMAlertController.showOKButton(title: object.title, message: message)
        present(alert, animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
