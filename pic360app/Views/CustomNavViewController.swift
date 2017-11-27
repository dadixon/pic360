//
//  CustomNavViewController.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/21/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit

class CustomNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
