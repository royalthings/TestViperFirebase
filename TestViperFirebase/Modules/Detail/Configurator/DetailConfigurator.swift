//
//  DetailDetailConfigurator.swift
//  TestViperFirebase
//
//  Created by agadu on 30/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class DetailModuleConfigurator {
   
   func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
      
      if let viewController = viewInput as? DetailViewController {
         moduleConfigured(for: viewController)
      }
   }
   
   func moduleViewAndInput() -> (DetailViewController, DetailModuleInput) {
      let moduleView = moduleViewController()
      let moduleInput = moduleConfigured(for: moduleView)
      return (moduleView, moduleInput)
   }
   
   func moduleViewController() -> DetailViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyboard.instantiateViewController(identifier: "DetailViewController") as DetailViewController
   }
   
   private func moduleConfigured(for viewController: DetailViewController) -> DetailModuleInput {
      //let dataManager = DataManager()
      let router = DetailRouter()
      let presenter = DetailPresenter()
      let interactor = DetailInteractor()
      
      presenter.view = viewController
      presenter.router = router
      
      //interactor.dataManager = dataManager
      interactor.output = presenter
      
      router.viewController = viewController
      
      presenter.interactor = interactor
      viewController.output = presenter
      
      return presenter
   }
   
   
   
   
   
   //    private func configure(viewController: DetailViewController) {
   //
   //        let router = DetailRouter()
   //
   //        let presenter = DetailPresenter()
   //        presenter.view = viewController
   //        presenter.router = router
   //
   //        let interactor = DetailInteractor()
   //        interactor.output = presenter
   //
   //        presenter.interactor = interactor
   //        viewController.output = presenter
   //    }
   
}
