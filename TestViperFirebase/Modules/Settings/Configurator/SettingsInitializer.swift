//
//  SettingsSettingsInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SettingsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var settingsViewController: SettingsViewController!

    override func awakeFromNib() {

        let configurator = SettingsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: settingsViewController)
    }

}
