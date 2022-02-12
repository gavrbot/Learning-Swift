//
//  Game.swift
//  Right on target
//
//  Created by Александр Гаврилов on 11.02.2022.
//
// в этот класс выносим логику, связанную с игрой
import Foundation

protocol GameProtocol {
    // количество очков за игру
    var score: Int { get }
    // загаданное число
    var currentSecretValue: Int { get }
    // переменная, отвечающая за то, окончена ли игра
    var isGameEnded: Bool { get }
    // функция перезапуска игры
    func restartGame()
    // функция для запуска нового раунда
    func startNewRound()
    // функция расчёта количества очков
    func calculateScore(with value: Int)
}

// класс выбран вместо структуры, так как при небольшой логике программы и малом количестве view разницы между ними нет, но при увеличении масштаба игры будут расти количества классов и обработчиков класса игры, где потребуется именно передача класса по ссылке, а не по значению, так как иначе расход памяти будет большим
class Game: GameProtocol {
    var score: Int = 0
    // минимальное значение секрета
    private var minSecretValue: Int
    // максимальное значение секрета
    private var maxSecretValue: Int
    var currentSecretValue: Int = 0
    private var lastRound: Int
    private var currentRound: Int = 1
    
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, round: Int) {
        // начальное значение не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = round
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewSecretValue()
        currentRound += 1
    }
    
    private func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
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
