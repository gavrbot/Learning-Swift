//
//  ProfileViewController.swift
//  SpotifyClone
//
//  Created by Александр Гаврилов on 08.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        fetchProfile()
        view.backgroundColor = .systemBackground

    }

    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                    break
                case .failure(let error):
                    self?.failedtoGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        
    }

    private func failedtoGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
}
