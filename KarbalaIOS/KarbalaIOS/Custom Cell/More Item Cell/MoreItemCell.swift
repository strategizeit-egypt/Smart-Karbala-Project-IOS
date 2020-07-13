//
//  MoreItemCell.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class MoreItemCell: UICollectionViewCell {
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}

extension MoreItemCell:MoreView{
    func displayItemNameInAR(name: String) {
        itemNameLabel.text = name
    }
    
    func displayItemName(name: String) {
        itemNameLabel.text = name
    }
    
    func displayItemImage(imageName: String,isUrl:Bool = false) {
        if isUrl{
            let url =  NetworkConstants.urls.categoryImage(imageName: imageName).value
            itemImageView.loadImage(with: url)
        }else{
            itemImageView.image = UIImage(named: imageName)
        }
    }
    
    
}
