//
//  DetailDetailPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 30/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class DetailPresenter: DetailModuleInput, DetailViewOutput, DetailInteractorOutput {
   
   
   
   weak var view: DetailViewInput!
   var interactor: DetailInteractorInput!
   var router: DetailRouterInput!
   
   func viewIsReady() {
      
   }
   
   func dismiss() {
      router.dismiss()
   }
}
