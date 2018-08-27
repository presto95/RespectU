//
//  MissionDetail2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {

    var object: MissionResponse.Mission!
    let myBPM = UserDefaults.standard.double(forKey: "bpm")
    let random = "RANDOM"
    
    var existsSong1: Bool {
        return object.song1 != nil
    }
    var existsSong2: Bool {
        return object.song2 != nil
    }
    var existsSong3: Bool {
        return object.song3 != nil
    }
    var existsSong4: Bool {
        return object.song4 != nil
    }
    var existsSong5: Bool {
        return object.song5 != nil
    }
    var existsSong6: Bool {
        return object.song6 != nil
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
        if let song = object.song1 {
            song1ButtonLabel.text = song.button.uppercased()
            song1DifficultyLabel.text = song.difficulty.uppercased()
            song1TitleLabel.text = song.localizedTitle
        }
        if let song = object.song2 {
            song2ButtonLabel.text = song.button.uppercased()
            song2DifficultyLabel.text = song.difficulty.uppercased()
            song2TitleLabel.text = song.localizedTitle
        }
        if let song = object.song3 {
            song3ButtonLabel.text = song.button.uppercased()
            song3DifficultyLabel.text = song.difficulty.uppercased()
            song3TitleLabel.text = song.localizedTitle
        }
        if let song = object.song4 {
            song4ButtonLabel.text = song.button.uppercased()
            song4DifficultyLabel.text = song.difficulty.uppercased()
            song4TitleLabel.text = song.localizedTitle
        }
        if let song = object.song5 {
            song5ButtonLabel.text = song.button.uppercased()
            song5DifficultyLabel.text = song.difficulty.uppercased()
            song5TitleLabel.text = song.localizedTitle
        }
        if let song = object.song6 {
            song6ButtonLabel.text = song.button.uppercased()
            song6DifficultyLabel.text = song.difficulty.uppercased()
            song6TitleLabel.text = song.localizedTitle
        }
    }

    static func instantiate(_ object: MissionResponse.Mission?) -> MissionDetailViewController? {
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
            presentMoreAlert(title: object.song1?.localizedTitle, button: object.song1?.button, difficulty: object.song1?.difficulty)
        case 1:
            presentMoreAlert(title: object.song2?.localizedTitle, button: object.song2?.button, difficulty: object.song2?.difficulty)
        case 2:
            presentMoreAlert(title: object.song3?.localizedTitle, button: object.song3?.button, difficulty: object.song3?.difficulty)
        case 3:
            presentMoreAlert(title: object.song4?.localizedTitle, button: object.song4?.button, difficulty: object.song4?.difficulty)
        case 4:
            presentMoreAlert(title: object.song5?.localizedTitle, button: object.song5?.button, difficulty: object.song5?.difficulty)
        case 5:
            presentMoreAlert(title: object.song6?.localizedTitle, button: object.song6?.button, difficulty: object.song6?.difficulty)
        default:
            break
        }
    }
}

extension MissionDetailViewController {
    private func presentMoreAlert(title: String?, button: String?, difficulty: String?){
        guard let title = title, let button = button, let difficulty = difficulty else { return }
        var level: Int = 0
        var bpm: Double = 0
        let query = NSPredicate(format: "title = %@", title)
        if let object = SongInfo.get().filter(query).first {
            bpm = object.bpm.bpmToDouble
            switch button {
            case Buttons.button4:
                switch difficulty {
                case Difficulty.normal:
                    level = object.nm4
                case Difficulty.hard:
                    level = object.hd4
                case Difficulty.maximum:
                    level = object.mx4
                default:
                    break
                }
            case Buttons.button5:
                switch difficulty {
                case Difficulty.normal:
                    level = object.nm5
                case Difficulty.hard:
                    level = object.hd5
                case Difficulty.maximum:
                    level = object.mx5
                default:
                    break
                }
            case Buttons.button6:
                switch difficulty {
                case Difficulty.normal:
                    level = object.nm6
                case Difficulty.hard:
                    level = object.hd6
                case Difficulty.maximum:
                    level = object.mx6
                default:
                    break
                }
            case Buttons.button8:
                switch difficulty {
                case Difficulty.normal:
                    level = object.nm8
                case Difficulty.hard:
                    level = object.hd8
                case Difficulty.maximum:
                    level = object.mx8
                default:
                    break
                }
            default:
                break
            }
        }
        let speed: String = { () -> String in
            if bpm != 0 {
                return recommendedSpeed(by: myBPM / bpm)
            } else {
                return "??"
            }
        }()
        let difficultyString = level == 0 ? "??" : "\(level)"
        let message = "\(button) \(difficulty)\n\n" + "Difficulty".localized + "\n\(difficultyString)\n\n" + "SPEED Recommendation".localized + "\n\(speed)"
        UIAlertController
            .alert(title: title, message: message)
            .defaultAction(title: "OK".localized)
            .present(to: self)
    }
    
    private func setVisibilityOfViews() {
        if !existsSong1 {
            song1ButtonLabel.isHidden = true
            song1DifficultyLabel.isHidden = true
            song1TitleLabel.isHidden = true
            song1MoreButton.isHidden = true
        } else if object.song1?.localizedTitle == random {
            song1MoreButton.isHidden = true
        }
        if !existsSong2 {
            song2ButtonLabel.isHidden = true
            song2DifficultyLabel.isHidden = true
            song2TitleLabel.isHidden = true
            song2MoreButton.isHidden = true
        } else if object.song2?.localizedTitle == random {
            song2MoreButton.isHidden = true
        }
        if !existsSong3 {
            song3ButtonLabel.isHidden = true
            song3DifficultyLabel.isHidden = true
            song3TitleLabel.isHidden = true
            song3MoreButton.isHidden = true
        } else if object.song3?.localizedTitle == random {
            song3MoreButton.isHidden = true
        }
        if !existsSong4 {
            song4ButtonLabel.isHidden = true
            song4DifficultyLabel.isHidden = true
            song4TitleLabel.isHidden = true
            song4MoreButton.isHidden = true
        } else if object.song4?.localizedTitle == random {
            song4MoreButton.isHidden = true
        }
        if !existsSong5 {
            song5ButtonLabel.isHidden = true
            song5DifficultyLabel.isHidden = true
            song5TitleLabel.isHidden = true
            song5MoreButton.isHidden = true
        } else if object.song5?.localizedTitle == random {
            song5MoreButton.isHidden = true
        }
        if !existsSong6 {
            song6ButtonLabel.isHidden = true
            song6DifficultyLabel.isHidden = true
            song6TitleLabel.isHidden = true
            song6MoreButton.isHidden = true
        } else if object.song6?.localizedTitle == random {
            song6MoreButton.isHidden = true
        }
    }
}
