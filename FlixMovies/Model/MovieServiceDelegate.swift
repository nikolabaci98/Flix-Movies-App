//
//  MovieServiceDelegate.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import Foundation

protocol MovieServiceDelegate {
    func didUpdateMovies(_ movieService: MovieService, movies: [Movie])
    func didGetVideo(_ movieService: MovieService, video: Video)
    func didFailToGetMovies(error: Error)
}
