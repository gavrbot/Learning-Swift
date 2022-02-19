//
//  ViewController.swift
//  Contacts
//
//  Created by Александр Гаврилов on 17.02.2022.
//

import UIKit

// протокол UITableViewDataSource необходимо реализовать, так как данный ViewController является источником данных для Table View
class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    // используем протокол, а не конкретный класс Contact для уменьшения зависимости от конкретной реализации протокола
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort{ $0.title < $1.title }
        }
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Центурион Передрейхус", phone: "+09921247122"))
        contacts.append(Contact(title: "Джейк Сулли", phone: "+79093441122"))
        contacts.append(Contact(title: "Кевин Маккалистер", phone: "+12334441122"))
        contacts.append(Contact(title: "Барак Обама", phone: "+11110001100"))
        contacts.append(Contact(title: "Майлс Логан", phone: "+22998874721"))
    }
    
    @IBAction func showNewContactAlert() {
        // создаём UIAlertController
        let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        
        // добавляем первое текстовое поле в alertController
        alertController.addTextField {textField in
            textField.placeholder = "Имя"
        }
        
        // добавляем второе текстовое поле в alertController
        alertController.addTextField {textField in
            textField.placeholder = "Номер телефона"
        }
        
        // создаём кнопку создания контакта
        let createButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else {
                      return
                  }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        // создаём кнопку отмены
        let cancelButton = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        // добавляем кнопки в alertController
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
}

// чтобы избежать разрастание кода viewController добавим реализацию протокола UITableViewDataSource как расширение
extension ViewController: UITableViewDataSource {
    
    // возвращает потенциальное количество строк, которые могут быть отображены
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    // возвращает ячейку, определяющую внешний вид данных, выводимых в каждой строке. Метод вызывается перед тем, как будет отображена очередная ячейка таблицы. Для каждой строки таблицы происходит отдельный вызов метода и возвращается собственная ячейка UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем экземпляр ячейки
        var cell: UITableViewCell
        // reuseIdentifier - уникальный идентификатор, который должен четко показывать, для чего он нужен, используется один для одного табличного представления
        // проверяем, есть ли переиспользуемая ячейка с указанным индексом
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "myCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаём новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        // конфигурируем ячейку
        // параметр cell содержит ячейку UIListContentConfiguration, которая является оформлением ячейки по умолчанию
        var configuration = cell.defaultContentConfiguration()
        // indexPath - параметр с внешним именем cellForRowAt типа IndexPath
        // indexPath.section - индекс секции
        // idexPath.row - индекс строки
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
}

// подписываем этот ViewController на UITableViewDelegate, т.к. обработка свайпов будет производится не самой таблицей, а с помощью делегата. Таким образом, мы используем делегирование
extension ViewController: UITableViewDelegate {
    // возвращает экземпляр UISwipeActionsConfiguration, содержащий множество действий при свайпе влево. Для свайпа вправо в названии функции вместо trailing используется leading. Принимает на вход экземпляр UITableView, в котором производится свайп, и индекс строки IndexPath
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // действие удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            // удаляем контакт
            self.contacts.remove(at: indexPath.row)
            // перезагружаем табличное представление
            tableView.reloadData()
        }
        // формируем экземпляр, описывающий допустимые действия при свайпе
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}


