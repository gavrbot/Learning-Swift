//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 02.03.2022.
//

import Foundation

// протокол, описывающий сущность "Хранилище задач"
protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

// сущность "Хранилище задач"
class TaskStorage: TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        let testTasks: [TaskProtocol] = [
            Task(title: "Побриться", priority: .normal, status: .planned),
            Task(title: "Принять душ", priority: .normal, status: .completed),
            Task(title: "Купить продукты", priority: .important, status: .planned),
            Task(title: "Поцеловать мами", priority: .important, status: .completed),
        ]
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {}
}
