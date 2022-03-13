//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 11.03.2022.
//

import UIKit

class TaskTypeController: UITableViewController {

    // 1. кортеж, описывающий тип задачи, с помощью которого таблица будет наполняться данными. typealias используется как псевдоним для более удобной читаемости кода(по факту новый тип данных не создаётся)
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    // 2. коллекция TypeCellDescription - доступных типов задач с их описанием.
    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи заводятся в самом верху списка задач."),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом.")
    ]
    
    // 3. выбранный приоритет. Свойство будет использоваться для определения выбранного значения. Соответствующая ему строка будет подмечаться галочкой
    var selectedType: TaskPriority = .normal
    
    // обработчик вызова типа
    // решено использовать замыкание, так как в таком случае вся ответственность за работу с обновлёнными данными будет лежать на вызывающем контроллере
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    // метод viewDidLoad() срабатывает до того, как табличное представление начинает использовать ячейки для наполнения себя данными, по этой причине данный метод идеально подходит для регистрации кастомной ячейки
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ячейки, основанные на xib-файлах, для использования их в табличном представлении требуют регистрации с помощью метода register. Это связано с тем, что такой тип ячеек существует отдельно от и независимо от Table View, и поэтому ему необходимо сообщить, что такая ячейка происходит
        
        // 1. получение значения типа UINib, соответствующее xib-файлу кастомной ячейки
        // тип UINib используется для программного описания сущности xib-файла, аналогия с UIStoryBoard
        let cellTypeNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        // 2. регистрация кастомной ячейки в табличном представлении
        // передаётся UINib экземпляр класса и строковый идентификатор ячейки
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TaskTypeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypesInformation.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. получение переиспользуемой кастомной ячейки по её идентификатору(тот же, по которому ячейка была зарегистрирована). Приведение к типу используется для получения доступа к аутлетам
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        
        // 2. получаем текущий элемент, информация о котором должна быть выведена в строке
        let typeDescpription = taskTypesInformation[indexPath.row]
        
        // 3. заполняем ячейку данными
        cell.typeTitle.text = typeDescpription.title
        cell.typeDescription.text = typeDescpription.description
        
        // 4. если тип является выбранным, то отмечаем строку галочкой. Свойство accessoryType позволяет определить стиль вспомогательного элемента в правой части ячейки
        if selectedType == typeDescpription.type {
            cell.accessoryType = .checkmark
        // в ином случае снимаем отметку
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // получаем выбранный тип
        let selectedType = taskTypesInformation[indexPath.row].type
        // вызов обработчика
        doAfterTypeSelected?(selectedType)
        // возвращаемся на экран создания
        navigationController?.popViewController(animated: true)
    }
    
}
