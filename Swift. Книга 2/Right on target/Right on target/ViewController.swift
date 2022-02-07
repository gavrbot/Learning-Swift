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
    var round: Int = 0
    // сумма очков за раунд
    var points: Int = 0
    
    @IBAction func checkNumber() {
        // случай, если приложение было только запущено
        if self.round == 0 {
            // сгенерировали число
            self.number = Int.random(in: 1...50)
            // передаём значение числа в label
            self.label.text = String(self.number)
            // инкрементируем раунд
            self.round += 1
        } else {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

