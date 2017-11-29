//
//  SongViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 29..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import ActionSheetPicker_3_0
import NotificationBannerSwift

class PlaylistInfo: Object{
    @objc dynamic var series: String=""
    @objc dynamic var title: String=""
    @objc dynamic var composer: String=""
    @objc dynamic var bpm: String=""
    @objc dynamic var nm4: Int=0
    @objc dynamic var nm5: Int=0
    @objc dynamic var nm6: Int=0
    @objc dynamic var nm8: Int=0
    @objc dynamic var hd4: Int=0
    @objc dynamic var hd5: Int=0
    @objc dynamic var hd6: Int=0
    @objc dynamic var hd8: Int=0
    @objc dynamic var mx4: Int=0
    @objc dynamic var mx5: Int=0
    @objc dynamic var mx6: Int=0
    @objc dynamic var mx8: Int=0
}

class SongTableViewController: UITableViewController {
    
    var temp:[String] = []
    var BPM: Double=0.0
    var realm: Realm? = nil
    var results: Results<SongInfo>? = nil
    var series: String="All"
    var key: String="4B"
    var indexSearch1=0
    var indexSearch2=0
    var indexSort1=0
    var indexSort2=0
    var wordsSection=[String]()
    var wordsDict=[String:[String]]()
    var wordsIndexTitles: [String]=[]
    let achievementResults = try! Realm().objects(AchievementInfo.self).filter("type = 'MUSIC'")
    let missionResults = try! Realm().objects(MissionInfo.self).filter("reward LIKE 'Music*'")

    func generateWordsDict(){
        for word in self.temp{
            let key="\(word[word.startIndex])"
            let upper=key.uppercased()
            if var wordValues=wordsDict[upper]{
                wordValues.append(word)
                wordsDict[upper]=wordValues
            }
            else{
                wordsDict[upper]=[word]
            }
        }
        wordsSection=[String](wordsDict.keys)
        wordsSection=wordsSection.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = try! Realm().objects(SongInfo.self).sorted(byKeyPath: "title")
        for i in 0..<self.results!.count{
            temp.append(self.results![i].title)
        }
        generateWordsDict()
        let locale = Locale.current
        switch(locale.regionCode!){
        case "KR":
            wordsIndexTitles = ["2","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","한"]
        case "JP":
            wordsIndexTitles = ["2","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z", "あ"]
        default:
            wordsIndexTitles = ["2","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isNight=UserDefaults.standard.bool(forKey: "night")
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.sectionIndexBackgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarController?.tabBar.barStyle=isNight ? .black : .default
        navigationController?.navigationBar.barStyle=isNight ? .black : .default
        if(NotificationBannerQueue.default.numberOfBanners > 0){
            NotificationBannerQueue.default.removeAll()
        }
        if(UserDefaults.standard.bool(forKey: "first") != true){
            UserDefaults.standard.set(450.0, forKey: "bpm")
        }
        UserDefaults.standard.set(true, forKey: "first")
        BPM=UserDefaults.standard.double(forKey: "bpm")
        tableView.reloadInputViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        self.temp.removeAll()
        ActionSheetMultipleStringPicker.show(withTitle: "Search".localized, rows: [
            ["All", "Portable 1", "Portable 2", "Respect", "Trilogy"],
            ["4B", "5B", "6B", "8B"]
            ], initialSelection: [indexSearch1, indexSearch2], doneBlock: {
                picker, indexes, values in
                self.indexSearch1=indexes![0] as! Int
                self.indexSearch2=indexes![1] as! Int
                switch(indexes![0] as! Int){
                case 0:
                    self.series="All"
                case 1:
                    self.series="Portable1"
                case 2:
                    self.series="Portable2"
                case 3:
                    self.series="Respect"
                case 4:
                    self.series="Trilogy"
                default:
                    break
                }
                switch(indexes![1] as! Int){
                case 0:
                    self.key="4B"
                case 1:
                    self.key="5B"
                case 2:
                    self.key="6B"
                case 3:
                    self.key="8B"
                default:
                    break
                }
                if(self.series=="All"){
                    self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "title")
                }
                else{
                    self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "title")
                }
                for i in 0..<self.results!.count{
                    self.temp.append(self.results![i].title)
                }
                self.wordsSection.removeAll()
                self.wordsDict.removeAll()
                //섹션별 딕셔너리
                self.generateWordsDict()
                self.wordsIndexTitles=["2","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","한"]
                self.tableView.reloadData()
                self.showSearchNotification(series: self.series)
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        var level: String=""
        var sort: String=""
        ActionSheetMultipleStringPicker.show(withTitle: "Sort".localized, rows: [
            ["NORMAL", "HARD", "MAXIMUM"],
            ["Asc".localized, "Desc".localized]
            ], initialSelection: [indexSort1, indexSort2], doneBlock: {
                picker, indexes, values in
                self.indexSort1=indexes![0] as! Int
                self.indexSort2=indexes![1] as! Int
                switch(indexes![0] as! Int){
                case 0:
                    level="NORMAL"
                case 1:
                    level="HARD"
                case 2:
                    level="MAXIMUM"
                default:
                    break
                }
                switch(indexes![1] as! Int){
                case 0:
                    sort="Asc"
                case 1:
                    sort="Desc"
                default:
                    break
                }
                
                if(level=="NORMAL"){
                    if(self.key=="4B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm4", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm4", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm4", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm4", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="5B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm5", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm5", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm5", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm5", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="6B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm6", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm6", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm6", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm6", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="8B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm8", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm6", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "nm8", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "nm6", ascending: false)
                            }
                        }
                    }
                }
                else if(level=="HARD"){
                    if(self.key=="4B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd4", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd4", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd4", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd4", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="5B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd5", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd5", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd5", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd5", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="6B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd6", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd6", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd6", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd6", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="8B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd8", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd8", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "hd8", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "hd8", ascending: false)
                            }
                        }
                    }
                }
                else if(level=="MAXIMUM"){
                    if(self.key=="4B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx4", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx4", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx4", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx4", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="5B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx5", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx5", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx5", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx5", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="6B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx6", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx6", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx6", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx6", ascending: false)
                            }
                        }
                    }
                    else if(self.key=="8B"){
                        if(sort=="Asc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx8", ascending: true)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx8", ascending: true)
                            }
                        }
                        else if(sort=="Desc"){
                            if(self.series=="All"){
                                self.results=try! Realm().objects(SongInfo.self).sorted(byKeyPath: "mx8", ascending: false)
                            }
                            else{
                                self.results=try! Realm().objects(SongInfo.self).filter("series = '"+self.series+"'").sorted(byKeyPath: "mx8", ascending: false)
                            }
                        }
                    }
                }
                self.wordsIndexTitles.removeAll()
                self.tableView.reloadData()
                self.showSortNotification(series: self.series, level: level, sort: sort)
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return wordsSection.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordsSection[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let wordKey=wordsSection[section]
        if let wordValues=wordsDict[wordKey]{
            return wordValues.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        var rowIndex=0
        if(indexPath.section > 0){
            for i in 0..<indexPath.section{
                let number=tableView.numberOfRows(inSection: i) //전 섹션의 수
                rowIndex=rowIndex + number
            }
        }
        rowIndex=rowIndex+indexPath.row
        let object=results![rowIndex]
        cell.title.text=object.title
        cell.composer.text=object.composer
        cell.bpm.text="BPM " + object.bpm
        switch(key){
        case "4B":
            cell.nm.text=object.nm4 == 0 ? "-" : String(object.nm4)
            cell.hd.text=object.hd4 == 0 ? "-" : String(object.hd4)
            cell.mx.text=object.mx4 == 0 ? "-" : String(object.mx4)
        case "5B":
            cell.nm.text=object.nm5 == 0 ? "-" : String(object.nm5)
            cell.hd.text=object.hd5 == 0 ? "-" : String(object.hd5)
            cell.mx.text=object.mx5 == 0 ? "-" : String(object.mx5)
        case "6B":
            cell.nm.text=object.nm6 == 0 ? "-" : String(object.nm6)
            cell.hd.text=object.hd6 == 0 ? "-" : String(object.hd6)
            cell.mx.text=object.mx6 == 0 ? "-" : String(object.mx6)
        case "8B":
            cell.nm.text=object.nm8 == 0 ? "-" : String(object.nm8)
            cell.hd.text=object.hd8 == 0 ? "-" : String(object.hd8)
            cell.mx.text=object.mx8 == 0 ? "-" : String(object.mx8)
        default:
            break
        }
        switch(object.series){
        case "Respect":
            cell.series.backgroundColor=UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Trilogy":
            cell.series.backgroundColor=UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Portable2":
            cell.series.backgroundColor=UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "Portable1":
            cell.series.backgroundColor=UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        default:
            break
        }
        let isNight=UserDefaults.standard.bool(forKey: "night")
        cell.title.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.bpm.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.nm.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.hd.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.mx.textColor = isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        // Configure the cell...
        cell.backgroundColor = isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell=tableView.cellForRow(at: indexPath) as! SongTableViewCell
        var recommend: String=""
        var recommendTransform: String="\n"+"(SPEED Variation)".localized
        var bpm: Double=0.0
        let bpmCell=cell.bpm.text!
        var strArr=bpmCell.split(separator: " ")
        if(strArr.contains("~")){
            bpm=Double(strArr[3])!
        }
        else{
            bpm=Double(strArr[1])!
            recommendTransform=""
        }
        let speed = BPM/bpm
        switch(speed){
        case ..<0.50: recommend="0.50"+recommendTransform
        case 0.50..<0.75: recommend="0.50 ~ 0.75"+recommendTransform
        case 0.75..<1.00: recommend="0.75 ~ 1.00"+recommendTransform
        case 1.00..<1.25: recommend="1.00 ~ 1.25"+recommendTransform
        case 1.25..<1.50: recommend="1.25 ~ 1.50"+recommendTransform
        case 1.50..<1.75: recommend="1.50 ~ 1.75"+recommendTransform
        case 1.75..<2.00: recommend="1.75 ~ 2.00"+recommendTransform
        case 2.00..<2.25: recommend="2.00 ~ 2.25"+recommendTransform
        case 2.25..<2.50: recommend="2.25 ~ 2.50"+recommendTransform
        case 2.50..<2.75: recommend="2.50 ~ 2.75"+recommendTransform
        case 2.75..<3.00: recommend="2.75 ~ 3.00"+recommendTransform
        case 3.00..<3.25: recommend="3.00 ~ 3.25"+recommendTransform
        case 3.25..<3.50: recommend="3.25 ~ 3.50"+recommendTransform
        case 3.50..<3.75: recommend="3.50 ~ 3.75"+recommendTransform
        case 3.75..<4.00: recommend="3.75 ~ 4.00"+recommendTransform
        case 4.00..<4.25: recommend="4.00 ~ 4.25"+recommendTransform
        case 4.25..<4.50: recommend="4.25 ~ 4.50"+recommendTransform
        case 4.50..<4.75: recommend="4.50 ~ 4.75"+recommendTransform
        case 4.75..<5.00: recommend="4.75 ~ 5.00"+recommendTransform
        case 5.00...: recommend="5.00"+recommendTransform
        default: break
        }
        var rowIndex=0
        if(indexPath.section > 0){
            for i in 0..<indexPath.section{
                let number=tableView.numberOfRows(inSection: i) //전 섹션의 수
                rowIndex=rowIndex + number
            }
        }
        rowIndex=rowIndex+indexPath.row
        var unlockString = ""
        for i in achievementResults{
            if(i.item == cell.title.text!){
                unlockString += "\n\n" + "Unlock (ACHIEVEMENT)".localized + "\n"
                unlockString += i.title.localized + " Stage \(i.level)"
                break
            }
        }
        for i in missionResults{
            if(i.reward.localized.split(separator: ":")[1].trimmingCharacters(in: .whitespaces) == results![rowIndex].title){
                unlockString += "\n\n" + "Unlock (MISSION)".localized + "\n"
                unlockString += i.section + " - " + i.title
                break
            }
        }
        
        let alert=UIAlertController(title: "\(cell.title.text!)", message: "SPEED Recommendation".localized+"\n\(recommend)" + unlockString, preferredStyle: .alert)
        let action=UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }

    //인덱스 바에 표시될 문자열 표시
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordsIndexTitles
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index=wordsSection.index(of: title) else{
            return -1
        }
        return index
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var rowIndex=0
        if(indexPath.section > 0){
            for i in 0..<indexPath.section{
                let number=tableView.numberOfRows(inSection: i)
                rowIndex=rowIndex + number
            }
        }
        rowIndex=rowIndex+indexPath.row
        let object=results![rowIndex]
        let buttonPerformance=UITableViewRowAction(style: .normal, title: "Performance".localized){action, index in
            let next=self.storyboard?.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
            next.detailBpm=object.bpm
            next.detailTitle = object.title
            next.detailSeries = object.series
            next.is4BNormalExist = object.nm4 == 0 ? false : true
            next.is4BHardExist = object.hd4 == 0 ? false : true
            next.is4BMaximumExist = object.mx4 == 0 ? false : true
            next.is5BNormalExist = object.nm5 == 0 ? false : true
            next.is5BHardExist = object.hd5 == 0 ? false : true
            next.is5BMaximumExist = object.mx5 == 0 ? false : true
            next.is6BNormalExist = object.nm6 == 0 ? false : true
            next.is6BHardExist = object.hd6 == 0 ? false : true
            next.is6BMaximumExist = object.mx6 == 0 ? false : true
            next.is8BNormalExist = object.nm8 == 0 ? false : true
            next.is8BHardExist = object.hd8 == 0 ? false : true
            next.is8BMaximumExist = object.mx8 == 0 ? false : true
            next.nm4 = object.nm4; next.nm5=object.nm5; next.nm6=object.nm6; next.nm8=object.nm8
            next.hd4=object.hd4; next.hd5=object.hd5; next.hd6=object.hd6; next.hd8=object.hd8
            next.mx4=object.mx4; next.mx5=object.mx5; next.mx6=object.mx6; next.mx8=object.mx8
            self.navigationController?.pushViewController(next, animated: true)
        }
        let buttonAddPlaylist=UITableViewRowAction(style: .normal, title: "Add to Playlist".localized){action, index in
            if(NotificationBannerQueue.default.numberOfBanners > 0){
                NotificationBannerQueue.default.removeAll()
            }
            let query=NSPredicate(format: "title = %@",object.title)
            if(self.realm?.objects(PlaylistInfo.self).filter(query).count == 0){
                let view=UIImageView(image: #imageLiteral(resourceName: "success"))
                self.addPlaylist(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
                NotificationBanner(title: "Added to Playlist".localized, subtitle: object.title, leftView: view, style: .success).show()
            }
            else{
                let view=UIImageView(image: #imageLiteral(resourceName: "fail"))
                NotificationBanner(title: "Not Added to Playlist".localized, subtitle: "Check for duplication.".localized, leftView: view, style: .danger).show()
            }
        }
        
        switch(object.series){
        case "Trilogy":
            buttonPerformance.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Respect":
            buttonPerformance.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Portable1":
            buttonPerformance.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "Portable2":
            buttonPerformance.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        default:
            break
        }
        return [buttonPerformance, buttonAddPlaylist]
    }
    func addPlaylist(series: String, title: String, composer: String, bpm: String, nm4: Int, hd4: Int, mx4: Int, nm5: Int, hd5: Int, mx5: Int, nm6: Int, hd6: Int, mx6: Int, nm8: Int, hd8: Int, mx8: Int){
        let playlist=PlaylistInfo()
        playlist.series=series; playlist.title=title; playlist.composer=composer; playlist.bpm=bpm
        playlist.nm4=nm4; playlist.nm5=nm5; playlist.nm6=nm6; playlist.nm8=nm8
        playlist.hd4=hd4; playlist.hd5=hd5; playlist.hd6=hd6; playlist.hd8=hd8
        playlist.mx4=mx4; playlist.mx5=mx5; playlist.mx6=mx6; playlist.mx8=mx8
        
        let realm=try! Realm()
        try! realm.write{
            realm.add(playlist)
        }
    }
    
    func showSearchNotification(series: String){
        if(NotificationBannerQueue.default.numberOfBanners > 0){
            NotificationBannerQueue.default.removeAll()
        }
        let view=UIImageView(image: #imageLiteral(resourceName: "info"))
        switch(series){
        case "All":
            NotificationBanner(title: "Search".localized, subtitle: series+"\t"+self.key, leftView: view, style: .info).show()
        case "Portable1":
            NotificationBanner(title: "Search".localized, subtitle: series+"\t"+self.key, leftView: view, style: .portable1).show()
        case "Portable2":
            NotificationBanner(title: "Search".localized, subtitle: series+"\t"+self.key, leftView: view, style: .portable2).show()
        case "Respect":
            NotificationBanner(title: "Search".localized, subtitle: series+"\t"+self.key, leftView: view, style: .respect).show()
        case "Trilogy":
            NotificationBanner(title: "Search".localized, subtitle: series+"\t"+self.key, leftView: view, style: .trilogy).show()
        default:
            break
        }
    }
    
    func showSortNotification(series: String, level: String, sort: String){
        if(NotificationBannerQueue.default.numberOfBanners > 0){
            NotificationBannerQueue.default.removeAll()
        }
        let view=UIImageView(image: #imageLiteral(resourceName: "info"))
        switch(series){
        case "All":
            NotificationBanner(title: "Sort".localized, subtitle: series+"\t"+self.key+"\t"+level+"\t"+sort.localized, leftView: view, style: .info).show()
        case "Portable1":
            NotificationBanner(title: "Sort".localized, subtitle: series+"\t"+self.key+"\t"+level+"\t"+sort.localized, leftView: view, style: .portable1).show()
        case "Portable2":
            NotificationBanner(title: "Sort".localized, subtitle: series+"\t"+self.key+"\t"+level+"\t"+sort.localized, leftView: view, style: .portable2).show()
        case "Respect":
            NotificationBanner(title: "Sort".localized, subtitle: series+"\t"+self.key+"\t"+level+"\t"+sort.localized, leftView: view, style: .respect).show()
        case "Trilogy":
            NotificationBanner(title: "Sort".localized, subtitle: series+"\t"+self.key+"\t"+level+"\t"+sort.localized, leftView: view, style: .trilogy).show()
        default:
            break
            
        }
    }
}
