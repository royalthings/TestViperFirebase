//
//  RegistrationRegistrationInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class RegistrationModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var registrationViewController: RegistrationViewController!

    override func awakeFromNib() {

        let configurator = RegistrationModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: registrationViewController)
    }

}
