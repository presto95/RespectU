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
        realm = try! Realm()
        results = realm?.objects(SongInfo.self)
        self.navigationItem.title = "My Record".localized
        labelPatterns.text = "PATTERNS".localized
        labelAverage.text = "AVERAGE".localized
        //0~7인덱스 : 정확도
        //8인덱스 : 맥스콤보
        //9인덱스 : 퍼펙트플레이
        //10인덱스 : 클리어한 패턴 수
        //키값 규칙 : [곡명][키][난이도][항목]
        for object in results!{
            let title=object.title
            for key in keyArray{
                for difficulty in difficultyArray{
                    guard let accuracyTemp = UserDefaults.standard.string(forKey: title+key+difficulty+"Accuracy") else { continue }
                    let accuracy=Double(accuracyTemp.split(separator: "%")[0].description)!
                    switch(accuracy){
                    case 99.80...100.00:
                        setAccuracyIndex(index: 0, key: key, accuracy: accuracy)
                    case 99.50..<99.80:
                        setAccuracyIndex(index: 1, key: key, accuracy: accuracy)
                    case 99.00..<99.49:
                        setAccuracyIndex(index: 2, key: key, accuracy: accuracy)
                    case 98.50..<99.00:
                        setAccuracyIndex(index: 3, key: key, accuracy: accuracy)
                    case 98.00..<98.50:
                        setAccuracyIndex(index: 4, key: key, accuracy: accuracy)
                    case 95.00..<98.00:
                        setAccuracyIndex(index: 5, key: key, accuracy: accuracy)
                    case 90.00..<95.00:
                        setAccuracyIndex(index: 6, key: key, accuracy: accuracy)
                    case ..<90.00:
                        setAccuracyIndex(index: 7, key: key, accuracy: accuracy)
                    default:
                        break
                    }
                    switch(UserDefaults.standard.string(forKey: title+key+difficulty+"Note")){
                    case "MAX COMBO"?:
                        setNoteIndex(index: 8, key: key)
                    case "PERFECT PLAY"?:
                        setNoteIndex(index: 9, key: key)
                    default:
                        break
                    }
                }
            }
        }
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
        label4BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label4BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label5BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label6BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label8BAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex0.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex2.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex3.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex4.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex5.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex6.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex7.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex8.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllIndex9.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllPatterns.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAllAverage.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
       
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
