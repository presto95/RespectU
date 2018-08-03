//
//  SummaryCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

protocol SummaryCellDelegate: class {
    func touchUpDetailButton(_ sender: UIButton)
    func touchUpSearchButton(_ sender: UIButton)
}

class SummaryCell: UITableViewCell {

    var delegate: SummaryCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    var realm: Realm!
    var results: Results<RecordInfo>!
    var maxCombo = 0
    var perfectPlay = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        realm = try! Realm()
        results = realm.objects(RecordInfo.self)
        collectionView.register(UINib(nibName: "SummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "summaryCollectionCell")
        detailButton.setTitle("Detail".localized, for: .normal)
        detailButton.layer.borderWidth = 2
        detailButton.layer.borderColor = UIColor.main.cgColor
        searchButton.setTitle("Search by Condition".localized, for: .normal)
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.main.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func touchUpSearchButton(_ sender: UIButton) {
        //SearchRecordViewController present
        delegate?.touchUpSearchButton(sender)
    }
    
    @objc func touchUpDetailButton(_ sender: UIButton) {
        //SummaryDetailViewController present
        delegate?.touchUpDetailButton(sender)
    }
}

extension SummaryCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCollectionCell", for: indexPath) as! SummaryCollectionCell
        var count = 0
        cell.layer.borderColor = UIColor.main.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        switch(indexPath.row){
        case 0:
            cell.contentLabel.text = "S"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Rank == "S") { count+=1 }; if(i.nm5Rank == "S") { count+=1 }; if(i.nm6Rank == "S") { count+=1 }; if(i.nm8Rank == "S") { count+=1 }; if(i.hd4Rank == "S") { count+=1 }; if(i.hd5Rank == "S") { count+=1 }; if(i.hd6Rank == "S") { count+=1 }; if(i.hd8Rank == "S") { count+=1 }; if(i.mx4Rank == "S") { count+=1 }; if(i.mx5Rank == "S") { count+=1 }; if(i.mx6Rank == "S") { count+=1 }; if(i.mx8Rank == "S") { count+=1 }
                }
                return String(count)
            }()
        case 1:
            cell.contentLabel.text = "A"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Rank == "A") { count+=1 }; if(i.nm5Rank == "A") { count+=1 }; if(i.nm6Rank == "A") { count+=1 }; if(i.nm8Rank == "A") { count+=1 }; if(i.hd4Rank == "A") { count+=1 }; if(i.hd5Rank == "A") { count+=1 }; if(i.hd6Rank == "A") { count+=1 }; if(i.hd8Rank == "A") { count+=1 }; if(i.mx4Rank == "A") { count+=1 }; if(i.mx5Rank == "A") { count+=1 }; if(i.mx6Rank == "A") { count+=1 }; if(i.mx8Rank == "A") { count+=1 }
                }
                return String(count)
            }()
        case 2:
            cell.contentLabel.text = "B"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Rank == "B") { count+=1 }; if(i.nm5Rank == "B") { count+=1 }; if(i.nm6Rank == "B") { count+=1 }; if(i.nm8Rank == "B") { count+=1 }; if(i.hd4Rank == "B") { count+=1 }; if(i.hd5Rank == "B") { count+=1 }; if(i.hd6Rank == "B") { count+=1 }; if(i.hd8Rank == "B") { count+=1 }; if(i.mx4Rank == "B") { count+=1 }; if(i.mx5Rank == "B") { count+=1 }; if(i.mx6Rank == "B") { count+=1 }; if(i.mx8Rank == "B") { count+=1 };
                }
                return String(count)
            }()
        case 3:
            cell.contentLabel.text = "C"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Rank == "C") { count+=1 }; if(i.nm5Rank == "C") { count+=1 }; if(i.nm6Rank == "C") { count+=1 }; if(i.nm8Rank == "C") { count+=1 }; if(i.hd4Rank == "C") { count+=1 }; if(i.hd5Rank == "C") { count+=1 }; if(i.hd6Rank == "C") { count+=1 }; if(i.hd8Rank == "C") { count+=1 }; if(i.mx4Rank == "C") { count+=1 }; if(i.mx5Rank == "C") { count+=1 }; if(i.mx6Rank == "C") { count+=1 }; if(i.mx8Rank == "C") { count+=1 };
                }
                return String(count)
            }()
        case 4:
            cell.contentLabel.text = "MC"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Note == "MAX COMBO") { count+=1 }; if(i.nm5Note == "MAX COMBO") { count+=1 }; if(i.nm6Note == "MAX COMBO") { count+=1 }; if(i.nm8Note == "MAX COMBO") { count+=1 }; if(i.hd4Note == "MAX COMBO") { count+=1 }; if(i.hd5Note == "MAX COMBO") { count+=1 }; if(i.hd6Note == "MAX COMBO") { count+=1 }; if(i.hd8Note == "MAX COMBO") { count+=1 }; if(i.mx4Note == "MAX COMBO") { count+=1 }; if(i.mx5Note == "MAX COMBO") { count+=1 }; if(i.mx6Note == "MAX COMBO") { count+=1 }; if(i.mx8Note == "MAX COMBO") { count+=1 };
                }
                maxCombo = count
                return String(count)
            }()
        case 5:
            cell.contentLabel.text = "PP"
            cell.valueLabel.text = { () -> String in
                for i in results{
                    if(i.nm4Note == "PERFECT PLAY") { count+=1 }; if(i.nm5Note == "PERFECT PLAY") { count+=1 }; if(i.nm6Note == "PERFECT PLAY") { count+=1 }; if(i.nm8Note == "PERFECT PLAY") { count+=1 }; if(i.hd4Note == "PERFECT PLAY") { count+=1 }; if(i.hd5Note == "PERFECT PLAY") { count+=1 }; if(i.hd6Note == "PERFECT PLAY") { count+=1 }; if(i.hd8Note == "PERFECT PLAY") { count+=1 }; if(i.mx4Note == "PERFECT PLAY") { count+=1 }; if(i.mx5Note == "PERFECT PLAY") { count+=1 }; if(i.mx6Note == "PERFECT PLAY") { count+=1 }; if(i.mx8Note == "PERFECT PLAY") { count+=1 };
                }
                perfectPlay = count
                return String(count)
            }()
        case 6:
            cell.contentLabel.text = "MC+PP"
            cell.valueLabel.text = String(maxCombo + perfectPlay)
        default:
            break
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}
