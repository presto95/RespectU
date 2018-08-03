//
//  SongFavoriteTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift
import DZNEmptyDataSet

class SongFavoriteTableViewController: SongBaseTableViewController {
    
    var playlistResults: Results<PlaylistInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.playlistResults = PlaylistInfo.get()
        self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = self.playlistResults[indexPath.row]
        let recommendedSpeed = getRecommendedSpeed(speed: myBPM / object.bpm.bpmToDouble)
        let message = "SPEED Recommendation".localized + "\n\(recommendedSpeed)"
        UIAlertController
            .alert(title: object.title, message: message)
            .destructiveAction(title: "Remove".localized) { [unowned self] action in
                let query = NSPredicate(format: "title = %@", object.title)
                guard let row = PlaylistInfo.get().filter(query).first else { return }
                PlaylistInfo.delete(row)
                self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
            }
            .cancelAction(title: "OK".localized)
            .present(to: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlistResults.count
    }
}

extension SongFavoriteTableViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "info")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Favorites".localized, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return nil
    }
}
extension SongFavoriteTableViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        tableView.backgroundColor = UIColor.subColor
        tableView.separatorStyle = .none
    }
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        tableView.backgroundColor = UIColor.mainColor
        tableView.separatorStyle = .singleLine
    }
}

extension SongFavoriteTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "FAVORITE")
    }
}
