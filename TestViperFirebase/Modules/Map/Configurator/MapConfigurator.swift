//
//  MapMapConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MapModuleConfigurator {
   
   static let sharedInstance = MapModuleConfigurator()
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? MapViewController {
         
         moduleConfigured(for: viewController)
         
//         configure(viewController: viewController)
      }
   }
   
   func moduleViewAndInput() -> (MapViewController, MapModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   private func moduleViewController() -> MapViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "MapViewController") as MapViewController
   }
   
   private func moduleConfigured(for viewController: MapViewController) -> MapModuleInput {
      
      let dataManager = DataManager()
      let router = MapRouter()
      let presenter = MapPresenter()
      let interactor = MapInteractor()
      
      router.viewController = viewController
      
      presenter.view = viewController
      presenter.router = router
      
      interactor.output = presenter
      interactor.dataManager = dataManager
      
      presenter.interactor = interactor
      viewController.output = presenter
      
      return presenter
   }

//   private func configure(viewController: MapViewController) {
//
//      let router = MapRouter()
//      let presenter = MapPresenter()
//      let interactor = MapInteractor()
//
//
//      presenter.view = viewController
//      presenter.router = router
//
//
//      interactor.output = presenter
//
//      presenter.interactor = interactor
//      viewController.output = presenter
//   }
   
}
