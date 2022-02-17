//
//  ViewController.swift
//  Contacts
//
//  Created by Александр Гаврилов on 17.02.2022.
//

import UIKit

// протокол UITableViewDataSource необходимо реализовать, так как данный ViewController является источником данных для Table View
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// чтобы избежать разрастание кода viewController добавим реализацию протокола UITableViewDataSource как расширение
extension ViewController: UITableViewDataSource {
    
    // возвращает потенциальное количество строк, которые могут быть отображены
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
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
        configuration.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
    
}

