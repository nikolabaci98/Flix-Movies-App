//
//  MovieTrailerViewController.swift
//  FlixMovies
//
//  Created by Nikola Baci on 3/4/22.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navBar: UINavigationBar!
    let movieService = MovieService()
    var movieID: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieService.delegate = self
        movieService.fetchMovieTrailer(with: movieID!)
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didPressDone))
    }

    @objc func didPressDone(){
        dismiss(animated: true)
    }
}

extension MovieTrailerViewController: MovieServiceDelegate {
    func didGetVideo(_ movieService: MovieService, video: Video) {
        let key = video.key!
        let url = URL(string: "https://www.youtube.com/watch?v=\(key)")!
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
        print(video.key!)
    }
    
    func didUpdateMovies(_ movieService: MovieService, movies: [Movie]) {
        
    }
    
    func didFailToGetMovies(error: Error) {
        print(error)
    }
}
