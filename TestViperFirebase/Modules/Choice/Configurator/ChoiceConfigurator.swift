//
//  ChoiceChoiceConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class ChoiceModuleConfigurator {
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? ChoiceViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (ChoiceViewController, ChoiceModuleInput) {
         let moduleView = moduleViewController()
         let moduleInput = moduleConfigured(for: moduleView)
         return (moduleView, moduleInput)
      }
      
      private func moduleViewController() -> ChoiceViewController {
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         return storyboard.instantiateViewController(identifier: "ChoiceViewController") as ChoiceViewController
      }
      
      private func moduleConfigured(for viewController: ChoiceViewController) -> ChoiceModuleInput {
         let dataManager = DataManager()
         let interactor = ChoiceInteractor()
         let presenter = ChoicePresenter()
         let router = ChoiceRouter()
         

         viewController.output = presenter
         
         presenter.view = viewController
         presenter.router = router
         
         router.viewController = viewController
         interactor.output = presenter
         interactor.dataManager = dataManager
         
         presenter.interactor = interactor
         
         return presenter
      }
   
}
