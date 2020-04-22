//
//  SelectCitySelectCityConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 22/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SelectCityModuleConfigurator {
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? SelectCityViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (SelectCityViewController, SelectCityModuleInput) {
        let moduleView = moduleViewController()
        let moduleInput = moduleConfigured(for: moduleView)
        return (moduleView, moduleInput)
     }
     
     func moduleViewController() -> SelectCityViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: "SelectCityViewController") as SelectCityViewController
     }
     
     private func moduleConfigured(for viewController: SelectCityViewController) -> SelectCityModuleInput {
        //let dataManager = DataManager()
        let router = SelectCityRouter()
        let presenter = SelectCityPresenter()
        let interactor = SelectCityInteractor()
        
        presenter.view = viewController
        presenter.router = router
        
        //interactor.dataManager = dataManager
        interactor.output = presenter
        
        router.viewController = viewController
        
        presenter.interactor = interactor
        viewController.output = presenter
        
        return presenter
     }
   
   
//   private func configure(viewController: SelectCityViewController) {
//
//      let router = SelectCityRouter()
//
//      let presenter = SelectCityPresenter()
//      presenter.view = viewController
//      presenter.router = router
//
//      let interactor = SelectCityInteractor()
//      interactor.output = presenter
//
//      presenter.interactor = interactor
//      viewController.output = presenter
//   }
   
}
