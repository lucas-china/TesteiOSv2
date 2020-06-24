//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: class {
    func displaySomething(viewModel: Home.ViewModel)
    func displayAccount(viewModel: Home.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
  
    @IBAction func doLogout(_ sender: UIButton) {
    }
    
    
    func doSomething() {
//        let request = Home.Request()
//        interactor?.doSomething(request: request)
        interactor?.showAccount()
    }

    func displaySomething(viewModel: Home.ViewModel) {
        
    }
    
    func displayAccount(viewModel: Home.ViewModel) {
        nameLabel.text = viewModel.name
        accountNumberLabel.text = "\(viewModel.agency) / \(viewModel.bankAccount)"
        balanceLabel.text = String(viewModel.balance)
    }
}