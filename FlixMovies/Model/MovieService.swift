//
//  MovieService.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import Foundation


class MovieService {
    
    var delegate: MovieServiceDelegate? //used to reference back (pass data) to UIViewController class
    let apiurl = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed" //api call to get the currently playing movies in theaters
    
    func fetchMovies() {
        //Step 1: Create a URL
        guard let url = URL(string: apiurl) else { //make sure the url is valid
            return
        }
        
        //Step 2: Create a URLSession
        let session = URLSession(configuration: .default)
        
        //Step 3: Create a task
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                self.delegate?.didFailToGetMovies(error: error!)
                return //terminate is an error occurs
            }
            
            if let safeData = data {
                self.parseJSON(data: safeData) //pass the data to be parsed
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) {
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
}

