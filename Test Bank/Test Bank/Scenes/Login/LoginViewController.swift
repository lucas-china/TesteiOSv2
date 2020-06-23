//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class {
    func showErrorLabel(viewModel: Login.ViewModel)
    func hideErrorLabel()
}

class LoginViewController: UIViewController {
  var interactor: LoginBusinessLogic?
  var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

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
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
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
    setupButton()
    setupUserTextField()
    setupPasswordTextField()
    setupErrorLabel()
  }
  
  // MARK: IBOutlet
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: Do something
    
    func setupButton() {
        loginButton.setRadius()
        loginButton.setShadow()
    }
    
    func setupUserTextField() {
        userTextField.layer.borderWidth = 1.0
        userTextField.layer.borderColor = UIColor.textFieldBorderColor.cgColor
    }
    
    func setupPasswordTextField() {
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.textFieldBorderColor.cgColor
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupErrorLabel() {
        errorLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        let userText = userTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        let request = Login.Request(user: userText, password: passwordText)
        interactor?.doLogin(request: request)
        
    }
}

extension LoginViewController: LoginDisplayLogic {
    func showErrorLabel(viewModel: Login.ViewModel) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.errorLabel.text = viewModel.errorMesage
        }
    }
    
    func hideErrorLabel() {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = true
        }
    }
}
