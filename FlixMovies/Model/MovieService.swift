//
//  MovieService.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import Foundation


class MovieService {
    
    var delegate: MovieServiceDelegate? //used to reference back (pass data) to UIViewController class
    let moviesURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed" //api call to get the currently playing movies in theaters
    let superheroURL = "https://api.themoviedb.org/3/discover/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&with_keywords=superhero"
    let videoURL = "https://api.themoviedb.org/3/movie/"
    let apikey = "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var pageCountNowPlayingMovies = 1
    var pageCountSuperheroMovies = 1
    
    func fetchMovies() {
        //Step 1: Create a URL
        guard let url = URL(string: "\(moviesURL)&page=\(pageCountNowPlayingMovies)") else { //make sure the url is valid
            return
        }
        makeRequest(with: url, type: "movie")
        pageCountNowPlayingMovies += 1
    }
    
    func fetchSuperheroMovies() {
        guard let url = URL(string: "\(superheroURL)&page=\(pageCountSuperheroMovies)") else { //make sure the url is valid
            return
        }
        makeRequest(with: url, type: "movie")
        pageCountSuperheroMovies += 1
    }
    
    func fetchMovieTrailer(with id: Int) {
        let stringURL = "\(videoURL)/\(id)/videos?\(apikey)"
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        makeRequest(with: url, type: "video")
    }
    
    func makeRequest(with url: URL, type: String) {
        //Step 2: Create a URLSession
        let session = URLSession(configuration: .default)
        
        //Step 3: Create a task
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                self.delegate?.didFailToGetMovies(error: error!)
                return //terminate is an error occurs
            }
            
            if let safeData = data {
                if type == "Movie" || type == "movie" {
                    self.parseMovieJSON(data: safeData) //pass the data to be parsed
                }
                else if type == "Video" || type == "video" {
                    self.parseVideoJSON(data: safeData)
                }
                
            }
        }
        task.resume()
    }
    
    func parseMovieJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            //decode the JSON data into MovieResult struct
            let decodedData = try decoder.decode(MovieResult.self, from: data)
            //pass it to the UIViewController
            self.delegate?.didUpdateMovies(self, movies: decodedData.results)
        } catch {
            self.delegate?.didFailToGetMovies(error: error)
        }
    }
    
    func parseVideoJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            //decode the JSON data into MovieResult struct
            let decodedData = try decoder.decode(VideoResult.self, from: data)
            //pass it to the UIViewController
            self.delegate?.didGetVideo(self, video: decodedData.results[0])
        } catch {
            self.delegate?.didFailToGetMovies(error: error)
        }
    }
}

