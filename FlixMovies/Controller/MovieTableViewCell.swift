//
//  MovieTableViewCell.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    func configure(with movie: Movie) {
        
        if let imagePath = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster_path ?? "")") {
            movieImageView.af.setImage(withURL: imagePath)
        } else {
            movieImageView.af.setImage(withURL: URL(string: "https://thenounproject.com/icon/no-image-2884221/")!)
        }

        movieTitleLabel.text = movie.original_title
        movieSynopsisLabel.text = movie.overview
        
    }
    
}
