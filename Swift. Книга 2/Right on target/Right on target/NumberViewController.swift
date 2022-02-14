//
//  ViewController.swift
//  Right on target
//
//  Created by Александр Гаврилов on 03.02.2022.
//

import UIKit

class NumberViewController: UIViewController {

    // использование опционала является обязательным, иначе приложение упадёт в процессе запуска, так как в процессе создания класса аутлеты не имеют значений, их привязка происходит позже, но экземпляр класса не может иметь неопциональный свойств без значений, отсюда и возникнет ошибка
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // экземпляр класса игра
    var game: Game!
    
    // создаём ленивое вычисляемое свойство для получения secondViewController, которое позволит загрузить экземпляр SecondViewController только один раз, а затем доставать из памяти
    lazy var secondViewController = getSecondViewController()
    
    // загружает все размещённые на сцене элементы
    // вызывается только один раз при первой загрузке сцены
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    // функция вызывается после завершения загрузки всех элементов(ex: внести правки перед добавление элементов на сцену)
    // вызывается только один раз при первой загрузке сцены
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let secretValueGenerator = Generator(startWith: 1, endWith: 50)
        game = Game(valueGenerator: secretValueGenerator!, rounds: 5)
        // передаём значение числа в label
        updateLabelWithSecretNumber(with: game.currentRound.currentSecretValue)
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
    
    // MARK: - Взаимодействие View - Model
    @IBAction func checkNumber() {
        self.game.currentRound.calculateScore(with: Int(self.slider.value))
        if self.game.isGameEnded {
            showAlert(with: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
            updateLabelWithSecretNumber(with: game.currentRound.currentSecretValue)
        }
    }
    
    private func showAlert(with score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        // добавляем экшн к нему(то есть кнопку), к которой привязали handler, где после нажатия кнопки отобразится новое число
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: {
            [self] _ in self.updateLabelWithSecretNumber(with: self.game.currentRound.currentSecretValue)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Обновление View
    private func updateLabelWithSecretNumber(with number: Int) {
        self.label.text = String(number)
    }
    
    // функция для подгрузки SecondViewController для ленивого вычисляемого свойства
    private func getSecondViewController() -> SecondViewController {
        // UIStoryBoard позволяет представить сторибоард в виде сущности, и использовать в дальнейшем
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // из него достаём ViewController с указанным именем(поле id в Identity Inspector)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
}

