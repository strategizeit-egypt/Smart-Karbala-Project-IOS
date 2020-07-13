//
//  MoreVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Item{
    let image:String
    let name:String
    let description:String
}

protocol MoreVCPresenterDelegate:LoaderDelegate {
    func didUpdatedSuccessfully(message:String)
    func displayUserName(name:String)
    func didLogout()
}

protocol MoreView {
    func displayItemName(name:String)
    func displayItemNameInAR(name:String)
    func displayItemImage(imageName:String,isUrl:Bool)
}

class MoreVCPresenter{
    private let items:[Item] = [Item(image: "about_us", name: "About us".localized, description: ""),
                                Item(image: "contact_us", name: "Contact us".localized, description: ""),
                                Item(image: "policy", name: "Terms & policy".localized, description: ""),
                                Item(image: "language", name: "Change languge".localized, description: "")]
    
    private let userInteractor = NetworkService<UserModel>()
    private let logoutInteractor = NetworkService<Bool>()

    weak var delegate:MoreVCPresenterDelegate?
    
    init(delegate:MoreVCPresenterDelegate) {
        self.delegate = delegate
        populateUserName()
    }
    
    func populateUserName(){
        delegate?.displayUserName(name: AppUser.shared.user.fullName)
    }
    
    func getItemsCount()->Int{
        return items.count
    }
    
    func getItemName(for index:Int)->String{
        return items[index].name
    }
    
    func configure(cell:MoreView,for index:Int){
        let item = items[index]
        cell.displayItemName(name: item.name)
        cell.displayItemImage(imageName: item.image, isUrl: false)
    }
    
    
    func editFullName(fullName:String?){
        guard let fullName = fullName , !fullName.isStringEmpty() else{
            delegate?.showError(message: "name_is_empty".localized)
            return
        }
        self.updateFullName(name: fullName)
    }
    
    func logoutFromApp(){
        self.logout()
    }
    
}

extension MoreVCPresenter{
    private func updateFullName(name:String){
        delegate?.showLoader()
        let request = UserRoutes.editFullName(fullName: name)
        userInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            guard var user = response as? UserModel else{return}
            user.token = AppUser.shared.user.token
            AppUser.shared.saveUserData(userObj: user, setToken: false)
            self.delegate?.didUpdatedSuccessfully(message:"msg_user_name_changed".localized)
        }) { [weak self](error) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            self.delegate?.showError(message:error.localizedDescription)
        }
    }
    
    private func logout(){
        delegate?.showLoader()
        let request = UserRoutes.logout
        logoutInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            guard var isLogout = response as? Bool ,isLogout == true else{return}
            AppUser.shared.removeUserData()
            self.delegate?.didLogout()
        }) { [weak self](error) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            if error == .unauthorized{return}
            self.delegate?.showError(message:error.localizedDescription)
        }
    }
}
