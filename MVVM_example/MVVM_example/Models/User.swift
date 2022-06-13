//
//  File.swift
//  MVVM_example
//
//  Created by Александр Гаврилов on 13.06.2022.
//

import Foundation

struct User {
    let login: String?
    let password: String?
}

extension User {
    static var logins = [
        User(login: "alex", password: "12345")
    ]
}
