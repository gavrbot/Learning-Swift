//
//  Generator.swift
//  Right on target
//
//  Created by Александр Гаврилов on 12.02.2022.
//

import Foundation

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class Generator: GeneratorProtocol {
    private var minSecretValue: Int
    private var maxSecretValue: Int
    
    init?(startWith minValue: Int, endWith maxValue: Int) {
        guard minValue <= maxValue else {
            return nil
        }
        self.minSecretValue = minValue
        self.maxSecretValue = maxValue
    }
    
    func getRandomValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
}
