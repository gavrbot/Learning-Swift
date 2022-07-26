//
//  Movie.swift
//  NetflixClone
//
//  Created by Александр Гаврилов on 25.07.2022.
//

import Foundation

struct TrendingTitleResponse: Codable{
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 {
adult = 0;
"backdrop_path" = "/pLOFQLeKQYsCzkYgsw9tg1cPuDG.jpg";
"genre_ids" =             (
 28,
 53
);
id = 725201;
"media_type" = movie;
"original_language" = en;
"original_title" = "The Gray Man";
overview = "When the CIA's most skilled mercenary known as Court Gentry, aka Sierra Six, accidentally uncovers dark agency secrets, he becomes a primary target and is hunted around the world by psychopathic former colleague Lloyd Hansen and international assassins.";
popularity = "364.477";
"poster_path" = "/13r1DFhfL0qufFjXnrvWuh6qKqH.jpg";
"release_date" = "2022-07-13";
title = "The Gray Man";
video = 0;
"vote_average" = "6.795";
"vote_count" = 408;
},
 */
