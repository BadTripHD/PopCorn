//
//  Category.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 27/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

struct Category: Decodable{
    var id: Int
    var name: String
    
    init(fromId id: Int, fromName name: String) {
        self.id = id
        self.name = name
    }
}

public struct CategoriesResponse: Decodable {
    let categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "genres"
    }
    
    func toCategory() -> [Category] {
        guard let categories = self.categories else {
            return []
        }
        return categories.compactMap { category -> Category? in
            Category(fromId: category.id, fromName: category.name)
        }
    }
}

