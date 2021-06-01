//
//  ViewController.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 13/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var image: UIImageView!
    
    var movie: Movie?
    private let movieRepository = MovieRepo()
    private let imageManager = ImageManager()

    var movieId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movieId)
        
        movieRepository.getMovieById(id: self.movieId) { response in
            if let movieResponse = response {
                guard let movie = Movie(from: movieResponse) else {
                    return
                }
                self.movie = movie
                self.loadTrailerUrl(from: movieResponse.videos)
                DispatchQueue.main.async() {
                    self.displayInformation(movie: movie)
                    self.displayImages(movie: self.movie)
                }
            }
        }

    }
    
    private func loadTrailerUrl(from movieVideos: MovieVideosResponse?) {
        guard let results = movieVideos?.results else {
            return
        }
        let urlList = results.toUrlList()
        if !urlList.isEmpty {
            self.movie?.trailerUrl = urlList[0]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // if memory leak
    }
    
    //-----------------Button action------------------>
    @IBAction func playButton(_ sender: Any) {
        if let url = movie?.toUrlTrailer() {
            UIApplication.shared.open(url)
        }
    }
    
    //-----------------Function setup data------------------>
    func displayInformation(movie: Movie){
        titleMovie.text = movie.title
        subTitle.text = movie.subtitle
        releaseDate.text = movie.releaseDate
        duration.text = movie.toStringDuration()
        categories.text = movie.toStringCategries()
        descriptionMovie.text = movie.description
    }
    
    func displayImages(movie: Movie?){
        if let url = movie?.toUrlImageUrl() {
            imageManager.getImageInCache(url: url) { image, imageUrl in
                DispatchQueue.main.async() {
                    if imageUrl ==  url.absoluteString {
                        self.image.image = image
                    }
                }
            }
        }
        if let url = movie?.toUrlPosterUrl() {
            imageManager.getImageInCache(url: url) { image, imageUrl in
                DispatchQueue.main.async() {
                    if imageUrl ==  url.absoluteString {
                        self.poster.image = image
                    }
                }
            }
        }
    }
    
}

