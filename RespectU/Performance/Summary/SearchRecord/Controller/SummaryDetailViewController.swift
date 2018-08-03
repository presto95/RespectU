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

    @IBOutlet weak var label4B0: UILabel!
    @IBOutlet weak var label4B1: UILabel!
    @IBOutlet weak var label4B2: UILabel!
    @IBOutlet weak var label4B3: UILabel!
    @IBOutlet weak var label4B4: UILabel!
    @IBOutlet weak var label4B5: UILabel!
    @IBOutlet weak var label4B6: UILabel!
    @IBOutlet weak var label4B7: UILabel!
    @IBOutlet weak var label4BMC: UILabel!
    @IBOutlet weak var label4BPP: UILabel!
    @IBOutlet weak var label4BPatterns: UILabel!
    @IBOutlet weak var label4BAvg: UILabel!
    @IBOutlet weak var label5B0: UILabel!
    @IBOutlet weak var label5B1: UILabel!
    @IBOutlet weak var label5B2: UILabel!
    @IBOutlet weak var label5B3: UILabel!
    @IBOutlet weak var label5B4: UILabel!
    @IBOutlet weak var label5B5: UILabel!
    @IBOutlet weak var label5B6: UILabel!
    @IBOutlet weak var label5B7: UILabel!
    @IBOutlet weak var label5BMC: UILabel!
    @IBOutlet weak var label5BPP: UILabel!
    @IBOutlet weak var label5BPatterns: UILabel!
    @IBOutlet weak var label5BAvg: UILabel!
    @IBOutlet weak var label6B0: UILabel!
    @IBOutlet weak var label6B1: UILabel!
    @IBOutlet weak var label6B2: UILabel!
    @IBOutlet weak var label6B3: UILabel!
    @IBOutlet weak var label6B4: UILabel!
    @IBOutlet weak var label6B5: UILabel!
    @IBOutlet weak var label6B6: UILabel!
    @IBOutlet weak var label6B7: UILabel!
    @IBOutlet weak var label6BMC: UILabel!
    @IBOutlet weak var label6BPP: UILabel!
    @IBOutlet weak var label6BPatterns: UILabel!
    @IBOutlet weak var label6BAvg: UILabel!
    @IBOutlet weak var label8B0: UILabel!
    @IBOutlet weak var label8B1: UILabel!
    @IBOutlet weak var label8B2: UILabel!
    @IBOutlet weak var label8B3: UILabel!
    @IBOutlet weak var label8B4: UILabel!
    @IBOutlet weak var label8B5: UILabel!
    @IBOutlet weak var label8B6: UILabel!
    @IBOutlet weak var label8B7: UILabel!
    @IBOutlet weak var label8BMC: UILabel!
    @IBOutlet weak var label8BPP: UILabel!
    @IBOutlet weak var label8BPatterns: UILabel!
    @IBOutlet weak var label8BAvg: UILabel!
    @IBOutlet weak var labelAll0: UILabel!
    @IBOutlet weak var labelAll1: UILabel!
    @IBOutlet weak var labelAll2: UILabel!
    @IBOutlet weak var labelAll3: UILabel!
    @IBOutlet weak var labelAll4: UILabel!
    @IBOutlet weak var labelAll5: UILabel!
    @IBOutlet weak var labelAll6: UILabel!
    @IBOutlet weak var labelAll7: UILabel!
    @IBOutlet weak var labelAllMC: UILabel!
    @IBOutlet weak var labelAllPP: UILabel!
    @IBOutlet weak var labelAllPatterns: UILabel!
    @IBOutlet weak var labelAllAvg: UILabel!
    
    var realm: Realm! = nil
    var results: Results<RecordInfo>! = nil
    var count4B = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var count5B = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var count6B = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var count8B = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var countAll = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var rates: [Double] = [0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0 ~ 7 : 정확도
        // 8 : 맥스콤보
        // 9 : 퍼펙트플레이
        // 10 : 패턴수
        // 11 : 평균 정확도
        // 12 : 성과 기록한 패턴 수
        realm = try! Realm()
        results = realm.objects(RecordInfo.self)
        //패턴 수 세기
        for result in results{
            if(result.nm4 != 0){
                count4B[10] += 1
            }
            if(result.hd4 != 0){
                count4B[10] += 1
            }
            if(result.mx4 != 0){
                count4B[10] += 1
            }
            if(result.nm5 != 0){
                count5B[10] += 1
            }
            if(result.hd5 != 0){
                count5B[10] += 1
            }
            if(result.mx5 != 0){
                count5B[10] += 1
            }
            if(result.nm6 != 0){
                count6B[10] += 1
            }
            if(result.hd6 != 0){
                count6B[10] += 1
            }
            if(result.mx6 != 0){
                count6B[10] += 1
            }
            if(result.nm8 != 0){
                count8B[10] += 1
            }
            if(result.hd8 != 0){
                count8B[10] += 1
            }
            if(result.mx8 != 0){
                count8B[10] += 1
            }
            var rate = Double(result.nm4Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button4, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button4, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button4, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button4, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button4, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button4, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button4, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button4, rate: rate)
            default:
                break
            }
            rate = Double(result.hd4Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button4, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button4, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button4, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button4, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button4, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button4, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button4, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button4, rate: rate)
            default:
                break
            }
            rate = Double(result.mx4Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button4, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button4, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button4, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button4, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button4, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button4, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button4, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button4, rate: rate)
            default:
                break
            }
            rate = Double(result.nm5Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button5, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button5, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button5, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button5, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button5, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button5, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button5, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button5, rate: rate)
            default:
                break
            }
            rate = Double(result.hd5Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button5, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button5, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button5, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button5, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button5, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button5, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button5, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button5, rate: rate)
            default:
                break
            }
            rate = Double(result.mx5Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button5, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button5, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button5, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button5, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button5, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button5, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button5, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button5, rate: rate)
            default:
                break
            }
            rate = Double(result.nm6Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button6, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button6, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button6, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button6, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button6, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button6, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button6, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button6, rate: rate)
            default:
                break
            }
            rate = Double(result.hd6Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button6, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button6, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button6, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button6, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button6, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button6, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button6, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button6, rate: rate)
            default:
                break
            }
            rate = Double(result.mx6Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button6, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button6, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button6, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button6, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button6, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button6, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button6, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button6, rate: rate)
            default:
                break
            }
            rate = Double(result.nm8Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button8, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button8, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button8, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button8, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button8, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button8, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button8, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button8, rate: rate)
            default:
                break
            }
            rate = Double(result.hd8Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button8, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button8, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button8, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button8, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button8, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button8, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button8, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button8, rate: rate)
            default:
                break
            }
            rate = Double(result.mx8Rate.split(separator: "%")[0]) ?? -1
            switch(rate){
            case 99.80...100.00:
                setArrayOfRate(index: 0, button: .button8, rate: rate)
            case 99.50..<99.80:
                setArrayOfRate(index: 1, button: .button8, rate: rate)
            case 99.00..<99.50:
                setArrayOfRate(index: 2, button: .button8, rate: rate)
            case 98.50..<99.00:
                setArrayOfRate(index: 3, button: .button8, rate: rate)
            case 98.00..<98.50:
                setArrayOfRate(index: 4, button: .button8, rate: rate)
            case 95.00..<98.00:
                setArrayOfRate(index: 5, button: .button8, rate: rate)
            case 90.00..<95.00:
                setArrayOfRate(index: 6, button: .button8, rate: rate)
            case 0.00..<90.00:
                setArrayOfRate(index: 7, button: .button8, rate: rate)
            default:
                break
            }
            var note = result.nm4Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button4)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button4)
            default:
                break
            }
            note = result.hd4Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button4)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button4)
            default:
                break
            }
            note = result.mx4Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button4)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button4)
            default:
                break
            }
            note = result.nm5Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button5)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button5)
            default:
                break
            }
            note = result.hd5Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button5)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button5)
            default:
                break
            }
            note = result.mx5Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button5)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button5)
            default:
                break
            }
            note = result.nm6Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button6)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button6)
            default:
                break
            }
            note = result.hd6Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button6)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button6)
            default:
                break
            }
            note = result.mx6Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button6)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button6)
            default:
                break
            }
            note = result.nm8Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button8)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button8)
            default:
                break
            }
            note = result.hd8Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button8)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button8)
            default:
                break
            }
            note = result.mx8Note
            switch(note){
            case "MAX COMBO":
                setArrayOfNote(index: 8, button: .button8)
            case "PERFECT PLAY":
                setArrayOfNote(index: 9, button: .button8)
            default:
                break
            }
        }
        for i in 0...12{
            countAll[i] = count4B[i] + count5B[i] + count6B[i] + count8B[i]
        }
        // 0 ~ 7 : 정확도
        // 8 : 맥스콤보
        // 9 : 퍼펙트플레이
        // 10 : 총 패턴수
        // 11 : 평균 정확도
        // 12 : 성과 기록한 패턴 수
        rates[0] = rates[0] / Double(count4B[12])
        rates[1] = rates[1] / Double(count5B[12])
        rates[2] = rates[2] / Double(count6B[12])
        rates[3] = rates[3] / Double(count8B[12])
        rates[4] = (rates[0] + rates[1] + rates[2] + rates[3]) / 4.0
        
        label4B0.text = count4B[0].description
        label4B1.text = count4B[1].description
        label4B2.text = count4B[2].description
        label4B3.text = count4B[3].description
        label4B4.text = count4B[4].description
        label4B5.text = count4B[5].description
        label4B6.text = count4B[6].description
        label4B7.text = count4B[7].description
        label4BMC.text = count4B[8].description
        label4BPP.text = count4B[9].description
        label4BPatterns.text = count4B[10].description
        label4BAvg.text = String(format: "%05.2f%%", rates[0])
        
        label5B0.text = count5B[0].description
        label5B1.text = count5B[1].description
        label5B2.text = count5B[2].description
        label5B3.text = count5B[3].description
        label5B4.text = count5B[4].description
        label5B5.text = count5B[5].description
        label5B6.text = count5B[6].description
        label5B7.text = count5B[7].description
        label5BMC.text = count5B[8].description
        label5BPP.text = count5B[9].description
        label5BPatterns.text = count5B[10].description
        label5BAvg.text = String(format: "%05.2f%%", rates[1])
        
        
        label6B0.text = count6B[0].description
        label6B1.text = count6B[1].description
        label6B2.text = count6B[2].description
        label6B3.text = count6B[3].description
        label6B4.text = count6B[4].description
        label6B5.text = count6B[5].description
        label6B6.text = count6B[6].description
        label6B7.text = count6B[7].description
        label6BMC.text = count6B[8].description
        label6BPP.text = count6B[9].description
        label6BPatterns.text = count6B[10].description
        label6BAvg.text = String(format: "%05.2f%%", rates[2])
        
        label8B0.text = count8B[0].description
        label8B1.text = count8B[1].description
        label8B2.text = count8B[2].description
        label8B3.text = count8B[3].description
        label8B4.text = count8B[4].description
        label8B5.text = count8B[5].description
        label8B6.text = count8B[6].description
        label8B7.text = count8B[7].description
        label8BMC.text = count8B[8].description
        label8BPP.text = count8B[9].description
        label8BPatterns.text = count8B[10].description
        label8BAvg.text = String(format: "%05.2f%%", rates[3])
        
        labelAll0.text = countAll[0].description
        labelAll1.text = countAll[1].description
        labelAll2.text = countAll[2].description
        labelAll3.text = countAll[3].description
        labelAll4.text = countAll[4].description
        labelAll5.text = countAll[5].description
        labelAll6.text = countAll[6].description
        labelAll7.text = countAll[7].description
        labelAllMC.text = countAll[8].description
        labelAllPP.text = countAll[9].description
        labelAllPatterns.text = countAll[10].description
        labelAllAvg.text = String(format: "%05.2f%%", rates[4])
    }

    static func instantiate() -> SummaryDetailViewController? {
        guard let viewController = UIStoryboard(name: "Performance", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? SummaryDetailViewController else { return nil }
        return viewController
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setArrayOfRate(index: Int, button: Button, rate: Double){
        switch(button){
        case .button4:
            count4B[index] += 1
            count4B[12] += 1
            rates[0] += rate
        case .button5:
            count5B[index] += 1
            count5B[12] += 1
            rates[1] += rate
        case .button6:
            count6B[index] += 1
            count6B[12] += 1
            rates[2] += rate
        case .button8:
            count8B[index] += 1
            count8B[12] += 1
            rates[3] += rate
        }
    }
    func setArrayOfNote(index: Int, button: Button){
        switch(button){
        case .button4:
            count4B[index] += 1
        case .button5:
            count5B[index] += 1
        case .button6:
            count6B[index] += 1
        case .button8:
            count8B[index] += 1
        }
    }
}
