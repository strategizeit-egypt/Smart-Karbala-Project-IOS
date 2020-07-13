//
//  ReportCategoryVC + CollectionView.swift
//  KarbalaIOS
//
//  Created by mac on 5/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension ReportCategoryVC{
    func setupCollectionView(){
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        categoryCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: sectionIdentifier)
        categoryCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (categoryCollectionView.frame.width - 20) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth )
        layout.minimumLineSpacing = 20
        categoryCollectionView.collectionViewLayout = layout
    }
}

//MARK:- Collection View Data source & Delegate
extension ReportCategoryVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getReportCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! MarginSectionCell
        section.backgroundColor = UIColor.clear
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoreItemCell
        presenter.configure(cell: cell, for: indexPath.item, isArabic: UIApplication.isRTL())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectButtonPressed(selectedIndex: indexPath.item)
    }
    
    
}

//MARK:- Collection View Flow Layout
extension ReportCategoryVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width - 30) / 2
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
