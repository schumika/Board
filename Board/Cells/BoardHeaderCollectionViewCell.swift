//
//  BoardHeaderCell.swift
//  Board
//
//  Created by Anca Julean on 27/12/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class BoardHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var totalPlayerScore: UILabel!
    
    public func setPlayerName(name: String) {
        playerNameLabel.text = name
    }
    
    public func setTotalScore(score: Int) {
        totalPlayerScore.text = "\(score)"
    }
    
}
