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
    @IBOutlet var secretValueLabel: UILabel!
    
    // экземпляр класса игра
    var game: Game<SecretNumericValue>!
    
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
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        // передаём значение числа в label
        updateLabelWithSecretNumber(with: game.secretValue.value)
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
        // Высчитываем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            // Показываем окно с итогами
            showAlert(with: game.score)
            // Рестартуем игру
            game.restartGame()
        } else {
            // Начинаем новый раунд игры
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(with: game.secretValue.value)
    }
    
    private func showAlert(with score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        // добавляем экшн к нему(то есть кнопку), к которой привязали handler, где после нажатия кнопки отобразится новое число
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: {
            [self] _ in self.updateLabelWithSecretNumber(with: self.game.secretValue.value)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Обновление View
    private func updateLabelWithSecretNumber(with number: Int) {
        self.secretValueLabel.text = String(number)
    }
    
}

