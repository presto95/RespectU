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
    var recordResults: Results<PerformanceInfo>!
    var songResults: Results<SongInfo>!
    var button4Array = Array(repeating: 0, count: 12)
    var button5Array = Array(repeating: 0, count: 12)
    var button6Array = Array(repeating: 0, count: 12)
    var button8Array = Array(repeating: 0, count: 12)
    var allArray = Array(repeating: 0, count: 12)
    var rateArray = Array(repeating: 0.0, count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordResults = PerformanceInfo.fetch()
        self.songResults = SongInfo.fetch()
        for result in recordResults {
            setButtonArrayWithTotalPatterns(songResults)
            setButtonArrayExceptTotalPatterns(result.button4, to: &button4Array)
            setButtonArrayExceptTotalPatterns(result.button5, to: &button5Array)
            setButtonArrayExceptTotalPatterns(result.button6, to: &button6Array)
            setButtonArrayExceptTotalPatterns(result.button8, to: &button8Array)
            setRateArray(result.button4, to: &rateArray[0])
            setRateArray(result.button5, to: &rateArray[1])
            setRateArray(result.button6, to: &rateArray[2])
            setRateArray(result.button8, to: &rateArray[3])
        }
        for i in 0..<allArray.count {
            allArray[i] = button4Array[i] + button5Array[i] + button6Array[i] + button8Array[i]
        }
        rateArray[4] = rateArray[0] + rateArray[1] + rateArray[2] + rateArray[3]
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
        button4AverageLabel.text = "\(rateArray[0])%"
        button5AverageLabel.text = "\(rateArray[1])%"
        button6AverageLabel.text = "\(rateArray[2])%"
        button8AverageLabel.text = "\(rateArray[3])%"
        allAverageLabel.text = "\(rateArray[4])%"
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SummaryDetailViewController {
    private func setButtonArrayWithTotalPatterns(_ results: Results<SongInfo>?) {
        guard let results = results else { return }
        for result in results {
            let buttons = ["button4", "button5", "button6", "button8"]
            let difficulties = ["normal", "hard", "maximum"]
            for i in 0..<4 {
                let buttonKey = buttons[i]
                guard let button = result.value(forKey: buttonKey) as? SongButtonInfo else { return }
                for difficulty in difficulties {
                    guard let difficulty = button.value(forKey: difficulty) as? Int else { return }
                    if difficulty != 0 {
                        switch i {
                        case 0:
                            button4Array[10] += 1
                        case 1:
                            button5Array[10] += 1
                        case 2:
                            button6Array[10] += 1
                        case 3:
                            button8Array[10] += 1
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    private func setButtonArrayExceptTotalPatterns(_ button: PerformanceButtonInfo?, to array: inout [Int]) {
        guard let button = button else { return }
        let difficulties = ["normal", "hard", "maximum"]
        for difficulty in difficulties {
            guard let difficulty = button.value(forKey: difficulty) as? PerformanceRecordInfo else { return }
            switch difficulty.rate {
            case 99.8...100:
                array[0] += 1
            case 99.5..<99.8:
                array[1] += 1
            case 99..<99.5:
                array[2] += 1
            case 98.5..<99:
                array[3] += 1
            case 98..<98.5:
                array[4] += 1
            case 95..<98:
                array[5] += 1
            case 90..<95:
                array[6] += 1
            case ..<90:
                array[7] += 1
            default:
                break
            }
            switch difficulty.note {
            case "MC":
                array[8] += 1
            case "PP":
                array[9] += 1
            default:
                break
            }
            if !difficulty.rank.isEmpty {
                array[11] += 1
            }
        }
    }
    private func setRateArray(_ button: PerformanceButtonInfo?, to value: inout Double) {
        guard let button = button else { return }
        let difficulties = ["normal", "hard", "maximum"]
        for difficulty in difficulties {
            guard let difficulty = button.value(forKey: difficulty) as? PerformanceRecordInfo else { return }
            value += difficulty.rate
        }
    }
}
