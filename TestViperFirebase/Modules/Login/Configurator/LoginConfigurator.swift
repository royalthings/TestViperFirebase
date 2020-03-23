//
//  LoginLoginConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class LoginModuleConfigurator {
   
   static let sharedInstance = LoginModuleConfigurator()
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? LoginViewController {
         moduleConfigured(for: viewController)
      }
   }
      
   func moduleViewAndInput() -> (LoginViewController, LoginModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   private func moduleViewController() -> LoginViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "LoginViewController") as LoginViewController
   }
   
   private func moduleConfigured(for viewController: LoginViewController) -> LoginModuleInput {
      let dataManager = DataManager()
      let interactor = LoginInteractor()
      let presenter = LoginPresenter()
      let router = LoginRouter()
      
      interactor.dataManager = dataManager
      viewController.output = presenter
      
      presenter.view = viewController
      presenter.router = router
      
      router.viewController = viewController
      interactor.output = presenter
      
      presenter.interactor = interactor
      
      return presenter
   }
   
   
   
   
   
//   private func configure(viewController: LoginViewController) {
//      let dataManager = DataManager()
//      let interactor = LoginInteractor()
//      let presenter = LoginPresenter()
//      let router = LoginRouter()
//
//      interactor.dataManager = dataManager
//      viewController.output = presenter
//
//      presenter.view = viewController
//      presenter.router = router
//
//      router.viewController = viewController
//      interactor.output = presenter
//
//      presenter.interactor = interactor
//
//   }
   
}
