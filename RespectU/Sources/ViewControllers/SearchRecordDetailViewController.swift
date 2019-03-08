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

struct SearchRecordDetail {
  
  let series: String
  
  let title: String
  
  let difficulty: String
  
  let rate: Double
}

final class SearchRecordDetailViewController: UIViewController {
  
  var results: [SearchRecordDetail] = []
  
  var executesFirst = false
  
  var methodIndex: Int = 0
  
  var buttonIndex: Int = 0
  
  var levelIndex: Int = 0
  
  var lowerRange: Double = 0
  
  var upperRange: Double = 0
  
  var noteDetailIndex: Int = 0
  
  @IBOutlet weak var resultsLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 40
    tableView.separatorColor = .main
    tableView.layer.borderColor = UIColor.lightGray.cgColor
    tableView.layer.borderWidth = 1
    tableView.layer.cornerRadius = 15
    tableView.register(UINib(nibName: "SearchRecordDetailCell", bundle: nil), forCellReuseIdentifier: "searchRecordDetailCell")
    let recordResults = NewRecordInfo.fetch()
    switch buttonIndex {
    case 0:
      switch methodIndex {
      case 0:
        let songResults = SongInfo.fetch()
        let level = levelIndex + 1
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d", #keyPath(SongInfo.button4.normal), level, #keyPath(SongInfo.button4.hard), level, #keyPath(SongInfo.button4.maximum), level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults.filter(NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), result.title?.english ?? "")).first else { return }
          if result.button4?.normal == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.normal, rate: record.button4?.normal?.rate ?? 0)
            self.results.append(object)
            
          }
          if result.button4?.hard == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.hard, rate: record.button4?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if result.button4?.maximum == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.maximum, rate: record.button4?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let predicate = NSPredicate(format: "%K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)}", #keyPath(NewRecordInfo.button4.normal.rate), #keyPath(NewRecordInfo.button4.hard.rate), #keyPath(NewRecordInfo.button4.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button4?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button4?.normal?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button4?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button4?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button4?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button4?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let predicate = NSPredicate(format: "%K == %@ AND %K != %@ OR %K == %@ AND %K != %@ OR %K == %@ AND %K != %@", #keyPath(NewRecordInfo.button4.normal.note), "", #keyPath(NewRecordInfo.button4.normal.rank), "", #keyPath(NewRecordInfo.button4.hard.note), "", #keyPath(NewRecordInfo.button4.hard.rank), "", #keyPath(NewRecordInfo.button4.maximum.note), "", #keyPath(NewRecordInfo.button4.maximum.rank), "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button4?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button4?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button4?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button4?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button4?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button4?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@", #keyPath(NewRecordInfo.button4.normal.note), Note.perfectPlay, #keyPath(NewRecordInfo.button4.hard.note), Note.perfectPlay, #keyPath(NewRecordInfo.button4.maximum.note), Note.perfectPlay)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button4?.normal?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button4?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button4?.hard?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button4?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button4?.maximum?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button4?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        }
      default:
        break
      }
    case 1:
      switch methodIndex {
      case 0:
        let songResults = SongInfo.fetch()
        let level = levelIndex + 1
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d", #keyPath(SongInfo.button5.normal), level, #keyPath(SongInfo.button5.hard), level, #keyPath(SongInfo.button5.maximum), level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults.filter(NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), result.title?.english ?? "")).first else { return }
          if result.button5?.normal == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.normal, rate: record.button5?.normal?.rate ?? 0)
            self.results.append(object)
            
          }
          if result.button5?.hard == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.hard, rate: record.button5?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if result.button5?.maximum == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.maximum, rate: record.button5?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let predicate = NSPredicate(format: "%K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)}", #keyPath(NewRecordInfo.button5.normal.rate), #keyPath(NewRecordInfo.button5.hard.rate), #keyPath(NewRecordInfo.button5.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button5?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button5?.normal?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button5?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button5?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button5?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button5?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let predicate = NSPredicate(format: "%K == %@ AND %K != %@ OR %K == %@ AND %K != %@ OR %K == %@ AND %K != %@", #keyPath(NewRecordInfo.button5.normal.note), "", #keyPath(NewRecordInfo.button5.normal.rank), "", #keyPath(NewRecordInfo.button5.hard.note), "", #keyPath(NewRecordInfo.button5.hard.rank), "", #keyPath(NewRecordInfo.button5.maximum.note), "", #keyPath(NewRecordInfo.button5.maximum.rank), "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button5?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button5?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button5?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button5?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button5?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button5?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@", #keyPath(NewRecordInfo.button4.normal.note), Note.perfectPlay, #keyPath(NewRecordInfo.button5.hard.note), Note.perfectPlay, #keyPath(NewRecordInfo.button4.maximum.note), Note.perfectPlay)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button5?.normal?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button5?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button5?.hard?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button5?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button5?.maximum?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button5?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        }
      default:
        break
      }
    case 2:
      switch methodIndex {
      case 0:
        let songResults = SongInfo.fetch()
        let level = levelIndex + 1
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d", #keyPath(SongInfo.button6.normal), level, #keyPath(SongInfo.button6.hard), level, #keyPath(SongInfo.button6.maximum), level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults.filter(NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), result.title?.english ?? "")).first else { return }
          if result.button6?.normal == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.normal, rate: record.button6?.normal?.rate ?? 0)
            self.results.append(object)
            
          }
          if result.button6?.hard == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.hard, rate: record.button6?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if result.button6?.maximum == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.maximum, rate: record.button6?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let predicate = NSPredicate(format: "%K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)}", #keyPath(NewRecordInfo.button6.normal.rate), #keyPath(NewRecordInfo.button6.hard.rate), #keyPath(NewRecordInfo.button6.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button6?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button6?.normal?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button6?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button6?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button6?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button6?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let predicate = NSPredicate(format: "%K == %@ AND %K != %@ OR %K == %@ AND %K != %@ OR %K == %@ AND %K != %@", #keyPath(NewRecordInfo.button6.normal.note), "", #keyPath(NewRecordInfo.button6.normal.rank), "", #keyPath(NewRecordInfo.button6.hard.note), "", #keyPath(NewRecordInfo.button6.hard.rank), "", #keyPath(NewRecordInfo.button6.maximum.note), "", #keyPath(NewRecordInfo.button6.maximum.rank), "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button6?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button6?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button6?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button6?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button6?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button6?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@", #keyPath(NewRecordInfo.button6.normal.note), Note.perfectPlay, #keyPath(NewRecordInfo.button6.hard.note), Note.perfectPlay, #keyPath(NewRecordInfo.button6.maximum.note), Note.perfectPlay)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button6?.normal?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button6?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button6?.hard?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button6?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button6?.maximum?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button6?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        }
      default:
        break
      }
    case 3:
      switch methodIndex {
      case 0:
        let songResults = SongInfo.fetch()
        let level = levelIndex + 1
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d", #keyPath(SongInfo.button8.normal), level, #keyPath(SongInfo.button8.hard), level, #keyPath(SongInfo.button8.maximum), level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults.filter(NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), result.title?.english ?? "")).first else { return }
          if result.button8?.normal == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.normal, rate: record.button8?.normal?.rate ?? 0)
            self.results.append(object)
            
          }
          if result.button8?.hard == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.hard, rate: record.button8?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if result.button8?.maximum == level {
            let object = SearchRecordDetail(series: record.series, title: record.localizedTitle, difficulty: Difficulty.maximum, rate: record.button8?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let predicate = NSPredicate(format: "%K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)} OR %K BETWEEN {\(lowerRange), \(upperRange)}", #keyPath(NewRecordInfo.button8.normal.rate), #keyPath(NewRecordInfo.button8.hard.rate), #keyPath(NewRecordInfo.button8.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button8?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button8?.normal?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button8?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button8?.hard?.rate ?? 0)
            self.results.append(object)
          }
          if range.contains(result.button8?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button8?.maximum?.rate ?? 0)
            self.results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let predicate = NSPredicate(format: "%K == %@ AND %K != %@ OR %K == %@ AND %K != %@ OR %K == %@ AND %K != %@", #keyPath(NewRecordInfo.button8.normal.note), "", #keyPath(NewRecordInfo.button8.normal.rank), "", #keyPath(NewRecordInfo.button8.hard.note), "", #keyPath(NewRecordInfo.button8.hard.rank), "", #keyPath(NewRecordInfo.button8.maximum.note), "", #keyPath(NewRecordInfo.button8.maximum.rank), "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button8?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button8?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button8?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button8?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button8?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button8?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@", #keyPath(NewRecordInfo.button8.normal.note), Note.perfectPlay, #keyPath(NewRecordInfo.button8.hard.note), Note.perfectPlay, #keyPath(NewRecordInfo.button8.maximum.note), Note.perfectPlay)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button8?.normal?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.normal, rate: result.button8?.normal?.rate ?? 0)
              self.results.append(object)
            }
            if result.button8?.hard?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.hard, rate: result.button8?.hard?.rate ?? 0)
              self.results.append(object)
            }
            if result.button8?.maximum?.note == Note.perfectPlay {
              let object = SearchRecordDetail(series: result.series, title: result.localizedTitle, difficulty: Difficulty.maximum, rate: result.button8?.maximum?.rate ?? 0)
              self.results.append(object)
            }
          }
        }
      default:
        break
      }
    default:
      break
    }
    self.results.sort { $0.title < $1.title }
    self.resultsLabel.text = "\(self.results.count)" + " Results".localized
  }
  
  @IBAction func touchUpCancelButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension SearchRecordDetailViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchRecordDetailCell") as? SearchRecordDetailCell else { return UITableViewCell() }
    cell.setProperties(self.results[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.results.count
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
    return NSAttributedString(string: "No Results".localized, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
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
