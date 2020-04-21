//
//  SettingsSettingsConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SettingsModuleConfigurator {
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? SettingsViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (SettingsViewController, SettingsModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   func moduleViewController() -> SettingsViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "SettingsViewController") as SettingsViewController
   }
   
   private func moduleConfigured(for viewController: SettingsViewController) -> SettingsModuleInput {
      //let dataManager = DataManager()
      let router = SettingsRouter()
      let presenter = SettingsPresenter()
      let interactor = SettingsInteractor()
      
      presenter.view = viewController
      presenter.router = router
      
      //interactor.dataManager = dataManager
      interactor.output = presenter
      
      router.viewController = viewController
      
      presenter.interactor = interactor
      viewController.output = presenter
      
      return presenter
   }

//   private func configure(viewController: SettingsViewController) {
//
//      let router = SettingsRouter()
//
//      let presenter = SettingsPresenter()
//      presenter.view = viewController
//      presenter.router = router
//
//      let interactor = SettingsInteractor()
//      interactor.output = presenter
//
//      presenter.interactor = interactor
//      viewController.output = presenter
//   }
   
}
