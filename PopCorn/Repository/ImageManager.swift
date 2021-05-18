//
//  ImageManager.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 18/05/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    var imageCache: [String: UIImage] = [:]
    
    func getImageInCache(url: URL, completion: @escaping ((UIImage, String) -> Void)) {
        guard let image = imageCache[url.absoluteString] else {
            RequestManager.shared.requestData(url: url) { data in
                if let image = UIImage(data: data) {
                    self.imageCache[url.absoluteString] = image
                    completion(image, url.absoluteString)
                }
            }
            return
        }
        completion(image, url.absoluteString)
    }
}
