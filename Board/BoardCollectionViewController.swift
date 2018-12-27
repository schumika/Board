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
    
    var game: Game = Game(name: "No name") {
        didSet {
            title = game.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        //collectionView?.bounces = false
        
        updateCollectionViewLayout()
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        // Add button
        
        let alertViewController = UIAlertController(title: "Add player", message: "Enter player name", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "Player name"
        }
        alertViewController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (alertAction) in
            if let textField = alertViewController.textFields?.first {
                self?.game.addPlayer(player: Player(name: textField.text ?? "Unnamed player"))
                self?.collectionView?.reloadData()
                self?.updateCollectionViewLayout()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension BoardCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Number of scores for each player
        guard let firstPlayer = game.players?.first else { return 0 }
        return (firstPlayer.scores?.count ?? 0) + 1 // todo: rethink!!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Number of players
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
                            cell.scoreLabel.text = "\(scores[indexPath.section - 1])"
                        }
                    }
                }
                
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.row != 0 {
            editScore(for: game.players![indexPath.row - 1], at: (indexPath.section - 1))
        }
    }
}

extension BoardCollectionViewController {
    func updateCollectionViewLayout() {
        let firstColumnWidth = "MMM".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16
        let otherColumnWidths = max("Player123".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16, ((collectionView?.bounds.width)! - firstColumnWidth) / CGFloat(game.players?.count ?? 1))
        
        if let stickyCollectionViewLayout = collectionViewLayout as? StickyCollectionViewLayout {
            stickyCollectionViewLayout.calculatedItemSize = { columnIndex, rowIndex in
                return CGSize(width: columnIndex == 0 ? firstColumnWidth : otherColumnWidths, height: rowIndex == 0 ? 80 : 40.0)
            }
        }
    }
    
    func editScore(for player: Player, at index: Int) {
        let alertViewController = UIAlertController(title: "Edit score", message: "", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "0"
            textField.text = "\(player.scores![index])"
        }
        alertViewController.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (alertAction) in
            if let textField = alertViewController.textFields?.first {
                let score = Int(textField.text ?? "0") ?? 0
                player.updateScore(at: index, with: score)
                self?.collectionView?.reloadData()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
        
    }
}
