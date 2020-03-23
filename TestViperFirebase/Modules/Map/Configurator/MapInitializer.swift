//
//  MapMapInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MapModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var mapViewController: MapViewController!

    override func awakeFromNib() {

        let configurator = MapModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: mapViewController)
    }

}
