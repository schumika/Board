//
//  RoundNumberCollectionViewCell.swift
//  Board
//
//  Created by Anca Julean on 28/12/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class RoundNumberCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var roundNumberLabel: UILabel!
    
    public func setRoundNumberValue(roundNumber: String) {
        roundNumberLabel.text = roundNumber
    }
    
}

