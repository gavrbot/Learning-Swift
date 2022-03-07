//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 02.03.2022.
//

import Foundation

// протокол, описывающий сущность "Хранилище задач"
protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

// сущность "Хранилище задач"
class TasksStorage: TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        let testTasks: [TaskProtocol] = [
            Task(title: "Побриться", type: .normal, status: .planned),
            Task(title: "Ну ё моё, короче, Клим Саныч, тут такое дело, долго рассказывать, но тут по-другому никак, это самое, в общем всё", type: .normal, status: .planned),
            Task(title: "Принять душ", type: .normal, status: .completed),
            Task(title: "Поцеловать мами", type: .important, status: .completed),
            Task(title: "Купить продукты", type: .important, status: .planned),
        ]
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {}
}
