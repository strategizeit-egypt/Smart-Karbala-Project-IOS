//
//  ImageCell.swift
//  Amanaksa
//
//  Created by mac on 2/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ImageCellDelegate:NSObjectProtocol {
    func didTapDelete(for cell:ImageCell)
}

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var reportImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate:ImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(image:UIImage){
        reportImageView.image = image
        deleteButton.isHidden = false
    }
    
    func setupCell(url:String){
           reportImageView.loadImage(with: url)
           deleteButton.isHidden = true
       }
    
    @IBAction func deletePhoto(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didTapDelete(for: self)
        }
    }
    
}
