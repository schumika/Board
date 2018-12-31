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
    
    public func add(score: Int) {
        self.scores?.append(score)
    }
    
    public func updateScore(at index: Int, with newValue: Int) {
        self.scores?[index] = newValue
    }
    
    public func totalScore() -> Int {
        guard let scores = scores else { return 0 }
        return scores.reduce(0) { $0 + $1 }
    }
    
    public func delete(at index: Int) {
        guard index < scores?.count ?? 0 else { return }
        scores?.remove(at: index)
    }
}
