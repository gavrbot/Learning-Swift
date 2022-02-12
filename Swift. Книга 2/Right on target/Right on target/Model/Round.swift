//
//  Round.swift
//  Right on target
//
//  Created by Александр Гаврилов on 12.02.2022.
//

import Foundation

protocol GameRoundProtocol {
    var score: Int { get }
    var currentSecretValue: Int { get }
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int
    
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}
