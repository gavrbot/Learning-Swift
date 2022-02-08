//
//  ViewController.swift
//  Right on target
//
//  Created by Александр Гаврилов on 03.02.2022.
//

import UIKit

class ViewController: UIViewController {

    // использование опционала является обязательным, иначе приложение упадёт в процессе запуска, так как в процессе создания класса аутлеты не имеют значений, их привязка происходит позже, но экземпляр класса не может иметь неопциональный свойств без значений, отсюда и возникнет ошибка
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // загаданное число
    var number: Int = 0
    // раунд
    var round: Int = 1
    // сумма очков за раунд
    var points: Int = 0
    
    @IBAction func checkNumber() {
        // получаем значение числа из слайдера
        let numSlider = Int(self.slider.value.rounded())
        // cравниваем число и высчитываем количество очков
        if numSlider > self.number {
            self.points += 50 - self.number + numSlider
        } else if numSlider < self.number {
            self.points += 50 - numSlider + self.number
        } else {
            self.points += 50
        }
        
        // если конец игры
        if self.round == 5 {
            // создаём экземпляр UIAlertController класса
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Вы заработали \(self.points) очков",
                preferredStyle: .alert)
            // добавляем экшн к нему(то есть кнопку)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.round = 1
            self.points = 0
        // иначе инкрементируем значение раунда
        } else {
            self.round += 1
        }
        // задаём следующее случайное число
        self.number = Int.random(in: 1...50)
        self.label.text = String(self.number)
    }
    
    // загружает все размещённые на сцене элементы
    // вызывается только один раз при первой загрузке сцены
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    // функция вызывается после завершения загрузки всех элементов(ex: внести правки перед добавление элементов на сцену)
    // вызывается только один раз при первой загрузке сцены
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // сгенерировали число
        self.number = Int.random(in: 1...50)
        // передаём значение числа в label
        self.label.text = String(self.number)
    }

    // функция вызывается перед тем, как элементы сцены будут добавлены в иерархию графических элементов
    // вызывается каждый раз, когда сцена добавляется в иерархию
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    // функция вызывается после появления элементов на сцену(ex: подходит для запуска анимации или синхронизации данных с сервером)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }

    // функции viewWillDisappear и viewDidDisappear вызываются до и после удаления элементов из иерархии view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
}

