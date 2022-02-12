//
//  Game.swift
//  Right on target
//
//  Created by Александр Гаврилов on 11.02.2022.
//
import Foundation

protocol GameProtocol {
    // количество очков за игру
    var score: Int { get }
    var secretValueGenerator: GeneratorProtocol! { get }
    var currentRound: GameRoundProtocol! { get }
    var isGameEnded: Bool { get }
    
    func restartGame()
    func startNewRound()
}

// класс выбран вместо структуры, так как при небольшой логике программы и малом количестве view разницы между ними нет, но при увеличении масштаба игры будут расти количества классов и обработчиков класса игры, где потребуется именно передача класса по ссылке, а не по значению, так как иначе расход памяти будет большим
class Game: GameProtocol {
    var score: Int {
        var totalScore = 0
        for round in rounds {
            totalScore += round.score
        }
        return totalScore
    }
    var secretValueGenerator: GeneratorProtocol!
    var currentRound: GameRoundProtocol!
    private var roundsCount: Int
    private var rounds: [GameRoundProtocol] = []
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currentRound = GameRound(secretValue: newSecretValue)
        rounds.append(currentRound)
    }
    
    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
}
