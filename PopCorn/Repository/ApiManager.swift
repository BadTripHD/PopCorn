//
//  ApiManager.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 27/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

enum ApiPath: String {
    case categories = "/genre/movie/list"
    case movie = "/movie/"
    case movieList = "/discover/movie"
}

struct ApiManager {
    static var shared = ApiManager()
    
    let BASE_URL = "https://api.themoviedb.org/3"
    let API_KEY = "3e6e36e037b91c4f5b19707df73e217f"
    let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    
    
    func createUrl(pathUrl: ApiPath, queryParams: [URLQueryItem]? = nil) -> URLComponents? {
        var url = URLComponents(string: "\(self.BASE_URL)\(pathUrl.rawValue)")
        
        url?.queryItems = [
            URLQueryItem(name: "api_key", value: self.API_KEY),
            URLQueryItem(name: "language", value: "fr-FR")
        ]
        
        if let queryParams = queryParams {
            url?.queryItems! += queryParams
        }
        
        return url
    }
}

