//
//  ReportDetailsVC + CollectionView.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension ReportDetailsVC{
    func setupCollectionView(){
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = imagesCollectionView.frame.height // (imagesCollectionView.frame.width / 3) - 28
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .horizontal
        imagesCollectionView.collectionViewLayout = layout
    }
}

//MARK:- Collection View Data source & Delegate
extension ReportDetailsVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getImagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCell
        let url = presenter.configureImageCell(for: indexPath.item)
        cell.setupCell(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        guard let image = cell.reportImageView.image else{return}
        presenter.stopPlayerWhenNavigate()
        Helper.showImageInFullScreen(image: image, presenterViewController: self)
    }
    
}

//MARK:- Collection View Flow Layout
extension ReportDetailsVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = imagesCollectionView.frame.height//(imagesCollectionView.frame.width / 3) - 28
        return CGSize.init(width: itemWidth , height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
}
