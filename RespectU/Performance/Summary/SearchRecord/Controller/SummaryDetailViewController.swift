//
//  SummaryDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SummaryDetailViewController: UIViewController {

    // 0 1 2 3 4 5 6 7 : 정확도
    // 8 : 맥스 콤보
    // 9 : 퍼펙트 플레이
    // 10 : 총 패턴 수
    // 11 : 성과 기록한 패턴 수
    @IBOutlet weak var button4StackView: UIStackView!
    @IBOutlet weak var button5StackView: UIStackView!
    @IBOutlet weak var button6StackView: UIStackView!
    @IBOutlet weak var button8StackView: UIStackView!
    @IBOutlet weak var allStackView: UIStackView!
    var songResults: Results<SongInfo>!
    var recordResults: Results<NewRecordInfo>!
    var button4Array = Array(repeating: 0, count: 12)
    var button5Array = Array(repeating: 0, count: 12)
    var button6Array = Array(repeating: 0, count: 12)
    var button8Array = Array(repeating: 0, count: 12)
    var allArray = Array(repeating: 0, count: 12)
    var rateArray = Array(repeating: 0.0, count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = ["button4", "button5", "button6", "button8"]
        let difficulties = ["normal", "hard", "maximum"]
        self.songResults = SongInfo.fetch()
        self.recordResults = NewRecordInfo.fetch()
        for recordResult in recordResults {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), recordResult.title?.english ?? "")
            guard let songResult = self.songResults.filter(predicate).first else { return }
            for index in 0..<4 {
                let button = buttons[index]
                guard let songButtonKeyPath = songResult.value(forKeyPath: button) as? SongButtonInfo else { return }
                guard let recordButtonKeyPath = recordResult.value(forKeyPath: button) as? NewRecordButtonInfo else { return }
                for difficulty in difficulties {
                    guard let level = songButtonKeyPath.value(forKeyPath: difficulty) as? Int else { return }
                    if level != 0 {
                        guard let recordKeyPath = recordButtonKeyPath.value(forKeyPath: difficulty) as? NewRecordDifficultyInfo else { return }
                        if !recordKeyPath.rank.isEmpty {
                            switch index {
                            case 0:
                                button4Array[11] += 1
                                rateArray[0] += recordKeyPath.rate
                            case 1:
                                button5Array[11] += 1
                                rateArray[1] += recordKeyPath.rate
                            case 2:
                                button6Array[11] += 1
                                rateArray[2] += recordKeyPath.rate
                            case 3:
                                button8Array[11] += 1
                                rateArray[3] += recordKeyPath.rate
                            default:
                                break
                            }
                        }
                        switch recordKeyPath.note {
                        case Note.maxCombo:
                            switch index {
                            case 0:
                                button4Array[8] += 1
                            case 1:
                                button5Array[8] += 1
                            case 2:
                                button6Array[8] += 1
                            case 3:
                                button8Array[8] += 1
                            default:
                                break
                            }
                        case Note.perfectPlay:
                            switch index {
                            case 0:
                                button4Array[9] += 1
                            case 1:
                                button5Array[9] += 1
                            case 2:
                                button6Array[9] += 1
                            case 3:
                                button8Array[9] += 1
                            default:
                                break
                            }
                        default:
                            break
                        }
                        switch recordKeyPath.rate {
                        case 99.8...100:
                            switch index {
                            case 0:
                                button4Array[0] += 1
                            case 1:
                                button5Array[0] += 1
                            case 2:
                                button6Array[0] += 1
                            case 3:
                                button8Array[0] += 1
                            default:
                                break
                            }
                        case 99.5..<99.8:
                            switch index {
                            case 0:
                                button4Array[1] += 1
                            case 1:
                                button5Array[1] += 1
                            case 2:
                                button6Array[1] += 1
                            case 3:
                                button8Array[1] += 1
                            default:
                                break
                            }
                        case 99..<99.5:
                            switch index {
                            case 0:
                                button4Array[2] += 1
                            case 1:
                                button5Array[2] += 1
                            case 2:
                                button6Array[2] += 1
                            case 3:
                                button8Array[2] += 1
                            default:
                                break
                            }
                        case 98.5..<99:
                            switch index {
                            case 0:
                                button4Array[3] += 1
                            case 1:
                                button5Array[3] += 1
                            case 2:
                                button6Array[3] += 1
                            case 3:
                                button8Array[3] += 1
                            default:
                                break
                            }
                        case 98..<98.5:
                            switch index {
                            case 0:
                                button4Array[4] += 1
                            case 1:
                                button5Array[4] += 1
                            case 2:
                                button6Array[4] += 1
                            case 3:
                                button8Array[4] += 1
                            default:
                                break
                            }
                        case 95..<98:
                            switch index {
                            case 0:
                                button4Array[5] += 1
                            case 1:
                                button5Array[5] += 1
                            case 2:
                                button6Array[5] += 1
                            case 3:
                                button8Array[5] += 1
                            default:
                                break
                            }
                        case 90..<95:
                            switch index {
                            case 0:
                                button4Array[6] += 1
                            case 1:
                                button5Array[6] += 1
                            case 2:
                                button6Array[6] += 1
                            case 3:
                                button8Array[6] += 1
                            default:
                                break
                            }
                        case ..<90:
                            switch index {
                            case 0:
                                button4Array[7] += 1
                            case 1:
                                button5Array[7] += 1
                            case 2:
                                button6Array[7] += 1
                            case 3:
                                button8Array[7] += 1
                            default:
                                break
                            }
                        default:
                            break
                        }
                    }
                }
            }
        }
        totalPatterns()
        for i in 0..<12 {
            allArray[i] = button4Array[i] + button5Array[i] + button6Array[i] + button8Array[i]
        }
        rateArray[0] = rateArray[0] / Double(button4Array[11])
        rateArray[1] = rateArray[1] / Double(button5Array[11])
        rateArray[2] = rateArray[2] / Double(button6Array[11])
        rateArray[3] = rateArray[3] / Double(button8Array[11])
        rateArray[4] = (rateArray[0] + rateArray[1] + rateArray[2] + rateArray[3]) / 4
        let count = button4StackView.arrangedSubviews.count
        for index in 1..<count - 1 {
            guard let button4Label = button4StackView.arrangedSubviews[index] as? UILabel else { return }
            guard let button5Label = button5StackView.arrangedSubviews[index] as? UILabel else { return }
            guard let button6Label = button6StackView.arrangedSubviews[index] as? UILabel else { return }
            guard let button8Label = button8StackView.arrangedSubviews[index] as? UILabel else { return }
            guard let allLabel = allStackView.arrangedSubviews[index] as? UILabel else { return }
            button4Label.text = "\(button4Array[index - 1])"
            button5Label.text = "\(button5Array[index - 1])"
            button6Label.text = "\(button6Array[index - 1])"
            button8Label.text = "\(button8Array[index - 1])"
            allLabel.text = "\(allArray[index - 1])"
        }
        guard let button4AverageLabel = button4StackView.arrangedSubviews.last as? UILabel else { return }
        guard let button5AverageLabel = button5StackView.arrangedSubviews.last as? UILabel else { return }
        guard let button6AverageLabel = button6StackView.arrangedSubviews.last as? UILabel else { return }
        guard let button8AverageLabel = button8StackView.arrangedSubviews.last as? UILabel else { return }
        guard let allAverageLabel = allStackView.arrangedSubviews.last as? UILabel else { return }
        button4AverageLabel.text = String(format: "%05.2f%%", rateArray[0])
        button5AverageLabel.text = String(format: "%05.2f%%", rateArray[1])
        button6AverageLabel.text = String(format: "%05.2f%%", rateArray[2])
        button8AverageLabel.text = String(format: "%05.2f%%", rateArray[3])
        allAverageLabel.text = String(format: "%05.2f%%", rateArray[4])
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SummaryDetailViewController {
    private func totalPatterns() {
        var button4: Int = 0
        var button5: Int = 0
        var button6: Int = 0
        var button8: Int = 0
        for result in self.songResults {
            let buttons = ["button4", "button5", "button6", "button8"]
            let difficulties = ["normal", "hard", "maximum"]
            for index in 0..<4 {
                let button = buttons[index]
                guard let buttonKeyPath = result.value(forKeyPath: button) as? SongButtonInfo else { return }
                for difficulty in difficulties {
                    guard let level = buttonKeyPath.value(forKeyPath: difficulty) as? Int else { return }
                    if level != 0 {
                        switch index {
                        case 0:
                            button4 += 1
                        case 1:
                            button5 += 1
                        case 2:
                            button6 += 1
                        case 3:
                            button8 += 1
                        default:
                            break
                        }
                    }
                }
            }
        }
        self.button4Array[10] = button4
        self.button5Array[10] = button5
        self.button6Array[10] = button6
        self.button8Array[10] = button8
    }
}
