//
//  GamesManager.swift
//  Board
//
//  Created by Anca Julean on 19/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import Foundation


class GamesManager {
    
    init() {
        games = [GamesManager.dummyGame(), GamesManager.dummyGame2(), GamesManager.dummyGame3()]
    }
    
    public var games: [Game]
    
    public func addGame(game: Game) {
        games.append(game)
    }
}

extension GamesManager {
    private static func dummyGame() -> Game {
        let game = Game(name: "Uno")
        game.addPlayer(player: Player(name: "Player1", scores: [200, 400, 500, 600, 40, 50, 2000, 200, 400]))
        game.addPlayer(player: Player(name: "Player2", scores: [400, 500, 600, 40, 50, 2000, 200, 400, 500]))
        return game
    }
    
    private static func dummyGame2() -> Game {
        let game = Game(name: "Remi")
        game.addPlayer(player: Player(name: "Player1", scores: [200, 400]))
        game.addPlayer(player: Player(name: "Player2", scores: [400, 500]))
        game.addPlayer(player: Player(name: "Player3", scores: [200, 400]))
        return game
    }
    
    private static func dummyGame3() -> Game {
        let game = Game(name: "Rent")
        game.addPlayer(player: Player(name: "Player1", scores: [200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000]))
        game.addPlayer(player: Player(name: "Player2", scores: [400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200]))
        game.addPlayer(player: Player(name: "Player3", scores: [500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400]))
        game.addPlayer(player: Player(name: "Player4", scores: [600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500]))
        game.addPlayer(player: Player(name: "Player5", scores: [40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600]))
        game.addPlayer(player: Player(name: "Player6", scores: [50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40]))
        game.addPlayer(player: Player(name: "Player7", scores: [2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50]))
        
        return game
    }
}
