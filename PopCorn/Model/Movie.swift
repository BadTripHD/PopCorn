//
//  Movie.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 26/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int
    var title: String
    var subtitle: String?
    var releaseDate: String?
    var duration: Int?
    var categories: [String]?
    var description: String?
    var trailerUrl: String?
    var imageUrl: String?
    var posterUrl: String?
    
    init?() {
        self.id = 1
        self.title = "Avengers"
        self.subtitle = "End Game"
        self.releaseDate = "24/04/2019"
        self.duration = 182
        self.categories = ["Action", "Fantastique", "Aventure"]
        self.description = "Thanos ayant anéanti la moitié de l’univers, les Avengers restants resserrent les rangs dans ce vingt-deuxième film des Studios Marvel, grande conclusion d’un des chapitres de l’Univers Cinématographique Marvel."
        self.trailerUrl = "https://www.youtube.com/watch?v=wV-Q0o2OQjQ"
        self.posterUrl = "endGamePoster"
        self.imageUrl = "endGameAffiche"
    }
    
    func toStringDuration() -> String{
        guard let duration = self.duration else {
            return "nil"
        }
        return "\(duration) min"
    }
    
    func toStringCategries() -> String {
        guard let categories = self.categories else {
            return "nil"
        }
        return categories.joined(separator: "/ ")
    }
    
    func getTrailer() -> URL?{
        guard let trailer = self.trailerUrl else {
            return nil
        }
        return URL(string: trailer)
    }
    
}
