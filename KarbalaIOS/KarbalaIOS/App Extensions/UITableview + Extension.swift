//
//  UITableview + Extension.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func setEmptyView(errorType:ApiError,message:String?){
        
        if let emptyView = backgroundView?.viewWithTag(AppConstants.emptyTableViewTag){
            emptyView.removeFromSuperview()
        }
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.tag = AppConstants.emptyTableViewTag
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
        errorImageView.widthAnchor.constraint(equalToConstant: emptyView.frame.width * 0.25).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: emptyView.frame.height * 0.25).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 0).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        errorImageView.image = UIImage(named: errorType.errorImage)
        errorImageView.contentMode = .scaleAspectFit

        messageLabel.text = message ?? errorType.localizedDescription
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.separatorStyle = .none
        self.backgroundView = emptyView
    }
    
    func restore(isHasSeperator:Bool){
        if let emptyView = backgroundView?.viewWithTag(AppConstants.emptyTableViewTag){
            emptyView.removeFromSuperview()
        }
        self.backgroundView = nil
        self.separatorStyle = (isHasSeperator == true) ? .singleLine : .none
    }
    
    func addRefresherToTableView(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.buttonBackgroundColor
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
    }
    
    func layoutTableHeaderView() {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
