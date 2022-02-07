//
//  SecondViewController.swift
//  MyName
//
//  Created by Александр Гаврилов on 06.02.2022.
//

import UIKit

class SecondViewController: UIViewController {

    // аннотация @IBOutlet используется для организации доступа к графическому элементу из кода
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(
            title: "Welcome", message: "This is myNameApp", preferredStyle: .alert
        )
        // UIAlertAction - класс, позволяющий создать функциональный элемент(кнопку), определяющий её текст(title), стиль(style) и обработчик нажатия кнопки(handler)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // метод addAction добавляет во всплывающее окно функциональные элементы(кнопки), принимает на вход экземпляр UIAlertAction класса
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        // метод present предназначен для показа элемента в виде модального окна(то есть элемент поверх сцены). Он должен быть вызван после всех изменений в выводимый элемент
        // параметры:
        // 1 - экземпляр класса UIViewController - элемент, который будет показан на экране устройства
        // 2 - animated - булевая переменная, отвечающая за наличие анимации
        // 3 - completion - замыкание, исполняемое после завершения показа элемента
        self.present(alertController, animated: true, completion: nil)
    }
    
    // sender - аргумент, с помощью которого action-метод может обратиться к вызвавшему его элементу
    @IBAction func changeLabelText(_ sender: UIButton) {
        // titleLabel - возвращает опциональный экземпляр класса UILabel
        if let buttonText = sender.titleLabel!.text {
            // myLabel - свойство, соответствующее элементу Label, находящемуся на сцене
            self.myLabel.text = "\(buttonText) button was pressed"
        }
    }
}
