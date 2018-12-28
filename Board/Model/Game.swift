//
//  Game.swift
//  Board
//
//  Created by Anca Julean on 18/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import Foundation

class Game {
    public var name: String
    public private(set) var players: [Player]?
    
    init(name: String) {
        self.name = name
        players = [Player]()
    }
    
    public func addPlayer(player: Player) {
        addPlayer(player: player, fillScores: true)
    }
    
    public func addPlayer(player: Player, fillScores: Bool) {
        players?.append(player)
        
        if fillScores {
            guard players?.count ?? 0 > 1, let firstPlayer = players?.first  else { return }
            let scoresCount = firstPlayer.scores?.count
            for _ in 0 ..< (scoresCount ?? 0) {
                player.addScore(score: 0)
            }
        }
        
    }
    
    public func addRound() {
        guard let players = players else { return }
        for player in players {
            player.addScore(score: 0)
        }
    }
    
    public func deletePlayer(player: Player) {
        if let index = players?.index(where: {$0 === player}) {
            players?.remove(at: index)
        }
    }
}
