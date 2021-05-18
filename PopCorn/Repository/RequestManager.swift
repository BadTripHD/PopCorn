//
//  RequestManager.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 18/05/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation
import UIKit

struct RequestManager {
    static var shared = RequestManager()
    let urlSession = URLSession.shared
    
    func requestData(url: URL, completion: @escaping (Data) -> Void) -> Void {
        
        self.urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            if let data = data {
                completion(data)
            }
        }.resume()
    }
}
