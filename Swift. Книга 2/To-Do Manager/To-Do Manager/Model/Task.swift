//
//  Task.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 02.03.2022.
//

import Foundation

enum TaskPriority {
    // текущая
    case normal
    // важная
    case important
}

enum TaskStatus {
    // запланированная
    case planned
    // завершённая
    case completed
}

// требование к типу, описывающему сущность "Задача"
protocol TaskProtocol {
    // название
    var title: String { get set }
    // тип
    var type: TaskPriority { get set }
    // статус
    var status: TaskStatus { get set }
}

// сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}
