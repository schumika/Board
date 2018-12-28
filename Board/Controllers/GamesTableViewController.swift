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
    
    var gamesManager = GamesManager()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCellIdentifier", for: indexPath)
        cell.textLabel?.text = games[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showGameSegue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            gamesManager.deleteGame(at: indexPath.row)
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
        }
    }
    
    // MARK: - Nav bar Buttons actions
    
    @IBAction func rightAddButtonClicked(_ sender: UIBarButtonItem) {
        // Add button
        
        let alertViewController = UIAlertController(title: "Add game", message: "Enter game name", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "Game name"
        }
        alertViewController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (alertAction) in
            if let textField = alertViewController.textFields?.first {
                self?.gamesManager.addGame(game: Game(name: textField.text ?? "Unnamed game"))
                self?.reloadData()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
    }
    
    @IBAction func leftButtonClicked(_ sender: UIBarButtonItem) {
        // Edit/Done button
        
        // todo: ??????
        if isEditing {
            isEditing = false
            sender.title = "Edit"
        } else {
            isEditing = true
            sender.title = "Done"
        }
    }
    
    // MARK: - UISplitViewControllerDelegate
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return games.count == 0
    }

}
