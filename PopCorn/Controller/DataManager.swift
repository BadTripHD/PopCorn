//
//  DataManager.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 27/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init(){
        
    }
    
    lazy var categories: [Category] = {
        var list = [Category]()
        
        for i in 0 ..< 10 {
            let category = Category(fromId: i, fromName: "Action_\(i)")
            list.append(category)
        }
        
        return list
    } ()
}
