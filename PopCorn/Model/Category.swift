//
//  Category.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 27/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

struct Category {
    var id: Int
    var name: String
    
    init(fromId id: Int, fromName name: String) {
        self.id = id
        self.name = name
    }
}
