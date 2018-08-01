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
    //alert
    static func alert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    //action
    @discardableResult
    func defaultAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: .default) { (action) in
            handler?(action)
        }
        self.addAction(action)
        return self
    }
    
    @discardableResult
    func cancelAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: .cancel) { (action) in
            handler?(action)
        }
        self.addAction(action)
        return self
    }
    
    @discardableResult
    func destructiveAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: .destructive) { (action) in
            handler?(action)
        }
        self.addAction(action)
        return self
    }
    
    @discardableResult
    func textField(handler: @escaping ((UITextField) -> Void)) -> UIAlertController {
        self.addTextField { (textField) in
            handler(textField)
        }
        return self
    }
    //present
    func present(to viewController: UIViewController) {
        viewController.present(self, animated: true, completion: nil)
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
}
