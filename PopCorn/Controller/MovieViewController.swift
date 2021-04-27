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

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = Movie() else {
            return
        }
        self.movie = movie
        
        displayImage(assetUrl: self.movie?.imageUrl, isPoster: false)
        displayImage(assetUrl: self.movie?.posterUrl)
        displayInformation(movie: movie)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // if memory leak
    }
    
    //-----------------Button action------------------>
    @IBAction func playButton(_ sender: Any) {
        if let url = movie?.getTrailer() {
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
    
    func displayImage(assetUrl: String?, isPoster: Bool = true){
        if let url = assetUrl{
            if isPoster{
                poster.image = UIImage(named: url)
            } else {
                image.image = UIImage(named: url)
            }
        }
    }
    
}

