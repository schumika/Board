//
//  BoardCollectionViewController.swift
//  Board
//
//  Created by Anca Julean on 05/07/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit
import Sticky

private let reuseIdentifier = "Cell"

class BoardCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        //collectionView?.bounces = false
        
        let firstColumnWidth = "MMM".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16
        let otherColumnWidths = max("Player123".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16, ((collectionView?.bounds.width)! - firstColumnWidth) / CGFloat(game.players?.count ?? 1))
        
        if let stickyCollectionViewLayout = collectionViewLayout as? StickyCollectionViewLayout {
            stickyCollectionViewLayout.calculatedItemSize = { columnIndex in
                return CGSize(width: columnIndex == 0 ? firstColumnWidth : otherColumnWidths, height: 40.0)
            }
        }
    }
    
    

    var game: Game = Game(name: "No name") {
        didSet {
            title = game.name
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let firstPlayer = game.players?.first else { return 0 }
        return firstPlayer.scores?.count ?? 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let players = game.players { return players.count + 1} else { return 0 }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = UIColor.darkGray.cgColor
        
        if let cell = cell as? BoardCollectionViewCell {
            
            if indexPath.section == 0 {
                
                cell.backgroundColor = UIColor.lightGray
                if indexPath.row == 0 {
                    cell.scoreLabel.text = "#"
                } else {
                    if let playerData = game.players?[indexPath.row - 1] {
                        cell.scoreLabel.text = playerData.name
                    }
                }
            } else {
                if indexPath.row == 0 {
                    cell.scoreLabel.text = "\(indexPath.section)"
                    cell.backgroundColor = UIColor.lightGray
                } else {
                    if let playerData = game.players?[indexPath.row - 1] {
                        if let scores = playerData.scores {
                            cell.scoreLabel.text = "\(scores[indexPath.section])"
                        }
                    }
                }
                
            }
        }
        
        return cell
    }
    
//    private func getData() -> [[String: Any]] {
//        return [["name": "Player1", "scores": [200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000]] as [String : Any],
//                ["name": "Player2", "scores": [400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200]] as [String : Any],
//                ["name": "Player3", "scores": [500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400]] as [String : Any],
//                ["name": "Player4", "scores": [600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500]] as [String : Any],
//                ["name": "Player5", "scores": [40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600]] as [String : Any],
//                ["name": "Player6", "scores": [50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40]] as [String : Any],
//                ["name": "Player7", "scores": [2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50]] as [String : Any]]
//    }
}
