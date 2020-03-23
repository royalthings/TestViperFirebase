//
//  AddPlaceAddPlaceConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class AddPlaceModuleConfigurator {
   
   static let sharedInstance = AddPlaceModuleConfigurator()

   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? AddPlaceViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (AddPlaceViewController, AddPlaceModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   func moduleViewController() -> AddPlaceViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "AddPlaceViewController") as AddPlaceViewController
   }
   
   private func moduleConfigured(for viewController: AddPlaceViewController) -> AddPlaceModuleInput {
      let dataManager = DataManager()
      let router = AddPlaceRouter()
      let presenter = AddPlacePresenter()
      let interactor = AddPlaceInteractor()
      
      presenter.view = viewController
      presenter.router = router
      
      interactor.dataManager = dataManager
      interactor.output = presenter
      
      router.viewController = viewController
      
      presenter.interactor = interactor
      viewController.output = presenter
      
      return presenter
   }
   
   
   
   
//   private func configure(viewController: AddPlaceViewController) {
//
//      let dataManager = DataManager()
//      let router = AddPlaceRouter()
//      let presenter = AddPlacePresenter()
//      let interactor = AddPlaceInteractor()
//
//      presenter.view = viewController
//      presenter.router = router
//
//      interactor.dataManager = dataManager
//      interactor.output = presenter
//
//      router.viewController = viewController
//
//      presenter.interactor = interactor
//      viewController.output = presenter
//   }
}
