//
//  Player.swift
//  Board
//
//  Created by Anca Julean on 18/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import Foundation

class Player {
    public var name: String
    public private(set) var scores: [Int]?
    
    init(name: String) {
        self.name = name
        self.scores = [Int]()
    }
    
    init(name: String, scores: [Int]) {
        self.name = name
        self.scores = scores
    }
    
    public func addScore(score: Int) {
        self.scores?.append(score)
    }
}
