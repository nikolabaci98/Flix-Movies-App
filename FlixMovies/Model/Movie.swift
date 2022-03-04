//
//  Movies.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import Foundation
import UIKit

struct MovieResult: Decodable {
    var results = [Movie]()
}

struct Movie: Decodable {
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let id: Int?
    let vote_average: Float?
    let vote_count: Int?
    let release_date: String?
}


struct VideoResult: Decodable {
    var results = [Video]()
}

struct Video: Decodable {
    let key: String?
}
