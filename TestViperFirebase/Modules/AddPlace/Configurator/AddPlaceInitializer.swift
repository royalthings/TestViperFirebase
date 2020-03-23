//
//  AddPlaceAddPlaceInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class AddPlaceModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var addplaceViewController: AddPlaceViewController!

    override func awakeFromNib() {

        let configurator = AddPlaceModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: addplaceViewController)
    }

}
