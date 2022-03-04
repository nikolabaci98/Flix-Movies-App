//
//  MovieGridCell.swift
//  FlixMovies
//
//  Created by Nikola Baci on 3/1/22.
//

import UIKit
import AlamofireImage
class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var movieGridCellPoster: UIImageView!
    
    func configure(with movie: Movie) {
        if let imagePath = URL(string: "https://image.tmdb.org/t/p/w780/\(movie.poster_path ?? "")") {
            movieGridCellPoster.af.setImage(withURL: imagePath)
        } else {
            movieGridCellPoster.af.setImage(withURL: URL(string: "https://thenounproject.com/icon/no-image-2884221/")!)
        }
    }
}
