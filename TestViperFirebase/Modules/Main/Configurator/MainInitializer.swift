//
//  MainMainInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MainModuleInitializer: NSObject {
   
   //Connect with object on storyboard
   @IBOutlet weak var mainViewController: MainViewController!
   
   override func awakeFromNib() {
      
      let configurator = MainModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: mainViewController)
      
   }
   
}
