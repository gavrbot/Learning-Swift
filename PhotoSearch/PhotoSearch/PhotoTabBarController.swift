//
//  PhotoTabBarController.swift
//  PhotoSearch
//
//  Created by Александр Гаврилов on 10.06.2022.
//

import UIKit

class PhotoTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomPhotoViewController = RandomPhotoViewController()
        let photoSearchViewController = ViewController()
        
        randomPhotoViewController.title = "Random Photo"
        photoSearchViewController.title = "Photo Search"
        
        self.modalPresentationStyle = .fullScreen
        
        self.setViewControllers([randomPhotoViewController, photoSearchViewController], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "star"]
        
        for i in 0..<images.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        present(self, animated: true)
    }
}
