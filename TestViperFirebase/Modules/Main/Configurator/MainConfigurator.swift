//
//  MainMainConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MainModuleConfigurator {
   
   static let sharedInstance = MainModuleConfigurator()
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? MainViewController {
         moduleConfigured(for: viewController)
         
//         configure(viewController: viewController)
      }
   }

   func moduleViewAndInput() -> (MainViewController, MainModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   private func moduleViewController() -> MainViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "MainViewController") as MainViewController
   }
   
   private func moduleConfigured(for viewController: MainViewController) -> MainModuleInput {
      let dataManager = DataManager()
      let interactor = MainInteractor()
      let presenter = MainPresenter()
      let router = MainRouter()
      
      router.viewController = viewController
      
      viewController.output = presenter
      
      presenter.view = viewController
      presenter.router = router
      presenter.interactor = interactor
      
      interactor.output = presenter
      interactor.dataManager = dataManager
      
      return presenter
   }
   
   
//   private func configure(viewController: MainViewController) {
//
//      let dataManager = DataManager()
//      let interactor = MainInteractor()
//      let presenter = MainPresenter()
//      let router = MainRouter()
//
//      router.viewController = viewController
//      interactor.dataManager = dataManager
//      viewController.output = presenter
//
//      presenter.view = viewController
//
//      presenter.router = router
//
//      interactor.output = presenter
//
//      presenter.interactor = interactor
//   }
}

