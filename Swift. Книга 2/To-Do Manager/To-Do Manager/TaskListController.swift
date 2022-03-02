//
//  TaskListController.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 02.03.2022.
//

import UIKit

class TaskListController: UITableViewController {

    // хранилище задач
    var tasksStorage: TasksStorageProtocol = TasksStorage()
    // коллекция задач
    var tasks: [TaskPriority:[TaskProtocol]] = [:]
    
    // порядок отображения секций по типам. Индекс в массиве соответствует индексу секции в таблице
    var sectionsTypePositions: [TaskPriority] = [.important, .normal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
    }

    private func loadTasks() {
        sectionsTypePositions.forEach{ taskType in
            tasks[taskType] = []
        }
        tasksStorage.loadTasks().forEach{ task in
            tasks[task.type]?.append(task)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
