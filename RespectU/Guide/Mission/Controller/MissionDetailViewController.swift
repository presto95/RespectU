//
//  MissionDetail2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {

    var object: MissionInfo!
    let myBPM = UserDefaults.standard.double(forKey: "bpm")
    let random = "RANDOM"
    
    var existsSong1: Bool {
        return object.stage1 != nil
    }
    var existsSong2: Bool {
        return object.stage2 != nil
    }
    var existsSong3: Bool {
        return object.stage3 != nil
    }
    var existsSong4: Bool {
        return object.stage4 != nil
    }
    var existsSong5: Bool {
        return object.stage5 != nil
    }
    var existsSong6: Bool {
        return object.stage6 != nil
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var feverLabel: UILabel!
    @IBOutlet weak var comboLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    @IBOutlet weak var song1ButtonLabel: UILabel!
    @IBOutlet weak var song2ButtonLabel: UILabel!
    @IBOutlet weak var song3ButtonLabel: UILabel!
    @IBOutlet weak var song4ButtonLabel: UILabel!
    @IBOutlet weak var song5ButtonLabel: UILabel!
    @IBOutlet weak var song6ButtonLabel: UILabel!
    @IBOutlet weak var song1DifficultyLabel: UILabel!
    @IBOutlet weak var song2DifficultyLabel: UILabel!
    @IBOutlet weak var song3DifficultyLabel: UILabel!
    @IBOutlet weak var song4DifficultyLabel: UILabel!
    @IBOutlet weak var song5DifficultyLabel: UILabel!
    @IBOutlet weak var song6DifficultyLabel: UILabel!
    @IBOutlet weak var song1TitleLabel: UILabel!
    @IBOutlet weak var song2TitleLabel: UILabel!
    @IBOutlet weak var song3TitleLabel: UILabel!
    @IBOutlet weak var song4TitleLabel: UILabel!
    @IBOutlet weak var song5TitleLabel: UILabel!
    @IBOutlet weak var song6TitleLabel: UILabel!
    @IBOutlet weak var song1MoreButton: UIButton!
    @IBOutlet weak var song2MoreButton: UIButton!
    @IBOutlet weak var song3MoreButton: UIButton!
    @IBOutlet weak var song4MoreButton: UIButton!
    @IBOutlet weak var song5MoreButton: UIButton!
    @IBOutlet weak var song6MoreButton: UIButton!
    @IBOutlet weak var effectorLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    var infoLabels = [UILabel]()
    var buttonLabels = [UILabel]()
    var difficultyLabels = [UILabel]()
    var titleLabels = [UILabel]()
    var moreButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisibilityOfViews()
        titleLabel.text = object.title
        scoreLabel.text = object.score == 0 ? "-" : "\(object.score)"
        feverLabel.text = object.fever == 0 ? "-" : "X\(object.fever)"
        comboLabel.text = object.combo == 0 ? "-" : "\(object.combo)"
        rateLabel.text = object.rate == 0 ? "-" : "\(object.rate)%"
        breakLabel.text = object.break == 0 ? "-" : "\(object.break)"
        effectorLabel.text = object.effector
        rewardLabel.text = object.localizedReward
        if let song = object.stage1 {
            song1ButtonLabel.text = song.button.uppercased()
            song1DifficultyLabel.text = song.difficulty.uppercased()
            song1TitleLabel.text = song.localizedTitle
        }
        if let song = object.stage2 {
            song2ButtonLabel.text = song.button.uppercased()
            song2DifficultyLabel.text = song.difficulty.uppercased()
            song2TitleLabel.text = song.localizedTitle
        }
        if let song = object.stage3 {
            song3ButtonLabel.text = song.button.uppercased()
            song3DifficultyLabel.text = song.difficulty.uppercased()
            song3TitleLabel.text = song.localizedTitle
        }
        if let song = object.stage4 {
            song4ButtonLabel.text = song.button.uppercased()
            song4DifficultyLabel.text = song.difficulty.uppercased()
            song4TitleLabel.text = song.localizedTitle
        }
        if let song = object.stage5 {
            song5ButtonLabel.text = song.button.uppercased()
            song5DifficultyLabel.text = song.difficulty.uppercased()
            song5TitleLabel.text = song.localizedTitle
        }
        if let song = object.stage6 {
            song6ButtonLabel.text = song.button.uppercased()
            song6DifficultyLabel.text = song.difficulty.uppercased()
            song6TitleLabel.text = song.localizedTitle
        }
    }

    static func instantiate(_ object: MissionInfo?) -> MissionDetailViewController? {
        guard let viewController = UIStoryboard(name: "Mission", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? MissionDetailViewController else { return nil }
        viewController.object = object
        return viewController
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpMoreButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            presentMoreAlert(title: object.stage1?.title?.english, button: object.stage1?.button, difficulty: object.stage1?.difficulty)
        case 1:
            presentMoreAlert(title: object.stage2?.title?.english, button: object.stage2?.button, difficulty: object.stage2?.difficulty)
        case 2:
            presentMoreAlert(title: object.stage3?.title?.english, button: object.stage3?.button, difficulty: object.stage3?.difficulty)
        case 3:
            presentMoreAlert(title: object.stage4?.title?.english, button: object.stage4?.button, difficulty: object.stage4?.difficulty)
        case 4:
            presentMoreAlert(title: object.stage5?.title?.english, button: object.stage5?.button, difficulty: object.stage5?.difficulty)
        case 5:
            presentMoreAlert(title: object.stage6?.title?.english, button: object.stage6?.button, difficulty: object.stage6?.difficulty)
        default:
            break
        }
    }
}

extension MissionDetailViewController {
    ///더보기 버튼 눌렀을 때 UIAlertController 띄우기
    private func presentMoreAlert(title: String?, button: String?, difficulty: String?) {
        guard let title = title, let button = button, let difficulty = difficulty else { return }
        var level: Int?
        var bpm: Int = 0
        var changesSpeed: Bool = false
        if let object = SongInfo.fetch(by: title) {
            if let subBpm = object.subBpm.value {
                bpm = subBpm
                changesSpeed = true
            } else {
                bpm = object.bpm
            }
            if let buttonKeyPath = button.buttonExpansion {
                guard let buttonResult = object.value(forKeyPath: buttonKeyPath) as? SongButtonInfo else { return }
                switch difficulty {
                case Difficulty.normal:
                    level = buttonResult.normal
                case Difficulty.hard:
                    level = buttonResult.hard
                case Difficulty.maximum:
                    level = buttonResult.maximum
                default:
                    break
                }
            }
        }
        let speedString = { () -> String in
            if bpm != 0 {
                return recommendedSpeed(by: myBPM / Double(bpm))
            } else {
                return "??"
            }
        }()
        let levelString = { () -> String in
            if let level = level {
                return "\(level)"
            } else {
                return "??"
            }
        }()
        var message = "\(button.uppercased()) \(difficulty.uppercased())\n\n" + "Level".localized + "\n\(levelString)\n\n" + "SPEED Recommendation".localized + "\n\(speedString)"
        if changesSpeed {
            message += "\n" + "(SPEED Variation)".localized
        }
        DispatchQueue.main.async { [weak self] in
            UIAlertController
                .alert(title: title, message: message)
                .action(title: "OK".localized)
                .present(to: self)
        }
    }
    
    ///뷰들의 가시성 초기 설정
    private func setVisibilityOfViews() {
        if !existsSong1 {
            song1ButtonLabel.isHidden = true
            song1DifficultyLabel.isHidden = true
            song1TitleLabel.isHidden = true
            song1MoreButton.isHidden = true
        } else if object.stage1?.localizedTitle == random {
            song1MoreButton.isHidden = true
        }
        if !existsSong2 {
            song2ButtonLabel.isHidden = true
            song2DifficultyLabel.isHidden = true
            song2TitleLabel.isHidden = true
            song2MoreButton.isHidden = true
        } else if object.stage2?.localizedTitle == random {
            song2MoreButton.isHidden = true
        }
        if !existsSong3 {
            song3ButtonLabel.isHidden = true
            song3DifficultyLabel.isHidden = true
            song3TitleLabel.isHidden = true
            song3MoreButton.isHidden = true
        } else if object.stage3?.localizedTitle == random {
            song3MoreButton.isHidden = true
        }
        if !existsSong4 {
            song4ButtonLabel.isHidden = true
            song4DifficultyLabel.isHidden = true
            song4TitleLabel.isHidden = true
            song4MoreButton.isHidden = true
        } else if object.stage4?.localizedTitle == random {
            song4MoreButton.isHidden = true
        }
        if !existsSong5 {
            song5ButtonLabel.isHidden = true
            song5DifficultyLabel.isHidden = true
            song5TitleLabel.isHidden = true
            song5MoreButton.isHidden = true
        } else if object.stage5?.localizedTitle == random {
            song5MoreButton.isHidden = true
        }
        if !existsSong6 {
            song6ButtonLabel.isHidden = true
            song6DifficultyLabel.isHidden = true
            song6TitleLabel.isHidden = true
            song6MoreButton.isHidden = true
        } else if object.stage6?.localizedTitle == random {
            song6MoreButton.isHidden = true
        }
    }
}
