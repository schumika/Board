//
//  GameTableViewCell.swift
//  Board
//
//  Created by Anca Julean on 31/12/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class GameTableViewCell : UITableViewCell {
    @IBOutlet weak var roundNoLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var onEdit: (()->())?
    
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
    @IBAction func editButtonClicked(_ sender: UIButton) {
        onEdit?()
        toggleSubviews()
    }
    
    private func toggleSubviews() {
        roundNoLabel.isHidden = !roundNoLabel.isHidden
        editButton.isHidden = !editButton.isHidden
    }
}
