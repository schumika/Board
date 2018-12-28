//
//  BoardCollectionViewCell.swift
//  Board
//
//  Created by Anca Julean on 10/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class ScoreCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var scoreLabel: UILabel!
    
    public func setScoreValue(score: String) {
        scoreLabel.text = score
    }
    
}
