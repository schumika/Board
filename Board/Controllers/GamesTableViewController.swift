//
//  GamesTableViewController.swift
//  Board
//
//  Created by Anca Julean on 19/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.splitViewController.delegate = self
        }
    }
    
    var gamesManager: GamesManager {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)!.gamesManager
        }
    }
    var games = [Game]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    private func reloadData() {
        games = gamesManager.games
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        //cell.textLabel?.text = games[indexPath.row].name
        if let cell = cell as? GameTableViewCell {
            cell.gameLabel.text = games[indexPath.row].name
            cell.roundNoLabel.text = "\(indexPath.row + 1)"
            cell.onEdit = { [weak self] in
                self?.performSegue(withIdentifier: "presentGame", sender: cell)
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showGameSegue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            gamesManager.delete(at: indexPath.row)
            // todo: ????
            games = gamesManager.games
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameSegue" {
            if let navCtrl = segue.destination as? UINavigationController, let boardVC = navCtrl.topViewController as? BoardCollectionViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    boardVC.game = games[indexPath.row]
                }

            }
        } else if let navCtrl = segue.destination as? UINavigationController, let gameViewController = navCtrl.topViewController as? EditViewController {
            if let cell = sender as? GameTableViewCell, let index = tableView?.indexPath(for: cell) {
                gameViewController.namedItem = Game(name: games[index.row].name)
                
                gameViewController.editItemCompletion = {[weak self] resolution in
                    switch resolution {
                    case .cancel :
                        break
                    case .done:
                        self?.games[index.row].name = gameViewController.namedItem.name
                    case .delete:
                        self?.tableView.beginUpdates()
                        self?.gamesManager.delete(at: index.row)
                        // todo: ????
                        if let games = self?.gamesManager.games {
                            self?.games = games
                        } else {
                            self?.games = [Game]()
                        }
                        
                        self?.tableView.deleteRows(at: [index], with: .automatic)
                        self?.tableView.endUpdates()
                    }
                    
                    gameViewController.dismiss(animated: true, completion: {
                        self?.tableView?.reloadData()
                    })
                }
            }
        }
    }
    
    // MARK: - Nav bar Buttons actions
    
    @IBAction func rightAddButtonClicked(_ sender: UIBarButtonItem) {
        // Add button
        
        let alertViewController = UIAlertController(title: "Add game", message: "Enter game name", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "Game name"
        }
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertViewController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (alertAction) in
            if let textField = alertViewController.textFields?.first {
                let gameName = (textField.text ?? "").isEmpty ? "Unnamed game" : textField.text!
                self?.gamesManager.add(game: Game(name: gameName))
                self?.reloadData()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
    }
    
    // MARK: - UISplitViewControllerDelegate
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return games.count == 0
    }

}
