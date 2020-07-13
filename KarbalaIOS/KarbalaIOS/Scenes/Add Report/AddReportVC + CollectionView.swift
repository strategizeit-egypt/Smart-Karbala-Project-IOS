//
//  AddReportVC + CollectionView.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Setup
extension AddReportVC{
    
    func setupCollectionView(){
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = photosCollectionView.frame.height//(photosCollectionView.frame.width / 3) - 28
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .horizontal
        photosCollectionView.collectionViewLayout = layout
    }
}

//MARK:- CollectionView
extension AddReportVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCell
        cell.delegate = self
        cell.setupCell(image: photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.stopPlayerAndRecorder()
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        guard let image = cell.reportImageView.image else{return}
        Helper.showImageInFullScreen(image: image, presenterViewController: self)
    }
    
}

//MARK:- Collection View Flow Layout
extension AddReportVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = photosCollectionView.frame.height//(photosCollectionView.frame.width / 3) - 28
        return CGSize.init(width: itemWidth , height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
}
