//
//  ChoiceChoiceInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class ChoiceModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var choiceViewController: ChoiceViewController!

    override func awakeFromNib() {

        let configurator = ChoiceModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: choiceViewController)
    }

}
