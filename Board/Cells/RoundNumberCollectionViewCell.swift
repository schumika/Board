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
    @IBOutlet weak var deleteButton: UIButton!
    
    var onDelete: (()->())?
    
    override func awakeFromNib() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .recognized {
            let translation = gesture.translation(in: self)
            // only consider panning with y offset < 5 and x offset > 5
            if abs(translation.y) <= 5 && abs(translation.x) >= 5 {
                toggleSubviews()
            }
            
        }
    }
    
    public func setRoundNumberValue(roundNumber: String) {
        roundNumberLabel.text = roundNumber
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        toggleSubviews()
        onDelete?()
    }
    
    private func toggleSubviews() {
        roundNumberLabel.isHidden = !roundNumberLabel.isHidden
        deleteButton.isHidden = !deleteButton.isHidden
    }
    
}

