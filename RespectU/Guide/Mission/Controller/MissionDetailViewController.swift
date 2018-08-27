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
    
    var existsSong1 = true
    var existsSong2 = true
    var isSong3Visible = true
    var isSong4Visible = true
    var isSong5Visible = true
    var isSong6Visible = true
    
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
        scoreLabel.text = object.scoreLim == 0 ? "-" : "\(object.scoreLim)"
        feverLabel.text = object.feverLim == 0 ? "-" : "X\(object.feverLim)"
        comboLabel.text = object.comboLim == 0 ? "-" : "\(object.comboLim)"
        rateLabel.text = object.rateLim == 0 ? "-" : "\(object.rateLim)%"
        breakLabel.text = object.breakLim == 0 ? "-" : "\(object.breakLim)"
        effectorLabel.text = object.more
        rewardLabel.text = object.reward.isEmpty ? "None".localized : object.reward
        if existsSong1 {
            song1ButtonLabel.text = object.song1key
            song1DifficultyLabel.text = object.song1level
            song1TitleLabel.text = object.song1title
        }
        if existsSong2 {
            song2ButtonLabel.text = object.song2key
            song2DifficultyLabel.text = object.song2level
            song2TitleLabel.text = object.song2title
        }
        if isSong3Visible {
            song3ButtonLabel.text = object.song3key
            song3DifficultyLabel.text = object.song3level
            song3TitleLabel.text = object.song3title
        }
        if isSong4Visible {
            song4ButtonLabel.text = object.song4key
            song4DifficultyLabel.text = object.song4level
            song4TitleLabel.text = object.song4title
        }
        if isSong5Visible {
            song5ButtonLabel.text = object.song5key
            song5DifficultyLabel.text = object.song5level
            song5TitleLabel.text = object.song5title
        }
        if isSong6Visible {
            song6ButtonLabel.text = object.song6key
            song6DifficultyLabel.text = object.song6level
            song6TitleLabel.text = object.song6title
        }
    }

    static func instantiate(_ object: MissionInfo) -> MissionDetailViewController? {
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
            presentMoreAlert(title: object.song1title, button: object.song1key, difficulty: object.song1level)
        case 1:
            presentMoreAlert(title: object.song2title, button: object.song2key, difficulty: object.song2level)
        case 2:
            presentMoreAlert(title: object.song3title, button: object.song3key, difficulty: object.song3level)
        case 3:
            presentMoreAlert(title: object.song4title, button: object.song4key, difficulty: object.song4level)
        case 4:
            presentMoreAlert(title: object.song5title, button: object.song5key, difficulty: object.song5level)
        case 5:
            presentMoreAlert(title: object.song6title, button: object.song6key, difficulty: object.song6level)
        default:
            break
        }
    }
}

extension MissionDetailViewController {
    private func presentMoreAlert(title: String, button: String, difficulty: String){
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
        if object.song1title.isEmpty {
            song1ButtonLabel.isHidden = true
            song1DifficultyLabel.isHidden = true
            song1TitleLabel.isHidden = true
            song1MoreButton.isHidden = true
            existsSong1 = false
        } else if object.song1title == random {
            song1MoreButton.isHidden = true
        }
        if object.song2title.isEmpty {
            song2ButtonLabel.isHidden = true
            song2DifficultyLabel.isHidden = true
            song2TitleLabel.isHidden = true
            song2MoreButton.isHidden = true
            existsSong2 = false
        } else if object.song2title == random {
            song2MoreButton.isHidden = true
        }
        if object.song3title.isEmpty {
            song3ButtonLabel.isHidden = true
            song3DifficultyLabel.isHidden = true
            song3TitleLabel.isHidden = true
            song3MoreButton.isHidden = true
            isSong3Visible = false
        } else if object.song3title == random {
            song3MoreButton.isHidden = true
        }
        if object.song4title.isEmpty {
            song4ButtonLabel.isHidden = true
            song4DifficultyLabel.isHidden = true
            song4TitleLabel.isHidden = true
            song4MoreButton.isHidden = true
            isSong4Visible = false
        } else if object.song4title == random {
            song4MoreButton.isHidden = true
        }
        if object.song5title.isEmpty {
            song5ButtonLabel.isHidden = true
            song5DifficultyLabel.isHidden = true
            song5TitleLabel.isHidden = true
            song5MoreButton.isHidden = true
            isSong5Visible = false
        } else if object.song5title == random {
            song5MoreButton.isHidden = true
        }
        if object.song6title.isEmpty {
            song6ButtonLabel.isHidden = true
            song6DifficultyLabel.isHidden = true
            song6TitleLabel.isHidden = true
            song6MoreButton.isHidden = true
            isSong6Visible = false
        } else if object.song6title == random {
            song6MoreButton.isHidden = true
        }
    }
}
