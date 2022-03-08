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
    var tasks: [TaskPriority:[TaskProtocol]] = [:] {
        didSet {
            // сортировка списка задач по Int значению в enum TaskStatus
            // свойство tasksStatusPosition используется вместо enum TaskStatus для уменьшения связность между моделью и контроллером
            for (tasksGroupPriority, taskGroup) in tasks {
                tasks[tasksGroupPriority] = taskGroup.sorted { task1, task2 in
                    let task1position = tasksStatusPosition.firstIndex(of: task1.status)
                    let task2position = tasksStatusPosition.firstIndex(of: task2.status)
                    return task1position! < task2position!
                }
            }
        }
    }
    
    // порядок отображения секций по типам. Индекс в массиве соответствует индексу секции в таблице
    var sectionsTypePosition: [TaskPriority] = [.important, .normal]
    
    var tasksStatusPosition: [TaskStatus] = [.planned, .completed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // загрузка задач
        loadTasks()
        // кнопка активации режима редактирования
        navigationItem.leftBarButtonItem = editButtonItem
    }

    private func loadTasks() {
        // подготовка коллекции с задачами, будем использовать только те, для которых определены секции в таблице
        sectionsTypePosition.forEach{ taskType in
            tasks[taskType] = []
        }
        // загрузка и разбор задач из хранилища
        tasksStorage.loadTasks().forEach{ task in
            tasks[task.type]?.append(task)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }

    // количество строк в определённой секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // определяем приоритет задач, соответствующий текущей секции
        let taskType = sectionsTypePosition[section]
        guard let currentTasksType = tasks[taskType] else {
            return 0
        }
        return currentTasksType.count
    }
    
    // вывод названия секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypePosition[section]
        if tasksType == .important {
            title = "Важные"
        } else  if tasksType == .normal {
            title = "Текущие"
        }
        return title
    }
    
    // функция обработки нажатия на кнопку редактирования. В данном случае удаляется строка
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // находим задачу для удаления
        let taskType = sectionsTypePosition[indexPath.section]
        // удаляем её из списка задач
        tasks[taskType]?.remove(at: indexPath.row)
        // удаляем строку с этой задачей
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // функция свайпа для возвращения задачи в статус запланированной
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // получаем данные о текущей задаче, которая нужна для перевода в статус запланированной
        let taskType = sectionsTypePosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else {
            return nil
        }
        // проверяем, что задача имеет статус выполненной
        guard tasks[taskType]![indexPath.row].status == .completed else {
            return nil
        }
        
        // создаём действие для изменения статуса
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") {
            _, _, _ in
            self.tasks[taskType]![indexPath.row].status = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        // возвращаем настроенный объект
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. проверяем существование задачи, соответствующей заданной строке
        let taskType = sectionsTypePosition[indexPath.section]
        guard let _  = tasks[taskType]?[indexPath.row] else {
            return
        }
        
        // 2. убеждаемся, что задача не является выполненной, так как по нажатию выполненные задачи не будут обратно возвращаться в запланированные
        guard tasks[taskType]![indexPath.row].status == .planned else {
            // с помощью метода deselectRow происходит снятие выделения нажатой строки
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        // 3. отмечаем задачу как выполненную
        tasks[taskType]![indexPath.row].status = .completed
        // 4. перезагружаем секцию таблицы, так как отображение не изменится лишь при изменении данных
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    // ячейка для строки таблицы
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ячейка на основе констреинтов
        // return getConfiguredTaskCell_constraints(for: indexPath)
        // ячейка на основе стека
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    // ячейка на основе стека
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        // получаем данные о задаче, которую необходимо вывести в ячейке
        let taskType = sectionsTypePosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        
        // изменяем текст в ячейке
        cell.title.text = currentTask.title
        // изменяем символ в ячейке
        cell.symbol.text = getSymbolForTask(with: currentTask.status)
        
        // изменяем цвет текста
        if currentTask.status == .planned {
            cell.title.textColor = .black
            cell.symbol.textColor = .black
        } else {
            cell.title.textColor = .lightGray
            cell.symbol.textColor = .lightGray
        }
        
        return cell
    }
    
    // ячейка на основе ограничений
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
        // получаем данные о задаче, которую необходимо вывести в ячейке
        let taskType = sectionsTypePosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        
        // текстовая метка символа
        let symbolLabel = cell.viewWithTag(1) as? UILabel
        // текстовая метка названия задачи
        let textLabel = cell.viewWithTag(2) as? UILabel
        
        // изменяем символ в ячейке
        symbolLabel?.text = getSymbolForTask(with: currentTask.status)
        // изменяем текст в ячейке
        textLabel?.text = currentTask.title
        
        // изменяем цвет текста и символа
        if currentTask.status == .planned {
            textLabel?.textColor = .black
            symbolLabel?.textColor = .black
        } else {
            textLabel?.textColor = .lightGray
            symbolLabel?.textColor = .lightGray
        }
        
        return cell
    }
    
    // возвращаем символ для конкретного типа задач
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    

}
