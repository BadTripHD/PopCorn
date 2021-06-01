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
    
    init?(from movieByIdResponse: MovieByIdResponse) {
        guard let id = movieByIdResponse.id,
            let title = movieByIdResponse.title,
            let releaseDate = movieByIdResponse.releaseDate,
            let poster = movieByIdResponse.posterUrl else {
                return nil
        }
        self.id = id
        self.title = title
        self.subtitle = movieByIdResponse.subtitle
        self.releaseDate = releaseDate
        self.description = movieByIdResponse.description
        if let imageUrl = movieByIdResponse.imageUrl {
            self.imageUrl = ApiManager.shared.IMAGE_BASE_URL + "w500" + imageUrl
        }
        self.posterUrl = ApiManager.shared.IMAGE_BASE_URL + "w200" + poster
        self.duration = movieByIdResponse.duration
        self.categories = movieByIdResponse.categories?.compactMap({ genre -> String? in
            return genre.name
        })
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
    
    func toUrlPosterUrl() -> URL? {
        guard let posterUrl = self.posterUrl else {
            return nil
        }
        return URL(string: posterUrl)
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

struct MovieByIdResponse: Decodable {
    let id: Int?
    let title: String?
    let imageUrl: String?
    let description: String?
    let subtitle: String?
    let posterUrl: String?
    let releaseDate: String?
    let video: Bool?
    let duration: Int?
    let categories: [Category]?
    let videos: MovieVideosResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "backdrop_path"
        case description = "overview"
        case posterUrl = "poster_path"
        case releaseDate = "release_date"
        case title
        case subtitle = "tagline"
        case video
        case duration = "runtime"
        case categories = "genres"
        case videos
    }
}

struct MovieVideosResponse: Decodable {
    let results: [MovieVideo]?
}

struct MovieVideo: Decodable {
    let key: String?
    let site: String?
    let type: String?
    
    func transformToStringUrl() -> String? {
        guard let key = key else {
            return nil
        }
        if self.site == "YouTube" {
            return "https://www.youtube.com/watch?v=\(key)"
        }
        return nil
    }
}

extension Array where Element == MovieVideo {
    func toUrlList() -> [String] {
        return self.compactMap { (movieVideo: MovieVideo) -> String? in
            movieVideo.transformToStringUrl()
        }
    }
}
