//
//  BoardGameController.swift
//  Cards
//
//  Created by Александр Гаврилов on 14.04.2022.
//

import UIKit

class BoardGameController: UIViewController {

    // количество пар уникальный карточек
    var cardsPairsCounts = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    
    private func getStartButtonView() -> UIButton {
        // 1
        // Создаём кнопку( (0, 0) - левый верхний угол родительского представления )
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2
        // Изменяем положение кнопки
        button.center.x = view.center.x
        
        // получаем доступ к текущему окну
        let window = UIApplication.shared.windows[0]
        // определяем отступ сверху от границ окна до Safe Area
        let topPadding = window.safeAreaInsets.top
        // устанавливаем координату Y нкопки в соответствии с отступом
        button.frame.origin.y = topPadding
        
        //3
        // Настраиваем внешний вид кнопки
        
        // устанавливаем текст
        button.setTitle("Начать игру", for: .normal)
        // устанавливаем цвет текста для обычного (не нажатого) состояния
        button.setTitleColor(.black, for: .normal)
        // устанавливаем цвет текста для нажатого состояния
        button.setTitleColor(.gray, for: .highlighted)
        // устанавливаем фоновый цвет
        button.backgroundColor = .systemGray4
        // скругляем углы
        button.layer.cornerRadius = 10
        
        // подключаем обработчик нажатия на ссылку
        // метод addTarget связывает событие for к методу action. Для создания ссылки на метод используется #selector
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    // аннотация @objc позволяет сделать метод видимым для Objective-C, в частности для использования #selector в связывании кнопки с действием
    @objc func startGame(_ sender: UIButton) {
        print("button was pressed")
    }
    
    private func getBoardGameView() -> UIView {
        // отступ игрового поля от боижайших элементов
        let margin: CGFloat = 10
        
        let boardView = UIView()
        
        // указываем координаты
        // x
        boardView.frame.origin.x = margin
        // y
        let window = UIApplication.shared.windows[0]
        let topPading = window.safeAreaInsets.top
        boardView.frame.origin.y = topPading + startButtonView.frame.height + margin
        
        // рассчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin * 2
        // рассчитываем высоту с учётом нижнего отступа
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // добавляем кнопку на сцену
        view.addSubview(startButtonView)
        // добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
}

