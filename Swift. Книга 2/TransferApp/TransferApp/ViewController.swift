//
//  ViewController.swift
//  TransferApp
//
//  Created by Александр Гаврилов on 26.02.2022.
//

import UIKit

class ViewController: UIViewController, DataUpdateProtocol {

    @IBOutlet var dataLabel: UILabel!
    
    var updatedData: String = "Test data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    // обновляем данные в текстовой метке
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }

    // изменяем данные с помощью кнопки
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаём данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор esgue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    // метод использует unwind segue, который позволяет перейти на любой нужный экран назад. Важно определять этот метод в том вьюконтроллере, куда будет осуществлён переход
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}

    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    // переход от А к Б
    // передача данных с помощью свойства и установка делегата
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // обновляем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // в качестве делегата устанавливаем текущий класс
        editScreen.handleUpdatedDataDelegate = self
        
        //открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // переход от А к Б
    // передача данных с помощью свойства и инициализация замыкания
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // передаем необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
}

