//
//  CategoryRepository.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 18/05/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

struct CategoryRepo {
    
    func getCategories(completion: @escaping ((CategoriesResponse?) -> Void)) -> Void {
        let url = ApiManager.shared.createUrl(pathUrl: ApiPath.categories)
        if let cateUrl = url?.url {
            RequestManager.shared.requestData(url: cateUrl) { data in
                completion(try? JSONDecoder().decode(CategoriesResponse.self, from: data))
            }
        }
    }
}
