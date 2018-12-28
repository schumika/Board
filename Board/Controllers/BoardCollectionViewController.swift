//
//  BoardCollectionViewController.swift
//  Board
//
//  Created by Anca Julean on 05/07/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit
import Sticky

private let reuseIdentifier = "ScoreCell"
private let headerReuseIdentifier = "HeaderCell"
private let roundReuseIdentifier = "RoundCell"

class BoardCollectionViewController: UICollectionViewController {
    
    private struct CollectionViewDimensions {
        static let headerHeight: CGFloat = 80.0
        static let scoreHeight: CGFloat = 40.0
    }
    
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
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertViewController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (alertAction) in
            if let textField = alertViewController.textFields?.first {
                self?.game.add(player: Player(name: textField.text ?? "Unnamed player"))
                self?.collectionView?.reloadData()
                self?.updateCollectionViewLayout()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navCtrl = segue.destination as? UINavigationController, let playerViewController = navCtrl.topViewController as? EditPlayerViewController {
            if let cell = sender as? BoardHeaderCollectionViewCell, let index = collectionView?.indexPath(for: cell), let players = game.players {
                playerViewController.player = Player(name: players[index.row - 1].name)
                
                playerViewController.editPlayerCompletion = {[weak self] resolution in
                    switch resolution {
                    case .cancel :
                        break
                    case .done:
                        players[index.row - 1].name = playerViewController.player.name
                    case .delete:
                        self?.game.delete(player: players[index.row - 1])
                    }
                    
                    playerViewController.dismiss(animated: true, completion: {
                        self?.collectionView?.reloadData()
                        self?.updateCollectionViewLayout()
                    })
                    
                }
                
            } else {
                playerViewController.player = game.players![0];
            }
            
        }
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
        
        let roundNo = indexPath.section == 0 ? -1 : (collectionView.numberOfSections - indexPath.section)
        
        if indexPath.row == 0 {
            // Configure the round # cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roundReuseIdentifier, for: indexPath)
            
            if let cell = cell as? RoundNumberCollectionViewCell {
                cell.setRoundNumberValue(roundNumber: indexPath.section == 0 ? "+" :  "\(roundNo)")
            }
            
            return cell
            
        } else if indexPath.section == 0 {
            // Configure the header cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerReuseIdentifier, for: indexPath)
            
            if let cell = cell as? BoardHeaderCollectionViewCell {
                if let playerData = game.players?[indexPath.row - 1] {
                    cell.setPlayerName(name: playerData.name)
                    cell.setTotalScore(score: playerData.totalScore())
                }
            }
            
            return cell
        } else {
            // Configure the score cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            
            if let cell = cell as? ScoreCollectionViewCell {
                if let playerData = game.players?[indexPath.row - 1] {
                    if let scores = playerData.scores {
                        cell.setScoreValue(score: "\(scores[roundNo - 1])")
                    }
                }
            }
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            game.addEmptyRound()
            collectionView.reloadData()
        } else if indexPath.section != 0 && indexPath.row != 0 {
            let roundNo = indexPath.section == 0 ? -1 : (collectionView.numberOfSections - indexPath.section)
            editScore(for: game.players![indexPath.row - 1], at: (roundNo - 1))
        }
    }
}

extension BoardCollectionViewController {
    func updateCollectionViewLayout() {
        let firstColumnWidth = "MMM".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16
        let otherColumnWidths = max("Player123".size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width + 16, ((collectionView?.bounds.width)! - firstColumnWidth) / CGFloat(game.players?.count ?? 1))
        
        if let stickyCollectionViewLayout = collectionViewLayout as? StickyCollectionViewLayout {
            stickyCollectionViewLayout.calculatedItemSize = { columnIndex, rowIndex in
                return CGSize(width: columnIndex == 0 ? firstColumnWidth : otherColumnWidths, height: rowIndex == 0 ? CollectionViewDimensions.headerHeight : CollectionViewDimensions.scoreHeight)
            }
        }
    }
    
    func editScore(for player: Player, at index: Int) {
        let alertViewController = UIAlertController(title: "Edit score", message: "", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "0"
            textField.text = "\(player.scores![index])"
        }
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
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
