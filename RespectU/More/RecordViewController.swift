//
//  RecordViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 31..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController {

    var realm: Realm? = nil
    var results: Results<SongInfo>? = nil
    var record: Results<RecordInfo>? = nil
    var count4B: [Int]=[0,0,0,0,0,0,0,0,0,0,0]
    var count5B: [Int]=[0,0,0,0,0,0,0,0,0,0,0]
    var count6B: [Int]=[0,0,0,0,0,0,0,0,0,0,0]
    var count8B: [Int]=[0,0,0,0,0,0,0,0,0,0,0]
    var countAll: [Int]=[0,0,0,0,0,0,0,0,0,0,0]
    var accuracyArray: [Double]=[0,0,0,0,0]
    let keyArray=["4B","5B","6B","8B"]
    let difficultyArray=["normal","hard","maximum"]
    
    @IBOutlet weak var labelPatterns: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    
    @IBOutlet weak var label4BIndex0: UILabel!
    @IBOutlet weak var label4BIndex1: UILabel!
    @IBOutlet weak var label4BIndex2: UILabel!
    @IBOutlet weak var label4BIndex3: UILabel!
    @IBOutlet weak var label4BIndex4: UILabel!
    @IBOutlet weak var label4BIndex5: UILabel!
    @IBOutlet weak var label4BIndex6: UILabel!
    @IBOutlet weak var label4BIndex7: UILabel!
    @IBOutlet weak var label4BIndex8: UILabel!
    @IBOutlet weak var label4BIndex9: UILabel!
    @IBOutlet weak var label4BAverage: UILabel!
    @IBOutlet weak var label4BPatterns: UILabel!
    
    @IBOutlet weak var label5BIndex0: UILabel!
    @IBOutlet weak var label5BIndex1: UILabel!
    @IBOutlet weak var label5BIndex2: UILabel!
    @IBOutlet weak var label5BIndex3: UILabel!
    @IBOutlet weak var label5BIndex4: UILabel!
    @IBOutlet weak var label5BIndex5: UILabel!
    @IBOutlet weak var label5BIndex6: UILabel!
    @IBOutlet weak var label5BIndex7: UILabel!
    @IBOutlet weak var label5BIndex8: UILabel!
    @IBOutlet weak var label5BIndex9: UILabel!
    @IBOutlet weak var label5BAverage: UILabel!
    @IBOutlet weak var label5BPatterns: UILabel!
    
    @IBOutlet weak var label6BIndex0: UILabel!
    @IBOutlet weak var label6BIndex1: UILabel!
    @IBOutlet weak var label6BIndex2: UILabel!
    @IBOutlet weak var label6BIndex3: UILabel!
    @IBOutlet weak var label6BIndex4: UILabel!
    @IBOutlet weak var label6BIndex5: UILabel!
    @IBOutlet weak var label6BIndex6: UILabel!
    @IBOutlet weak var label6BIndex7: UILabel!
    @IBOutlet weak var label6BIndex8: UILabel!
    @IBOutlet weak var label6BIndex9: UILabel!
    @IBOutlet weak var label6BAverage: UILabel!
    @IBOutlet weak var label6BPatterns: UILabel!
    
    @IBOutlet weak var label8BIndex0: UILabel!
    @IBOutlet weak var label8BIndex1: UILabel!
    @IBOutlet weak var label8BIndex2: UILabel!
    @IBOutlet weak var label8BIndex3: UILabel!
    @IBOutlet weak var label8BIndex4: UILabel!
    @IBOutlet weak var label8BIndex5: UILabel!
    @IBOutlet weak var label8BIndex6: UILabel!
    @IBOutlet weak var label8BIndex7: UILabel!
    @IBOutlet weak var label8BIndex8: UILabel!
    @IBOutlet weak var label8BIndex9: UILabel!
    @IBOutlet weak var label8BAverage: UILabel!
    @IBOutlet weak var label8BPatterns: UILabel!
    
    @IBOutlet weak var labelAllIndex0: UILabel!
    @IBOutlet weak var labelAllIndex1: UILabel!
    @IBOutlet weak var labelAllIndex2: UILabel!
    @IBOutlet weak var labelAllIndex3: UILabel!
    @IBOutlet weak var labelAllIndex4: UILabel!
    @IBOutlet weak var labelAllIndex5: UILabel!
    @IBOutlet weak var labelAllIndex6: UILabel!
    @IBOutlet weak var labelAllIndex7: UILabel!
    @IBOutlet weak var labelAllIndex8: UILabel!
    @IBOutlet weak var labelAllIndex9: UILabel!
    @IBOutlet weak var labelAllAverage: UILabel!
    @IBOutlet weak var labelAllPatterns: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var button4Patterns: Int = 0
        var button5Patterns: Int = 0
        var button6Patterns: Int = 0
        var button8Patterns: Int = 0
        var allPatterns: Int = 0
        realm = try! Realm()
        record = realm?.objects(RecordInfo.self)
        self.navigationItem.title = "My Record".localized
        labelPatterns.text = "PATTERNS".localized
        labelAverage.text = "AVERAGE".localized
        //0~7인덱스 : 정확도
        //8인덱스 : 맥스콤보
        //9인덱스 : 퍼펙트플레이
        //10인덱스 : 클리어한 패턴 수
        //키값 규칙 : [곡명][키][난이도][항목]
        var accuracy: Double = 0.0
        var rate: String = ""
        for i in record!{
            //패턴 수 계산
            if(i.nm4 != 0){
                button4Patterns += 1
            }
            if(i.nm5 != 0){
                button5Patterns += 1
            }
            if(i.nm6 != 0){
                button6Patterns += 1
            }
            if(i.nm8 != 0){
                button8Patterns += 1
            }
            if(i.hd4 != 0){
                button4Patterns += 1
            }
            if(i.hd5 != 0){
                button5Patterns += 1
            }
            if(i.hd6 != 0){
                button6Patterns += 1
            }
            if(i.hd8 != 0){
                button8Patterns += 1
            }
            if(i.mx4 != 0){
                button4Patterns += 1
            }
            if(i.mx5 != 0){
                button5Patterns += 1
            }
            if(i.mx6 != 0){
                button6Patterns += 1
            }
            if(i.mx8 != 0){
                button8Patterns += 1
            }
            
            accuracy=Double(i.nm4Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
                case 99.80...100.00:
                    setAccuracyIndex(index: 0, key: "4B", accuracy: accuracy)
                case 99.50..<99.80:
                    setAccuracyIndex(index: 1, key: "4B", accuracy: accuracy)
                case 99.00..<99.50:
                    setAccuracyIndex(index: 2, key: "4B", accuracy: accuracy)
                case 98.50..<99.00:
                    setAccuracyIndex(index: 3, key: "4B", accuracy: accuracy)
                case 98.00..<98.50:
                    setAccuracyIndex(index: 4, key: "4B", accuracy: accuracy)
                case 95.00..<98.00:
                    setAccuracyIndex(index: 5, key: "4B", accuracy: accuracy)
                case 90.00..<95.00:
                    setAccuracyIndex(index: 6, key: "4B", accuracy: accuracy)
                case 0.00..<90.00:
                    setAccuracyIndex(index: 7, key: "4B", accuracy: accuracy)
                default:
                    break
            }
            accuracy=Double(i.hd4Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "4B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "4B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "4B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "4B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "4B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "4B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "4B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "4B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.mx4Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "4B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "4B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "4B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "4B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "4B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "4B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "4B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "4B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.nm5Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "5B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "5B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "5B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "5B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "5B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "5B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "5B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "5B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.hd5Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "5B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "5B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "5B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "5B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "5B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "5B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "5B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "5B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.mx5Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "5B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "5B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "5B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "5B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "5B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "5B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "5B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "5B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.nm6Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "6B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "6B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "6B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "6B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "6B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "6B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "6B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "6B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.hd6Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "6B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "6B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "6B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "6B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "6B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "6B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "6B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "6B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.mx6Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "6B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "6B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "6B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "6B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "6B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "6B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "6B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "6B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.nm8Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "8B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "8B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "8B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "8B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "8B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "8B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "8B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "8B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.hd8Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "8B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "8B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "8B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "8B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "8B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "8B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "8B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "8B", accuracy: accuracy)
            default:
                break
            }
            accuracy=Double(i.mx8Rate.split(separator: "%")[0]) ?? -1
            switch(accuracy){
            case 99.80...100.00:
                setAccuracyIndex(index: 0, key: "8B", accuracy: accuracy)
            case 99.50..<99.80:
                setAccuracyIndex(index: 1, key: "8B", accuracy: accuracy)
            case 99.00..<99.50:
                setAccuracyIndex(index: 2, key: "8B", accuracy: accuracy)
            case 98.50..<99.00:
                setAccuracyIndex(index: 3, key: "8B", accuracy: accuracy)
            case 98.00..<98.50:
                setAccuracyIndex(index: 4, key: "8B", accuracy: accuracy)
            case 95.00..<98.00:
                setAccuracyIndex(index: 5, key: "8B", accuracy: accuracy)
            case 90.00..<95.00:
                setAccuracyIndex(index: 6, key: "8B", accuracy: accuracy)
            case 0.00..<90.00:
                setAccuracyIndex(index: 7, key: "8B", accuracy: accuracy)
            default:
                break
            }
            rate = i.nm4Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "4B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "4B")
            default:
                break
            }
            rate = i.hd4Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "4B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "4B")
            default:
                break
            }
            rate = i.mx4Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "4B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "4B")
            default:
                break
            }
            rate = i.nm5Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "5B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "5B")
            default:
                break
            }
            rate = i.hd5Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "5B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "5B")
            default:
                break
            }
            rate = i.mx5Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "5B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "5B")
            default:
                break
            }
            rate = i.nm6Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "6B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "6B")
            default:
                break
            }
            rate = i.hd6Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "6B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "6B")
            default:
                break
            }
            rate = i.mx6Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "6B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "6B")
            default:
                break
            }
            rate = i.nm8Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "8B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "8B")
            default:
                break
            }
            rate = i.hd8Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "8B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "8B")
            default:
                break
            }
            rate = i.mx8Note
            switch(rate){
            case "MAX COMBO":
                setNoteIndex(index: 8, key: "8B")
            case "PERFECT PLAY":
                setNoteIndex(index: 9, key: "8B")
            default:
                break
            }
        }
        allPatterns = button4Patterns+button5Patterns+button6Patterns+button8Patterns
        //평균정확도 계산, 총계
        for i in 0...10{
            countAll[i]=count4B[i]+count5B[i]+count6B[i]+count8B[i]
        }
        accuracyArray[0]=(accuracyArray[0]/Double(count4B[10]))
        accuracyArray[1]=accuracyArray[1]/Double(count5B[10])
        accuracyArray[2]=accuracyArray[2]/Double(count6B[10])
        accuracyArray[3]=accuracyArray[3]/Double(count8B[10])
        accuracyArray[4]=(accuracyArray[0]+accuracyArray[1]+accuracyArray[2]+accuracyArray[3])/4.0
        //바인딩
        label4BPatterns.text = String(button4Patterns)
        label5BPatterns.text = String(button5Patterns)
        label6BPatterns.text = String(button6Patterns)
        label8BPatterns.text = String(button8Patterns)
        labelAllPatterns.text = String(allPatterns)
        label4BIndex0.text=String(count4B[0]); label4BIndex1.text=String(count4B[1]); label4BIndex2.text=String(count4B[2]); label4BIndex3.text=String(count4B[3]); label4BIndex4.text=String(count4B[4]); label4BIndex5.text=String(count4B[5]); label4BIndex6.text=String(count4B[6]); label4BIndex7.text=String(count4B[7]); label4BIndex8.text=String(count4B[8]); label4BIndex9.text=String(count4B[9]); label4BAverage.text = count4B[10] != 0 ? String(format: "%.2f%%", accuracyArray[0]) : "-"
        label5BIndex0.text=String(count5B[0]); label5BIndex1.text=String(count5B[1]); label5BIndex2.text=String(count5B[2]); label5BIndex3.text=String(count5B[3]); label5BIndex4.text=String(count5B[4]); label5BIndex5.text=String(count5B[5]); label5BIndex6.text=String(count5B[6]); label5BIndex7.text=String(count5B[7]); label5BIndex8.text=String(count5B[8]); label5BIndex9.text=String(count5B[9]); label5BAverage.text = count5B[10] != 0 ? String(format: "%.2f%%", accuracyArray[1]) : "-"
        label6BIndex0.text=String(count6B[0]); label6BIndex1.text=String(count6B[1]); label6BIndex2.text=String(count6B[2]); label6BIndex3.text=String(count6B[3]); label6BIndex4.text=String(count6B[4]); label6BIndex5.text=String(count6B[5]); label6BIndex6.text=String(count6B[6]); label6BIndex7.text=String(count6B[7]); label6BIndex8.text=String(count6B[8]); label6BIndex9.text=String(count6B[9]); label6BAverage.text = count6B[10] != 0 ? String(format: "%.2f%%", accuracyArray[2]) : "-"
        label8BIndex0.text=String(count8B[0]); label8BIndex1.text=String(count8B[1]); label8BIndex2.text=String(count8B[2]); label8BIndex3.text=String(count8B[3]); label8BIndex4.text=String(count8B[4]); label8BIndex5.text=String(count8B[5]); label8BIndex6.text=String(count8B[6]); label8BIndex7.text=String(count8B[7]); label8BIndex8.text=String(count8B[8]); label8BIndex9.text=String(count8B[9]); label8BAverage.text = count8B[10] != 0 ? String(format: "%.2f%%", accuracyArray[3]) : "-"
        labelAllIndex0.text=String(countAll[0]); labelAllIndex1.text=String(countAll[1]); labelAllIndex2.text=String(countAll[2]); labelAllIndex3.text=String(countAll[3]); labelAllIndex4.text=String(countAll[4]); labelAllIndex5.text=String(countAll[5]); labelAllIndex6.text=String(countAll[6]); labelAllIndex7.text=String(countAll[7]); labelAllIndex8.text=String(countAll[8]); labelAllIndex9.text=String(countAll[9]); labelAllAverage.text = countAll[10] != 0 ? String(format: "%.2f%%", accuracyArray[4]) : "-"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let isNight=UserDefaults.standard.bool(forKey: "night")
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label4BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label4BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label5BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label6BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        label8BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
        labelAllAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAccuracyIndex(index: Int, key: String, accuracy: Double){
        switch(key){
        case "4B":
            count4B[index]+=1
            count4B[10]+=1
            accuracyArray[0]+=accuracy
        case "5B":
            count5B[index]+=1
            count5B[10]+=1
            accuracyArray[1]+=accuracy
        case "6B":
            count6B[index]+=1
            count6B[10]+=1
            accuracyArray[2]+=accuracy
        case "8B":
            count8B[index]+=1
            count8B[10]+=1
            accuracyArray[3]+=accuracy
        default:
            break
        }
    }
    func setNoteIndex(index: Int, key: String){
        switch(key){
        case "4B":
            count4B[index]+=1
        case "5B":
            count5B[index]+=1
        case "6B":
            count6B[index]+=1
        case "8B":
            count8B[index]+=1
        default:
            break
        }
    }
}
