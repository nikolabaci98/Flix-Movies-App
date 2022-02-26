//
//  Movies.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import Foundation

struct MovieResult: Decodable {
    var results = [Movie]()
}

struct Movie: Decodable {
    let original_title: String?
    let overview: String?
    let poster_path: String?
}
