//
//  SettingsSettingsRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class SettingsRouter: SettingsRouterInput {

   weak var viewController: SettingsViewController!
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
   
   func goToSelectCityScreen() {
      let configurator = SelectCityModuleConfigurator()
      let (moduleView, _) = configurator.moduleViewAndInput()
      
      viewController.present(moduleView, animated: true, completion: nil)
   }
   
}
