//
//  SearchRecordDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import DZNEmptyDataSet
import RealmSwift

/// The search record detail view controller.
final class SearchRecordDetailViewController: UIViewController {
  
  private enum CellIdentifier {
    
    static let searchRecordDetail = "searchRecordDetailCell"
  }
  
  var methodIndex: Int = 0
  
  var buttonIndex: Int = 0
  
  var levelIndex: Int = 0
  
  var lowerRange: Double = 0
  
  var upperRange: Double = 0
  
  var noteDetailIndex: Int = 0
  
  private var results: [SearchRecordDetail] = []
  
  private var isPresented = false
  
  @IBOutlet private weak var resultsLabel: UILabel!
  
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 40
    tableView.separatorColor = .main
    tableView.layer.borderColor = UIColor.lightGray.cgColor
    tableView.layer.borderWidth = 1
    tableView.layer.cornerRadius = 15
    tableView.register(UINib(nibName: SearchRecordDetailCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.searchRecordDetail)
    let recordResults = RecordInfo.fetch()
    switch buttonIndex {
    case 0:
      switch methodIndex {
      case 0:
        let songResults = SongInfo.fetch()
        let level = levelIndex + 1
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d",
                                    #keyPath(SongInfo.button4.normal),
                                    level,
                                    #keyPath(SongInfo.button4.hard),
                                    level,
                                    #keyPath(SongInfo.button4.maximum),
                                    level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults
            .filter(NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                result.title?.english ?? "")).first else { return }
          if result.button4?.normal == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: record.button4?.normal?.rate ?? 0)
            results.append(object)
            
          }
          if result.button4?.hard == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: record.button4?.hard?.rate ?? 0)
            results.append(object)
          }
          if result.button4?.maximum == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: record.button4?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let format = "%K BETWEEN {\(lowerRange), \(upperRange)}"
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)")
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)}")
        let predicate = NSPredicate(format: format,
                                    #keyPath(RecordInfo.button4.normal.rate),
                                    #keyPath(RecordInfo.button4.hard.rate),
                                    #keyPath(RecordInfo.button4.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button4?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: result.button4?.normal?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button4?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: result.button4?.hard?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button4?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: result.button4?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let format = "%K == %@ AND %K != %@"
            .appending(" OR %K == %@ AND %K != %@")
            .appending(" OR %K == %@ AND %K != %@")
          let predicate = NSPredicate(format: format,
                                      #keyPath(RecordInfo.button4.normal.note),
                                      "",
                                      #keyPath(RecordInfo.button4.normal.rank),
                                      "",
                                      #keyPath(RecordInfo.button4.hard.note),
                                      "",
                                      #keyPath(RecordInfo.button4.hard.rank),
                                      "",
                                      #keyPath(RecordInfo.button4.maximum.note),
                                      "",
                                      #keyPath(RecordInfo.button4.maximum.rank), "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button4?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button4?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button4?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button4?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button4?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button4?.maximum?.rate ?? 0)
              results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@",
                                      #keyPath(RecordInfo.button4.normal.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button4.hard.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button4.maximum.note),
                                      Note.perfectPlay.rawValue)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button4?.normal?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button4?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button4?.hard?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button4?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button4?.maximum?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button4?.maximum?.rate ?? 0)
              results.append(object)
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
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d",
                                    #keyPath(SongInfo.button5.normal),
                                    level,
                                    #keyPath(SongInfo.button5.hard),
                                    level,
                                    #keyPath(SongInfo.button5.maximum), level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults
            .filter(NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                result.title?.english ?? ""))
            .first else { return }
          if result.button5?.normal == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: record.button5?.normal?.rate ?? 0)
            results.append(object)
            
          }
          if result.button5?.hard == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: record.button5?.hard?.rate ?? 0)
            results.append(object)
          }
          if result.button5?.maximum == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: record.button5?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let format = "%K BETWEEN {\(lowerRange), \(upperRange)}"
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)")
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)}")
        let predicate = NSPredicate(format: format,
                                    #keyPath(RecordInfo.button5.normal.rate),
                                    #keyPath(RecordInfo.button5.hard.rate),
                                    #keyPath(RecordInfo.button5.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button5?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: result.button5?.normal?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button5?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: result.button5?.hard?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button5?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: result.button5?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let format = "%K == %@ AND %K != %@"
            .appending(" OR %K == %@ AND %K != %@")
            .appending(" OR %K == %@ AND %K != %@")
          let predicate = NSPredicate(format: format,
                                      #keyPath(RecordInfo.button5.normal.note),
                                      "",
                                      #keyPath(RecordInfo.button5.normal.rank),
                                      "",
                                      #keyPath(RecordInfo.button5.hard.note),
                                      "",
                                      #keyPath(RecordInfo.button5.hard.rank),
                                      "",
                                      #keyPath(RecordInfo.button5.maximum.note),
                                      "",
                                      #keyPath(RecordInfo.button5.maximum.rank),
                                      "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button5?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button5?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button5?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button5?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button5?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button5?.maximum?.rate ?? 0)
              results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@",
                                      #keyPath(RecordInfo.button4.normal.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button5.hard.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button4.maximum.note),
                                      Note.perfectPlay.rawValue)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button5?.normal?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button5?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button5?.hard?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button5?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button5?.maximum?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button5?.maximum?.rate ?? 0)
              results.append(object)
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
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d",
                                    #keyPath(SongInfo.button6.normal),
                                    level,
                                    #keyPath(SongInfo.button6.hard),
                                    level,
                                    #keyPath(SongInfo.button6.maximum),
                                    level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults
            .filter(NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                result.title?.english ?? ""))
            .first else { return }
          if result.button6?.normal == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: record.button6?.normal?.rate ?? 0)
            results.append(object)
          }
          if result.button6?.hard == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: record.button6?.hard?.rate ?? 0)
            results.append(object)
          }
          if result.button6?.maximum == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: record.button6?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let format = "%K BETWEEN {\(lowerRange), \(upperRange)}"
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)")
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)}")
        let predicate = NSPredicate(format: format,
                                    #keyPath(RecordInfo.button6.normal.rate),
                                    #keyPath(RecordInfo.button6.hard.rate),
                                    #keyPath(RecordInfo.button6.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button6?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: result.button6?.normal?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button6?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: result.button6?.hard?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button6?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: result.button6?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let format = "%K == %@ AND %K != %@"
            .appending(" OR %K == %@ AND %K != %@")
            .appending(" OR %K == %@ AND %K != %@")
          let predicate = NSPredicate(format: format,
                                      #keyPath(RecordInfo.button6.normal.note),
                                      "",
                                      #keyPath(RecordInfo.button6.normal.rank),
                                      "",
                                      #keyPath(RecordInfo.button6.hard.note),
                                      "",
                                      #keyPath(RecordInfo.button6.hard.rank),
                                      "",
                                      #keyPath(RecordInfo.button6.maximum.note),
                                      "",
                                      #keyPath(RecordInfo.button6.maximum.rank),
                                      "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button6?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button6?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button6?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button6?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button6?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button6?.maximum?.rate ?? 0)
              results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@",
                                      #keyPath(RecordInfo.button6.normal.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button6.hard.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button6.maximum.note),
                                      Note.perfectPlay.rawValue)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button6?.normal?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button6?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button6?.hard?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button6?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button6?.maximum?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button6?.maximum?.rate ?? 0)
              results.append(object)
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
        let predicate = NSPredicate(format: "%K = %d OR %K = %d OR %K = %d",
                                    #keyPath(SongInfo.button8.normal),
                                    level, #keyPath(SongInfo.button8.hard),
                                    level,
                                    #keyPath(SongInfo.button8.maximum),
                                    level)
        let filtered = songResults.filter(predicate)
        for result in filtered {
          guard let record = recordResults
            .filter(NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                result.title?.english ?? ""))
            .first else { return }
          if result.button8?.normal == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: record.button8?.normal?.rate ?? 0)
            results.append(object)
            
          }
          if result.button8?.hard == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: record.button8?.hard?.rate ?? 0)
            results.append(object)
          }
          if result.button8?.maximum == level {
            let object = SearchRecordDetail(series: record.series,
                                            title: record.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: record.button8?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 1:
        let range = lowerRange...upperRange
        let format = "%K BETWEEN {\(lowerRange), \(upperRange)}"
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)")
          .appending(" OR %K BETWEEN {\(lowerRange), \(upperRange)}")
        
        let predicate = NSPredicate(format: format,
                                    #keyPath(RecordInfo.button8.normal.rate),
                                    #keyPath(RecordInfo.button8.hard.rate),
                                    #keyPath(RecordInfo.button8.maximum.rate))
        let filtered = recordResults.filter(predicate)
        for result in filtered {
          if range.contains(result.button8?.normal?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.normal.rawValue,
                                            rate: result.button8?.normal?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button8?.hard?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.hard.rawValue,
                                            rate: result.button8?.hard?.rate ?? 0)
            results.append(object)
          }
          if range.contains(result.button8?.maximum?.rate ?? 0) {
            let object = SearchRecordDetail(series: result.series,
                                            title: result.localizedTitle,
                                            difficulty: Difficulty.maximum.rawValue,
                                            rate: result.button8?.maximum?.rate ?? 0)
            results.append(object)
          }
        }
      case 2:
        if noteDetailIndex == 0 {
          let format = "%K == %@ AND %K != %@"
            .appending(" OR %K == %@ AND %K != %@")
            .appending(" OR %K == %@ AND %K != %@")
          let predicate = NSPredicate(format: format,
                                      #keyPath(RecordInfo.button8.normal.note),
                                      "",
                                      #keyPath(RecordInfo.button8.normal.rank),
                                      "",
                                      #keyPath(RecordInfo.button8.hard.note),
                                      "",
                                      #keyPath(RecordInfo.button8.hard.rank),
                                      "",
                                      #keyPath(RecordInfo.button8.maximum.note),
                                      "",
                                      #keyPath(RecordInfo.button8.maximum.rank),
                                      "")
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button8?.normal?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button8?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button8?.hard?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button8?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button8?.maximum?.note.isEmpty ?? false {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button8?.maximum?.rate ?? 0)
              results.append(object)
            }
          }
        } else {
          let predicate = NSPredicate(format: "%K == %@ OR %K == %@ OR %K == %@",
                                      #keyPath(RecordInfo.button8.normal.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button8.hard.note),
                                      Note.perfectPlay.rawValue,
                                      #keyPath(RecordInfo.button8.maximum.note),
                                      Note.perfectPlay.rawValue)
          let filtered = recordResults.filter(predicate)
          for result in filtered {
            if result.button8?.normal?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.normal.rawValue,
                                              rate: result.button8?.normal?.rate ?? 0)
              results.append(object)
            }
            if result.button8?.hard?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.hard.rawValue,
                                              rate: result.button8?.hard?.rate ?? 0)
              results.append(object)
            }
            if result.button8?.maximum?.note == Note.perfectPlay.rawValue {
              let object = SearchRecordDetail(series: result.series,
                                              title: result.localizedTitle,
                                              difficulty: Difficulty.maximum.rawValue,
                                              rate: result.button8?.maximum?.rate ?? 0)
              results.append(object)
            }
          }
        }
      default:
        break
      }
    default:
      break
    }
    results.sort { $0.title < $1.title }
    resultsLabel.text = "\(results.count)\(L10n.results)"
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Conforming UITableViewDataSource

extension SearchRecordDetailViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchRecordDetail,
                                             for: indexPath)
    if case let searchRecordDetailCell as SearchRecordDetailCell = cell {
      searchRecordDetailCell.configure(with: results[indexPath.row])
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results.count
  }
}

// MARK: - Conforming UITableViewDelegate

extension SearchRecordDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - Conforming DZNEmptyDataSetSource

extension SearchRecordDetailViewController: DZNEmptyDataSetSource {
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    let fontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    return NSAttributedString(string: L10n.noResults, attributes: fontAttribute)
  }
}

// MARK: - Conforming DZNEmptyDataSetDelegate

extension SearchRecordDetailViewController: DZNEmptyDataSetDelegate {
  
  func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
    return false
  }
  
  func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
    tableView.separatorStyle = .none
  }
  
  func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
    if !isPresented {
      isPresented = true
      return
    }
    tableView.separatorStyle = .singleLine
  }
}
