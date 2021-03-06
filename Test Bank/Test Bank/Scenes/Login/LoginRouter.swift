//
//  LoginRouter.swift
//  Test Bank
//
//  Created by Lucas Santana Brito on 20/06/20.
//  Copyright (c) 2020 lsb. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol LoginRoutingLogic {
  func routeToShowHome(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
  var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
  weak var viewController: LoginViewController?
  var dataStore: LoginDataStore?
  
  // MARK: Routing
  
    @objc func routeToShowHome(segue: UIStoryboardSegue?) {
        if let segue = segue {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            guard let router = destinationVC.router else { return }
            guard var destinationDS = router.dataStore else { return }
            guard let dataStore = dataStore else { return }
            passDataToShowHome(source: dataStore, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
            guard let router = destinationVC.router else { return }
            guard var destinationDS = router.dataStore else { return }
            guard let dataStore = dataStore else { return }
            passDataToShowHome(source: dataStore, destination: &destinationDS)
            navigateToShowHome(source: viewController!, destination: destinationVC)
        }
    }

  // MARK: Navigation
  func navigateToShowHome(source: LoginViewController, destination: HomeViewController) {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
    func passDataToShowHome(source: LoginDataStore, destination: inout HomeDataStore) {
        destination.account = source.account
    }
}
