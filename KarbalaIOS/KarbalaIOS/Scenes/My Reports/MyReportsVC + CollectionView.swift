//
//  MyReportsVC + CollectionView.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView


//MARK:- Setup
extension MyReportsVC{
    func setupCollectionView(){
        
        refreshCollectionView()
        
        setSkeletonView()
        
        reportsCollectionView.delegate = self
        reportsCollectionView.dataSource = self
        reportsCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        reportsCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: sectionIdentifier)
        
        reportsCollectionView.register(UINib(nibName: sectionIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = reportsCollectionView.frame.width
        layout.itemSize = CGSize(width: itemWidth, height: 160)
        layout.minimumLineSpacing = 17
        reportsCollectionView.collectionViewLayout = layout
    }
    
    func setSkeletonView(){
        
        SkeletonAppearance.default.multilineHeight = 15
        SkeletonAppearance.default.multilineSpacing = 10
        
        reportsCollectionView.isSkeletonable = true
        reportsCollectionView.prepareSkeleton { done in
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func refreshCollectionView(){
        reportsCollectionView.addRefresherToCollectionView()
        reportsCollectionView.refreshControl?.addTarget(self, action: #selector(refreshReports), for: .valueChanged)
    }
    
    @objc func refreshReports(){
        presenter.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.reportsCollectionView.refreshControl?.endRefreshing()
        }
    }
}

//MARK:- Collection View Data source & Delegate
extension MyReportsVC:SkeletonCollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return sectionIdentifier
    }
    
    //MARK:- Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getReportsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! MarginSectionCell
        section.backgroundColor = UIColor.clear
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReportCell
        presenter.configure(cell: cell, for: indexPath.item, isArabic: UIApplication.isRTL())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectRow(for: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.loadMore(for: indexPath.item)
    }
    
    
}

//MARK:- Collection View Flow Layout
extension MyReportsVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width , height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
}
