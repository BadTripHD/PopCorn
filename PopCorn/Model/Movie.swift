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
    
    init?(from movieResponse: MovieResponse)
    {
        guard let id = movieResponse.id, let title = movieResponse.title, let releaseDate = movieResponse.releaseDate else {
            return nil
        }
        
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.description = movieResponse.overview
        if let backdrop = movieResponse.backdropPath {
            self.imageUrl = ApiManager.shared.IMAGE_BASE_URL + "w500" + backdrop
        }

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
    
    func toUrlTrailer() -> URL?{
        guard let trailer = self.trailerUrl else {
            return nil
        }
        return URL(string: trailer)
    }
    
    func toUrlImageUrl() -> URL? {
        guard let imageUrl = self.imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
    
}


struct MovieByCategoryResponse: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [MovieResponse]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    func toMovieByCategory() -> [Movie] {
        guard let results = self.results else {
            return []
        }
        return results.compactMap { movieReponse -> Movie? in
            Movie(from: movieReponse)
        }
    }
}

struct MovieResponse: Decodable {
    let id: Int?
    let backdropPath: String?
    let genres: [Int]?
    let title: String?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
    }
}
