//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Александр Гаврилов on 26.02.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var dataTextField: UITextField!
    
    var updatingData: String = ""
    
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    var completionHandler: ((String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextField(withText: updatingData)
    }
    
    private func updateTextField(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // реализуем метод prepare для unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toFirstScreen":
            // обрабатываем переход
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на первый
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    // переход от Б к А
    // передача данных с помощью делегата
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        // получаем обновлённые даныне
        let updatedData = dataTextField.text ?? ""
        
        // вызываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        
        // возвращаемся на предыдущий экран
        self.navigationController?.popViewController(animated: true)
    }
    
    // переход от Б к А
    // передача данных с помощью замыкания
    @IBAction func saveWithClosure(_ sender: UIButton) {
        // получаем обновлённые данные
        let updatedData = dataTextField.text ?? ""
        // вызываем замыкание
        completionHandler?(updatedData)
        // возвращаемся на предыдущий экран
        self.navigationController?.popViewController(animated: true)
    }
}
