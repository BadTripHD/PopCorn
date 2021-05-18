//
//  MovieCell.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 26/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.description
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async() {
            self.movieImageView.image = image
        }
    }

}
