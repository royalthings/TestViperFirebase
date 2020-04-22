//
//  SelectCitySelectCityInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 22/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SelectCityModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var selectcityViewController: SelectCityViewController!

    override func awakeFromNib() {

        let configurator = SelectCityModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: selectcityViewController)
    }

}
