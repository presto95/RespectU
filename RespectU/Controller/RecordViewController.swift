//
//  Record2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class RecordViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    var realm: Realm! = nil
    var results: Results<RecordInfo>! = nil
    var searchedResults: Results<RecordInfo>! = nil
    var isFirstInitialize = true
    var isFirstClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(RecordInfo.self).sorted(byKeyPath: "lowercase")
        searchedResults = results
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        searchBar.placeholder = "Song".localized
        if let textField = searchBar.value(forKey: "searchField") as? UITextField{
            textField.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func removeRecordView(){
        if(view.subviews.filter { $0 is RecordView }.count != 0) {
            view.subviews.last?.removeFromSuperview()
        }
    }

}

extension RecordViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedResults = results.filter("title CONTAINS '" + searchText + "'")
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension RecordViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell")!
        let object = searchedResults[indexPath.row]
        
        cell.textLabel?.text = object.title
        cell.textLabel?.font = UIFont(name: "NotoSansCJKkr-Medium", size: 14)
        return cell
    }
}
extension RecordViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        removeRecordView()
        if(isFirstClick){
            tableView.frame.size = CGSize(width: tableView.frame.width, height: tableView.frame.height - 200)
        }
        isFirstClick = false
        let recordView = RecordView.instanceFromXib(title: (cell?.textLabel?.text!)!, controller: self) as! RecordView
        recordView.layer.borderWidth = 3
        recordView.layer.cornerRadius = 10
        recordView.layer.borderColor = UIColor.mainColor.cgColor
        recordView.frame = CGRect(x: 0, y: view.frame.height - 210, width: view.frame.width, height: 200)
        view.addSubview(recordView)
    }
}

extension RecordViewController: DZNEmptyDataSetSource{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "iconInfo.png")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Results".localized, attributes: [NSAttributedStringKey.font : UIFont(name: "NotoSansCJKkr-Bold", size: 20)!])
    }
}
extension RecordViewController: DZNEmptyDataSetDelegate{
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetDidAppear(_ scrollView: UIScrollView!) {
        tableView.separatorStyle = .none
    }
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        if(!isFirstInitialize){
            tableView.separatorStyle = .singleLine
        }
        isFirstInitialize = false
    }
}
