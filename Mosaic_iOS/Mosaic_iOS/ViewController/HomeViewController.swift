//
//  HomeViewController.swift
//  Mosaic_iOS
//
//  Created by Zedd on 2018. 7. 28..
//  Copyright © 2018년 Zedd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    static func create() -> HomeViewController?{
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
