//
//  GamesTableViewController.swift
//  Board
//
//  Created by Anca Julean on 19/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        games = GamesManager().games
        
//        games.append(dummyGame())
//        games.append(dummyGame2())
//        games.append(dummyGame3())
    }
    
    var games = [Game]()

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCellIdentifier", for: indexPath)
        cell.textLabel?.text = games[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showGameSegue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameSegue" {
            if let boardVC = segue.destination as? BoardCollectionViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    boardVC.game = games[indexPath.row]
                }

            }
        }
    }
    
}
