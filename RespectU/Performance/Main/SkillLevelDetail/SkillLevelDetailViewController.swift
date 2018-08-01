//
//  SkillLevelDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SkillLevelDetailViewController: UIViewController {

    @IBOutlet weak var button4BackgroundView: UIView!
    @IBOutlet weak var button5BackgroundView: UIView!
    @IBOutlet weak var button6BackgroundView: UIView!
    @IBOutlet weak var button8BackgroundView: UIView!
    private let skillLevelDetailView = "SkillLevelDetailView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let performanceRecordRate = getPerformanceRecordRate()
        guard let button4View = UIView.instanceFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
        guard let button5View = UIView.instanceFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
        guard let button6View = UIView.instanceFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
        guard let button8View = UIView.instanceFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
        let recordViews = [button4View, button5View, button6View, button8View]
        let backgroundViews = [button4BackgroundView!, button5BackgroundView!, button6BackgroundView!, button8BackgroundView!]
        for index in 0..<recordViews.count {
            let recordView = recordViews[index]
            let backgroundView = backgroundViews[index]
            recordView.frame.size = backgroundView.bounds.size
            backgroundView.addSubview(recordView)
        }
        let button4Max = getMaxSkillPoint(button: "4B")
        let button5Max = getMaxSkillPoint(button: "5B")
        let button6Max = getMaxSkillPoint(button: "6B")
        let button8Max = getMaxSkillPoint(button: "8B")
        let myButton4 = getMySkillPoint(button: "4B")
        let myButton5 = getMySkillPoint(button: "5B")
        let myButton6 = getMySkillPoint(button: "6B")
        let myButton8 = getMySkillPoint(button: "8B")
        let button4SkillLevel = getSkillLevelButton4(value: myButton4.sum)
        let button5SkillLevel = getSkillLevelButton5(value: myButton5.sum)
        let button6SkillLevel = getSkillLevelButton6And8(value: myButton6.sum)
        let button8SkillLevel = getSkillLevelButton6And8(value: myButton8.sum)
        button4View.button.text = "4B"
        button5View.button.text = "5B"
        button6View.button.text = "6B"
        button8View.button.text = "8B"
        button4View.skillLevel.text = button4SkillLevel
        button5View.skillLevel.text = button5SkillLevel
        button6View.skillLevel.text = button6SkillLevel
        button8View.skillLevel.text = button8SkillLevel
        button4View.skillPoint.text = "\((myButton4.sum * 100).rounded() / 100) " + "Point".localized
        button5View.skillPoint.text = "\((myButton5.sum * 100).rounded() / 100) " + "Point".localized
        button6View.skillPoint.text = "\((myButton6.sum * 100).rounded() / 100) " + "Point".localized
        button8View.skillPoint.text = "\((myButton8.sum * 100).rounded() / 100) " + "Point".localized
        button4View.gauge.maxValue = CGFloat(button4Max)
        button5View.gauge.maxValue = CGFloat(button5Max)
        button6View.gauge.maxValue = CGFloat(button6Max)
        button8View.gauge.maxValue = CGFloat(button8Max)
        button4View.gauge.startColor = { () -> UIColor in
            switch(myButton4.highestSeries){
            case "Portable1":
                return UIColor.portable1
            case "Portable2":
                return UIColor.portable2
            case "Respect":
                return UIColor.respect
            case "Trilogy":
                return UIColor.trilogy
            case "CE":
                return UIColor.ce
            case "Technika1":
                return UIColor.technika1
            case "BS":
                return UIColor.bs
            default:
                return UIColor()
            }
        }()
        button5View.gauge.startColor = { () -> UIColor in
            switch(myButton5.highestSeries){
            case "Portable1":
                return UIColor.portable1
            case "Portable2":
                return UIColor.portable2
            case "Respect":
                return UIColor.respect
            case "Trilogy":
                return UIColor.trilogy
            case "CE":
                return UIColor.ce
            case "Technika1":
                return UIColor.technika1
            case "BS":
                return UIColor.bs
            default:
                return UIColor()
            }
        }()
        button6View.gauge.startColor = { () -> UIColor in
            switch(myButton6.highestSeries){
            case "Portable1":
                return UIColor.portable1
            case "Portable2":
                return UIColor.portable2
            case "Respect":
                return UIColor.respect
            case "Trilogy":
                return UIColor.trilogy
            case "CE":
                return UIColor.ce
            case "Technika1":
                return UIColor.technika1
            case "BS":
                return UIColor.bs
            default:
                return UIColor()
            }
        }()
        button8View.gauge.startColor = { () -> UIColor in
            switch(myButton8.highestSeries){
            case "Portable1":
                return UIColor.portable1
            case "Portable2":
                return UIColor.portable2
            case "Respect":
                return UIColor.respect
            case "Trilogy":
                return UIColor.trilogy
            case "CE":
                return UIColor.ce
            case "Technika1":
                return UIColor.technika1
            case "BS":
                return UIColor.bs
            default:
                return UIColor()
            }
        }()
        button4View.performanceRecordRate.text = String.init(format: "%04.1f%%", performanceRecordRate.button4PerformanceRecordRate * 100) + " Recorded".localized
        button5View.performanceRecordRate.text = String.init(format: "%04.1f%%", performanceRecordRate.button5PerformanceRecordRate * 100) + " Recorded".localized
        button6View.performanceRecordRate.text = String.init(format: "%04.1f%%", performanceRecordRate.button6PerformanceRecordRate * 100) + " Recorded".localized
        button8View.performanceRecordRate.text = String.init(format: "%04.1f%%", performanceRecordRate.button8PerformanceRecordRate * 100) + " Recorded".localized
        button4View.gauge.bgColor = button4View.gauge.startColor
        button5View.gauge.bgColor = button5View.gauge.startColor
        button6View.gauge.bgColor = button6View.gauge.startColor
        button8View.gauge.bgColor = button8View.gauge.startColor
        button4View.percent.text = String(format: "%05.2f%%", myButton4.sum * 100 / button4Max)
        button5View.percent.text = String(format: "%05.2f%%", myButton5.sum * 100 / button5Max)
        button6View.percent.text = String(format: "%05.2f%%", myButton6.sum * 100 / button6Max)
        button8View.percent.text = String(format: "%05.2f%%", myButton8.sum * 100 / button8Max)
        button4View.gauge.animateRate(1, newValue: CGFloat(myButton4.sum)) { _ in }
        button5View.gauge.animateRate(1, newValue: CGFloat(myButton5.sum)) { _ in }
        button6View.gauge.animateRate(1, newValue: CGFloat(myButton6.sum)) { _ in }
        button8View.gauge.animateRate(1, newValue: CGFloat(myButton8.sum)) { _ in }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickShare(_ sender: UIButton) {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

func getPerformanceRecordRate() -> (button4PerformanceRecordRate: Double, button5PerformanceRecordRate: Double, button6PerformanceRecordRate: Double, button8PerformanceRecordRate: Double){
    var count4B = [0,0]
    var count5B = [0,0]
    var count6B = [0,0]
    var count8B = [0,0]
    let results = try! Realm().objects(RecordInfo.self)
    for result in results{
        if(result.nm4 != 0){
            count4B[0] += 1
        }
        if(result.hd4 != 0){
            count4B[0] += 1
        }
        if(result.mx4 != 0){
            count4B[0] += 1
        }
        if(result.nm5 != 0){
            count5B[0] += 1
        }
        if(result.hd5 != 0){
            count5B[0] += 1
        }
        if(result.mx5 != 0){
            count5B[0] += 1
        }
        if(result.nm6 != 0){
            count6B[0] += 1
        }
        if(result.hd6 != 0){
            count6B[0] += 1
        }
        if(result.mx6 != 0){
            count6B[0] += 1
        }
        if(result.nm8 != 0){
            count8B[0] += 1
        }
        if(result.hd8 != 0){
            count8B[0] += 1
        }
        if(result.mx8 != 0){
            count8B[0] += 1
        }
        if let _ = Double(result.nm4Rate.split(separator: "%")[0]){
            count4B[1] += 1
        }
        if let _ = Double(result.hd4Rate.split(separator: "%")[0]){
            count4B[1] += 1
        }
        if let _ = Double(result.mx4Rate.split(separator: "%")[0]){
            count4B[1] += 1
        }
        if let _ = Double(result.nm5Rate.split(separator: "%")[0]){
            count5B[1] += 1
        }
        if let _ = Double(result.hd5Rate.split(separator: "%")[0]){
            count5B[1] += 1
        }
        if let _ = Double(result.mx5Rate.split(separator: "%")[0]){
            count5B[1] += 1
        }
        if let _ = Double(result.nm6Rate.split(separator: "%")[0]){
            count6B[1] += 1
        }
        if let _ = Double(result.hd6Rate.split(separator: "%")[0]){
            count6B[1] += 1
        }
        if let _ = Double(result.mx6Rate.split(separator: "%")[0]){
            count6B[1] += 1
        }
        if let _ = Double(result.nm8Rate.split(separator: "%")[0]){
            count8B[1] += 1
        }
        if let _ = Double(result.hd8Rate.split(separator: "%")[0]){
            count8B[1] += 1
        }
        if let _ = Double(result.mx8Rate.split(separator: "%")[0]){
            count8B[1] += 1
        }
    }
    let rate4B = Double(count4B[1]) / Double(count4B[0])
    let rate5B = Double(count5B[1]) / Double(count5B[0])
    let rate6B = Double(count6B[1]) / Double(count6B[0])
    let rate8B = Double(count8B[1]) / Double(count8B[0])
    return (rate4B, rate5B, rate6B, rate8B)
}
