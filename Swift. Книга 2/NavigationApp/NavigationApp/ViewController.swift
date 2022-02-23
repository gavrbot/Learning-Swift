//
//  ViewController.swift
//  NavigationApp
//
//  Created by Александр Гаврилов on 23.02.2022.
//

import UIKit

class ViewController: UIViewController {

    // ссылка на сторибоард, где размещён данный ViewController
    let storyBoardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    // переход к жёлтой сцене
    @IBAction func toGreenScene(_ sender: UIButton) {
        // получаем ссылку на следующий контроллер с зелёным цветом
        let nextViewController = storyBoardInstance.instantiateViewController(withIdentifier: "greenViewController")
        // обращаемся к Navigation Controller и вызываем метод перехода к новому контроллеру
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // переход к жёлтой сцене аналогичен переходу к зелёной
    @IBAction func toYellowScene(_ sender: UIButton) {
        let nextViewController = storyBoardInstance.instantiateViewController(withIdentifier: "yellowViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // переход к корневой сцене
    @IBAction func toRootScene(_ sender: UIButton) {
        // обращаемся к Navigation Controller и вызываем метод перехода к корневому контроллеру
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // переход к предыдущему экрану
    @IBAction func toPreviousScene(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.prompt = "Подсказка"
        self.navigationItem.title = "Заголовок сцены"
        self.navigationItem.backButtonTitle = "Назад"
    }


}

