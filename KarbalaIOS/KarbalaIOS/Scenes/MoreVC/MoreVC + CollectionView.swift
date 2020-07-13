//
//  MoreVC + CollectionView.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension MoreVC{
    func setupCollectionView(){
        moreCollectionView.delegate = self
        moreCollectionView.dataSource = self
        moreCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        moreCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: sectionIdentifier)
        moreCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (moreCollectionView.frame.width - 20) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth )
        layout.minimumLineSpacing = 20
        moreCollectionView.collectionViewLayout = layout
    }
}

//MARK:- Collection View Data source & Delegate
extension MoreVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! MarginSectionCell
        section.backgroundColor = UIColor.clear
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoreItemCell
        presenter.configure(cell: cell, for: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: presenter.getItemName(for: indexPath.item), style: .plain, target: nil, action: nil)
        switch indexPath.item {
        case 0:
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromMoreToAboutUs.rawValue, sender: nil)
        case 1:
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromMoreToContactUs.rawValue, sender: nil)
        case 2:
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromMoreToTerms.rawValue, sender: nil)
        case 3:
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromMoreToLanguage.rawValue, sender: nil)
        default:break
        }
    }
    
    
}

//MARK:- Collection View Flow Layout
extension MoreVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width - 20) / 2
        return CGSize.init(width: itemWidth , height: itemWidth )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
