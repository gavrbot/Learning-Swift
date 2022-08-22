//
//  SettingsModels.swift
//  SpotifyClone
//
//  Created by Александр Гаврилов on 22.08.2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
