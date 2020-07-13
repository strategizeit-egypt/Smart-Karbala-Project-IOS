//
//  UICollectionView + Extension.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    func setEmptyView(errorType:ApiError,message:String?){
        if let emptyView = backgroundView?.viewWithTag(AppConstants.emptyCollectionViewTag){
            emptyView.removeFromSuperview()
        }
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.tag = AppConstants.emptyCollectionViewTag
        let errorImageView = UIImageView()
        let messageLabel = UILabel()
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont().regularFont(with: 15)
        
        emptyView.addSubview(errorImageView)
        emptyView.addSubview(messageLabel)
        
        errorImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        errorImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        // errorImageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 20).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: emptyView.frame.width * 0.25).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: emptyView.frame.width * 0.25).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 16).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        errorImageView.image = UIImage(named: errorType.errorImage)
        errorImageView.contentMode = .scaleToFill
        
        messageLabel.text = message ?? errorType.localizedDescription
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
    }
    
    func restore(){
        if let emptyView = backgroundView?.viewWithTag(AppConstants.emptyCollectionViewTag){
            emptyView.removeFromSuperview()
        }
        self.backgroundView = nil
    }
    
    func addRefresherToCollectionView(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.buttonBackgroundColor
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
    }
    
}
