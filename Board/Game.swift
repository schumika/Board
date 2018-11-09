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
        players?.append(player)
    }
}
