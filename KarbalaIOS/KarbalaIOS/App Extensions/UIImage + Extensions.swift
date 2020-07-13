//
//  UIImage + Extensions.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
//MARK:- UIImage
extension UIImage {
    
    func convertImageToBase64()->String? {
        let compressedImage = self.compressImage()
        guard let imageData:Data = (compressedImage ?? self).pngData() else{
            return nil
        }
        
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func convertImageToData()->Data?{
        let compressedImage = self.compressImage()
        guard let imageData:Data = (compressedImage ?? self).pngData() else{
            return nil
        }
        return imageData
    }
    
    func compressImage() -> UIImage? {
        // Reducing file size to a 10th
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        let maxHeight: CGFloat = 1136.0
        let maxWidth: CGFloat = 640.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 1
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        guard let imageData =  img?.jpegData(compressionQuality: compressionQuality) else{
            return nil
        }
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)
    }
}

//MARK:- UIImageView
extension UIImageView {
    func loadImage(with urlString:String,placholder:String = "Place-holder"){
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: placholder), options: .highPriority) { (image, error, cach, url) in
            if error != nil{
                
            }
        }
    }
}
