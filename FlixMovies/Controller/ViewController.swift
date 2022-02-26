//
//  ViewController.swift
//  FlixMovies
//
//  Created by Nikola Baci on 2/24/22.
//

import UIKit

class ViewController: UIViewController {

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
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
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
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//MARK: - MovieServiceDelegate
extension ViewController: MovieServiceDelegate {
    func didUpdateMovies(_ movieService: MovieService, movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    func didFailToGetMovies(error: Error) {
        print(error)
    }
}
