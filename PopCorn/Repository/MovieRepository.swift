//
//  MovieRepository.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 18/05/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

struct MovieRepo {
    
    func getMoviesByCategory(page: Int = 1, categoryId: Int? = nil, completion: @escaping ((MovieByCategoryResponse?) -> Void)) {
        
        var params: [URLQueryItem] = []
        params.append(URLQueryItem(name: "page", value: "\(page)"))
        
        if let category = categoryId {
            params.append(URLQueryItem(name: "with_genres", value: "\(category)"))
        }
        
        let url = ApiManager.shared.createUrl(pathUrl: ApiPath.movieList, queryParams: params)
        if let movieByCateUrl = url?.url {
            RequestManager.shared.requestData(url: movieByCateUrl) { data in
                completion(try? JSONDecoder().decode(MovieByCategoryResponse.self, from: data))
            }
        }
    }
    
    
    func getMovieById(id: Int, completion: @escaping ((MovieByIdResponse?) -> Void)) {
        var detailsUrl = ApiManager.shared.createUrl(pathUrl: ApiPath.movie, queryParams: [
            URLQueryItem(name: "append_to_response", value: "videos")
            ])
        detailsUrl?.path += String(id)
        if let url = detailsUrl?.url {
            RequestManager.shared.requestData(url: url) { data in
                completion(try? JSONDecoder().decode(MovieByIdResponse.self, from: data))
            }
        }
    }
}
