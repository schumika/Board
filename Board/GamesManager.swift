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
    
    public func add(game: Game) {
        games.append(game)
    }
    
    public func delete(at index: Int) {
        games.remove(at: index)
    }
}

extension GamesManager {
    public static func dummyGame() -> Game {
        let game = Game(name: "Uno")
        
        game.add(player: Player(name: "Player1"), fillScores: false)
        game.add(player: Player(name: "Player2"), fillScores: false)
        return game
    }
    
    public static func dummyGame2() -> Game {
        let game = Game(name: "Remi")
        game.add(player: Player(name: "Player1", scores: [200, 400]), fillScores: false)
        game.add(player: Player(name: "Player2", scores: [400, 500]), fillScores: false)
        game.add(player: Player(name: "Player3", scores: [200, 400]), fillScores: false)
        return game
    }
    
    public static func dummyGame3() -> Game {
        let game = Game(name: "Rent")
        game.add(player: Player(name: "Player1", scores: [200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000]), fillScores: false)
        game.add(player: Player(name: "Player2", scores: [400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200]), fillScores: false)
        game.add(player: Player(name: "Player3", scores: [500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400]), fillScores: false)
        game.add(player: Player(name: "Player4", scores: [600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500]), fillScores: false)
        game.add(player: Player(name: "Player5", scores: [40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600]), fillScores: false)
        game.add(player: Player(name: "Player6", scores: [50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40]), fillScores: false)
        game.add(player: Player(name: "Player7", scores: [2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50, 2000, 200, 400, 500, 600, 40, 50]), fillScores: false)
        
        return game
    }
}
