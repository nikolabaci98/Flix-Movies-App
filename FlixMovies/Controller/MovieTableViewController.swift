//
//  ViewController.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import UIKit

class MovieTableViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    let movieService = MovieService()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        movieService.delegate = self
        
        movieService.fetchMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cellPressed = sender as! MovieTableViewCell
        let indexPath = moviesTableView.indexPath(for: cellPressed)!
        let movie = movies[indexPath.row]
        
        if segue.identifier == "toMovieDetail" {
            let movieDetailVC = segue.destination as! MovieDetailViewController
            movieDetailVC.movie = movie
        }
        
        moviesTableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: - UITableViewDataSource
extension MovieTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            movieService.fetchMovies()
        }
    }
}

//MARK: - UITableViewDelegate
extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//MARK: - MovieServiceDelegate
extension MovieTableViewController: MovieServiceDelegate {
    func didGetVideo(_ movieService: MovieService, video: Video) {
        //do nothing
    }
    
    func didUpdateMovies(_ movieService: MovieService, movies: [Movie]) {
        for movie in movies {
            self.movies.append(movie)
        }
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    func didFailToGetMovies(error: Error) {
        print(error)
    }
}
