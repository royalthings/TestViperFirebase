//
//  DetailDetailInitializer.swift
//  TestViperFirebase
//
//  Created by agadu on 30/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class DetailModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var detailViewController: DetailViewController!

    override func awakeFromNib() {

        let configurator = DetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: detailViewController)
    }

}
