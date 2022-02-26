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
        
        let imagePath = "https://image.tmdb.org/t/p/w185/\(movie.poster_path!)"

        movieTitleLabel.text = movie.original_title
        movieSynopsisLabel.text = movie.overview
        movieImageView.af.setImage(withURL: URL(string: imagePath )!)
    }
    
}
