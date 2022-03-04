//
//  MovieGridViewController.swift
//  FlixMovies
//
//  Created by Nikola Baci on 3/1/22.
//

import UIKit

class MovieGridViewController: UIViewController, UICollectionViewDelegate {
    

    @IBOutlet weak var movieGridCollection: UICollectionView!
    let movieService = MovieService()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieGridCollection.dataSource = self
        movieGridCollection.delegate = self
        movieService.delegate = self
        
        movieService.fetchSuperheroMovies()
        configureGridCell()
    }
    
    func configureGridCell() {
        let layout = movieGridCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cellPressed = sender as! MovieGridCell
        let indexPath = movieGridCollection.indexPath(for: cellPressed)!
        let movie = movies[indexPath.row]
        
        if segue.identifier == "toDetail" {
            let movieDetailVC = segue.destination as! MovieDetailViewController
            movieDetailVC.movie = movie
        }
    }
}

extension MovieGridViewController: MovieServiceDelegate {
    func didGetVideo(_ movieService: MovieService, video: Video) {
        //do nothing
    }
    
    func didUpdateMovies(_ movieService: MovieService, movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.movieGridCollection.reloadData()
        }
    }
    
    func didFailToGetMovies(error: Error) {
        print(error)
    }
}

extension MovieGridViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
            cell.configure(with: movies[indexPath.row])
            return cell
        }
}

