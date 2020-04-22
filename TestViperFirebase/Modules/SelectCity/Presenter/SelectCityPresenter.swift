//
//  SelectCitySelectCityPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 22/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class SelectCityPresenter: SelectCityModuleInput, SelectCityViewOutput, SelectCityInteractorOutput {
   
   weak var view: SelectCityViewInput!
   var interactor: SelectCityInteractorInput!
   var router: SelectCityRouterInput!
   
   func viewIsReady() {
      
   }
   
   func dismiss() {
      router.dismiss()
   }
}
