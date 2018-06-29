//
//  UIAlertController+.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

extension UIAlertController {
    static func showOKButton(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    static func showOKAndAddFavorite(title: String, message: String, object: SongInfo) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        let favoriteAction = UIAlertAction(title: "Add to Favorite".localized, style: .default) { _ in
            let query=NSPredicate(format: "title = %@",object.title)
            if(try! Realm().objects(PlaylistInfo.self).filter(query).count == 0){
                addPlaylist(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
            }
        }
        alert.addAction(favoriteAction)
        alert.addAction(yesAction)
        return alert
    }
    static func showOKAndRemoveFavorite(title: String, message: String, object: PlaylistInfo, tableView: UITableView) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        let removeAction = UIAlertAction(title: "Remove".localized, style: .default) { _ in
            let realm = try! Realm()
            let query=NSPredicate(format: "title = %@", object.title)
            let deleteRow = try! Realm().objects(PlaylistInfo.self).filter(query).first!
            try! realm.write{
                realm.delete(deleteRow)
            }
            tableView.reloadData()
        }
        alert.addAction(removeAction)
        alert.addAction(yesAction)
        return alert
    }
    static func showSearch(all: SongAllTableViewController, portable1: SongPortable1TableViewController, portable2: SongPortable2TableViewController, respect: SongRespectTableViewController, trilogy: SongTrilogyTableViewController, ce: SongCETableViewController, technika1: SongTechnika1TableViewController, bs: SongBSTableViewController, favorite: SongFavoriteTableViewController) -> UIAlertController {
        func reloadTableView() {
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            technika1.tableView.reloadData()
            bs.tableView.reloadData()
            favorite.tableView.reloadData()
        }
        let alert = UIAlertController(title: "Search".localized, message: "Select the button type.".localized, preferredStyle: .alert)
        let button4 = UIAlertAction(title: "4B", style: .default) { _ in
            all.favoriteButton = "4B"
            portable1.favoriteButton = "4B"
            portable2.favoriteButton = "4B"
            respect.favoriteButton = "4B"
            trilogy.favoriteButton = "4B"
            ce.favoriteButton = "4B"
            technika1.favoriteButton = "4B"
            bs.favoriteButton = "4B"
            favorite.favoriteButton = "4B"
            reloadTableView()
        }
        let button5 = UIAlertAction(title: "5B", style: .default) { _ in
            all.favoriteButton = "5B"
            portable1.favoriteButton = "5B"
            portable2.favoriteButton = "5B"
            respect.favoriteButton = "5B"
            trilogy.favoriteButton = "5B"
            ce.favoriteButton = "5B"
            technika1.favoriteButton = "5B"
            bs.favoriteButton = "5B"
            favorite.favoriteButton = "5B"
            reloadTableView()
        }
        let button6 = UIAlertAction(title: "6B", style: .default) { _ in
            all.favoriteButton = "6B"
            portable1.favoriteButton = "6B"
            portable2.favoriteButton = "6B"
            respect.favoriteButton = "6B"
            trilogy.favoriteButton = "6B"
            ce.favoriteButton = "6B"
            technika1.favoriteButton = "6B"
            bs.favoriteButton = "6B"
            favorite.favoriteButton = "6B"
            reloadTableView()
        }
        let button8 = UIAlertAction(title: "8B", style: .default) { _ in
            all.favoriteButton = "8B"
            portable1.favoriteButton = "8B"
            portable2.favoriteButton = "8B"
            respect.favoriteButton = "8B"
            trilogy.favoriteButton = "8B"
            ce.favoriteButton = "8B"
            technika1.favoriteButton = "8B"
            bs.favoriteButton = "8B"
            favorite.favoriteButton = "8B"
            reloadTableView()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(button4)
        alert.addAction(button5)
        alert.addAction(button6)
        alert.addAction(button8)
        return alert
    }
    static func showSort(all: SongAllTableViewController, portable1: SongPortable1TableViewController, portable2: SongPortable2TableViewController, respect: SongRespectTableViewController, trilogy: SongTrilogyTableViewController, ce: SongCETableViewController, technika1: SongTechnika1TableViewController, bs: SongBSTableViewController) -> UIAlertController {
        func reloadTableView() {
            all.tableView.reloadData()
            portable1.tableView.reloadData()
            portable2.tableView.reloadData()
            respect.tableView.reloadData()
            trilogy.tableView.reloadData()
            ce.tableView.reloadData()
            technika1.tableView.reloadData()
            bs.tableView.reloadData()
        }
        let realm = try! Realm()
        let alert = UIAlertController(title: "Sort".localized, message: "Select the sort method".localized, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        let normalAsc = UIAlertAction(title: "NORMAL / ASC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "nm4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "nm5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "nm6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "nm8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        let normalDesc = UIAlertAction(title: "NORMAL / DESC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "nm4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "nm5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "nm6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "nm8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        let hardAsc = UIAlertAction(title: "HARD / ASC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "hd4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "hd5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "hd6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "hd8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        let hardDesc = UIAlertAction(title: "HARD / DESC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "hd4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "hd5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "hd6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "hd8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        let maximumAsc = UIAlertAction(title: "MAXIMUM / ASC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "mx4", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "mx5", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "mx6", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "mx8", ascending: true), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        let maximumDesc = UIAlertAction(title: "MAXIMUM / DESC".localized, style: .default) { _ in
            switch(all.favoriteButton){
            case "4B":
                let sortBy = [SortDescriptor(keyPath: "mx4", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "5B":
                let sortBy = [SortDescriptor(keyPath: "mx5", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "6B":
                let sortBy = [SortDescriptor(keyPath: "mx6", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            case "8B":
                let sortBy = [SortDescriptor(keyPath: "mx8", ascending: false), SortDescriptor(keyPath: "series", ascending: true), SortDescriptor(keyPath: "lowercase", ascending: true)]
                all.results = realm.objects(SongInfo.self).sorted(by: sortBy)
                portable1.results = realm.objects(SongInfo.self).filter("series = 'Portable1'").sorted(by: sortBy)
                portable2.results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(by: sortBy)
                respect.results = realm.objects(SongInfo.self).filter("series = 'Respect'").sorted(by: sortBy)
                trilogy.results = realm.objects(SongInfo.self).filter("series = 'Trilogy'").sorted(by: sortBy)
                ce.results = realm.objects(SongInfo.self).filter("series = 'CE'").sorted(by: sortBy)
                technika1.results = realm.objects(SongInfo.self).filter("series = 'Technika1'").sorted(by: sortBy)
                bs.results = realm.objects(SongInfo.self).filter("series = 'BS'").sorted(by: sortBy)
            default:
                break
            }
            reloadTableView()
        }
        alert.addAction(cancel)
        alert.addAction(normalAsc)
        alert.addAction(normalDesc)
        alert.addAction(hardAsc)
        alert.addAction(hardDesc)
        alert.addAction(maximumAsc)
        alert.addAction(maximumDesc)
        return alert
    }
    static func showFavoriteButtonSetting() -> UIAlertController {
        let favorite = UserDefaults.standard.string(forKey: "favoriteButton")
        let message = "Current".localized + " : \(favorite ?? "None".localized)\n\n" + "The information related to the set value is displayed first.".localized
        let alert = UIAlertController(title: "My Favorite Button".localized, message: message, preferredStyle: .alert)
        let button4 = UIAlertAction(title: "4B", style: .default) { _ in
            UserDefaults.standard.set("4B", forKey: "favoriteButton")
        }
        let button5 = UIAlertAction(title: "5B", style: .default) { _ in
            UserDefaults.standard.set("5B", forKey: "favoriteButton")
        }
        let button6 = UIAlertAction(title: "6B", style: .default) { _ in
            UserDefaults.standard.set("6B", forKey: "favoriteButton")
        }
        let button8 = UIAlertAction(title: "8B", style: .default) { _ in
            UserDefaults.standard.set("8B", forKey: "favoriteButton")
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(button4)
        alert.addAction(button5)
        alert.addAction(button6)
        alert.addAction(button8)
        return alert
    }
    static func showBPMDefault() -> UIAlertController {
        let message = "Current".localized + " : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n" + "It becomes standard of Speed Recommendation.".localized
        let alert = UIAlertController(title: "BPM Default Setting".localized, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "BPM"
            textField.keyboardType = .numberPad
        }
        let yesAction = UIAlertAction(title: "OK".localized, style: .default) { _ in
            if let input = alert.textFields?.first?.text {
                if(!input.isEmpty){
                    UserDefaults.standard.set(Double(input)!, forKey: "bpm")
                }
            }
        }
        let noAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        return alert
    }
}
