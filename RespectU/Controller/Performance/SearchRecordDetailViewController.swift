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

    var isFirstExecuted = false
    var searchType: Int = 0
    var button: Int = 0
    var lowerRange: Double = 0
    var upperRange: Double = 0
    var detailType: Int = 0
    @IBOutlet weak var tableView: UITableView!
    var realm: Realm! = nil
    var noteResults: Results<RecordInfo>! = nil
    var tempRateResults: LazyFilterBidirectionalCollection<Results<RecordInfo>>! = nil
    var rateResults: [RecordInfo]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        noteResults = realm.objects(RecordInfo.self).sorted(byKeyPath: "lowercase")
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "SearchRecordDetailCell", bundle: nil), forCellReuseIdentifier: "searchRecordDetailCell")
        
        if(searchType == 0) {
            switch(button){
            case 0:
                tempRateResults = noteResults.filter({ (object) -> Bool in
                    var count = 0
                    let nm4Text = object.nm4Rate.split(separator: "%")[0].description
                    let hd4Text = object.hd4Rate.split(separator: "%")[0].description
                    let mx4Text = object.mx4Rate.split(separator: "%")[0].description
                    if let nm4 = Double(nm4Text){
                        if(nm4 >= self.lowerRange && nm4 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let hd4 = Double(hd4Text){
                        if(hd4 >= self.lowerRange && hd4 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let mx4 = Double(mx4Text){
                        if(mx4 >= self.lowerRange && mx4 <= self.upperRange){
                            count += 1
                        }
                    }
                    return count != 0
                })
            case 1:
                tempRateResults = noteResults.filter({ (object) -> Bool in
                    var count = 0
                    let nm5Text = object.nm5Rate.split(separator: "%")[0].description
                    let hd5Text = object.hd5Rate.split(separator: "%")[0].description
                    let mx5Text = object.mx5Rate.split(separator: "%")[0].description
                    if let nm5 = Double(nm5Text){
                        if(nm5 >= self.lowerRange && nm5 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let hd5 = Double(hd5Text){
                        if(hd5 >= self.lowerRange && hd5 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let mx5 = Double(mx5Text){
                        if(mx5 >= self.lowerRange && mx5 <= self.upperRange){
                            count += 1
                        }
                    }
                    return count != 0
                })
            case 2:
                tempRateResults = noteResults.filter({ (object) -> Bool in
                    var count = 0
                    let nm6Text = object.nm6Rate.split(separator: "%")[0].description
                    let hd6Text = object.hd6Rate.split(separator: "%")[0].description
                    let mx6Text = object.mx6Rate.split(separator: "%")[0].description
                    if let nm6 = Double(nm6Text){
                        if(nm6 >= self.lowerRange && nm6 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let hd6 = Double(hd6Text){
                        if(hd6 >= self.lowerRange && hd6 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let mx6 = Double(mx6Text){
                        if(mx6 >= self.lowerRange && mx6 <= self.upperRange){
                            count += 1
                        }
                    }
                    return count != 0
                })
            case 3:
                tempRateResults = noteResults.filter({ (object) -> Bool in
                    var count = 0
                    let nm8Text = object.nm8Rate.split(separator: "%")[0].description
                    let hd8Text = object.hd8Rate.split(separator: "%")[0].description
                    let mx8Text = object.mx8Rate.split(separator: "%")[0].description
                    if let nm8 = Double(nm8Text){
                        if(nm8 >= self.lowerRange && nm8 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let hd8 = Double(hd8Text){
                        if(hd8 >= self.lowerRange && hd8 <= self.upperRange){
                            count += 1
                        }
                    }
                    if let mx8 = Double(mx8Text){
                        if(mx8 >= self.lowerRange && mx8 <= self.upperRange){
                            count += 1
                        }
                    }
                    return count != 0
                })
            default:
                break
            }
            rateResults = Array(tempRateResults)
        } else {
            if(detailType == 0){
                switch(button){
                case 0:
                    let query = NSPredicate(format: "nm4 != 0 AND nm4Note = %@ OR hd4 != 0 AND hd4Note = %@ OR mx4 != 0 AND mx4Note = %@", "-", "-", "-")
                    noteResults = noteResults.filter(query)
                case 1:
                    let query = NSPredicate(format: "nm5 != 0 AND nm5Note = %@ OR hd5 != 0 AND hd5Note = %@ OR mx5 != 0 AND mx5Note = %@", "-", "-", "-")
                    noteResults = noteResults.filter(query)
                case 2:
                    let query = NSPredicate(format: "nm6 != 0 AND nm6Note = %@ OR hd6 != 0 AND hd6Note = %@ OR mx6 != 0 AND mx6Note = %@", "-", "-", "-")
                    noteResults = noteResults.filter(query)
                case 3:
                    let query = NSPredicate(format: "nm8 != 0 AND nm8Note = %@ OR hd8 != 0 AND hd8Note = %@ OR mx8 != 0 AND mx8Note = %@", "-", "-", "-")
                    noteResults = noteResults.filter(query)
                default:
                    break
                }
            } else {
                switch(button){
                case 0:
                    let query = NSPredicate(format: "nm4Note = %@ OR hd4Note = %@ OR mx4Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
                    noteResults = noteResults.filter(query)
                case 1:
                    let query = NSPredicate(format: "nm5Note = %@ OR hd5Note = %@ OR mx5Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
                    noteResults = noteResults.filter(query)
                case 2:
                    let query = NSPredicate(format: "nm6Note = %@ OR hd6Note = %@ OR mx6Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
                    noteResults = noteResults.filter(query)
                case 3:
                    let query = NSPredicate(format: "nm8Note = %@ OR hd8Note = %@ OR mx8Note = %@", "PERFECT PLAY", "PERFECT PLAY", "PERFECT PLAY")
                    noteResults = noteResults.filter(query)
                default:
                    break
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchRecordDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchRecordDetailCell") as! SearchRecordDetailCell
        
        if(searchType == 0){
            let object = rateResults[indexPath.row]
            cell.title.text = object.title
            switch(button){
            case 0:
                let nm4Text = object.nm4Rate.split(separator: "%")[0].description
                let hd4Text = object.hd4Rate.split(separator: "%")[0].description
                let mx4Text = object.mx4Rate.split(separator: "%")[0].description
                if let nm4 = Double(nm4Text) {
                    if(nm4 >= lowerRange && nm4 <= upperRange){
                        cell.nm.text = nm4Text+"%"
                    } else { cell.nm.text = nil }
                } else { cell.nm.text = nil }
                if let hd4 = Double(hd4Text) {
                    if(hd4 >= lowerRange && hd4 <= upperRange){
                        cell.hd.text = hd4Text+"%"
                    } else { cell.hd.text = nil }
                } else { cell.hd.text = nil }
                if let mx4 = Double(mx4Text) {
                    if(mx4 >= lowerRange && mx4 <= upperRange){
                        cell.mx.text = mx4Text+"%"
                    } else { cell.mx.text = nil }
                } else { cell.mx.text = nil }
            case 1:
                let nm5Text = object.nm5Rate.split(separator: "%")[0].description
                let hd5Text = object.hd5Rate.split(separator: "%")[0].description
                let mx5Text = object.mx5Rate.split(separator: "%")[0].description
                if let nm5 = Double(nm5Text) {
                    if(nm5 >= lowerRange && nm5 <= upperRange){
                        cell.nm.text = nm5Text+"%"
                    } else { cell.nm.text = nil }
                } else { cell.nm.text = nil }
                if let hd5 = Double(hd5Text) {
                    if(hd5 >= lowerRange && hd5 <= upperRange){
                        cell.hd.text = hd5Text+"%"
                    } else { cell.hd.text = nil }
                } else { cell.hd.text = nil }
                if let mx5 = Double(mx5Text) {
                    if(mx5 >= lowerRange && mx5 <= upperRange){
                        cell.mx.text = mx5Text+"%"
                    } else { cell.mx.text = nil }
                } else { cell.mx.text = nil }
            case 2:
                let nm6Text = object.nm6Rate.split(separator: "%")[0].description
                let hd6Text = object.hd6Rate.split(separator: "%")[0].description
                let mx6Text = object.mx6Rate.split(separator: "%")[0].description
                if let nm6 = Double(nm6Text) {
                    if(nm6 >= lowerRange && nm6 <= upperRange){
                        cell.nm.text = nm6Text+"%"
                    } else { cell.nm.text = nil }
                } else { cell.nm.text = nil }
                if let hd6 = Double(hd6Text) {
                    if(hd6 >= lowerRange && hd6 <= upperRange){
                        cell.hd.text = hd6Text+"%"
                    } else { cell.hd.text = nil }
                } else { cell.hd.text = nil }
                if let mx6 = Double(mx6Text) {
                    if(mx6 >= lowerRange && mx6 <= upperRange){
                        cell.mx.text = mx6Text+"%"
                    } else { cell.mx.text = nil }
                } else { cell.mx.text = nil }
            case 3:
                let nm8Text = object.nm8Rate.split(separator: "%")[0].description
                let hd8Text = object.hd8Rate.split(separator: "%")[0].description
                let mx8Text = object.mx8Rate.split(separator: "%")[0].description
                if let nm8 = Double(nm8Text) {
                    if(nm8 >= lowerRange && nm8 <= upperRange){
                        cell.nm.text = nm8Text+"%"
                    } else { cell.nm.text = nil }
                } else { cell.nm.text = nil }
                if let hd8 = Double(hd8Text) {
                    if(hd8 >= lowerRange && hd8 <= upperRange){
                        cell.hd.text = hd8Text+"%"
                    } else { cell.hd.text = nil }
                } else { cell.hd.text = nil }
                if let mx8 = Double(mx8Text) {
                    if(mx8 >= lowerRange && mx8 <= upperRange){
                        cell.mx.text = mx8Text+"%"
                    } else { cell.mx.text = nil }
                } else { cell.mx.text = nil }
            default:
                break
            }
        } else {
            let object = noteResults[indexPath.row]
            cell.title.text = object.title
            if(detailType == 0){
                switch(button){
                case 0:
                    if(object.nm4 != 0 && object.nm4Note == "-"){
                        cell.nm.text = "No MC"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd4 != 0 && object.hd4Note == "-"){
                        cell.hd.text = "No MC"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx4 != 0 && object.mx4Note == "-"){
                        cell.mx.text = "No MC"
                    } else {
                        cell.mx.text = nil
                    }
                case 1:
                    if(object.nm5 != 0 && object.nm5Note == "-"){
                        cell.nm.text = "No MC"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd5 != 0 && object.hd5Note == "-"){
                        cell.hd.text = "No MC"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx5 != 0 && object.mx5Note == "-"){
                        cell.mx.text = "No MC"
                    } else {
                        cell.mx.text = nil
                    }
                case 2:
                    if(object.nm6 != 0 && object.nm6Note == "-"){
                        cell.nm.text = "No MC"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd6 != 0 && object.hd6Note == "-"){
                        cell.hd.text = "No MC"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx6 != 0 && object.mx6Note == "-"){
                        cell.mx.text = "No MC"
                    } else {
                        cell.mx.text = nil
                    }
                case 3:
                    if(object.nm8 != 0 && object.nm8Note == "-"){
                        cell.nm.text = "No MC"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd8 != 0 && object.hd8Note == "-"){
                        cell.hd.text = "No MC"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx8 != 0 && object.mx8Note == "-"){
                        cell.mx.text = "No MC"
                    } else {
                        cell.mx.text = nil
                    }
                default:
                    break
                }
            } else {
                switch(button){
                case 0:
                    if(object.nm4Note == "PERFECT PLAY"){
                        cell.nm.text = "PP"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd4Note == "PERFECT PLAY"){
                        cell.hd.text = "PP"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx4Note == "PERFECT PLAY"){
                        cell.mx.text = "PP"
                    } else {
                        cell.mx.text = nil
                    }
                case 1:
                    if(object.nm5Note == "PERFECT PLAY"){
                        cell.nm.text = "PP"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd5Note == "PERFECT PLAY"){
                        cell.hd.text = "PP"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx5Note == "PERFECT PLAY"){
                        cell.mx.text = "PP"
                    } else {
                        cell.mx.text = nil
                    }
                case 2:
                    if(object.nm6Note == "PERFECT PLAY"){
                        cell.nm.text = "PP"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd6Note == "PERFECT PLAY"){
                        cell.hd.text = "PP"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx6Note == "PERFECT PLAY"){
                        cell.mx.text = "PP"
                    } else {
                        cell.mx.text = nil
                    }
                case 3:
                    if(object.nm8Note == "PERFECT PLAY"){
                        cell.nm.text = "PP"
                    } else {
                        cell.nm.text = nil
                    }
                    if(object.hd8Note == "PERFECT PLAY"){
                        cell.hd.text = "PP"
                    } else {
                        cell.hd.text = nil
                    }
                    if(object.mx8Note == "PERFECT PLAY"){
                        cell.mx.text = "PP"
                    } else {
                        cell.mx.text = nil
                    }
                default:
                    break
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchType == 0){
            return rateResults.count
        } else {
            return noteResults.count
        }
    }
}
extension SearchRecordDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchRecordDetailViewController: DZNEmptyDataSetSource{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return nil
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Results".localized, attributes: [NSAttributedStringKey.font : UIFont(name: "NotoSansCJKkr-Bold", size: 20)!])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return nil
    }
}
extension SearchRecordDetailViewController: DZNEmptyDataSetDelegate{
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        tableView.separatorStyle = .none
    }
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        if(!isFirstExecuted){
            isFirstExecuted = true
            return
        }
        tableView.separatorStyle = .singleLine
    }
}
