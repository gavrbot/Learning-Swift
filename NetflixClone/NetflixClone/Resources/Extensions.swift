//
//  Extensions.swift
//  NetflixClone
//
//  Created by Александр Гаврилов on 26.07.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
