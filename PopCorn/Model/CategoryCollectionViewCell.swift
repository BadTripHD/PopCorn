//
//  CategoryCollectionViewCell.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 27/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
    }
    
    func setCategoryLabel(category: Category) {
        categoryLabel.text = category.name
    }
}
