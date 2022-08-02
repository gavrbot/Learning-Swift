//
//  YouTubeSearchResponse.swift
//  NetflixClone
//
//  Created by Александр Гаврилов on 01.08.2022.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

/*
 items =     (
             {
         etag = "F0UQYAF5oT6eqhZtCd_iuDKGTWY";
         id =             {
             kind = "youtube#video";
             videoId = "y06J5O9t_Lg";
         };
         kind = "youtube#searchResult";
     },
 */
