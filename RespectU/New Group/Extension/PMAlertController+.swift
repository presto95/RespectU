//
//  PMAlertController+.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import PMAlertController
import BRYXBanner
import RealmSwift

extension PMAlertController{
    
    static func showOKButton(title: String, message: String) -> PMAlertController{
        let alert = PMAlertController(title: title, description: message, image: nil, style: .alert)
        let action = PMAlertAction(title: "OK".localized, style: .default)
        action.separator.backgroundColor = .mainColor
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        action.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.addAction(action)
        return alert
    }
    
    static func showOKAndAddFavorite(title: String, message: String, object: SongInfo) -> PMAlertController{
        let alert = PMAlertController(title: title, description: message, image: nil, style: .alert)
        let yesAction = PMAlertAction(title: "OK".localized, style: .default)
        let favoriteAction = PMAlertAction(title: "Add to Favorite".localized, style: .default) {
            let query=NSPredicate(format: "title = %@",object.title)
            if(try! Realm().objects(PlaylistInfo.self).filter(query).count == 0){
                addPlaylist(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
            }
        }
        yesAction.separator.backgroundColor = .mainColor
        favoriteAction.separator.backgroundColor = .mainColor
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        yesAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        favoriteAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.addAction(favoriteAction)
        alert.addAction(yesAction)
        return alert
    }
    
    static func showOkAndRemoveFavorite(title: String, message: String, object: PlaylistInfo, tableView: UITableView) -> PMAlertController{
        let alert = PMAlertController(title: title, description: message, image: nil, style: .alert)
        let yesAction = PMAlertAction(title: "OK".localized, style: .default)
        let removeAction = PMAlertAction(title: "Remove".localized, style: .default) {
            let realm = try! Realm()
            let query=NSPredicate(format: "title = %@", object.title)
            let deleteRow = try! Realm().objects(PlaylistInfo.self).filter(query).first!
            try! realm.write{
                realm.delete(deleteRow)
            }
            tableView.reloadData()
        }
        yesAction.separator.backgroundColor = .mainColor
        removeAction.separator.backgroundColor = .mainColor
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        yesAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        removeAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.addAction(removeAction)
        alert.addAction(yesAction)
        return alert
    }
    
    static func showSearch(all: SongAllTableViewController, portable1: SongPortable1TableViewController, portable2: SongPortable2TableViewController, respect: SongRespectTableViewController, trilogy: SongTrilogyTableViewController, ce: SongCETableViewController, favorite: SongFavoriteTableViewController) -> PMAlertController{
        let alert = PMAlertController(title: "Search".localized, description: "Select the button type.".localized, image: nil, style: .alert)
        let button4 = PMAlertAction(title: "4B", style: .default) {
            all.favoriteButton = "4B"
            portable1.favoriteButton = "4B"
            portable2.favoriteButton = "4B"
            respect.favoriteButton = "4B"
            trilogy.favoriteButton = "4B"
            ce.favoriteButton = "4B"
            favorite.favoriteButton = "4B"
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            favorite.tableView.reloadData()
        }
        let button5 = PMAlertAction(title: "5B", style: .default) {
            all.favoriteButton = "5B"
            portable1.favoriteButton = "5B"
            portable2.favoriteButton = "5B"
            respect.favoriteButton = "5B"
            trilogy.favoriteButton = "5B"
            ce.favoriteButton = "5B"
            favorite.favoriteButton = "5B"
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            favorite.tableView.reloadData()
        }
        let button6 = PMAlertAction(title: "6B", style: .default) {
            all.favoriteButton = "6B"
            portable1.favoriteButton = "6B"
            portable2.favoriteButton = "6B"
            respect.favoriteButton = "6B"
            trilogy.favoriteButton = "6B"
            ce.favoriteButton = "6B"
            favorite.favoriteButton = "6B"
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            favorite.tableView.reloadData()
        }
        let button8 = PMAlertAction(title: "8B", style: .default) {
            all.favoriteButton = "8B"
            portable1.favoriteButton = "8B"
            portable2.favoriteButton = "8B"
            respect.favoriteButton = "8B"
            trilogy.favoriteButton = "8B"
            ce.favoriteButton = "8B"
            favorite.favoriteButton = "8B"
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            favorite.tableView.reloadData()
        }
        let cancel = PMAlertAction(title: "Cancel".localized, style: .cancel, action: nil)
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        button4.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button5.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button6.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button8.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        cancel.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button4.separator.backgroundColor = .mainColor
        button5.separator.backgroundColor = .mainColor
        button6.separator.backgroundColor = .mainColor
        button8.separator.backgroundColor = .mainColor
        cancel.separator.backgroundColor = .mainColor
        alert.addAction(cancel)
        alert.addAction(button4)
        alert.addAction(button5)
        alert.addAction(button6)
        alert.addAction(button8)
        return alert
    }
    
    static func showSort(all: SongAllTableViewController, portable1: SongPortable1TableViewController, portable2: SongPortable2TableViewController, respect: SongRespectTableViewController, trilogy: SongTrilogyTableViewController, ce: SongCETableViewController) -> PMAlertController{
        let realm = try! Realm()
        let alert = PMAlertController(title: "Sort".localized, description: "Select the sort method".localized, image: nil, style: .alert)
        let cancel = PMAlertAction(title: "Cancel".localized, style: .cancel)
        let normalAsc = PMAlertAction(title: "NORMAL / ASC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "nm4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "nm5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "nm6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "nm8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        let normalDesc = PMAlertAction(title: "NORMAL / DESC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "nm4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "nm5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "nm6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "nm8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        let hardAsc = PMAlertAction(title: "HARD / ASC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "hd4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "hd5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "hd6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "hd8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        let hardDesc = PMAlertAction(title: "HARD / DESC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "hd4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "hd5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "hd6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "hd8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        let maximumAsc = PMAlertAction(title: "MAXIMUM / ASC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "mx4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "mx5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "mx6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "mx8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        let maximumDesc = PMAlertAction(title: "MAXIMUM / DESC".localized, style: .default) {
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "mx4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "mx5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "mx6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "mx8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
            default:
                break
            }
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
        }
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        normalAsc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        normalDesc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        hardAsc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        hardDesc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        maximumAsc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        maximumDesc.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        normalAsc.separator.backgroundColor = .mainColor
        normalDesc.separator.backgroundColor = .mainColor
        hardAsc.separator.backgroundColor = .mainColor
        hardDesc.separator.backgroundColor = .mainColor
        maximumAsc.separator.backgroundColor = .mainColor
        maximumDesc.separator.backgroundColor = .mainColor
        cancel.separator.backgroundColor = .mainColor
        alert.addAction(cancel)
        alert.addAction(normalAsc)
        alert.addAction(normalDesc)
        alert.addAction(hardAsc)
        alert.addAction(hardDesc)
        alert.addAction(maximumAsc)
        alert.addAction(maximumDesc)
        return alert
    }
    
    static func showFavoriteButtonSetting() -> PMAlertController{
        let favorite = UserDefaults.standard.string(forKey: "favoriteButton")
        let message = "Current".localized + " : \(favorite ?? "None".localized)\n\n" + "The information related to the set value is displayed first.".localized
        let alert = PMAlertController(title: "My Favorite Button".localized, description: message, image: nil, style: .alert)
        let button4 = PMAlertAction(title: "4B", style: .default) {
            UserDefaults.standard.set("4B", forKey: "favoriteButton")
        }
        let button5 = PMAlertAction(title: "5B", style: .default) {
            UserDefaults.standard.set("5B", forKey: "favoriteButton")
        }
        let button6 = PMAlertAction(title: "6B", style: .default) {
            UserDefaults.standard.set("6B", forKey: "favoriteButton")
        }
        let button8 = PMAlertAction(title: "8B", style: .default) { 
            UserDefaults.standard.set("8B", forKey: "favoriteButton")
        }
        let cancel = PMAlertAction(title: "Cancel".localized, style: .cancel, action: nil)
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        button4.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button5.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button6.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button8.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        cancel.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        button4.separator.backgroundColor = .mainColor
        button5.separator.backgroundColor = .mainColor
        button6.separator.backgroundColor = .mainColor
        button8.separator.backgroundColor = .mainColor
        cancel.separator.backgroundColor = .mainColor
        alert.addAction(cancel)
        alert.addAction(button4)
        alert.addAction(button5)
        alert.addAction(button6)
        alert.addAction(button8)
        return alert
    }

    static func showBPMDefault() -> PMAlertController{
        let message = "Current".localized + " : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n" + "It becomes standard of Speed Recommendation.".localized
        let alert = PMAlertController(title: "BPM Default Setting".localized, description: message, image: nil, style: .alert)
        alert.addTextField { (textField) in
            textField?.placeholder = "BPM"
            textField?.keyboardType = .numberPad
        }
        let yesAction = PMAlertAction(title: "OK".localized, style: .default) {
            if let input = alert.textFields.first?.text{
                if(!input.isEmpty){
                    UserDefaults.standard.set(Double(input)!, forKey: "bpm")
                }
            }
        }
        let noAction = PMAlertAction(title: "Cancel".localized, style: .cancel)
        alert.alertTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        alert.alertDescription.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        yesAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        noAction.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        yesAction.separator.backgroundColor = UIColor.mainColor
        noAction.separator.backgroundColor = UIColor.mainColor
        alert.addAction(noAction)
        alert.addAction(yesAction)
        return alert
    }
}
