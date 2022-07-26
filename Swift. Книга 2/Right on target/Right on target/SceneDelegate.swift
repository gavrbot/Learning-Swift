//
//  SceneDelegate.swift
//  Right on target
//
//  Created by Александр Гаврилов on 03.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // загрузка необходимых для работы приложения данных с диска или из сети
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("willConnectTo")

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // создаём экземпляр UIWindow с размером, равным размеру устройства. UIScreen.main.bounds - экземпляр CGRect прямоугольника с размерами основного экрана
        // window = UIWindow(frame: UIScreen.main.bounds)
        // предыдущий конструктор строил экран на основе четко заданного размера дисплея устройства, соответственно возникала ошибка при открытия второго приложения в многооконном режиме. Исправить эту ошибку можно с помощью задания размера конкретно самой windowScene
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        
        // привязываем текущий вариант интерфейса к созданному окну
        // Этот код был закомментирован из-за использования инициализатора с windowScene, иначе его нужно раскомментировать
        // window.windowScene = windowScene
        
        // загружаем ViewController из Storyboard по Storyboard Id
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        // делаем этот ViewController основным(аналогично с указанием чекбокса в Storyboard)
        window.rootViewController = viewController
        
        // окно делается ключевым и видимым. Ключевое окно - окно, которое принимает и обрабатывает события(нажатия). Ключевым может быть только одно окно в один момент времени
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("sceneDidEnterBackground")
    }


}

