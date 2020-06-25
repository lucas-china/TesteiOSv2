//
//  HomePresenter.swift
//  Test Bank
//
//  Created by Lucas Santana Brito on 23/06/20.
//  Copyright (c) 2020 lsb. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomePresentationLogic {
    func presentAccount(response: Home.Response)
    func presentStatements(list: [Home.Statement])
    func presentErrorGetStatements(errorMessage: String)
}

class HomePresenter: HomePresentationLogic
{
  weak var viewController: HomeDisplayLogic?
  
  // MARK: Do something
    
    func presentAccount(response: Home.Response) {
        guard let accout = response.account else { return }
        let viewModel = Home.ViewModel(
            name: accout.name ?? "",
            bankAccount: accout.bankAccount ?? "",
            agency: accout.agency ?? "",
            balance: accout.balance ?? 0.0
        )
        viewController?.displayAccount(viewModel: viewModel)
    }
    
    func presentStatements(list: [Home.Statement]) {
        viewController?.displayStatements(list: list)
    }
    
    func presentErrorGetStatements(errorMessage: String) {
        print(errorMessage)
        viewController?.displayErrorGetStatements(errorMessage: errorMessage)
    }
}
