//
//  UserProfile.swift
//  SpotifyClone
//
//  Created by Александр Гаврилов on 08.08.2022.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}
