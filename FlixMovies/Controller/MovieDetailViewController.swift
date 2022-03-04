//
//  MovieDetailViewController.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/27/22.
//

import UIKit
import AlamofireImage
class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie?.original_title
        movieOverview.text = movie?.overview
        movieRating.text = "Rating: \(movie?.vote_average ?? 0) (\(movie?.vote_count ?? 0))"
        movieReleaseDate.text = "Release Date: \(movie?.release_date ?? "Unknown")"
        if let posterPath = movie?.poster_path {
            posterImage.af.setImage(withURL: URL(string: "https://image.tmdb.org/t/p/w780\(posterPath)")!)
        }
        if let backdropPath = movie?.backdrop_path {
            backdropImage.af.setImage(withURL: URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieTrailer" {
            let movieTrailerVC = segue.destination as! MovieTrailerViewController
            movieTrailerVC.movieID = movie?.id!
        }
    }
    
}
