//
//  SearchRecordDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class SearchRecordDetailViewController: UIViewController {

    var executesFirst = false
    var searchType: Int = 0
    var button: Int = 0
    var level: Int = 0
    var lowerRange: Double = 0
    var upperRange: Double = 0
    var detailType: Int = 0
    var levelResults: Results<PerformanceInfo>!
    var noteResults: Results<PerformanceInfo>!
    var tempRateResults: LazyFilterCollection<Results<PerformanceInfo>>!
    var rateResults: [PerformanceInfo]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let baseResults = RecordInfo.fetch()
//        noteResults = baseResults.sorted(byKeyPath: "localizedTitle")
//        levelResults = baseResults.sorted(byKeyPath: "localizedTitle")
//        tableView.rowHeight = 80
//        tableView.separatorColor = UIColor.main
//        tableView.layer.borderColor = UIColor.main.cgColor
//        tableView.layer.borderWidth = 3
//        tableView.layer.cornerRadius = 10
//        tableView.register(UINib(nibName: "SearchRecordDetailCell", bundle: nil), forCellReuseIdentifier: "searchRecordDetailCell")
//        if searchType == 0 {
//            let query: NSPredicate
//            switch button {
//            case 0:
//                query = NSPredicate(format: "nm4 = %d OR hd4 = %d OR mx4 = %d", level, level, level)
//            case 1:
//                query = NSPredicate(format: "nm5 = %d OR hd5 = %d OR mx5 = %d", level, level, level)
//            case 2:
//                query = NSPredicate(format: "nm6 = %d OR hd6 = %d OR mx6 = %d", level, level, level)
//            case 3:
//                query = NSPredicate(format: "nm8 = %d OR hd8 = %d OR mx8 = %d", level, level, level)
//            default:
//                query = NSPredicate(value: false)
//            }
//            levelResults = levelResults.filter(query)
//        } else if searchType == 1 {
//            let buttonInt: Int
//            switch button {
//            case 0:
//                buttonInt = 4
//            case 1:
//                buttonInt = 5
//            case 2:
//                buttonInt = 6
//            case 3:
//                buttonInt = 8
//            default:
//                buttonInt = 0
//            }
//            tempRateResults = noteResults.filter({ [unowned self] object -> Bool in
//                var count = 0
//                guard let normalText = (object.value(forKey: "nm\(buttonInt)Rate") as? String ?? "").split(separator: "%").first?.description else { return false }
//                guard let hardText = (object.value(forKey: "hd\(buttonInt)Rate") as? String ?? "").split(separator: "%").first?.description else { return false }
//                guard let maximumText = (object.value(forKey: "mx\(buttonInt)Rate") as? String ?? "").split(separator: "%").first?.description else { return false }
//                let range = self.lowerRange...self.upperRange
//                if let normal = Double(normalText) {
//                    if range.contains(normal) {
//                        count += 1
//                    }
//                }
//                if let hard = Double(hardText) {
//                    if range.contains(hard) {
//                        count += 1
//                    }
//                }
//                if let maximum = Double(maximumText) {
//                    if range.contains(maximum) {
//                        count += 1
//                    }
//                }
//                return count != 0
//            })
//            rateResults = Array(tempRateResults)
//        } else if searchType == 2 {
//            if detailType == 0 {
//                switch button {
//                case 0:
//                    let query = NSPredicate(format: "nm4 != 0 AND nm4Note = %@ OR hd4 != 0 AND hd4Note = %@ OR mx4 != 0 AND mx4Note = %@", "-", "-", "-")
//                    noteResults = noteResults.filter(query)
//                case 1:
//                    let query = NSPredicate(format: "nm5 != 0 AND nm5Note = %@ OR hd5 != 0 AND hd5Note = %@ OR mx5 != 0 AND mx5Note = %@", "-", "-", "-")
//                    noteResults = noteResults.filter(query)
//                case 2:
//                    let query = NSPredicate(format: "nm6 != 0 AND nm6Note = %@ OR hd6 != 0 AND hd6Note = %@ OR mx6 != 0 AND mx6Note = %@", "-", "-", "-")
//                    noteResults = noteResults.filter(query)
//                case 3:
//                    let query = NSPredicate(format: "nm8 != 0 AND nm8Note = %@ OR hd8 != 0 AND hd8Note = %@ OR mx8 != 0 AND mx8Note = %@", "-", "-", "-")
//                    noteResults = noteResults.filter(query)
//                default:
//                    break
//                }
//            } else {
//                switch button {
//                case 0:
//                    let query = NSPredicate(format: "nm4Note = %@ OR hd4Note = %@ OR mx4Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
//                    noteResults = noteResults.filter(query)
//                case 1:
//                    let query = NSPredicate(format: "nm5Note = %@ OR hd5Note = %@ OR mx5Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
//                    noteResults = noteResults.filter(query)
//                case 2:
//                    let query = NSPredicate(format: "nm6Note = %@ OR hd6Note = %@ OR mx6Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
//                    noteResults = noteResults.filter(query)
//                case 3:
//                    let query = NSPredicate(format: "nm8Note = %@ OR hd8Note = %@ OR mx8Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
//                    noteResults = noteResults.filter(query)
//                default:
//                    break
//                }
//            }
//        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchRecordDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchRecordDetailCell") as? SearchRecordDetailCell else { return UITableViewCell() }
//        if searchType == 0 {
//            let object = levelResults[indexPath.row]
//            cell.titleLabel.text = object.localizedTitle
//            let query = NSPredicate(format: "title = %@", object.title)
//            guard let songInfo = SongInfo.get().filter(query).first else { return UITableViewCell() }
//            cell.colorLabel.backgroundColor = songInfo.series.seriesColor
//            switch button {
//            case 0:
//                if object.nm4 == level {
//                    cell.normalLabel.isHidden = false
//                    cell.normalValueLabel.text = object.nm4Rate
//                } else {
//                    cell.normalLabel.isHidden = true
//                    cell.normalValueLabel.text = nil
//                }
//                if object.hd4 == level {
//                    cell.hardLabel.isHidden = false
//                    cell.hardValueLabel.text = object.hd4Rate
//                } else {
//                    cell.hardLabel.isHidden = true
//                    cell.hardValueLabel.text = nil
//                }
//                if object.mx4 == level {
//                    cell.maximumLabel.isHidden = false
//                    cell.maximumValueLabel.text = object.mx4Rate
//                } else {
//                    cell.maximumLabel.isHidden = true
//                    cell.maximumValueLabel.text = nil
//                }
//            case 1:
//                if object.nm5 == level {
//                    cell.normalLabel.isHidden = false
//                    cell.normalValueLabel.text = object.nm5Rate
//                } else {
//                    cell.normalLabel.isHidden = true
//                    cell.normalValueLabel.text = nil
//                }
//                if object.hd5 == level {
//                    cell.hardLabel.isHidden = false
//                    cell.hardValueLabel.text = object.hd5Rate
//                } else {
//                    cell.hardLabel.isHidden = true
//                    cell.hardValueLabel.text = nil
//                }
//                if object.mx5 == level {
//                    cell.maximumLabel.isHidden = false
//                    cell.maximumValueLabel.text = object.mx5Rate
//                } else {
//                    cell.maximumLabel.isHidden = true
//                    cell.maximumValueLabel.text = nil
//                }
//            case 2:
//                if object.nm6 == level {
//                    cell.normalLabel.isHidden = false
//                    cell.normalValueLabel.text = object.nm6Rate
//                } else {
//                    cell.normalLabel.isHidden = true
//                    cell.normalValueLabel.text = nil
//                }
//                if object.hd6 == level {
//                    cell.hardLabel.isHidden = false
//                    cell.hardValueLabel.text = object.hd6Rate
//                } else {
//                    cell.hardLabel.isHidden = true
//                    cell.hardValueLabel.text = nil
//                }
//                if object.mx6 == level {
//                    cell.maximumLabel.isHidden = false
//                    cell.maximumValueLabel.text = object.mx6Rate
//                } else {
//                    cell.maximumLabel.isHidden = true
//                    cell.maximumValueLabel.text = nil
//                }
//            case 3:
//                if object.nm8 == level {
//                    cell.normalLabel.isHidden = false
//                    cell.normalValueLabel.text = object.nm8Rate
//                } else {
//                    cell.normalLabel.isHidden = true
//                    cell.normalValueLabel.text = nil
//                }
//                if object.hd8 == level {
//                    cell.hardLabel.isHidden = false
//                    cell.hardValueLabel.text = object.hd8Rate
//                } else {
//                    cell.hardLabel.isHidden = true
//                    cell.hardValueLabel.text = nil
//                }
//                if object.mx8 == level {
//                    cell.maximumLabel.isHidden = false
//                    cell.maximumValueLabel.text = object.mx8Rate
//                } else {
//                    cell.maximumLabel.isHidden = true
//                    cell.maximumValueLabel.text = nil
//                }
//            default:
//                break
//            }
//        } else if searchType == 1 {
//            let object = rateResults[indexPath.row]
//            cell.titleLabel.text = object.title
//            let query = NSPredicate(format: "title = %@", object.title)
//            guard let songInfo = SongInfo.get().filter(query).first else { return UITableViewCell() }
//            cell.colorLabel.backgroundColor = songInfo.series.seriesColor
//            switch button {
//            case 0:
//                let nm4Text = object.nm4Rate.split(separator: "%")[0].description
//                let hd4Text = object.hd4Rate.split(separator: "%")[0].description
//                let mx4Text = object.mx4Rate.split(separator: "%")[0].description
//                if let nm4 = Double(nm4Text) {
//                    if nm4 >= lowerRange && nm4 <= upperRange {
//                        cell.normalValueLabel.text = nm4Text+"%"
//                        cell.normalLabel.isHidden = false
//                    } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                if let hd4 = Double(hd4Text) {
//                    if(hd4 >= lowerRange && hd4 <= upperRange){
//                        cell.hardValueLabel.text = hd4Text+"%"
//                        cell.hardLabel.isHidden = false
//                    } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                if let mx4 = Double(mx4Text) {
//                    if(mx4 >= lowerRange && mx4 <= upperRange){
//                        cell.maximumValueLabel.text = mx4Text+"%"
//                        cell.maximumLabel.isHidden = false
//                    } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//                } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//            case 1:
//                let nm5Text = object.nm5Rate.split(separator: "%")[0].description
//                let hd5Text = object.hd5Rate.split(separator: "%")[0].description
//                let mx5Text = object.mx5Rate.split(separator: "%")[0].description
//                if let nm5 = Double(nm5Text) {
//                    if(nm5 >= lowerRange && nm5 <= upperRange){
//                        cell.normalValueLabel.text = nm5Text+"%"
//                        cell.normalLabel.isHidden = false
//                    } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                if let hd5 = Double(hd5Text) {
//                    if(hd5 >= lowerRange && hd5 <= upperRange){
//                        cell.hardValueLabel.text = hd5Text+"%"
//                        cell.hardLabel.isHidden = false
//                    } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                if let mx5 = Double(mx5Text) {
//                    if(mx5 >= lowerRange && mx5 <= upperRange){
//                        cell.maximumValueLabel.text = mx5Text+"%"
//                        cell.maximumLabel.isHidden = false
//                    } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//                } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//            case 2:
//                let nm6Text = object.nm6Rate.split(separator: "%")[0].description
//                let hd6Text = object.hd6Rate.split(separator: "%")[0].description
//                let mx6Text = object.mx6Rate.split(separator: "%")[0].description
//                if let nm6 = Double(nm6Text) {
//                    if(nm6 >= lowerRange && nm6 <= upperRange){
//                        cell.normalValueLabel.text = nm6Text+"%"
//                        cell.normalLabel.isHidden = false
//                    } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                if let hd6 = Double(hd6Text) {
//                    if(hd6 >= lowerRange && hd6 <= upperRange){
//                        cell.hardValueLabel.text = hd6Text+"%"
//                        cell.hardLabel.isHidden = false
//                    } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                if let mx6 = Double(mx6Text) {
//                    if(mx6 >= lowerRange && mx6 <= upperRange){
//                        cell.maximumValueLabel.text = mx6Text+"%"
//                        cell.maximumLabel.isHidden = false
//                    } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//                } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//            case 3:
//                let nm8Text = object.nm8Rate.split(separator: "%")[0].description
//                let hd8Text = object.hd8Rate.split(separator: "%")[0].description
//                let mx8Text = object.mx8Rate.split(separator: "%")[0].description
//                if let nm8 = Double(nm8Text) {
//                    if(nm8 >= lowerRange && nm8 <= upperRange){
//                        cell.normalValueLabel.text = nm8Text+"%"
//                        cell.normalLabel.isHidden = false
//                    } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                } else { cell.normalValueLabel.text = nil; cell.normalLabel.isHidden = true }
//                if let hd8 = Double(hd8Text) {
//                    if(hd8 >= lowerRange && hd8 <= upperRange){
//                        cell.hardValueLabel.text = hd8Text+"%"
//                        cell.hardLabel.isHidden = false
//                    } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                } else { cell.hardValueLabel.text = nil; cell.hardLabel.isHidden = true }
//                if let mx8 = Double(mx8Text) {
//                    if(mx8 >= lowerRange && mx8 <= upperRange){
//                        cell.maximumValueLabel.text = mx8Text+"%"
//                        cell.maximumLabel.isHidden = false
//                    } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//                } else { cell.maximumValueLabel.text = nil; cell.maximumLabel.isHidden = true }
//            default:
//                break
//            }
//        } else if searchType == 2 {
//            let object = noteResults[indexPath.row]
//            cell.titleLabel.text = object.title
//            let query = NSPredicate(format: "title = %@", object.title)
//            guard let songInfo = SongInfo.get().filter(query).first else { return UITableViewCell() }
//            cell.colorLabel.backgroundColor = songInfo.series.seriesColor
//            if detailType == 0 {
//                switch(button){
//                case 0:
//                    if object.nm4 != 0 && object.nm4Note == "-" {
//                        cell.normalValueLabel.text = object.nm4Rate
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd4 != 0 && object.hd4Note == "-" {
//                        cell.hardValueLabel.text = object.hd4Rate
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx4 != 0 && object.mx4Note == "-" {
//                        cell.maximumValueLabel.text = object.mx4Rate
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 1:
//                    if object.nm5 != 0 && object.nm5Note == "-" {
//                        cell.normalValueLabel.text = object.nm5Rate
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd5 != 0 && object.hd5Note == "-" {
//                        cell.hardValueLabel.text = object.hd5Rate
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx5 != 0 && object.mx5Note == "-" {
//                        cell.maximumValueLabel.text = object.mx5Rate
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 2:
//                    if object.nm6 != 0 && object.nm6Note == "-" {
//                        cell.normalValueLabel.text = object.nm6Rate
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd6 != 0 && object.hd6Note == "-" {
//                        cell.hardValueLabel.text = object.hd6Rate
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx6 != 0 && object.mx6Note == "-" {
//                        cell.maximumValueLabel.text = object.mx6Rate
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 3:
//                    if object.nm8 != 0 && object.nm8Note == "-" {
//                        cell.normalValueLabel.text = object.nm8Rate
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd8 != 0 && object.hd8Note == "-" {
//                        cell.hardValueLabel.text = object.hd8Rate
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx8 != 0 && object.mx8Note == "-" {
//                        cell.maximumValueLabel.text = object.mx8Rate
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                default:
//                    break
//                }
//            } else {
//                switch(button){
//                case 0:
//                    if object.nm4Note == "PERFECT PLAY" {
//                        cell.normalValueLabel.text = "PP"
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd4Note == "PERFECT PLAY" {
//                        cell.hardValueLabel.text = "PP"
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx4Note == "PERFECT PLAY" {
//                        cell.maximumValueLabel.text = "PP"
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 1:
//                    if object.nm5Note == "PERFECT PLAY" {
//                        cell.normalValueLabel.text = "PP"
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd5Note == "PERFECT PLAY" {
//                        cell.hardValueLabel.text = "PP"
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx5Note == "PERFECT PLAY" {
//                        cell.maximumValueLabel.text = "PP"
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 2:
//                    if object.nm6Note == "PERFECT PLAY" {
//                        cell.normalValueLabel.text = "PP"
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd6Note == "PERFECT PLAY" {
//                        cell.hardValueLabel.text = "PP"
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx6Note == "PERFECT PLAY" {
//                        cell.maximumValueLabel.text = "PP"
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                case 3:
//                    if object.nm8Note == "PERFECT PLAY" {
//                        cell.normalValueLabel.text = "PP"
//                        cell.normalLabel.isHidden = false
//                    } else {
//                        cell.normalValueLabel.text = nil
//                        cell.normalLabel.isHidden = true
//                    }
//                    if object.hd8Note == "PERFECT PLAY" {
//                        cell.hardValueLabel.text = "PP"
//                        cell.hardLabel.isHidden = false
//                    } else {
//                        cell.hardValueLabel.text = nil
//                        cell.hardLabel.isHidden = true
//                    }
//                    if object.mx8Note == "PERFECT PLAY" {
//                        cell.maximumValueLabel.text = "PP"
//                        cell.maximumLabel.isHidden = false
//                    } else {
//                        cell.maximumValueLabel.text = nil
//                        cell.maximumLabel.isHidden = true
//                    }
//                default:
//                    break
//                }
//            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchType == 0 {
            return levelResults.count
        } else if searchType == 1 {
            return rateResults.count
        } else {
            return noteResults.count
        }
    }
}
extension SearchRecordDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchRecordDetailViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return nil
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Results".localized, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return nil
    }
}
extension SearchRecordDetailViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        tableView.separatorStyle = .none
    }
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        if !executesFirst {
            executesFirst = true
            return
        }
        tableView.separatorStyle = .singleLine
    }
}
