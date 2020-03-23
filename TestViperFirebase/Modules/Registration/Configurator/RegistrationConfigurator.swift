//
//  RegistrationRegistrationConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class RegistrationModuleConfigurator {
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? RegistrationViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (RegistrationViewController, RegistrationModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   private func moduleViewController() -> RegistrationViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "RegistrationViewController") as RegistrationViewController
   }
   
   private func moduleConfigured(for viewController: RegistrationViewController) -> RegistrationModuleInput {
      let dataManager = DataManager()
      let interactor = RegistrationInteractor()
      let presenter = RegistrationPresenter()
      let router = RegistrationRouter()
      
//      interactor.dataManager = dataManager
      viewController.output = presenter
      
      presenter.view = viewController
      presenter.router = router
      
      router.viewController = viewController
      interactor.output = presenter
      
      presenter.interactor = interactor
      
      return presenter
   }   
}
